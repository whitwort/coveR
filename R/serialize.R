ct.columns        <- 1:6
names(ct.columns) <- c("a","b","r","p","c","h")

#' Cover class
#' 
#' Coverings are list like objects consumed and produced by many of the
#' functions in this package.
#' 
#' @param a numeric vector containing remainders for the covering
#' @param b numeric vector containing moduli for the covering
#' @param r 
#' @param p 
#' @param s 
#' @param h 
#' @param solution 
#' @param ... 
#'
#' @details The lengths of a, b must be the same.
#'
#' @return a covering object
covering    <- function(a = NA, b = NA, r = NA, p = NA, s = NA, h = NA, solution = list(k = NA, mod = NA), ...) {
  tools::assertError(length(a) == length(b))
  as.cover(list(..., solution = solution, a, b, r, p, s, h))
}

#' @describeIn covering Convert a list-like object to a covering
as.cover <- function(x) {
  x <- as.list(x)
  if (is.null(x$solution)) {
    x$solution  <- list(k = as.bigz(NA), mod = as.bigz(NA))
  }
  class(x) <- "cover"
  x
}

format.cover <- function(x, pretty = TRUE) {
  annotations <- x[setdiff(names(x), names(ct.columns))]
  
  if (length(annotations) > 0) {
    if (!is.null(annotations$solution)) {
      annotations$solution <- printMod( annotations$solution$k
                                      , annotations$solution$mod
                                      , pretty = pretty
                                      )
    }
    
    head <- paste("---\n", yaml::as.yaml(annotations), "---\n", sep = "")
  } else { 
    head <- NULL
  }
  
  body <- paste( printMod(x$a, x$b, pretty)
               , printMod(x$r, x$p, pretty)
               , printMod(x$c, x$h, pretty)
               , sep = " "
               )
  
  paste(c(head, body), sep = "\n", collapse = "\n")
  
}

print.cover  <- function(x, pretty = TRUE) { cat(format(x, pretty)) }

parseMod <- function(s) {
  s %>%
    gsub(   "\\s",    "", .)        %>% 
    gsub("\\(mod", "%.%", .)        %>% 
    gsub(   "\\)", "%.%", .)        %>% 
    strsplit(split = "%.%")
}

printMod <- function(n, m, pretty = TRUE) {
  n <- as.character(n)
  m <- as.character(m)
  if (pretty) {
    n <- stringr::str_pad(n, max(nchar(n), 1))
    m <- stringr::str_pad(m, max(nchar(m), 1))
  }
  paste(n, " (mod ", m, ")", sep = "")
}

read.cover  <- function(file) {
  lines <- readLines(file)
  lines <- lines[lines != ""]
  
  headerN <- grep("^---\\s*$", lines)
  
  if (length(headerN) == 2) {
    headers <- (headerN[1] + 1):(headerN[2] - 1)
    
    annotations <- yaml::yaml.load( paste(lines[headers], collapse = "\n") )
    if (!is.null(annotations$solution)) {
      solution <- parseMod(annotations$solution)
      annotations$solution <- list( k   = as.bigz(solution[[1]][1])
                                  , mod = as.bigz(solution[[1]][2])
                                  )
    }
    
    lines   <- lines[-c(headerN, headers)]
    
  } else {
    annotations <- list()
  }
  
  parseData <- lines %>% 
    parseMod         %>%
    unlist()         %>%
    matrix(ncol = 6, byrow = TRUE)
  
  as.cover( c( annotations
             , lapply( ct.columns
                     , function(i) { as.bigz(parseData[,i]) }
                     )
             )
          )
}

write.cover <- function(ct, file = "", pretty = TRUE) {    
  write(format(ct, pretty), file)
}
