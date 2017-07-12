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

// #[rustr_export]
pub fn check_covering(a: &Vec<u64>, b: &Vec<u64>) -> bool {

    let max_n  = max(b) - 1;
    let mut ns = vec![false; (max_n + 1) as usize];

    for (index, residual) in a.iter().enumerate() {
        let modulo = b[index];

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
