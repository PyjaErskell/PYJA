#
# Python (Global)
#

import sys

sys.dont_write_bytecode = True

from datetime import datetime

GC_ST = datetime.now () # (G)lobal (C)onstant

GC_PYJA_NM = 'Pyja'
GC_PYJA_AU = 'Erskell' # (au)thor

GC_PJYA_CEN = 20
GC_PYJA_YEA = 18
GC_PYJA_MON =  2
GC_PYJA_DAY =  1

GC_PYJA_CD = f'{GC_PJYA_CEN:02d}{GC_PYJA_YEA:02d}.{GC_PYJA_MON:02d}.{GC_PYJA_DAY:02d}' # Pyja creation date
GC_PYJA_VR = f'{GC_PYJA_YEA:02d}.{GC_PYJA_MON:02d}.{GC_PYJA_DAY:02d}'                  # Pyja version with fixed length 8
GC_PYJA_V2 = f'{GC_PYJA_YEA}.{GC_PYJA_MON}.{GC_PYJA_DAY}'                              # Pyja version without leading zero

GC_PYJA_VER_MAJ = GC_PYJA_YEA # Major 
GC_PYJA_VER_MIN = GC_PYJA_MON # Minor
GC_PYJA_VER_PAT = GC_PYJA_DAY # Patch

GC_PYJA_RT_SYM = '@`'
GC_PYJA_HM_SYM = '@~'
GC_MILO_PN_SYM = '@!'

GC_EC_NONE     = -200
GC_EC_SHUTDOWN = -199
GC_EC_SUCCESS  = 0
GC_EC_ERROR    = 1

from PyQt5 import QtCore
from PyQt5.QtCore import pyqtSignal
from PyQt5.QtCore import QCoreApplication
from PyQt5.QtCore import QObject
from PyQt5.QtCore import QStandardPaths
from PyQt5.QtCore import Qt
from PyQt5.QtCore import QThread
from PyQt5.QtCore import QTimer
from PyQt5.QtWidgets import QApplication
from PyQt5.QtWidgets import QDesktopWidget

GC_PYQT_VR = QtCore .qVersion ()
GC_QAPP = QApplication ([])

import os

GC_FOSA = os.sep     # (fo)lder (s)ep(a)rator
GC_PASA = os.pathsep # (pa)th (s)ep(a)rator

from collections import namedtuple
import ctypes
import getpass
import inspect
import logging
import platform
import psutil
import re
import shutil
import time
import tkinter
import traceback
import types

GC_PYTHON_VR = platform .python_version ()

GC_TOTAL_CPU = psutil.cpu_count ()
GC_TOTAL_MEMORY = psutil.virtual_memory () .total
GC_HOST_NM = platform.node()
GC_CUSR = getpass.getuser ()
GC_THIS_PID = os.getpid ()

def gf_os_env (x_key) : return os.environ [x_key] # (g)lobal (f)unction
def gf_str_is_valid_date ( x_str, x_format ) :
  try : time .strptime ( x_str, x_format )
  except ValueError : return False
  else : return True
def gf_rm_px ( x_str, x_px ) : # px : prefix
  return x_str [ len (x_px) : ] if x_str .startswith (x_px) else x_str

GC_OS_ENV_PATHS = gf_os_env ('SC_PATH') .split (GC_PASA)

def gf_ap (x_it) : # ap -> (a)bs(p)ath, x -> parameter
  fu_trans = str.maketrans ( '\\','/' ) # (f)unction val(u)e
  fu_ap = os.path.abspath ( x_it .translate (fu_trans) )
  return fu_ap .translate (fu_trans)
def gf_fn (x_fn) : # (f)ile (n)ame
  fu_trans = str.maketrans ( '\\','/' )
  fu_abs_fn = os.path.abspath ( x_fn .translate (fu_trans) )
  return fu_abs_fn .translate (fu_trans)
def gf_jn (x_fn) : # (j)ust (n)ame
  fu_fn = gf_fn (x_fn)
  return os.path.splitext ( os.path.basename (fu_fn) ) [0]
def gf_xn (x_fn) : # e(x)tension (n)ame
  fu_split = gf_bn (x_fn) .split ('.')
  return fu_split [-1] if len (fu_split) > 1 else ''
def gf_bn (x_fn) : # (b)ase (n)ame
  fu_fn = gf_fn (x_fn)
  return os.path.basename (fu_fn)
def gf_pn (x_pn) : # (p)ath (n)ame
  fu_trans = str.maketrans ( '\\','/' )
  fu_abs_pn = os.path.abspath ( os.path.dirname ( x_pn .translate (fu_trans) ) )
  return fu_abs_pn .translate (fu_trans)
def gf_on (x_pn) : # f(o)lder (n)ame
  fu_pn = gf_ap (x_pn)
  return os.path.basename (fu_pn)
def gf_pj (*x_args) : # (p)ath (j)oin
  fu_trans = str.maketrans ( '\\','/' )
  return '/' .join (x_args) .translate (fu_trans)

GC_THIS_START_UP_PN = gf_ap ( os.getcwd () )

