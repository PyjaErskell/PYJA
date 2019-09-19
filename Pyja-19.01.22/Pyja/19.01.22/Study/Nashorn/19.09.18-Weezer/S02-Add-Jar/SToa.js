var GC_NA = this;
var GC_FOSA = java.io.File.separator;     // (fo)lder (s)ep(a)rator
var GC_PASA = java.io.File.pathSeparator; // (pa)th (s)ep(a)rator

function gf_if (x_it) { // (i)s (f)ile
  var fu_fl = new java.io.File (x_it);
  return fu_fl .exists () && fu_fl .isFile ();
}
function gf_os_env (x_key) {
  var fu_it = java.lang.System .getenv (x_key);
  if ( fu_it == null ) { throw "Environment variable not found => " + x_key; }
  return fu_it;
}
function gf_os_env_has (x_key) { return java.lang.System .getenv (x_key) != null; }
function gf_sys_props (x_key) {
  var fu_it = java.lang.System .getProperty (x_key);
  if ( fu_it == null ) { throw "System property not found => " + x_key; }
  return fu_it;
}
function gf_pj () { return Array.prototype.join.call ( arguments, GC_FOSA ); } // (p)ath (j)oin
function gp_add_jar (x_jar_fn) {
  if ( ! gf_if (x_jar_fn) ) { throw ( "JAR file not found => " + x_jar_fn ); }
  var CClassArray = Java .type ("java.lang.Class[]");
  var pu_parameters = new CClassArray (1);
  pu_parameters [0] = java.net.URL.class;
  var pu_add_url = java.net.URLClassLoader.class .getDeclaredMethod ( "addURL", pu_parameters );
  pu_add_url .setAccessible (true);
  var pu_sys_cl = java.lang.ClassLoader .getSystemClassLoader ();
  var CObjectArray = Java .type ("java.lang.Object[]");
  var pu_array = new CObjectArray (1);
  pu_array [0] = new java.io.File (x_jar_fn) .toURL ();
  pu_add_url .invoke ( pu_sys_cl, pu_array );
}
( function () {
  var pu_os = gf_sys_props ("os.name") .toLowerCase ();
  if ( pu_os .contains ("mac") ) { GC_NA.GC_KAPA_HM = gf_pj ( "", "Applications", "Kapa" ); }
  else if ( pu_os .contains ("win") ) { GC_NA.GC_KAPA_HM = gf_pj ( "C:", "PROGRA~1", "Kapa" ) }
} ) ();
gp_add_jar ( gf_pj ( GC_KAPA_HM, "19.01.22", "Cumuni", "Groovy", "2.5.5", "indy", "groovy-2.5.5-indy.jar" ) );
gp_add_jar ( gf_pj ( GC_KAPA_HM, "19.01.22", "Cumuni", "Groovy", "2.5.5", "indy", "groovy-jsr223-2.5.5-indy.jar" ) );
var GC_GR = new Packages.javax.script.ScriptEngineManager () .getEngineByName("Groovy");
GC_GR .put ( "GC_GR", GC_GR );
GC_GR .put ( "GC_NA", GC_NA );
gu_string = "Hello, this is Nashorn string";
function gf_hello (x_name) { return "Hello " + x_name + " !!!"; }
function gf_sum ( x_1, x_2, x_3 ) { return new java.lang.Long ( x_1 + x_2 + x_3 ); }
GC_GR .eval ( new java.io.FileReader ( gf_pj ( gf_os_env ("SC_TONO_HM"), "SToa.groovy" ) ) );
