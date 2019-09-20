var gu_na = this;
var GC_FOSA = java.io.File.separator;     // (fo)lder (s)ep(a)rator
var GC_PASA = java.io.File.pathSeparator; // (pa)th (s)ep(a)rator
var CgString = java.lang.String;
var CgSystem = java.lang.System;
function gf_sf () { return CgString .format ( arguments [0], Java .to ( Array.prototype.slice .call ( arguments, 1 ) ) ); }
function gp_println () { CgSystem.out.println ( gf_sf .apply ( null, arguments ) ); }
function gf_if (x_it) { // (i)s (f)ile
  var fu_fl = new java.io.File (x_it);
  return fu_fl .exists () && fu_fl .isFile ();
}
function gf_os_env (x_key) {
  var fu_it = CgSystem .getenv (x_key);
  if ( fu_it == null ) { throw "Environment variable not found => " + x_key; }
  return fu_it;
}
function gf_os_env_has (x_key) { return CgSystem .getenv (x_key) != null; }
function gf_sys_props (x_key) {
  var fu_it = CgSystem .getProperty (x_key);
  if ( fu_it == null ) { throw "System property not found => " + x_key; }
  return fu_it;
}
function gf_pj () { return Array.prototype.join .call ( arguments, GC_FOSA ); } // (p)ath (j)oin
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
GC_TONO_HM = gf_os_env ("SC_TONO_HM");
( function () {
  var pu_os = gf_sys_props ("os.name") .toLowerCase ();
  if ( pu_os .contains ("mac") ) { gu_na.GC_KAPA_HM = gf_pj ( "", "Applications", "Kapa" ); }
  else if ( pu_os .contains ("win") ) { gu_na.GC_KAPA_HM = gf_pj ( "C:", "PROGRA~1", "Kapa" ) }
} ) ();
[
  gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Apache', 'Commons', 'IO', '2.5', 'commons-io-2.5.jar' ),
  gf_pj ( GC_KAPA_HM, "19.01.22", "Cumuni", "Groovy", "2.5.5", "indy", "groovy-2.5.5-indy.jar" ),
  gf_pj ( GC_KAPA_HM, "19.01.22", "Cumuni", "Groovy", "2.5.5", "indy", "groovy-jsr223-2.5.5-indy.jar" ),
  gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'JNA', '5.1.0', 'jna-5.1.0.jar' ),
  gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'JNA', '5.1.0', 'jna-platform-5.1.0.jar' ),
] .forEach ( function ( x_it, x_idx, x_arr ) { gp_add_jar (x_it) } );
( function () { gu_na.GC_GR = new Packages.javax.script.ScriptEngineManager () .getEngineByName("Groovy"); gp_gr_p ( "GC_GR", GC_GR ); } ) ();
gp_gr_p ( "gu_na", gu_na );
gy_gr_e ( new java.io.FileReader ( gf_pj ( GC_TONO_HM, "SToa.groovy" ) ) );
function gy_gr_e (x_str) { return GC_GR .eval (x_str); }
function gf_gr_g (x_key) { return GC_GR .get (x_key); }
function gp_gr_p ( x_key, x_val ) { GC_GR .put ( x_key, x_val ); }
function gy_gr_f () { return GC_GR .invokeFunction ( arguments [0], Java .to ( Array.prototype.slice .call ( arguments, 1 ) ) ); }
var gu_gr = gf_gr_g ("gu_gr");
( function () { gu_na.GC_PY = gy_gr_f ("gf_new_python"); gp_gr_p ( "GC_PY", GC_PY ); } ) ();
GC_PY .set ( 'GC_GR', GC_GR );
GC_PY .set ( 'GC_PY', GC_PY );
GC_PY .set ( 'gu_na', gu_na );
GC_PY .set ( 'gu_gr', gu_gr );
GC_PY .runScript ( gf_pj ( GC_TONO_HM, "SToa.py" ) );
gy_gr_f ("gp_make_globals");