GC_THIS_EXE_FN = gf_fn (sys.executable)
GC_THIS_EXE_JN = gf_jn (GC_THIS_EXE_FN)
GC_THIS_EXE_XN = gf_xn (GC_THIS_EXE_FN)
GC_THIS_EXE_BN = gf_bn (GC_THIS_EXE_FN)
GC_THIS_EXE_PN = gf_pn (GC_THIS_EXE_FN)
GC_THIS_EXE_ON = gf_on (GC_THIS_EXE_FN)

GC_CMD = psutil.Process () .cmdline ()
def __gaf_asa () : # __gaf -> (__)private (g)lobal priv(a)te (f)unction
  fu_app_nm = ...
  fu_script_fn = ...
  fv_idx4script = 0 # (f)unction (v)ariable
  for bu2_idx, bu2_it in enumerate (GC_CMD) : # bu2 -> (b)lock val(u)e nested level 2
    if gf_xn (bu2_it) .lower () in ['py'] :
      fv_idx4script = bu2_idx
      fu_script_fn = gf_fn (bu2_it)
      fu_app_nm = gf_jn (fu_script_fn)
      break
  fu_argv = GC_CMD [fv_idx4script+1:] if ( fv_idx4script + 1 ) < len(GC_CMD) else []
  return fu_app_nm, fu_script_fn, fu_argv
GC_APP_NM, GC_SCRIPT_FN, GC_ARGV = __gaf_asa ()
sys.argv = [ GC_SCRIPT_FN ] + GC_ARGV

GC_PYJA_RT   = gf_ap ( gf_os_env ('SC_PYJA_RT') )
GC_PYJA_HM   = gf_ap ( gf_os_env ('SC_PYJA_HM') )
GC_PYTHON_HM = gf_ap ( gf_os_env ('SC_PYTHON_HM') )
GC_MILO_PN   = gf_ap ( gf_os_env ('SC_MILO_PN') )

def gf_banner ( x_leading_space = 0, x_margin_inside = 2 ) :
  fu_msgs = [
    '{} {}' .format ( GC_PYJA_NM, GC_APP_NM ),
    'made by {}' .format (GC_PYJA_AU),
    '',
    'ran on {:04d}-{:02d}-{:02d} {:02d}:{:02d}:{:02d}' .format (
      GC_ST.year, GC_ST.month, GC_ST.day,
      GC_ST.hour, GC_ST.minute, GC_ST.second,
    ),
    'released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.',
  ]
  fu_msl = max ( list ( map ( ( lambda bx2_it : len (bx2_it) ), fu_msgs ) ) ) # max string length
  fu_ls = x_leading_space # leading space before box
  fu_mg = x_margin_inside # margin inside box
  fu_ll = fu_mg + fu_msl + fu_mg # line length inside box
  def ff2_get_line () : return ' ' * fu_ls + '+' + '-' * fu_ll + '+' # ff2 -> (f)unction inside (f)unction nested level (2)
  def ff2_get_string (x2_str) :
    fu2_sl = len (x2_str) # string lentgh
    fu2_lm = int ( ( fu_ll - fu2_sl ) / 2.0 ) # left margin inside box
    fu2_rm = fu_ll - ( fu2_sl + fu2_lm ) # right margin inside box
    return ' ' * fu_ls + ':' + ' ' * fu2_lm + x2_str + ' ' * fu2_rm + ':' 
  fu_r = [ ff2_get_line () ] + list ( map ( ( lambda bx2_msg : ff2_get_string (bx2_msg) ), fu_msgs ) ) + [ ff2_get_line () ]
  return fu_r

def gf_ppn (x_pn) : # (p)arent (p)ath (n)ame
  fu_pn = gf_ap (x_pn)
  return os.path.dirname (fu_pn)

def gf_ppn_list ( x_pn, x_include_self = False ) :
  fu_pn = gf_ap (x_pn)
  fv_list = []
  fv_prev_ppn = ...
  if x_include_self :
    fv_list.append (fu_pn)
    fv_prev_ppn = fu_pn
  fv_ppn = os.path.dirname (fu_pn)
  while fv_ppn != fv_prev_ppn :
    fv_list.append (fv_ppn)
    fv_prev_ppn = fv_ppn
    fv_ppn = os.path.dirname (fv_ppn)
  return fv_list

def gf_on_list (x_pn) :
  fu_pn = gf_ap (x_pn)
  return fu_pn .split ('/')
def gf_np (x_it) : # (n)orm(p)ath
  return os.path.normpath (x_it)
def gp_rt (x_pn) : # gp -> (g)lobal (p)rocedure, rt -> (r)emove (t)ree
  if gf_il (x_pn) : gp_ul (x_pn)
  elif gf_id (x_pn) : shutil.rmtree (x_pn)
def gp_mp (x_pn) : # (m)ake (p)ath
  if not gf_id (x_pn) : os.makedirs (x_pn)
def gp_ep (x_pn) : # (e)mpty out (p)ath
  if not gf_id (x_pn) : return
  pu_pn, pu_ons, pu_bns = next ( os.walk (x_pn) )
  for bu2_on in pu_ons :
    bu2_pn = gf_pj ( pu_pn, bu2_on )
    gp_rt (bu2_pn)
  for bu2_bn in pu_bns :
    bu2_fn = gf_pj ( pu_pn, bu2_bn )
    gp_ul (bu2_fn)

