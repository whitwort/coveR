use test::Bencher;
use super::*;

#[test]
fn check_good() {
  let a = vec![0, 0, 1, 11, 7, 31, 19];
  let b = vec![2, 3, 4, 12, 9, 36, 36];
  assert!(check_covering(&a, &b));
}

#[test]
fn check_bad() {
  let a_bad = vec![0, 1, 11, 7, 31, 19];
  let b_bad = vec![3, 4, 12, 9, 36, 36];
  assert!(!check_covering(&a_bad, &b_bad));
}

#[bench]
fn benchmark_check_covering(bench: &mut Bencher) {
  let a = vec![0, 0, 1, 11, 7, 31, 19];
  let b = vec![2, 3, 4, 12, 9, 36, 36];
  bench.iter(|| { check_covering(&a, &b) });
}
