#!/usr/bin/env bash

# fixed encoding list (exactly as in your Makefile)
ENCODING=(
    sffsmm.lp
    theta.lp
    propsat.lp
    unknown.lp
    ordering.lp
    standpoints.lp
    minimality.lp
    transform.lp
    # defaults.lp
    more-defaults.lp
)

INSTANCE="$1"

if [ -z "$INSTANCE" ]; then
    echo "usage: $0 <instance.lp>"
    exit 1
fi

# run clingo: 1 model, quiet except SAT/UNSAT
out=$(clingo -n 1 --quiet=1,2 "${ENCODING[@]}" "$INSTANCE" 2>/dev/null)

if echo "$out" | grep -q "UNSATISFIABLE"; then
    echo "NO"
    exit 0
fi

if echo "$out" | grep -q "SATISFIABLE"; then
    echo "YES"
    exit 0
fi

# if clingo crashed or produced no banner
echo "ERROR"
exit 1