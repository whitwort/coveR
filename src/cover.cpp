#include <Rcpp.h>
using namespace Rcpp;


//' @title session_count
//' @description Session counting function
//' 
//' @details Blarg
//' @export
// [[Rcpp::export]]
List rcpp_hello_world() {

    CharacterVector x = CharacterVector::create( "foo", "bar" )  ;
    NumericVector y   = NumericVector::create( 0.0, 1.0 ) ;
    List z            = List::create( x, y ) ;

    return z ;
}