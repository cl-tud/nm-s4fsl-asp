from dataclasses import dataclass
from typing import List, Set, Dict, Tuple, Optional
import random, os, csv, shutil

UNIVERSAL_STANDPOINT = 'all'

@dataclass
class Rule:
    head: str
    body_nonasm: List[str]
    body_asm: List[str]
    standpoint: str

@dataclass
class ABAFramework:
    atoms: Set[str]
    assumptions: Set[str]
    non_assumptions: Set[str]
    contrary: Dict[str, str]
    standpoints: List[str]          # includes '*'
    order: Set[Tuple[str, str]]     # (less, greater)
    facts: List[Rule]               # facts live at standpoint '*'
    rules: List[Rule]               # all rules, including facts

def generate_aba_framework(
    n_atoms: int,
    assumption_ratio: float,
    n_standpoints: int,
    rules_per_sp: Tuple[int, int] = (1, 5),
    max_body_nonasm: int = 2,
    max_body_asm: int = 2,
    facts_per_star: Tuple[int, int] = (1, 3),
    seed: Optional[int] = None,
) -> ABAFramework:
    if seed is not None:
        random.seed(seed)

    base_atoms = [f"a{i}" for i in range(1, n_atoms + 1)]
    n_assumptions = max(1, min(n_atoms - 1, int(round(assumption_ratio * n_atoms))))
    assumptions = set(random.sample(base_atoms, n_assumptions))
    non_assumptions = set(base_atoms) - assumptions

    contrary: Dict[str, str] = {}
    atoms: Set[str] = set(base_atoms)
    for a in assumptions:
        c = f"not_{a}"
        contrary[a] = c
        atoms.add(c)

    standpoints = [UNIVERSAL_STANDPOINT] + [f"s{i}" for i in range(1, n_standpoints + 1)]
    order: Set[Tuple[str, str]] = set()
    for sp in standpoints[1:]:
        order.add((sp, UNIVERSAL_STANDPOINT))
    for i in range(1, len(standpoints)):
        for j in range(1, i):
            if random.random() < 0.3:
                order.add((standpoints[i], standpoints[j]))

    rules: List[Rule] = []
    facts: List[Rule] = []
    heads_pool = list(non_assumptions | set(contrary.values()))

    # facts at standpoint '*'
    n_facts = random.randint(*facts_per_star)
    for _ in range(max(1, n_facts)):
        head = random.choice(heads_pool)
        fact = Rule(head=head, body_nonasm=[], body_asm=[], standpoint=UNIVERSAL_STANDPOINT)
        facts.append(fact)
        rules.append(fact)

    # rules for other standpoints
    for sp in standpoints[1:]:
        n_rules = random.randint(*rules_per_sp)
        for _ in range(n_rules):
            head = random.choice(heads_pool)
            k_nonasm = random.randint(0, max_body_nonasm)
            k_asm = random.randint(0, max_body_asm)
            body_nonasm = random.sample(list(non_assumptions), min(k_nonasm, len(non_assumptions))) if non_assumptions else []
            body_asm = random.sample(list(assumptions), min(k_asm, len(assumptions))) if assumptions else []
            rules.append(Rule(head=head, body_nonasm=body_nonasm, body_asm=body_asm, standpoint=sp))

    return ABAFramework(
        atoms=atoms,
        assumptions=assumptions,
        non_assumptions=non_assumptions,
        contrary=contrary,
        standpoints=standpoints,
        order=order,
        facts=facts,
        rules=rules,
    )

def _sp_suffix(sp: str) -> str:
    # return "u" if sp == UNIVERSAL_STANDPOINT else sp
    return sp


def to_asp_with_standpoints(fr: ABAFramework) -> str:
    lines = []

    # assumptions
    if fr.assumptions:
        lines.append(
            "assumption(" + ";".join(sorted(fr.assumptions)) + ")."
        )
        lines.append("")

    # contraries (unindexed)
    for a in sorted(fr.assumptions):
        c = fr.contrary.get(a)
        if c is not None:
            lines.append(f"contrary({a},{c}).")
    lines.append("")

    # rules with standpoint index
    rule_id = 1
    for r in fr.rules:
        suf = _sp_suffix(r.standpoint)
        head_atom = f"{r.head}_{suf}"
        body_atoms = [f"{b}_{suf}" for b in (r.body_nonasm + r.body_asm)]

        if body_atoms:
            lines.append(f"% {head_atom} <- {', '.join(body_atoms)}")
        else:
            lines.append(f"% {head_atom}.")
        lines.append(f"head({rule_id},{head_atom}).")
        for b in body_atoms:
            lines.append(f"body({rule_id},{b}).")
        lines.append("")
        rule_id += 1

    # inheritance rules for standpoint order: if s1 < s2, a_s1 <- a_s2
    lines.append(f'%')
    lines.append(f'%%% Standpoint Inheritance Rules')
    lines.append(f'%')
    for less, greater in sorted(fr.order):
        suf_less = _sp_suffix(less)
        suf_greater = _sp_suffix(greater)
        if suf_less == suf_greater:
            continue
        for a in sorted(fr.atoms):
            head_atom = f"{a}_{suf_less}"
            body_atom = f"{a}_{suf_greater}"
            lines.append(f"% {head_atom} <- {body_atom}")
            lines.append(f"head({rule_id},{head_atom}).")
            lines.append(f"body({rule_id},{body_atom}).")
            lines.append("")
            rule_id += 1

    return "\n".join(lines)


