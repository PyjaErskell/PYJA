GC_NH .print ( "Call Nashorn's print from Groovy : Hello ${ 111 + 999 }\n" )
println GC_NH.gu_string
println "Nashorn function's class name => ${ GC_NH .gf_hello .getClass () }"
println GC_NH .gf_hello .call ( GC_NH, 'Electrika' )