gf_xi = os.path.exists # e(xi)sts
gf_id = os.path.isdir # (i)s (d)irectory
gf_if = os.path.isfile # (i)s (f)ile
gp_cp = shutil.copy # (c)o(p)y
gp_ul = os.unlink # (u)n(l)ink
gp_rf = os.remove # (r)emove (f)ile
gp_rd = os.rmdir # (r)emove (d)irectory

GC_TCL = tkinter.Tcl ()
GC_TCL.eval ( """
  proc gf_tcl_ver {} {
    return [info tclversion]
  }
  proc gf_run_xcmd {args} {
    set fu_ec [ catch { set fu_result [ exec {*}$args ] } fu_error ]
    if { $fu_ec } {
      return [ list $fu_ec $fu_error ]
    }
    return [ list $fu_ec $fu_result ]
  }
  proc gf_il {x_it} { # (i)s (l)ink
    return [ expr { [file type $x_it] eq "link" } ]
  }
  proc gp_ml { x_link x_target } { # (m)ake (l)ink
    file link -symbolic $x_link $x_target
  }
""")
GC_TCL_VR = GC_TCL.call ('gf_tcl_ver')

def gf_run_xcmd (x_xcmd) :
  fu_r = types.SimpleNamespace ()
  fu_called = GC_TCL.call ( 'gf_run_xcmd', *x_xcmd )
  fu_r.ru_ec = fu_called [0]
  fu_r.ru_message = fu_called [1]
  return fu_r
def gf_il (x_it) : # (i)s (l)ink
  return GC_TCL.call ( 'gf_il', x_it ) == 1
def gp_ml ( x_src, x_link ) : # (m)ake (l)ink
  return GC_TCL.call ( 'gp_ml', x_link, x_src )

def gf_exception_to_list () :
  fv_fe = traceback.format_exception ( * sys.exc_info () )
  del fv_fe [0]
  fv_fe.reverse ()
  fv_fe = map ( ( lambda bx2 : bx2.rstrip () ), fv_fe )
  return list (fv_fe)

def gf_process (x_pid) : return psutil.Process (x_pid)
def gf_os_available_memory () : return psutil.virtual_memory () .available

def gf_replace_with_px_symbol ( x_pn, x_px_path, x_px_symbol ) :
  fu_pn = gf_ap (x_pn)
  if fu_pn .startswith (x_px_path) : return gf_pj ( x_px_symbol, fu_pn [ len (x_px_path) + 1 : ] )
  else : return fu_pn
def gf_to_prs (x_pn) : # to (p)yja (r)oot (s)ymbol
  return gf_replace_with_px_symbol ( x_pn, GC_PYJA_RT, GC_PYJA_RT_SYM )
def gf_to_phs (x_pn) : # to (p)yja (h)ome (s)ymbol
  return gf_replace_with_px_symbol ( x_pn, GC_PYJA_HM, GC_PYJA_HM_SYM )
def gf_to_mps (x_pn) : # to (m)ilo (p)ath (s)ymbol
  return gf_replace_with_px_symbol ( x_pn, GC_MILO_PN, GC_MILO_PN_SYM )

def gp_log_array ( xp_out, x_title, x_array ) :
  if x_title is not None : xp_out ( '{} :'.format ( x_title ) )
  for bu2_idx, bu2_it in enumerate ( x_array, start = 1 ) : xp_out ( '  {:2d} => {}' .format ( bu2_idx, bu2_it ) )
def gp_log_dict ( xp_out, x_title, x_dict ) :
  if x_title is not None : xp_out ( '{} :'.format ( x_title ) )
  for bu2_idx, bu2_it in enumerate ( sorted(list(x_dict.keys())), start = 1 ) : xp_out ( '  {:2d} : {} => {}' .format ( bu2_idx, bu2_it, x_dict [bu2_it] ) )
def gp_log_header ( xp_out, x_header, x_line_width ) :
  xp_out ( '+' + '-' * x_line_width )
  xp_out ( ': {}' .format (x_header) )
  xp_out ( '+' + '-' * x_line_width )
def gp_log_exception ( xp_out, x_title, x_ex, x_header_line_width ) :
  pu_type = type(x_ex)
  if pu_type is str : 
    gp_log_header ( xp_out, x_title, x_header_line_width )
    xp_out (x_ex)
  elif pu_type is list :
    gp_log_header ( xp_out, x_title, x_header_line_width )
    xp_out ( "\n" .join (x_ex) )
  else :
    gp_log_header ( xp_out, f'Invalid exception type !!!', x_header_line_width )
    xp_out (f'{x_ex}')

class __DgLongLiveObjects :
  __dau_it = {}
  @classmethod
  def df_cllo ( cls, x_it, *x_args ) : # cllo -> (c)reate (l)ong (l)ive (o)bject
    fu_yo = ...
    if inspect.isclass (x_it) :
      fu_yo = x_it (*x_args)
    elif isinstance ( x_it, object ) :
      fu_yo = x_it
    else :
      raise Exception ( f'Unsupported {x_it} !!!' )
    fu_yi = gf_yi (fu_yo)
    cls.__dau_it [fu_yi] = fu_yo
    return fu_yi
  @classmethod
  def dp_dllo ( cls, x_yi ) : # dllo -> (d)estroy (l)ong (l)ive (o)bject
    cls.__dau_it .pop ( x_yi, None )
  @classmethod
  def df_it (cls) :
    return cls.__dau_it
