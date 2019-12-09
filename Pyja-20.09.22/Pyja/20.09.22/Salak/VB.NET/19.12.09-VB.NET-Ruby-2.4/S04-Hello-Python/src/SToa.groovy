//---------------------------------------------------------------
// Global
//---------------------------------------------------------------

gf_cls = { x_cls_nm -> Class .forName (x_cls_nm) } // find class from string

gp_make_globals = { -> this.binding.variables .each { x2_key, x2_value -> if ( ! x2_key .startsWith ('_') ) { Object.metaClass."$x2_key" = x2_value } } }
gp_make_globals ()

//---------------------------------------------------------------
// Your Source
//---------------------------------------------------------------

sf_hello = { x_str, x_no -> "Hello ${ x_str * x_no } !!!" }
sf_sum = { long ... x_args -> x_args*.value .sum () }
