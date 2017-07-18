# coveR

Utilities for working with coverings in R and Rust.

## Installation

This package incorporates code compiled via [Rust](https://www.rust-lang.org/en-US/).  Follow [these instructions to install](https://www.rust-lang.org/en-US/install.html) the rust compiler and cargo developement tools.

For now, you'll need to opt into the Nightly Rust build toolchain as this package uses the new format for Rust test suites.  You can do that by executing these shell commands after installing Rust:

```shell
rustup install nightly
rustup default nightly
```

Next install the [RustR](https://rustr.org/) bridge packge from github:

```r
# install devtools if you don't already have it:
# install.packages("devtools")

# then install rustinr from github
devtools::install_github("rustr/rustinr")

# finally install this package from github
devtools::install_github("whitwort/coveR")
```

## Versions

0.1  Barebones first pass that implements a `check_covering` function

## License

[GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html)