gf_cllo = __DgLongLiveObjects.df_cllo
gp_dllo = __DgLongLiveObjects.dp_dllo
gf_llos = __DgLongLiveObjects.df_it
def gf_yo ( x_yi, x_dllo = False ) : # p(y)thon (o)bject
  fu_it = ctypes.cast ( x_yi, ctypes.py_object ) .value
  if x_dllo : gp_dllo (x_yi)
  return fu_it
def gf_yi (x_yo) : # p(y)thon (i)d
  return id (x_yo)

def gp_yn ( x_yi, x_nethod_nm, *x_args ) : # from p(y)thon id, call (n)ethod
  pu_yo = gf_yo (x_yi)
  if hasattr ( pu_yo, x_nethod_nm ) : getattr ( pu_yo, x_nethod_nm ) (*x_args)

def gf_wai ( x_msg = None ) :
  fu_frame = sys._getframe().f_back
  fu_module_nm = fu_frame.f_globals ['__name__']
  fu_func_nm = fu_frame.f_code.co_name
  fu_lineno = fu_frame.f_lineno
  fu_msg = f'@ {fu_module_nm}.{fu_func_nm} [{fu_lineno:03}]'
  if x_msg is None : return fu_msg
  return '{0} {1}' .format ( fu_msg, x_msg )

class TgWai : # (T)rait (g)lobal 
  @staticmethod
  def __tasm_wai ( x_qualname, x_msg = None ) : # tasm -> (t)rait priv(a)te (s)tatic (m)ethod
    mu_frame = sys._getframe().f_back.f_back # mu -> (m)ethod val(u)e
    mu_module_nm = mu_frame.f_globals ['__name__']
    mu_func_nm = mu_frame.f_code.co_name
    mu_lineno = mu_frame.f_lineno
    mu_msg = f'@ {mu_module_nm}.{x_qualname}.{mu_func_nm} [{mu_lineno:03}]'
    if x_msg is None : return mu_msg
    return '{0} {1}' .format ( mu_msg, x_msg )
  @classmethod
  def tcm_wai ( cls, x_msg = None ) : return cls.__tasm_wai ( cls.__qualname__, x_msg ) # tcm -> (t)rait (c)lass (m)ethod
  def tm_wai ( self, x_msg = None ) : return self.__class__.__tasm_wai ( self.__class__.__qualname__, x_msg ) # tm -> (t)rait public instance (m)ethod

LgCx = namedtuple ( 'LgCx', [ 'lu_ec', 'lu_ex' ] )

class CgQo (QObject) :
  def __init__ (self) :
    super () .__init__ ()
    self.cu_yi = gf_yi (self)

#
# Java (Global)
#

import jep

JC_GR = jep .findClass ('javax.script.ScriptEngineManager') () .getEngineByName ('groovy')
JC_GR .put ( 'GC_JEP', JC_JEP )

def jy_ge (x_str) : return JC_GR .eval (x_str)
jy_ge (f'''
  GC_APP_NM      = '{GC_APP_NM}'
  GC_EC_NONE     = {GC_EC_NONE}
  GC_EC_SHUTDOWN = {GC_EC_SHUTDOWN}
  GC_EC_SUCCESS  = {GC_EC_SUCCESS}
  GC_EC_ERROR    = {GC_EC_ERROR}
  GC_THIS_PID    = {GC_THIS_PID}
''')
jy_ge ('''
  gf_jcls = { final String x_cls_nm -> return Class.forName (x_cls_nm) }
  gp_add_jar = { final String x_jar_fn ->
    if ( ! new File (x_jar_fn) .exists () ) { throw new FileNotFoundException ( "JAR file not found => ${x_jar_fn}" ) }
    final URL pu_url = new File (x_jar_fn) .toURI () .toURL ()
    final URLClassLoader pu_cl = ClassLoader .getSystemClassLoader ()
    final fu_m = URLClassLoader.class .getDeclaredMethod 'addURL', URL.class
    fu_m.setAccessible true
    fu_m.invoke pu_cl, pu_url
  }
  gp_sr = { final Closure xp_it -> // (S)wing (r)un
    javax.swing.SwingUtilities .invokeLater { xp_it () }
  } 
  gp_xr = { final Closure xp_it -> // JavaF(x) (r)un
    javafx.application.Platform .runLater { xp_it () }
  }
  gp_cy = { final String x_fun_nm, final Object... x_args -> GC_JEP .invoke ( x_fun_nm, *x_args ) } // (c)all p(y)thon
  gp_yn = { final long x_yi, final String x_nethod_nm, final Object... x_args -> gp_cy ( 'gp_yn', x_yi, x_nethod_nm, *x_args ) }
  gf_is_fat = { return javafx.application.Platform .isFxApplicationThread () }
  Object.metaClass.gp_xr = gp_xr
  Object.metaClass.gp_yn = gp_yn
''')
def jf_jarray (x_py_list) :
  fu_arr_sz = len (x_py_list)
  fu_params = jy_ge ( f'new Object [{fu_arr_sz}]' )
  for bu2_idx, bu2_it in enumerate ( x_py_list ) : fu_params [bu2_idx] = x_py_list [bu2_idx]
  return fu_params
