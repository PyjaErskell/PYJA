"use strict"

var GC_FOSA = java.io.File.separator;     // (fo)lder (s)ep(a)rator
var GC_PASA = java.io.File.pathSeparator; // (pa)th (s)ep(a)rator

function gf_pn (x_fn) { return x_fn .match ( /(.*)[\/\\]/ ) [1] || ''; }      // (p)ath (n)ame from given file name
function gf_bn (x_fn) { return x_fn .replace ( /^.*(\\|\/|\:)/, '' ); }       // (b)ase (n)ame from given file name
function gf_jn (x_fn) { var fu_bn = gf_bn (x_fn); return fu_bn .substr ( 0, fu_bn .lastIndexOf ('.') ); } // (j)ust (n)ame from given file name
function gf_if (x_it) { // (i)s (f)ile
  var fu_fl = new java.io.File (x_it);
  return fu_fl .exists () && fu_fl .isFile ();
}
function gf_id (x_it) { // (i)s (d)irectory
  var fu_fl = new java.io.File (x_it);
  return fu_fl .exists () && fu_fl .isDirectory ();
}

function gf_os_env (x_nm) {
  var fu_it = java.lang.System .getenv (x_nm);
  if ( fu_it == null ) { throw "Cannot find environment variable => " + x_nm; }
  return fu_it;
}

function gf_pj (x_args) { return x_args .join (GC_FOSA); } // (p)ath (j)oin
function gp_add_jar (x_jar_fn) {
  if ( ! gf_if (x_jar_fn) ) { throw ( "JAR file not found => " + x_jar_fn ); }
  var CClassArray = Java.type ("java.lang.Class[]");
  var pu_parameters = new CClassArray (1);
  pu_parameters [0] = java.net.URL.class;
  var pu_add_url = java.net.URLClassLoader.class .getDeclaredMethod ( "addURL", pu_parameters );
  pu_add_url .setAccessible (true);
  var pu_sys_cl = java.lang.ClassLoader .getSystemClassLoader ();
  var CObjectArray = Java.type ("java.lang.Object[]");
  var pu_array = new CObjectArray (1);
  pu_array [0] = new java.io.File (x_jar_fn) .toURL ();
  pu_add_url .invoke ( pu_sys_cl, pu_array );
}
function gp_set_library_paths (x_paths) {
  java.lang.System .getProperties () .setProperty ( "java.library.path", x_paths .join (GC_PASA) )
  var pu_sys_paths = java.lang.ClassLoader .class .getDeclaredField ("sys_paths")
  pu_sys_paths .setAccessible (true)
  pu_sys_paths .set ( null, null )
}

function gf_jc () { return java.lang.System .getProperty ("sun.java.command"); } // (j)ava (c)ommand given to java executable
function gf_jar_fn () { // (JAR) (f)ile (n)ame given to java executable
  var fu_java_cmd_line = gf_jc ();
  var fu_jar = ".jar";
  var fu_idx_jar = fu_java_cmd_line .toLowerCase () .indexOf (fu_jar); 
  return fu_java_cmd_line .substring ( 0, fu_idx_jar + fu_jar .length () );
}
function gf_js_fn () { // (J)ava(S)cript (f)ile (n)ame given to java executable
  var fu_java_cmd_line = gf_jc ();
  var fu_jar = ".jar";
  var fu_js = ".js";
  var fu_idx_jar = fu_java_cmd_line .toLowerCase () .indexOf (fu_jar); 
  var fu_idx_js = fu_java_cmd_line .toLowerCase () .indexOf (fu_js);
  return fu_java_cmd_line .substring ( fu_idx_jar + fu_jar .length () + 1, fu_idx_js + fu_js .length () );
}

var GC_PYJA_HM = gf_os_env ("SC_PYJA_HM");
gp_add_jar ( gf_pj ( [ GC_PYJA_HM, "Library", "Groovy", "2.4.15", "embeddable", "groovy-all-2.4.15-indy.jar" ] ) );
gp_add_jar ( gf_os_env ("SC_JEP_JAR_FN") );
gp_set_library_paths ( [ gf_os_env ("SC_JEP_PN") ] );

var GC_JEP = ( function () {
  var fu_it;
  try { fu_it = new ( Java.type ("jep.Jep") ) (false); }
  catch (bu2_ex) { throw "Cannot create Jep =>\n" + bu2_ex.message; }
  fu_it .eval ( "import sys" );
  fu_it .eval ( "sys.dont_write_bytecode = True" );
  fu_it .set ( "GC_LOG_DEBUG", false )
  fu_it .set  ( "JC_JEP", fu_it );
  var fu_jar_jn = gf_jn ( gf_jar_fn () );
  if ( fu_jar_jn == "ScriptRunner" ) {
    fu_it .set  ( "JC_BR", br );
    fu_it .set  ( "JC_BW", bw );
  } else if ( fu_jar_jn == "ImageScriptRunner" ) {
    fu_it .set  ( "JC_IR", inputReader );
    fu_it .set  ( "JC_OR", outputReader );
  }
  return fu_it;
} ) ();

function gp_run_py (x_it) {
  var pu_fn = [ GC_PYJA_HM, "Program" ] .concat (x_it) .join (GC_FOSA)
  if ( ! gf_if (pu_fn) ) { throw ( "Python script file not found => " + pu_fn ); }
  GC_JEP .set ( "GC_APP_NM", x_it [0] )
  GC_JEP .set ( "GC_PY_FN", pu_fn )
  try { GC_JEP .runScript (pu_fn); }
  catch (bu2_ex) { throw "Cannot run Python script =>\n" + bu2_ex.message; }
}
