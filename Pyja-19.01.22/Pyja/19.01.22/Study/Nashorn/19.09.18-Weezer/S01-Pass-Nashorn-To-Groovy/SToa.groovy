gf_sys_props = { x_key ->
  final fu_it = System .getProperty (x_key)
  if ( fu_it == null ) { throw new NullPointerException ( "System property not found => ${x_key}" ) }
  fu_it
}
println "Java version => ${ gf_sys_props 'java.version' }"
println "Groovy version => ${GroovySystem.version}"
println "GC_GR's class => ${GC_GR.class}"
println "GC_NA's class => ${ GC_NA .getClass () }"
GC_NA .print ( "Call Nashorn's print from Groovy : Hello ${ 111 + 999 }\n" )
println GC_NA.gu_string
println "Nashorn function's class => ${ GC_NA .gf_hello .getClass () }"
println GC_NA .gf_hello .call ( GC_NA, 'Electrika' )
GC_NA .getClass () .metaClass .methodMissing = { x_name, x_args -> GC_NA ."$x_name" .call ( GC_NA, * x_args ) }
println GC_NA .gf_hello ('^^')
println GC_NA .gf_sum ( 1, 20, 3000000000000000 )

// Java version => 1.8.0_202
// Groovy version => 2.5.5
// GC_GR's class => class org.codehaus.groovy.jsr223.GroovyScriptEngineImpl
// GC_NA's class => class jdk.nashorn.api.scripting.ScriptObjectMirror
// Call Nashorn's print from Groovy : Hello 1110
// Hello, this is Nashorn string
// Nashorn function's class => class jdk.nashorn.api.scripting.ScriptObjectMirror
// Hello Electrika !!!
// Hello ^^ !!!
// 3000000000000021