def jy_gf ( x_nm, *x_args ) : return JC_GR. invokeFunction ( x_nm, jf_jarray (x_args) )
def jy_gm ( x_oj, x_nm, *x_args ) : return JC_GR. invokeMethod ( x_oj, x_nm, jf_jarray (x_args) )
def jy_gc ( x_closure, *x_args ) :
  yu_closure = jy_ge (x_closure) if type(x_closure) is str else x_closure
  return jy_gm ( yu_closure, 'call', *x_args )
def jf_gi (x_cls) : return jy_ge ( f'@groovy.transform.Immutable {x_cls}' ) # (g)roovy (i)mmutable class
def jf_jcls (x_cls_nm) : return jy_gf ( 'gf_jcls', x_cls_nm )
def jp_add_jar (x_jar_fn) : jy_gf ( 'gp_add_jar', x_jar_fn )

for bu2_jar_fn in [
  gf_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'akka-actor_2.12-2.5.9.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'config-1.3.2.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-library.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-classic-1.2.3.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-core-1.2.3.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
] : jp_add_jar (bu2_jar_fn)

jy_ge ('''
  GC_LOG = org.slf4j.LoggerFactory .getILoggerFactory () .with { bx2_lc ->
    reset ()
    getLogger ("GC_LOG") .with { bx3_log ->
      addAppender ( new ch.qos.logback.core.ConsoleAppender () .with { bx4_ca ->
        setContext (bx2_lc)
        setEncoder ( new ch.qos.logback.classic.encoder.PatternLayoutEncoder () .with {
          setContext (bx2_lc)
          setPattern ( "[${ String.format ( '%06d', GC_THIS_PID ) },%.-1level,%date{yyMMdd-HHmmss}] %msg%n" )
          start ()
          it
        } )
        start ()
        bx4_ca
      } )
      bx3_log
    }
  }
  gp_set_log_level_to_info  = { GC_LOG.level = ch.qos.logback.classic.Level.INFO }
  gp_set_log_level_to_warn  = { GC_LOG.level = ch.qos.logback.classic.Level.WARN }
  gp_set_log_level_to_debug = { GC_LOG.level = ch.qos.logback.classic.Level.DEBUG }
  gp_set_log_level_to_trace = { GC_LOG.level = ch.qos.logback.classic.Level.TRACE }
  gp_set_log_level_to_debug ()
  gp_log_array = { final xp_out = GC_LOG.&info, final x_title, final x_array ->
    xp_out "${x_title} => "
    x_array.eachWithIndex { final bx2_it, final bx2_idx -> xp_out "  ${ (bx2_idx+1) .toString() .padLeft(2) } : $bx2_it" }
  }
  gp_log_header = { final xp_out = GC_LOG.&info, final x_header, final x_line_width = 60 ->
    xp_out '+' + '-' * x_line_width
    xp_out ": ${x_header}"
    xp_out '+' + '-' * x_line_width
  }
  gp_log_exception = { final xp_out = GC_LOG.&error, final x_title, final x_ex ->
    gp_log_header xp_out, x_title
    x_ex .each { xp_out "  ${it}" }
  }
  Object.metaClass.GC_LOG = GC_LOG
  Object.metaClass.gp_log_array = gp_log_array
  Object.metaClass.gp_log_header = gp_log_header
  Object.metaClass.gp_log_exception = gp_log_exception
''')

JC_LOG = jy_ge ('GC_LOG')
def jp_set_log_level_to_info () :  jy_gf ( 'gp_set_log_level_to_info' )
def jp_set_log_level_to_warn () :  jy_gf ( 'gp_set_log_level_to_warn' )
def jp_set_log_level_to_debug () : jy_gf ( 'gp_set_log_level_to_debug' )
def jp_set_log_level_to_trace () : jy_gf ( 'gp_set_log_level_to_trace' )

def jp_os_exit (x_ec) :
  JC_LOG .info ( 'Elapsed {} ...' .format ( datetime.now () - GC_ST ) )
  os._exit (x_ec)

jy_ge ('''
  gp_exit = { final long x_ec, final x_ex = [] ->
    def pp2_before_exit = {
      if (x_ex) gp_log_exception "Following error occurs !!!", x_ex
      if ( x_ec != GC_EC_SUCCESS && !x_ex ) { gp_log_header ( GC_LOG.&error, "Unknown error occurs !!!" ); }
      switch (x_ec) {
        case GC_EC_NONE : GC_LOG .error "Undefined exit code (GC_EC_NONE), check your logic !!!"; break
        case GC_EC_SHUTDOWN : GC_LOG .info "Exit from shutdown like ctrl+c, ..."; break
        default :
          if ( x_ec < 0 ) GC_LOG .error "Negative exit code ${x_ec}, should consider using a positive value !!!"
          else GC_LOG .info "Exit code => ${x_ec}"
          break
      }
    }
    def pp2_exit = {
      switch (x_ec) {
        case GC_EC_NONE : gp_cy ( 'jp_os_exit', GC_EC_ERROR ); break
        case GC_EC_SHUTDOWN : gp_cy ( 'jp_os_exit', GC_EC_ERROR ); break
        default :
          if ( x_ec < 0 ) gp_cy ( 'jp_os_exit', GC_EC_ERROR )
          else  gp_cy ( 'jp_os_exit', x_ec .intValue () )
          break
      }
    }
    pp2_before_exit ()
    pp2_exit ()
  }
''')

