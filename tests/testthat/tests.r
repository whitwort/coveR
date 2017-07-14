## Test coverings and congruences
library(testthat)

# context("Coverings")

testCoverings <- list( list( r = c(0, 0, 1, 11, 7, 31, 19)
                           , m = c(2, 3, 4, 12, 9, 36, 36)
                           )
                     , list( r = c(0, 0, 1, 11,  1, 4,  7)
                           , m = c(2, 3, 4, 12, 18, 9, 36)
                           )
                     , list( r = c(0, 0, 1, 11,  1, 31,  7)
                           , m = c(2, 3, 4, 12, 18, 36, 36)
                           )
                     )
badCoverings  <- list( list( r = c(0, 0, 1, 11, 31, 19)
                           , m = c(2, 3, 4, 12, 36, 36)
                           )
                     , list( r = c(0, 1, 11, 7, 31, 19)
                           , m = c(3, 4, 12, 9, 36, 36)
                           )
                     )

test_that("check_covering returns TRUE for good coverings", {
    
    for (ct in testCoverings) {
        expect_true(check_covering(as.integer(ct$r), as.integer(ct$m)))
    }
    
})

test_that("check_covering returns FALSE for bad coverings", {
    
    for (ct in badCoverings) {
        expect_false(check_covering(as.integer(ct$r), as.integer(ct$m)))
    }
    
})
