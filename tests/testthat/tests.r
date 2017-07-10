## Test coverings and congruences
library(testthat)

# context("Coverings")

testCoverings <- lapply( list.files("./", ".cover$")
                       , function(file) {
                           cover      <- read.cover(file)
                           cover$file <- file
                           cover
                           }
                       )

badCoverings  <- lapply( list.files("./", ".bad$")
                       , function(file) {
                           cover      <- read.cover(file)
                           cover$file <- file
                           cover
                         }
                       )

fastCoverings <- list( read.cover("finch.RF3.cover")
                     , read.cover("finch.SF3.cover")
                     , read.cover("finch.RF4.cover")
                     , read.cover("finch.SF4.cover")
                     )

test_that("findK returns the correct k and mod values", {
    for (ct in testCoverings) {
        s <- findK(ct)
        expect_equal(s$k,   ct$solution$k  )
        expect_equal(s$mod, ct$solution$mod)
    }
})

test_that("findK fails on bad coverings", {
    for (ct in badCoverings) {
        s <- findK(ct)
        expect_false(s$k   == ct$solution$k  )
        expect_false(s$mod == ct$solution$mod)
    }
})

test_that("testCovering returns TRUE for good coverings", {
    
    for (ct in testCoverings) {
        expect_true(testCovering(ct))
    }
    
})

test_that("testCovering returns FALSE for bad coverings", {
    
    for (ct in badCoverings) {
        if (ct$bad == 'covering') {
            expect_false(testCovering(ct))
        }
    }
    
})

# test_that("lcm.seq returns the correct solution mod in test coverings", {
#     for (ct in testCoverings) {
#         mod <- ct$solution$mod
#         expect_equal( lcm.seq(ct$m), mod )
#     }
# })

test_that("residueClass returns results in test coverings", {
    
    for (ct in testCoverings) {
        sequence <- sequences[[ct$sequence]]
        expect_equal( sequence$residueClass(ct)
                    , ct$r
                    , info = ct$file
                    )
    }
    
    
})


# TODO

# Test parse-print-parse stability

# Pruning:  randomly permute the order of the covering -> get consistent answers
