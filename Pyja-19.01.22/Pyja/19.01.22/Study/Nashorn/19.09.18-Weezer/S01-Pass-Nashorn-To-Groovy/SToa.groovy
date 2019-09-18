GC_NH .print ( "Call Nashorn's print from Groovy : Hello ${ 111 + 999 }\n" )
println GC_NH.gu_string
println "Nashorn function's class name => ${ GC_NH .gf_hello .getClass () }"
println GC_NH .gf_hello .call ( GC_NH, 'Electrika' )
GC_NH .getClass () .metaClass .methodMissing = { x_name, x_args -> GC_NH ."$x_name" .call ( GC_NH, * x_args ) }
println GC_NH .gf_hello ('^^')
println GC_NH .gf_sum ( 1, 20, 3000000000000000 )

// Call Nashorn's print from Groovy : Hello 1110
// Hello, this is Nashorn string
// Nashorn function's class name => class jdk.nashorn.api.scripting.ScriptObjectMirror
// Hello Electrika !!!
// Hello ^^ !!!
// 3000000000000021
