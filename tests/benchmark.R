library(microbenchmark)
library(magrittr)
source("tests/testthat/tests.r")

r <- as.integer(testCoverings[[1]]$r)
m <- as.integer(testCoverings[[1]]$m)

r_check_covering <- function(r, m) {
  ns <- as.numeric(max(m) - 1)
  
  covers <- function(r, m, seq = 1:(m - 1)) { seq[seq %% m == r] }
  
  mapply(covers, r, m, MoreArgs = list(seq = 1:ns)) %>%
    c(recursive = TRUE)                             %>%
    unique                                          %>%
    length == ns
  
}

microbenchmark(r_check_covering(r, m), check_covering(r, m), times = 1000)