CjSystem   = jf_jcls ('java.lang.System')

CjActorRef = jf_jcls ('akka.actor.ActorRef')
CjAwait    = jf_jcls ('scala.concurrent.Await')
CjDuration = jf_jcls ('scala.concurrent.duration.Duration')

CjByteArrayInputStream = jf_jcls ('java.io.ByteArrayInputStream')
CjByteArrayOutputStream = jf_jcls ('java.io.ByteArrayOutputStream')

JC_JAVA_VR = CjSystem .getProperty ('java.version')
JC_GROOVY_VR = jf_jcls ('groovy.lang.GroovySystem') .getVersion ()

def jf_ba_2_jbais (x_ba) : # (b)yte (a)rray (2) (j)ava (b)yte (a)rray (i)nput (s)tream
  fu_jbaos = CjByteArrayOutputStream ()
  for bx2_it in x_ba .data () : fu_jbaos .write (bx2_it)
  fu_jbais = CjByteArrayInputStream ( fu_jbaos .toByteArray () )
  return fu_jbais

class __DjExit : # (__)private mo(D)ule (g)lobal
  __dav_cx = LgCx ( GC_EC_NONE, None )
  __dav_was_lgcx_processed = False
  @classmethod
  def dp_it ( cls, x_cx ) :
    JC_LOG .debug ( f'Received LgCx ({x_cx.lu_ec})' )
    if cls.__dav_was_lgcx_processed == False :
      cls.__dav_was_lgcx_processed = True
      cls.__dav_cx = x_cx
      cls.__dap_before_exit ()
      cls.__dap_exit ()
  @classmethod
  def __dap_before_exit (cls) :
    pu_ec = cls.__dav_cx.lu_ec
    pu_ex = cls.__dav_cx.lu_ex
    if pu_ex is not None : gp_log_exception ( JC_LOG .error, 'Following error occurs !!!', pu_ex, 60 )
    if pu_ec != GC_EC_SUCCESS and pu_ex is None : gp_log_header ( JC_LOG .error, 'Unknown error occurs !!!', 60 )
    if pu_ec == GC_EC_NONE : JC_LOG .error ( 'Undefined exit code (GC_EC_NONE), check your logic !!!' )
    elif pu_ec == GC_EC_SHUTDOWN : JC_LOG .info ( 'Exit from shutdown like ctrl+c, ...' )
    elif pu_ec < 0 : JC_LOG .error ( f'Negative exit code ({pu_ec}), should consider using a positive value !!!' )
    else : JC_LOG .info ( 'Exit code => {}' .format (pu_ec) )
  @classmethod
  def __dap_exit (cls) :
    pu_ec = cls.__dav_cx.lu_ec
    if pu_ec == GC_EC_NONE : jp_os_exit (GC_EC_ERROR)
    elif pu_ec == GC_EC_SHUTDOWN : jp_os_exit (GC_EC_ERROR)
    elif pu_ec < 0 : jp_os_exit (GC_EC_ERROR)
    else : jp_os_exit (pu_ec)

def __jap_exit ( x_ec, x_ex = None ) :
  pu_llos = gf_llos ()
  if len(pu_llos) > 0 :
    JC_LOG .warn ( f'You did not delete {len(pu_llos)} llo(s) with gp_dllo () function after using llo(s) !!!' )
    gp_log_dict ( JC_LOG .warn, 'Undeleted python llo(s)', pu_llos )
  pu_ex = ...
  if x_ex is None : pu_ex = None
  else : pu_ex = x_ex
  __DjExit .dp_it ( LgCx ( x_ec, pu_ex ) )

def jp_request_exit ( x_ec, x_ex_list = None ) :
  jf_jcls ('javafx.application.Platform') .exit ()
  if JC_AS is not ... :
    JC_AS .terminate ()
    CjAwait .ready ( JC_AS .whenTerminated (), CjDuration .Inf () )
  pu_ex = ...
  if x_ex_list is None : pu_ex = None
  else :
    pu_ex = "\n" .join ( map ( lambda bx3_it : str (bx3_it), x_ex_list ) )
  if pu_ex == None : jy_ge ( f"gp_xr {{ gp_cy ( '__jap_exit', {x_ec} ) }}" )
  else :
    jy_gc ('''
      { x_ec, final String x_ex -> 
        gp_xr { gp_cy ( '__jap_exit', x_ec, x_ex ) }
      }
    ''', x_ec, pu_ex )

jy_ge ('''
  addShutdownHook {
    if ( gf_is_fat () ) {
      gp_cy ( '__jap_exit', GC_EC_SHUTDOWN, 'Shutdown occurred !!!' )
    } else {
      gp_exit ( GC_EC_SHUTDOWN, [ 'Shutdown occurred !!!' ] )
    }
  }
''')