function sp_test () {
  function pp2_gr_ev (x_str) {
    gp_println ( "[NA] Groovy eval : %s => %s", x_str, gy_gr_e (x_str) );  
  }
  gp_println ( "+--------------------------------------------------------------------" );
  gp_println ( ": Nashorn" );
  gp_println ( "+--------------------------------------------------------------------" );
  gp_println ( "[NA] Milo path (%s) => %s", gf_gr_g ('GC_MILO_PN_SYM'), gu_gr.GC_MILO_PN );
  gp_println ( "[NA] Tono home (%s) => %s", gu_gr.GC_TONO_HM_SYM, gu_gr.gf_to_mps.call ( gu_gr.GC_TONO_HM ) );
  gp_println ( "[NA] Kapa home (%s) => %s", gu_gr.GC_KAPA_HM_SYM, gu_gr.GC_KAPA_HM );
  gp_println ( "[NA] GC_GR class name => %s", GC_GR .getClass () .getName () );
  gp_println ( "[NA] GC_PY class name => %s", GC_PY .getClass () .getName () );
  gp_println ( "[NA] gu_na class name => %s", gu_na.constructor.name );
  gp_println ( "[NA] gu_gr class name => %s", gu_gr .getClass () .getName () );
  pp2_gr_ev ( "gf_to_ths (\"C:\\\\NotExit\")" );
  pp2_gr_ev ( "gu_na .getClass () .getName ()" );
}

function sp_main () {
  sp_test ();
  gu_gr.sp_test.call ();
  GC_PY .invoke ("sp_test");
}

sp_main ();

// +--------------------------------------------------------------------
// : Nashorn
// +--------------------------------------------------------------------
// [NA] Milo path (@!) => C:\Program Files\Pyja\19.01.22\Study\Nashorn\19.09.18-Weezer
// [NA] Tono home (@*) => @!\S04-Python
// [NA] Kapa home (@^) => C:\PROGRA~1\Kapa
// [NA] GC_GR class name => org.codehaus.groovy.jsr223.GroovyScriptEngineImpl
// [NA] GC_PY class name => jep.Jep
// [NA] gu_na class name => Object
// [NA] gu_gr class name => javax.script.SimpleBindings
// [NA] Groovy eval : gf_to_ths ("C:\\NotExit") => C:\NotExit
// [NA] Groovy eval : gu_na .getClass () .getName () => jdk.nashorn.api.scripting.ScriptObjectMirror
// +--------------------------------------------------------------------
// : Groovy
// +--------------------------------------------------------------------
// [GR] Milo path (@!) => C:\Program Files\Pyja\19.01.22\Study\Nashorn\19.09.18-Weezer
// [GR] Tono home (@*) => @!\S04-Python
// [GR] Kapa home (@^) => C:\PROGRA~1\Kapa
// [GR] Folder Separator => \
// [GR] Path Separator => ;
// [GR] Java command => ORun
// [GR] Java version => 1.8.0_202
// [GR] Groovy version => 2.5.5
// [GR] GC_GR class name => org.codehaus.groovy.jsr223.GroovyScriptEngineImpl
// [GR] GC_PY class name => jep.Jep
// [GR] gu_na class name => jdk.nashorn.api.scripting.ScriptObjectMirror
// [GR] gu_gr class name => javax.script.SimpleBindings
// +--------------------------------------------------------------------
// : Python
// +--------------------------------------------------------------------
// [PY] Python version => 3.6.4
// [PY] PyQt version => 5.6.2
// [PY] Folder separator => \
// [PY] Path separator => ;
// [PY] Is Windows ? => True
// [PY] Total memory => 8,589,443,072 bytes
// [PY] GC_GR class name => PyJObject
// [PY] GC_PY class name => PyJAutoCloseable
// [PY] gu_na class name => PyJMap
// [PY] gu_gr class name => PyJMap
// [PY] GC_GR java name => org.codehaus.groovy.jsr223.GroovyScriptEngineImpl
// [PY] GC_PY java name => jep.Jep
// [PY] gu_na java name => jdk.nashorn.api.scripting.ScriptObjectMirror
// [PY] gu_gr java name => javax.script.SimpleBindings
// [PY] gu_na's GC_TONO_HM => C:\Program Files\Pyja\19.01.22\Study\Nashorn\19.09.18-Weezer\S04-Python
// [PY] gu_gr's GC_KAPA_HM => C:\PROGRA~1\Kapa
