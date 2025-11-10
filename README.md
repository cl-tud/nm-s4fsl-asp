
# ASP Encoding of Non-Monotonic S4F Standpoint Logic

This repository contains a disjunctive ASP encoding of non-monotonic S4F standpoint logic.

## Usage

To run all unit tests:

```sh
make
# or
make test
```

To run the main example from the paper:

```sh
make one
```

You can modify the example used in `make one` by editing `instances/pcos-aaai.lp`, for example by flipping the pregnancy information (known or unknown). Additional examples can be found in the `instances/` directory.

Unit tests are located in the `testfiles/` directory.