jy_ge ('''
  class CgAt extends akka.actor.AbstractActor { // (A)c(t)or
    final private long __cau_yi_at
    CgAt ( final long x_yi_at ) { this.__cau_yi_at = x_yi_at }
    void preStart () {
      gp_xr { gp_yn ( this.__cau_yi_at, 'cn_pre_start', this ) }
    }
    akka.actor.AbstractActor.Receive createReceive () {
      return receiveBuilder () .match ( Object.class, { x_letter ->
        gp_xr { gp_yn ( this.__cau_yi_at, 'cn_receive', x_letter, getSender () ) }
      } ) .build ()
    }
    void postStop () {
      gp_xr { gp_yn ( this.__cau_yi_at, 'cn_post_stop' ) }
    }
  }
  gf_mk_atr = { final long x_yi_at, final String x_at_nm, final akka.actor.ActorRefFactory x_arf -> // atr -> (a)c(t)or (r)eference
    switch (x_at_nm) {
      case ':a' : return x_arf .actorOf ( akka.actor.Props .create ( CgAt, x_yi_at ) )
      default : return x_arf .actorOf ( akka.actor.Props .create ( CgAt, x_yi_at ), x_at_nm )
    }
  }
''')
class CjAt (QObject) :
  def __init__ (self) :
    super () .__init__ ()
    self.cu_yi = gf_cllo (self)
  def cn_pre_start ( self, x_at_org ) :
    try :
      self.cu_at_org = x_at_org
      if hasattr ( self, 'preStart' ) : getattr ( self, 'preStart' ) ()
    except : jp_request_exit ( GC_EC_ERROR, gf_exception_to_list () )
  def cn_receive ( self, x_letter, x_atr_sender ) :
    try :
      if hasattr ( self, 'receive' ) : getattr ( self, 'receive' ) ( x_letter, x_atr_sender )
    except : jp_request_exit ( GC_EC_ERROR, gf_exception_to_list () )
  def cn_post_stop (self) :
    try :
      if hasattr ( self, 'postStop' ) : getattr ( self, 'postStop' ) ()
      gf_yo ( self.cu_yi, True )
    except : jp_request_exit ( GC_EC_ERROR, gf_exception_to_list () )
  def getSelf (self) : return self.cu_at_org .getSelf ()
  def getContext (self) : return self.cu_at_org .getContext ()
  def tell ( self, x_atr_target, x_letter, x_atr_sender = None ) :
    nu_atr_sender = self .getSelf () if x_atr_sender == None else x_atr_sender
    x_atr_target .tell ( x_letter, nu_atr_sender )
JC_AS = ...
def jf_mk_atr ( x_at, x_at_nm, x_arf = None ) :
  global JC_AS
  if JC_AS is ... : JC_AS = jy_ge ( '''Object.metaClass.{0} = akka.actor.ActorSystem .create '{0}', com.typesafe.config.ConfigFactory .parseString ( 'akka {{ loglevel = "ERROR" }}' )''' .format ('GC_AS') )
  fu_arf = JC_AS if x_arf is None else x_arf
  fu_at_nm = x_at.__class__.__name__ if x_at_nm == ':c' else ':a' if x_at_nm == None else x_at_nm
  return jy_gf ( 'gf_mk_atr', gf_yi (x_at), fu_at_nm, fu_arf )

#
#

class DRun :
  @classmethod
  def __dap_begin (cls) :
    print ( "\n" .join ( gf_banner () ) )
    JC_LOG .debug ( f'Pyja name => {GC_PYJA_NM}' )
    if GC_PYJA_NM != gf_os_env ('SC_PYJA_NM') : raise Exception ( 'Invalid Pyja name !!!' )
    JC_LOG .debug ( f'Pyja creation date => {GC_PYJA_CD}' )
    if not gf_str_is_valid_date ( GC_PYJA_CD, '%Y.%m.%d' ) : raise Exception ( 'Pyja create date is not invalid !!!' )
    JC_LOG .debug ( f'Pyja version => {GC_PYJA_V2}' )
    if GC_PYJA_VR != gf_os_env ('SC_PYJA_VR') : raise Exception ( 'Invalid Pyja version !!!' )
    JC_LOG .info  ( f'Pyja root ({GC_PYJA_RT_SYM}) => {GC_PYJA_RT}' )
    JC_LOG .info  ( f'Pyja home ({GC_PYJA_HM_SYM}) => { gf_to_prs (GC_PYJA_HM) }' )
    JC_LOG .info  ( f'Milo path ({GC_MILO_PN_SYM}) => { gf_to_phs (GC_MILO_PN) }' )
    JC_LOG .info  ( f'Java version => {JC_JAVA_VR}' )
    JC_LOG .info  ( f'Python version => {GC_PYTHON_VR}' )
    JC_LOG .info  ( f'Tcl version => {GC_TCL_VR}' )
    JC_LOG .info  ( f'PyQt version => {GC_PYQT_VR}' )
    JC_LOG .info  ( f'Groovy version => {JC_GROOVY_VR}' )
    JC_LOG .debug ( f'Python home => {GC_PYTHON_HM}' )
    JC_LOG .debug ( f'Total CPU => {GC_TOTAL_CPU}' )
    JC_LOG .debug ( f'Total memory => {GC_TOTAL_MEMORY:,d} bytes' )
    JC_LOG .debug ( f'Available memory => {gf_os_available_memory():,d} bytes' )
    JC_LOG .debug ( f'Computer name => {GC_HOST_NM}' )
    JC_LOG .debug ( f'Current user => {GC_CUSR}' )
    JC_LOG .debug ( f'Process ID => {GC_THIS_PID}' )
    JC_LOG .debug ( f'Executable file => {GC_THIS_EXE_FN}' )
    JC_LOG .info  ( f'Start up path => { gf_to_phs (GC_THIS_START_UP_PN) }' )
    JC_LOG .info  ( f'Script file => { gf_to_mps (GC_SCRIPT_FN) }' )
    gp_log_array ( JC_LOG .debug, 'Paths', GC_OS_ENV_PATHS )
    if len(GC_CMD) > 0 : gp_log_array ( JC_LOG .debug, 'Command', GC_CMD )
    if len(GC_ARGV) > 0 : gp_log_array ( JC_LOG .info, 'Arguments', GC_ARGV )
  @classmethod
  def dp_it (cls) :
    try :
      cls.__dap_begin ()
      DBody .dp_it ()
    except :
      jp_request_exit ( GC_EC_ERROR, gf_exception_to_list () )

