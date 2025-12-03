#!/usr/bin/env bash

CLINGO="$1"
INSTANCE="$2"

# fixed encoding list
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

if [ -z "$CLINGO" ] || [ -z "$INSTANCE" ]; then
    echo "usage: $0 <path/to/clingo> <instance.lp>"
    exit 1
fi

out=$("$CLINGO" -n 1 --quiet=1,2 "${ENCODING[@]}" "$INSTANCE" 2>/dev/null)

if echo "$out" | grep -q "UNSATISFIABLE"; then
    echo "NO"
    exit 0
fi

if echo "$out" | grep -q "SATISFIABLE"; then
    echo "YES"
    exit 0
fi

echo "ERROR"
exit 1
