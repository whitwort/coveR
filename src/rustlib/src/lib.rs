#![feature(test)]
extern crate test;

#[cfg(test)]
mod tests;

#[macro_use]
extern  crate rustr;
pub mod export;
pub use rustr::*;

fn max(x: &[u64]) -> u64 {
    *x.iter().max_by(|x, y| x.cmp(y)).unwrap()
}

fn all_true(x: &Vec<bool>) -> bool {
    for i in 0..x.len() {
        if x[i] == false { return false; }
    }

    true
}

// ' Check a covering for a set of moduli and residuals
// ' 
// ' Checks whether or not a set of residuals and moduli.  Both parameters 
// ' (r and m) must be integer vectors; use \code{\link{as.integer}} to convert 
// ' generic numeric vectors to integer vectors.
// '
// ' @param r an integer vector containing residues
// ' @param m an integer vector containing the moduli
// ' @return a single boolean value
// '
// ' @export
// #[rustr_export]
pub fn check_covering(r: &Vec<u64>, m: &Vec<u64>) -> bool {

    let max_n  = max(m);
    let mut ns = vec![false; (max_n + 1) as usize];

    for (index, residual) in r.iter().enumerate() {
        let modulo = m[index];

        let mut i = 0;
        loop {
            let n = (i * modulo) + residual;
            if n > max_n { break; }
            ns[n as usize] = true;
            i += 1;
        }

    }

    all_true(&ns)
}

pub fn vectorize(size: usize) -> Vec<i32> {
    let mut zero_vec: Vec<i32> = Vec::with_capacity(size);
    for num in 0..size {
        zero_vec.push(num);
    }
    return zero_vec;
}