#
# Your Source
#

from PyQt5.QtCore import QBuffer
from PyQt5.QtCore import QByteArray
from PyQt5.QtCore import QIODevice
from PyQt5.QtGui import QPixmap
from PyQt5.QtWidgets import QDesktopWidget

CjFxImage     = jf_jcls ('javafx.scene.image.Image')
CjFxImageView = jf_jcls ('javafx.scene.image.ImageView')
CjFxLabel     = jf_jcls ('javafx.scene.control.Label')
CjFxPos       = jf_jcls ('javafx.geometry.Pos')
CjFxScene     = jf_jcls ('javafx.scene.Scene')
CjFxVBox      = jf_jcls ('javafx.scene.layout.VBox')
CjFxWebView   = jf_jcls ('javafx.scene.web.WebView')

class WFxMain ( CgQo, TgWai ) :
  def __init__ (self) :
    super () .__init__ ()
    self .wn_init ()
  def wn_init (self) :
    JC_LOG .info ( self.tm_wai ('Initializing ...') )
    self.wu_stage = JC_FX_STAGE
    self.wu_root = CjFxVBox ()
    self.wu_scene = CjFxScene ( self.wu_root, 650, 650 )
    self.wu_stage .setTitle (GC_APP_NM)
    self.wu_stage .setScene (self.wu_scene)
    nu_svg_fn = gf_pj ( GC_MILO_PN, 'as', 'fx-180611-1413.svg' )
    JC_LOG .info ( f'SVG file => { gf_to_mps (nu_svg_fn) }' )

    nu_ba = QByteArray ()
    nu_bf = QBuffer (nu_ba)
    nu_bf .open (QIODevice.WriteOnly)
    QPixmap (nu_svg_fn) .save ( nu_bf, 'PNG' )

    self.wu_iv_svg = CjFxImageView ( CjFxImage ( jf_ba_2_jbais (nu_ba) ) )
    self.wu_wv_license = CjFxWebView ()
    self.wu_wv_license .getEngine () .loadContent ('''
      <center>
        <div>Icons made by <a href="https://www.flaticon.com/authors/pixel-perfect" title="Pixel perfect">Pixel perfect</a>
        from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed
        by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
      </center>
    ''')
    self.wu_root .setAlignment (CjFxPos.CENTER)
    self.wu_root .setSpacing (10)
    self.wu_root .getChildren () .addAll ( [ self.wu_iv_svg, self.wu_wv_license ] )
    jy_gc ('''{ x_yi, x_stage ->
      x_stage .with {
        onShown = { gp_yn x_yi, 'wn_shown' }
        onCloseRequest = { gp_yn x_yi, 'wn_quit' }
      }
    }''', self.cu_yi, self.wu_stage )
    self.wu_stage .show ()
    self .wn_move_center ()
  def wn_move_center (self) :
    nu_cp = QDesktopWidget () .availableGeometry () .center () # center point
    self.wu_stage .setX ( nu_cp .x () - self.wu_stage .getWidth () / 2 )
    self.wu_stage .setY ( nu_cp .y () - self.wu_stage .getHeight () / 2 )
  def wn_shown (self) : JC_LOG .info ( 'Stage shown ...' )
  def wn_quit (self) :
    JC_LOG .info ( self.tm_wai ( 'About to quit ...' ) )
    jp_request_exit (GC_EC_SUCCESS)

class DBody :
  @classmethod
  def dp_it (cls) :
    GC_QAPP .setStyle ('fusion')
    cls.du_fx = WFxMain ()

class OStart :
  @classmethod
  def main (cls) :
    jp_set_log_level_to_info ()
    DRun .dp_it ()
  
if __name__ == '__main__':
  OStart .main ()
