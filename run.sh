#!/usr/bin/env bash

CLINGO="$1"
INSTANCE="$2"

DIR="$(cd "$(dirname "$0")" && pwd)"

ENCODING=(
    "$DIR/sffsmm.lp"
    "$DIR/theta.lp"
    "$DIR/propsat.lp"
    "$DIR/unknown.lp"
    "$DIR/ordering.lp"
    "$DIR/standpoints.lp"
    "$DIR/minimality.lp"
    "$DIR/transform.lp"
    "$DIR/defaults.lp"
)

if [ -z "$CLINGO" ] || [ -z "$INSTANCE" ]; then
    echo "usage: $0 <path/to/clingo> <instance.lp>"
    exit 1
fi

out=$("$CLINGO" -n 1 --quiet=2,2 --outf=0 "${ENCODING[@]}" "$INSTANCE" 2>&1)
status=$?

# if [ $status -ne 0 ]; then
#     echo "ERROR (clingo exit $status)"
#     echo "$out"
#     exit $status
# fi

if echo "$out" | grep -q "UNSATISFIABLE"; then
    echo "NO"
    exit 0
fi

if echo "$out" | grep -q "SATISFIABLE"; then
    echo "YES"
    exit 0
fi

echo "ERROR (unexpected solver output)"
echo "$out"
exit 1
