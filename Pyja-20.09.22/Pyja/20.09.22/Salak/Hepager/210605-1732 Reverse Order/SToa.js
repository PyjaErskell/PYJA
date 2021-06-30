// +-----------------------------------------------------------------------+
// :                                 Pyja                                  :
// :                    https://github.com/PyjaErskell                     :
// :               made by Erskell (pyja.erskell@gmail.com)                :
// :  released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.  :
// +-----------------------------------------------------------------------+

//---------
// Global
//---------

"use strict"

var gu_n = this; // (n)ashorn

var CjFile = java.io.File;
var CjSystem = java.lang.System;

var GC_TONO_HM = new CjFile (__DIR__) .path;
var GC_FOSA = CjFile .separator;     // (fo)lder (s)ep(a)rator
var GC_PASA = CjFile .pathSeparator; // (pa)th (s)ep(a)rator

function gf_if (x_it) { return new CjFile (x_it) .isFile (); } // (i)s (f)ile
function gf_id (x_it) { return new CjFile (x_it) .isDirectory (); } // (i)s (d)irectory
function gf_xi (x_it) { return new CjFile (x_it) .exists (); } // e(xi)sts

function gf_pj () { return Array.prototype.join .call ( arguments, GC_FOSA ); } // (p)ath (j)oin

function gf_os_env (x_nm) {
  var fu_it = CjSystem .getenv (x_nm);
  if ( fu_it == null ) { throw "Cannot find environment variable => " + x_nm; }
  return fu_it;
}

function gp_add_jar (x_jar_fn) {
  if ( ! gf_if (x_jar_fn) ) { throw ( "JAR file not found => " + x_jar_fn ); }
  var CClassArray = Java.type ("java.lang.Class[]");
  var pu_parameters = new CClassArray (1);
  pu_parameters [0] = java.net.URL .class;
  var pu_add_url = java.net.URLClassLoader .class .getDeclaredMethod ( "addURL", pu_parameters );
  pu_add_url .setAccessible (true);
  var pu_sys_cl = java.lang.ClassLoader .getSystemClassLoader ();
  var CObjectArray = Java .type ("java.lang.Object[]");
  var pu_array = new CObjectArray (1);
  pu_array [0] = new CjFile (x_jar_fn) .toURL ();
  pu_add_url .invoke ( pu_sys_cl, pu_array );
}

function gp_add_java_library_path (x_java_library_pn) {
  if ( ! ( gf_xi (x_java_library_pn) && gf_id (x_java_library_pn) ) ) { throw ( "Java library path not found => " + x_java_library_pn ); }
  var pu_org_paths = CjSystem .getProperty ("java.library.path");
  if ( pu_org_paths .contains (x_java_library_pn) ) { return; }
  CjSystem .setProperty ( "java.library.path", pu_org_paths + GC_PASA + x_java_library_pn );
  var pu_f = java.lang.ClassLoader .class .getDeclaredField ("sys_paths")
  pu_f .setAccessible (true)
  pu_f .set ( null, null )
}

gp_add_jar ( gf_os_env ("__SAC_JEP_JAR_FN") );
gp_add_java_library_path ( gf_os_env ("__SAC_JEP_PN") );

var gu_t = new Packages.jep.Jep ( false, GC_TONO_HM ); // py(t)hon

function gf_tf () { return gu_t .invoke ( arguments [0], Java .to ( Array.prototype .slice .call ( arguments, 1 ) ) ); } // invoke (f)unction
function gp_ts ( x_key, x_val ) { gu_t .set ( x_key, x_val ); } // (s)et value
function gf_tg (x_key) { return gu_t .getValue (x_key); } // (g)et value
function gp_tx (x_str) { return gu_t .eval (x_str); } // e(x)ecute statement
function gf_te (x_str) { return gf_tf ( 'gf_te', x_str ); } // (e)valuate expression
function gp_trs (x_fn) { gp_ts ( '__file__', x_fn ); gu_t .runScript (x_fn); } // (r)un (s)cript

gp_tx ( 'import sys' )
gp_tx ( 'sys.dont_write_bytecode = True' )
gp_ts ( '__sau_n', gu_n );

//--------------
// Your Source
//--------------

gp_trs ( gf_pj ( GC_TONO_HM, 'SToa.py' ) );