def _and_term(args: List[str]) -> str:
    if not args:
        raise ValueError("and_term needs at least one arg")
    if len(args) == 1:
        return args[0]
    k = len(args)
    if not (2 <= k <= 11):
        raise ValueError(f"unsupported and-arity: {k}")
    return f"and{k}({','.join(args)})"


def _norm(a: str) -> str:
    return f"neg({a[4:]})" if a.startswith("not_") else a


def _goal_suffix(sp: str, head: str) -> str:
    safe_head = head.replace("not_", "not-")
    return f"goal-{sp}-{safe_head}"


def _goal_fact(sp: str, head: str) -> List[str]:
    atom = f"{head}_{_sp_suffix(sp)}"
    return ["% goal", f"g({atom})."]


def _goal_constraint(sp: str, head: str) -> str:
    return f":- not known(box({sp},{_norm(head)}))."


def _clear_dir(path: str) -> None:
    os.makedirs(path, exist_ok=True)
    for name in os.listdir(path):
        full = os.path.join(path, name)
        if os.path.isfile(full) or os.path.islink(full):
            os.remove(full)
        elif os.path.isdir(full):
            shutil.rmtree(full)


def _pick_goals(framework: ABAFramework, count: int) -> List[Tuple[str, str]]:
    """Pick (standpoint, head) pairs to serve as goals."""
    candidates = [(r.standpoint, r.head) for r in framework.rules if r.standpoint != UNIVERSAL_STANDPOINT and not r.head.startswith("not_")]
    if not candidates:
        candidates = [(r.standpoint, r.head) for r in framework.rules if not r.head.startswith("not_")]
    if not candidates:
        candidates = [(UNIVERSAL_STANDPOINT, r.head) for r in framework.facts]

    random.shuffle(candidates)
    return candidates[:count]


def aba_to_standpoint_default_asp(
    F: ABAFramework,
    facts_by_sp: Dict[str, Set[str]],
) -> str:
    lines: List[str] = []
    seen_facts: Set[Tuple[str, str]] = set()  # (standpoint, fact)

    # facts
    for S, facts in facts_by_sp.items():
        for R in sorted(facts):
            R = _norm(R)
            key = (S, R)
            if key in seen_facts:
                continue
            seen_facts.add(key)
            lines.append(f"form(box({S},{R})).")

    # rules
    for r in F.rules:
        S = r.standpoint
        nonasm = [_norm(x) for x in r.body_nonasm]
        asm = [_norm(x) for x in r.body_asm]
        R = _norm(r.head)

        # empty body ⇒ fact
        if not nonasm and not asm:
            key = (S, R)
            if key in seen_facts:
                continue
            seen_facts.add(key)
            lines.append(f"form(box({S},{R})).")
            continue

        # no assumptions ⇒ strict rule
        if not asm:
            P = _and_term(nonasm)
            lines.append(f"strictRule({S},{P},{R}).")
            continue

        # default with assumptions
        n = len(asm)
        if nonasm:
            P = _and_term(nonasm)
            qs = ",".join(asm)
            lines.append(f"default{n}({S},{P},{qs},{R}).")
        else:
            qs = ",".join(asm)
            lines.append(f"default{n}NoPrem({S},{qs},{R}).")

    return "\n".join(lines)


if __name__ == "__main__":
    configs = [
        (8, 0.25, 1, 1, 5),
        (12, 0.3, 2, 2, 5),
        (16, 0.35, 3, 3, 5),
        (20, 0.4, 4, 4, 5),
    ]

    out_aba = "instances_aba"
    out_sd = "instances_sd"
    _clear_dir(out_aba)
    _clear_dir(out_sd)

    rows = [["instance", "instance_raw", "goal", "standpoint"]]

    for i, (n_atoms, ar, n_sp, n_facts, n_goals) in enumerate(configs, start=1):
        fw = generate_aba_framework(
            n_atoms=n_atoms,
            assumption_ratio=ar,
            n_standpoints=n_sp,
            rules_per_sp=(1 + i, 2 + i),
            max_body_nonasm=2,
            max_body_asm=2,
            facts_per_star=(n_facts, n_facts),
            seed=i,
        )

        enc_aba = to_asp_with_standpoints(fw)
        facts_by_sp = {UNIVERSAL_STANDPOINT: {r.head for r in fw.facts}}
        enc_sd = aba_to_standpoint_default_asp(fw, facts_by_sp)

        goals = _pick_goals(fw, n_goals)
        for sp, head in goals:
            suffix = _goal_suffix(sp, head)

            instance_name = f"instance_{i}_{suffix}.lp"

            aba_goal_lines = [enc_aba, *(_goal_fact(sp, head))]
            aba_goal_path = os.path.join(out_aba, instance_name)
            with open(aba_goal_path, "w") as f:
                f.write("\n".join(aba_goal_lines))

            sd_goal_lines = [enc_sd, _goal_constraint(sp, head)]
            sd_goal_path = os.path.join(out_sd, instance_name)
            with open(sd_goal_path, "w") as f:
                f.write("\n".join(sd_goal_lines))


            rows.append([instance_name, f"instance_{i}", _norm(head), sp])

    with open("instances_metadata.csv", "w", newline="") as csvfile:
        writer = csv.writer(csvfile)
        writer.writerows(rows)
