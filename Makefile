TESTFILES = $(wildcard testfiles/exm*.lp)
ENCODING = sffsmm.lp theta.lp propsat.lp unknown.lp ordering.lp standpoints.lp minimality.lp defaults.lp # filter.lp

# uncomment the following line instead to get a more compact / insightful representation -- warning, inefficient suited for debugging
# e.g. for the instance pcos-aaai.lp solving times are:
#   standard encoding - 1s
#   better representation - 78s
#  (requires extra encoding of all atoms. standpoint names see instances/pcos-aaai.lp)
# ENCODING = theta.lp propsat.lp unknown.lp ordering.lp standpoints.lp minimality.lp defaults.lp filter.lp

ONE = instances/pcos-aaai.lp

# ONE = instances/asp.lp
# ONE = instances/coffee.lp
# ONE = instances/default.lp
# ONE = instances/default2.lp

default: test

one: $(ENCODING) $(ONE)
	clingo --project 0 $(ENCODING) $(ONE); return 0

test: $(ENCODING) $(TESTFILES)
	for i in $(TESTFILES); \
	do \
		echo "--------------------------------------------------------------------------------"; \
		echo $$i; \
		cat $$i; \
		echo "\r\n--------------------------------------------------------------------------------"; \
		clingo --project 0 $(ENCODING) $$i; \
	done; \
	return 0