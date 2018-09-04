#
#  Python (Global)
#

import sys
sys.dont_write_bytecode = True

from datetime import datetime
GC_ST = datetime.now () # (G)lobal (C)onstant

from collections import namedtuple
import ctypes
import getpass
import inspect
import jep
import logging
import os
import platform
import psutil
import re
import shutil
import time
import tkinter
import traceback
import types

from PyQt5 import QtCore
from PyQt5.QtCore import pyqtSignal
from PyQt5.QtCore import QBuffer
from PyQt5.QtCore import QByteArray
from PyQt5.QtCore import QCoreApplication
from PyQt5.QtCore import QIODevice
from PyQt5.QtCore import QObject
from PyQt5.QtCore import QStandardPaths
from PyQt5.QtCore import Qt
from PyQt5.QtCore import QThread
from PyQt5.QtCore import QTimer
from PyQt5.QtGui import QPixmap
from PyQt5.QtWidgets import QApplication
from PyQt5.QtWidgets import QDesktopWidget

def gf_os_env (x_key) : return os.environ [x_key] # (g)lobal (f)unction
def gf_fn (x_fn) : # (f)ile (n)ame
  fu_trans = str .maketrans ( '\\','/' )
  fu_abs_fn = os.path .abspath ( x_fn .translate (fu_trans) )
  return fu_abs_fn .translate (fu_trans)
def gf_ap (x_it) : # ap -> (a)bs(p)ath, x -> parameter
  fu_trans = str .maketrans ( '\\','/' ) # (f)unction val(u)e
  fu_ap = os.path .abspath ( x_it .translate (fu_trans) )
  return fu_ap .translate (fu_trans)
def gf_jn (x_fn) : # (j)ust (n)ame
  fu_fn = gf_fn (x_fn)
  return os.path .splitext ( os.path .basename (fu_fn) ) [0]
def gf_bn (x_fn) : # (b)ase (n)ame
  fu_fn = gf_fn (x_fn)
  return os.path .basename (fu_fn)
def gf_xn (x_fn) : # e(x)tension (n)ame
  fu_split = gf_bn (x_fn) .split ('.')
  return fu_split [-1] if len (fu_split) > 1 else ''
def gf_pn (x_pn) : # (p)ath (n)ame
  fu_trans = str .maketrans ( '\\','/' )
  fu_abs_pn = os.path .abspath ( os.path .dirname ( x_pn .translate (fu_trans) ) )
  return fu_abs_pn .translate (fu_trans)
def gf_on (x_pn) : # f(o)lder (n)ame
  fu_pn = gf_ap (x_pn)
  return os.path .basename (fu_pn)
def gf_pj (*x_args) : # (p)ath (j)oin
  fu_trans = str .maketrans ( '\\','/' )
  return '/' .join (x_args) .translate (fu_trans)
gf_jar_pj = gf_pj
def gf_str_is_valid_date ( x_str, x_format ) :
  try : time .strptime ( x_str, x_format )
  except ValueError : return False
  else : return True
def gf_frange ( x_start, x_end, x_step = 1.0, x_include_end = False ) :
  fv_it = x_start # (f)unction (v)ariable
  while ( fv_it < x_end if not x_include_end else fv_it <= x_end ) :
    yield fv_it
    fv_it += x_step
def gf_rm_px ( x_str, x_px ) : # px : prefix
  return x_str [ len (x_px) : ] if x_str .startswith (x_px) else x_str
gf_xi = os.path .exists # e(xi)sts
gf_id = os.path .isdir # (i)s (d)irectory
gf_if = os.path .isfile # (i)s (f)ile
gp_cp = shutil .copy # (c)o(p)y
gp_ul = os .unlink # (u)n(l)ink
gp_rf = os .remove # (r)emove (f)ile
gp_rd = os .rmdir # (r)emove (d)irectory
def gf_ppn (x_pn) : # (p)arent (p)ath (n)ame
  fu_pn = gf_ap (x_pn)
  return os.path .dirname (fu_pn)
def gf_ppn_list ( x_pn, x_include_self = False ) :
  fu_pn = gf_ap (x_pn)
  fv_list = []
  fv_prev_ppn = ...
  if x_include_self :
    fv_list .append (fu_pn)
    fv_prev_ppn = fu_pn
  fv_ppn = os.path .dirname (fu_pn)
  while fv_ppn != fv_prev_ppn :
    fv_list .append (fv_ppn)
    fv_prev_ppn = fv_ppn
    fv_ppn = os.path .dirname (fv_ppn)
  return fv_list
def gf_on_list (x_pn) :
  fu_pn = gf_ap (x_pn)
  return fu_pn .split ('/')
def gf_np (x_it) : # (n)orm(p)ath
  return os.path .normpath (x_it)
def gp_mp (x_pn) : # (m)ake (p)ath
  if not gf_id (x_pn) : os .makedirs (x_pn)
def gf_exception_to_list () :
  fv_fe = traceback .format_exception ( * sys .exc_info () )
  del fv_fe [0]
  fv_fe .reverse ()
  fv_fe = map ( ( lambda bx2 : bx2 .rstrip () ), fv_fe )
  return list (fv_fe)
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
  if x_title is not None : xp_out ( '{} :' .format ( x_title ) )
  for bu2_idx, bu2_it in enumerate ( x_array, start = 1 ) : xp_out ( '  {:2d} => {}' .format ( bu2_idx, bu2_it ) )
def gp_log_dict ( xp_out, x_title, x_dict ) :
  if x_title is not None : xp_out ( '{} :' .format ( x_title ) )
  for bu2_idx, bu2_it in enumerate ( sorted(list(x_dict.keys())), start = 1 ) : xp_out ( '  {:2d} : {} => {}' .format ( bu2_idx, bu2_it, x_dict [bu2_it] ) )
def gp_log_header ( xp_out, x_header, x_line_width ) :
  xp_out ( '+' + '-' * x_line_width )
  xp_out ( ': {}' .format (x_header) )
  xp_out ( '+' + '-' * x_line_width )
def gp_log_lines ( xp_out, x_lines ) :
  for bu2_it in x_lines : xp_out ( '{}' .format (bu2_it) )
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
def gf_process (x_pid) : return psutil.Process (x_pid)
def gf_available_memory () : return psutil .virtual_memory () .available

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

GC_PYJA_RT   = gf_ap ( gf_os_env ('SC_PYJA_RT') )
GC_PYJA_HM   = gf_ap ( gf_os_env ('SC_PYJA_HM') )
GC_MILO_PN   = gf_ap ( gf_os_env ('SC_MILO_PN') )

GC_PYJA_RT_SYM = '@`'
GC_PYJA_HM_SYM = '@~'
GC_MILO_PN_SYM = '@!'

GC_KAPA_HM  = gf_ap ( gf_os_env ('SC_KAPA_HM') )
GC_JAVA_HM  = gf_ap ( gf_os_env ('SC_J8_HM') )
GC_PYTHON_HM = gf_ap ( gf_os_env ('SC_PYTHON_HM') )

GC_EC_NONE     = -200
GC_EC_SHUTDOWN = -199
GC_EC_SUCCESS  = 0
GC_EC_ERROR    = 1

GC_FOSA = os.sep     # (fo)lder (s)ep(a)rator
GC_PASA = os.pathsep # (pa)th (s)ep(a)rator

GC_QAPP = QApplication ([])
GC_PYTHON_VR = platform .python_version ()
GC_PYQT_VR = QtCore .qVersion ()

GC_TOTAL_CPU = psutil .cpu_count ()
GC_TOTAL_MEMORY = psutil .virtual_memory () .total
GC_HOST_NM = platform .node ()
GC_CUSR = getpass .getuser ()
GC_OS_ENV_PATHS = gf_os_env ('SC_PATH') .split (GC_PASA)

GC_THIS_PID = os .getpid ()
GC_THIS_EXE_FN = gf_fn (sys.executable)
GC_THIS_START_UP_PN = gf_ap ( os .getcwd () )

GC_DESKTOP_PN = QStandardPaths .writableLocation (QStandardPaths.DesktopLocation)
GC_DOWNLOAD_PN = QStandardPaths .writableLocation (QStandardPaths.DownloadLocation)

GC_THIS_CMD = psutil.Process () .cmdline ()
def __gaf_asa () : # __gaf -> (__)private (g)lobal priv(a)te (f)unction
  fu_app_nm = ...
  fu_script_fn = ...
  fv_idx4script = 0
  for bu2_idx, bu2_it in enumerate (GC_THIS_CMD) : # bu2 -> (b)lock val(u)e nested level 2
    if gf_xn (bu2_it) .lower () in ['py'] :
      fv_idx4script = bu2_idx
      fu_script_fn = gf_fn (bu2_it)
      fu_app_nm = gf_jn (fu_script_fn)
      break
  fu_argv = GC_THIS_CMD [fv_idx4script+1:] if ( fv_idx4script + 1 ) < len (GC_THIS_CMD) else []
  return fu_app_nm, fu_script_fn, fu_argv
GC_APP_NM, GC_SCRIPT_FN, GC_ARGV = __gaf_asa ()
GC_SCRIPT_PN = gf_pn (GC_SCRIPT_FN)

sys.argv = [ GC_SCRIPT_FN ] + GC_ARGV

GC_TCL = tkinter.Tcl ()
GC_TCL .eval ( """
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
GC_TCL_VR = GC_TCL .call ('gf_tcl_ver')
def gf_run_xcmd (x_xcmd) :
  fu_r = types.SimpleNamespace ()
  fu_called = GC_TCL .call ( 'gf_run_xcmd', *x_xcmd )
  fu_r.ru_ec = fu_called [0]
  fu_r.ru_message = fu_called [1]
  return fu_r
def gf_il (x_it) : # (i)s (l)ink
  return GC_TCL .call ( 'gf_il', x_it ) == 1
def gp_rt (x_pn) : # gp -> (g)lobal (p)rocedure, rt -> (r)emove (t)ree
  if gf_il (x_pn) : gp_ul (x_pn)
  elif gf_id (x_pn) : shutil .rmtree (x_pn)
def gp_ml ( x_src, x_link ) : # (m)ake (l)ink
  return GC_TCL .call ( 'gp_ml', x_link, x_src )
def gp_ep (x_pn) : # (e)mpty out (p)ath
  if not gf_id (x_pn) : return
  pu_pn, pu_ons, pu_bns = next ( os .walk (x_pn) )
  for bu2_on in pu_ons :
    bu2_pn = gf_pj ( pu_pn, bu2_on )
    gp_rt (bu2_pn)
  for bu2_bn in pu_bns :
    bu2_fn = gf_pj ( pu_pn, bu2_bn )
    gp_ul (bu2_fn)

class __DgLongLiveObjects :
  __dau_it = {}
  @classmethod
  def df_cllo ( cls, x_it, *x_args ) : # cllo -> (c)reate (l)ong (l)ive (o)bject
    fu_yo = ... # yo -> p(y)thon (o)bject
    if inspect .isclass (x_it) :
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
  fu_it = ctypes .cast ( x_yi, ctypes.py_object ) .value
  if x_dllo : gp_dllo (x_yi)
  return fu_it
def gf_yi (x_yo) : # p(y)thon (i)d
  return id (x_yo)
def gp_yn ( x_yi, x_nethod_nm, *x_args ) : # from p(y)thon id, call (n)ethod
  pu_yo = gf_yo (x_yi)
  if hasattr ( pu_yo, x_nethod_nm ) : getattr ( pu_yo, x_nethod_nm ) (*x_args)
def gf_ym ( x_yi, x_method_nm, *x_args ) : # from p(y)thon id, call (m)ethod
  pu_yo = gf_yo (x_yi)
  if hasattr ( pu_yo, x_method_nm ) : return getattr ( pu_yo, x_method_nm ) (*x_args)

def gf_box ( x_msgs,  x_leading_space = 0, x_margin_inside = 2 ) :
  fu_msgs = x_msgs
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
  return gf_box ( fu_msgs, x_leading_space, x_margin_inside )

def gf_wai ( x_msg = None ) :
  fu_frame = sys ._getframe () .f_back
  fu_module_nm = fu_frame.f_globals ['__name__']
  fu_func_nm = fu_frame.f_code.co_name
  fu_lineno = fu_frame.f_lineno
  fu_msg = f'@ {fu_module_nm}.{fu_func_nm} [{fu_lineno:03}]'
  if x_msg is None : return fu_msg
  return '{0} {1}' .format ( fu_msg, x_msg )
class TgWai : # (T)rait (g)lobal 
  @staticmethod
  def __tasm_wai ( x_qualname, x_msg = None ) : # __tasm -> (t)rait priv(a)te (s)tatic (m)ethod
    mu_frame = sys ._getframe () .f_back.f_back # mu -> (m)ethod val(u)e
    mu_module_nm = mu_frame.f_globals ['__name__']
    mu_func_nm = mu_frame.f_code.co_name
    mu_lineno = mu_frame.f_lineno
    mu_msg = f'@ {mu_module_nm}.{x_qualname}.{mu_func_nm} [{mu_lineno:03}]'
    if x_msg is None : return mu_msg
    return '{0} {1}' .format ( mu_msg, x_msg )
  @classmethod
  def tcm_wai ( cls, x_msg = None ) : return cls.__tasm_wai ( cls.__qualname__, x_msg ) # tcm -> (t)rait (c)lass (m)ethod
  def tm_wai ( self, x_msg = None ) : return self.__class__.__tasm_wai ( self.__class__.__qualname__, x_msg ) # tm -> (t)rait public instance (m)ethod

class CgQo (QObject) :
  def __init__ (self) :
    super () .__init__ ()
    self.cu_yi = gf_yi (self)

#
# Java (Global)
#

__OjRun = jep.findClass ('ORun')
JC_FX_STAGE = __OjRun.ol_fx_stage
jp_add_jar = __OjRun.on_add_jar
jp_add_library_path = __OjRun.on_add_library_path
for bu2_jar_fn in [
  gf_jar_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'akka-actor_2.12-2.5.9.jar' ),
  gf_jar_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'akka-slf4j_2.12-2.5.9.jar' ),
  gf_jar_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'config-1.3.2.jar' ),
  gf_jar_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-library.jar' ),
  gf_jar_pj ( GC_PYJA_HM, 'Library', 'Apache', 'Commons', 'Lang', '3.8', 'commons-lang3-3.8.jar' ),
  gf_jar_pj ( GC_PYJA_HM, 'Library', 'Groovy', '2.4.15', 'embeddable', 'groovy-all-2.4.15-indy.jar' ),
  gf_jar_pj ( GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-classic-1.2.3.jar' ),
  gf_jar_pj ( GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-core-1.2.3.jar' ),
  gf_jar_pj ( GC_PYJA_HM, 'Library', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
] : jp_add_jar (bu2_jar_fn)
JC_GR = jep .findClass ('javax.script.ScriptEngineManager') () .getEngineByName ('groovy')
JC_GR .put ( 'GC_JEP', __OjRun.ol_jep )
JC_GR .put ( 'GC_EC_SHUTDOWN', GC_EC_SHUTDOWN )
def jy_ge (x_str) : return JC_GR .eval (x_str)
jy_ge ('''
  import javafx.application.Platform
  Platform .setImplicitExit (false)
  gf_jcls = { final String x_cls_nm -> return Class.forName (x_cls_nm) }
  gf_is_instance = { final x_cls, final x_oj -> x_cls .isInstance (x_oj) }
  gp_sr = { final Closure xp_it -> // (S)wing (r)un
    javax.swing.SwingUtilities .invokeLater { xp_it () }
  } 
  gp_xr = { final Closure xp_it -> // JavaF(x) (r)un
    Platform .runLater { xp_it () }
  }
  Object.metaClass.gp_sr = gp_sr
  Object.metaClass.gp_xr = gp_xr
  gp_cy = { final String x_fun_nm, final Object... x_args -> GC_JEP .invoke ( x_fun_nm, *x_args ) } // (c)all p(y)thon without return
  gf_cy = { final String x_fun_nm, final Object... x_args -> return GC_JEP .invoke ( x_fun_nm, *x_args ) } // (c)all p(y)thon with return
  Object.metaClass.gp_cy = gp_cy
  Object.metaClass.gf_cy = gf_cy
  gp_yn = { final long x_yi, final String x_nethod_nm, final Object... x_args -> gp_cy ( 'gp_yn', x_yi, x_nethod_nm, *x_args ) }
  gf_ym = { final long x_yi, final String x_method_nm, final Object... x_args -> return gf_cy ( 'gf_ym', x_yi, x_method_nm, *x_args ) }
  Object.metaClass.gp_yn = gp_yn
  Object.metaClass.gf_ym = gf_ym
''')
def jf_script_params (x_py_list) :
  fu_arr_sz = len (x_py_list)
  fu_params = jy_ge ( f'new Object [{fu_arr_sz}]' )
  for bu2_idx, bu2_it in enumerate (x_py_list) : fu_params [bu2_idx] = x_py_list [bu2_idx]
  return fu_params
def jy_gf ( x_nm, *x_args ) : return JC_GR. invokeFunction ( x_nm, jf_script_params (x_args) )
def jy_gm ( x_oj, x_nm, *x_args ) : return JC_GR. invokeMethod ( x_oj, x_nm, jf_script_params (x_args) )
def jy_gc ( x_closure, *x_args ) :
  yu_closure = jy_ge (x_closure) if type(x_closure) is str else x_closure
  return jy_gm ( yu_closure, 'call', *x_args )
def jf_gi (x_cls) : return jy_ge ( f'@groovy.transform.Immutable ( knownImmutableClasses = [Object] ) {x_cls}' ) # (g)roovy (i)mmutable class
def jf_jcls (x_cls_nm) : return jy_gf ( 'gf_jcls', x_cls_nm )
def jf_is_instance ( x_cls, x_oj ) : return jy_gf ( 'gf_is_instance', x_cls, x_oj )

CjActorRef              = jf_jcls ('akka.actor.ActorRef')
CjAwait                 = jf_jcls ('scala.concurrent.Await')
CjBigInteger            = jf_jcls ('java.math.BigInteger')
CjByteArrayInputStream  = jf_jcls ('java.io.ByteArrayInputStream')
CjByteArrayOutputStream = jf_jcls ('java.io.ByteArrayOutputStream')
CjCalendar              = jf_jcls ('java.util.Calendar')
CjDuration              = jf_jcls ('scala.concurrent.duration.Duration')
CjInteger               = jf_jcls ('java.lang.Integer')
CjMath                  = jf_jcls ('java.lang.Math')
CjPatterns              = jf_jcls ('akka.pattern.Patterns')
CjProperties            = jf_jcls ('scala.util.Properties')
CjString                = jf_jcls ('java.lang.String')
CjSymbol                = jf_jcls ('scala.Symbol')
CjSystem                = jf_jcls ('java.lang.System')
CjTimeout               = jf_jcls ('akka.util.Timeout')

def jf_datetime_from_java_util_date (x_date) :
  fu_cd = CjCalendar .getInstance ()
  fu_cd .setTime (x_date)
  return datetime (
    fu_cd .get (CjCalendar.YEAR),
    fu_cd .get (CjCalendar.MONTH) + 1,
    fu_cd .get (CjCalendar.DAY_OF_MONTH),
    fu_cd .get (CjCalendar.HOUR_OF_DAY),
    fu_cd .get (CjCalendar.MINUTE),
    fu_cd .get (CjCalendar.SECOND)
  )
def jf_elapsed (x_st) :
  fu_st = x_st if isinstance ( x_st, datetime ) else jf_datetime_from_java_util_date (x_st)
  return datetime .now () - fu_st
def jf_pixmap ( x_fn, x_format = 'PNG' ) : # Load image from file for using QPixmap in java
  fu_qba = QByteArray ()
  fu_qbf = QBuffer (fu_qba)
  fu_qbf .open (QIODevice.WriteOnly)
  QPixmap (x_fn) .save ( fu_qbf, x_format )
  fu_qbf .close ()
  fu_jbaos = CjByteArrayOutputStream ()
  for bx2_it in fu_qba .data () : fu_jbaos .write (bx2_it)
  del (fu_qba)
  fu_jbais = CjByteArrayInputStream ( fu_jbaos .toByteArray () )
  fu_jbaos .close ()
  return fu_jbais

JC_OS_NM = CjProperties .osName ()
JC_IS_LINUX = CjProperties .isLinux ()
JC_IS_MAC = CjProperties .isMac ()
JC_IS_WIN = CjProperties .isWin ()

JC_AKKA_VR = jf_jcls ('akka.Version') .current ()
JC_GROOVY_VR = jf_jcls ('groovy.lang.GroovySystem') .getVersion ()
JC_JAVA_VR = CjProperties .javaVersion ()
JC_SCALA_VR = CjProperties .versionNumberString ()

JC_LOG_PATTERN = f"[{ '%06d' % GC_THIS_PID },%.-1level,%date{{yyMMdd-HHmmss}}] %msg%n"
JC_LOG = jy_ge (f'''
  org.slf4j.LoggerFactory .getILoggerFactory () .with {{ bx2_lc ->
    Object.metaClass.GC_LOG_CONTEXT = bx2_lc
    bx2_lc .reset ()
    bx2_lc .getLogger ("GC_LOG") .with {{ bx3_log ->
      addAppender ( new ch.qos.logback.core.ConsoleAppender () .with {{ bx4_ca ->
        setContext (bx2_lc)
        setTarget ("System.out")
        setEncoder ( new ch.qos.logback.classic.encoder.PatternLayoutEncoder () .with {{
          setContext (bx2_lc)
          setPattern ( "{JC_LOG_PATTERN}" )
          start ()
          it
        }} )
        start ()
        bx4_ca
      }} )
      Object.metaClass.GC_LOG = bx3_log
      bx3_log
    }}
  }}
''')
def jp_set_log_level_to_warn ()  : JC_LOG .setLevel ( jf_jcls ('ch.qos.logback.classic.Level') .WARN )
def jp_set_log_level_to_info ()  : JC_LOG .setLevel ( jf_jcls ('ch.qos.logback.classic.Level') .INFO )
def jp_set_log_level_to_debug () : JC_LOG .setLevel ( jf_jcls ('ch.qos.logback.classic.Level') .DEBUG )
def jp_set_log_level_to_trace () : JC_LOG .setLevel ( jf_jcls ('ch.qos.logback.classic.Level') .TRACE )
jy_ge ("""
  //
  // Redirect System.err to GC_LOG
  //
  import org.apache.commons.lang3.StringUtils
  System .setErr ( new PrintStream (System.err) {
    public void print ( final String x_str ) { GC_LOG .error (x_str) }
    public void println () { GC_LOG .error ('') }
    public void println ( final String x_str ) { GC_LOG .error (x_str) }
    public void write ( byte [] x_buf, int x_off, int x_len ) {
      final nu_s = StringUtils .stripEnd ( new String (x_buf) .substring ( x_off, x_len ), null )
      if ( ! StringUtils .isEmpty (nu_s) ) { GC_LOG .error (nu_s) }
    }
  })
""")

jy_ge ('''
  gp_config_as_log = { final String x_cfg_str ->
    final fu_jc = new ch.qos.logback.classic.joran.JoranConfigurator ()
    fu_jc .setContext (GC_LOG_CONTEXT)
    GC_LOG_CONTEXT .reset ()
    final String fu_cfg_xml_str = """
      <configuration>
        <statusListener class="ch.qos.logback.core.status.NopStatusListener" />
        ${x_cfg_str}
        <logger name="akka.event.slf4j.Slf4jLogger" level="OFF" additivity="false" />
        <logger name="akka.event.EventStream" level="OFF" additivity="false" />
        <logger name="slick" level="INFO" />
      </configuration>
    """
    fu_jc .doConfigure ( new java.io.ByteArrayInputStream ( fu_cfg_xml_str .getBytes () ) )
  }
''')
def jp_config_as_log (x_cfg_str) : jy_gf ( 'gp_config_as_log', x_cfg_str )

JC_AS = ...
def gp_create_as (x_cfg_str) : # create (a)ctor (s)ystem
  global JC_AS
  pu_cfg = jf_jcls ('com.typesafe.config.ConfigFactory') .parseString (x_cfg_str)
  JC_AS = jf_jcls ('akka.actor.ActorSystem') .create ( 'GC_AS', pu_cfg )
def jp_set_as_log_level_to_error () :
  if JC_AS is not ... :
    JC_AS .eventStream () .setLogLevel ( jy_ge ( 'akka.event.Logging .ErrorLevel ()' ) )
def jp_set_as_log_level_to_warning () :
  if JC_AS is not ... :
    JC_AS .eventStream () .setLogLevel ( jy_ge ( 'akka.event.Logging .WarningLevel ()' ) )
def jp_set_as_log_level_to_info () :
  if JC_AS is not ... :
    JC_AS .eventStream () .setLogLevel ( jy_ge ( 'akka.event.Logging .InfoLevel ()' ) )
def jp_set_as_log_level_to_debug () :
  if JC_AS is not ... :
    JC_AS .eventStream () .setLogLevel ( jy_ge ( 'akka.event.Logging .DebugLevel ()' ) )

def __jap_just_before_exiting () :
  JC_LOG .info ( 'Exiting application [{}] ...' .format (GC_APP_NM) )
  gp_log_lines ( JC_LOG .info, gf_box ( [ f'Elapsed { jf_elapsed (GC_ST) } ...' ] ) )
  JC_LOG .getLoggerContext () .stop ()
def __jap_exit (x_ec) :
  pu_llos = gf_llos ()
  if len (pu_llos) > 0 :
    JC_LOG .warn ( f'You did not delete { len (pu_llos) } llo(s) with gp_dllo () function after using llo(s) !!!' )
    gp_log_dict ( JC_LOG .warn, 'Undeleted python llo(s)', pu_llos )
  if x_ec == GC_EC_NONE : JC_LOG .error ( 'Undefined exit code (GC_EC_NONE), check your logic !!!' )
  elif x_ec < 0 : JC_LOG .error ( f'Negative exit code ({x_ec}), should consider using a positive value !!!' )
  else : JC_LOG .info ( 'Exit code => {}' .format (x_ec) )
  __jap_just_before_exiting ()
  if x_ec == GC_EC_NONE : os ._exit (GC_EC_ERROR)
  elif x_ec == GC_EC_SHUTDOWN : pass
  elif x_ec < 0 : os ._exit (GC_EC_ERROR)
  else : os ._exit (x_ec)
def jp_request_exit ( x_ec, x_ex_list = None ) :
  if JC_AS is not ... :
    JC_AS .terminate ()
    CjAwait .ready ( JC_AS .whenTerminated (), CjDuration .Inf () )
  pu_ex = None if x_ex_list is None else "\n" .join ( map ( lambda bx2_it : str (bx2_it), x_ex_list ) )
  if pu_ex is not None : gp_log_exception ( JC_LOG .error, 'Following error occurs !!!', pu_ex, 60 )
  if x_ec == GC_EC_SHUTDOWN :
    JC_LOG .info ( 'Exit from shutdown like ctrl+c, ...' )
    __jap_just_before_exiting ()
  jy_gc ( "{ x_ec -> gp_xr { gp_cy ( '__jap_exit', x_ec ) } }", x_ec  )
jy_ge ( "addShutdownHook { gp_cy ( 'jp_request_exit', GC_EC_SHUTDOWN, [ 'Shutdown occurred !!!' ] ) }" )

jy_ge ('''
  class CgAt extends akka.actor.AbstractActor { // (A)c(t)or
    final private long __cau_yi_at
    CgAt ( final long x_yi_at ) {
      this.__cau_yi_at = x_yi_at
      gp_xr { gp_yn ( this.__cau_yi_at, 'cn_create', this ) }
    }
    void preStart () {
      gp_xr { gp_yn ( this.__cau_yi_at, 'cn_pre_start' ) }
    }
    akka.actor.AbstractActor.Receive createReceive () {
      return receiveBuilder () .match ( Object.class, { x_letter ->
        final pu_sender = getSender ()
        gp_xr { gp_yn ( this.__cau_yi_at, 'cn_receive', x_letter, pu_sender ) }
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
  def cn_create ( self, x_at_org ) :
    JC_LOG .trace ( self .tm_wai ('Entered ...') )
    self.cu_at_org = x_at_org
    if hasattr ( self, 'create' ) : getattr ( self, 'create' ) ()
  def cn_pre_start (self) :
    JC_LOG .trace ( self .tm_wai ('Entered ...') )
    if hasattr ( self, 'preStart' ) : getattr ( self, 'preStart' ) ()
  def cn_receive ( self, x_letter, x_atr_sender ) :
    if hasattr ( self, 'receive' ) : getattr ( self, 'receive' ) ( x_letter, x_atr_sender )
  def cn_post_stop (self) :
    JC_LOG .trace ( self .tm_wai ('Entered ...') )
    if hasattr ( self, 'postStop' ) : getattr ( self, 'postStop' ) ()
    gp_dllo (self.cu_yi)
  def cm_self (self) : return self.cu_at_org .getSelf ()
  def cm_context (self) : return self.cu_at_org .getContext ()
  def cn_tell ( self, x_atr_target, x_letter, x_atr_sender = None ) :
    nu_atr_sender = self .cm_self () if x_atr_sender == None else x_atr_sender
    x_atr_target .tell ( x_letter, nu_atr_sender )
def jf_mk_atr ( x_at, x_at_nm, x_arf = None ) :
  fu_arf = JC_AS if x_arf is None else x_arf
  fu_at_nm = x_at.__class__.__name__ if x_at_nm == ':c' else ':a' if x_at_nm == None else x_at_nm
  return jy_gf ( 'gf_mk_atr', gf_yi (x_at), fu_at_nm, fu_arf )

class TjUtil :
  def tn_fx_set_eh ( self, x_xo, x_xo_eh_nm, x_yo_nethod_nm ) : # xo -> F(X) (o)bject, eh -> fx (e)vent (h)andler
    jy_gc ( f"""{{ x_xo ->
      x_xo.{x_xo_eh_nm} = {{ x2_ev -> gp_yn {self.cu_yi}, '{x_yo_nethod_nm}', x2_ev }}
    }}""", x_xo  )
  def tn_fx_add_cl ( self, x_property, x_yo_nethod_nm ) : # cl -> (c)hange (l)istener
    jy_gc ( f"""{{ x_property ->
      x_property .addListener ( {{ x2_obs, x2_old, x2_new -> gp_yn {self.cu_yi}, '{x_yo_nethod_nm}', x2_obs, x2_old, x2_new }} as javafx.beans.value.ChangeListener )
    }}""", x_property  )
  def tn_ak_foc ( self, x_future, x_yo_nethod_nm ) : # ak -> (ak)ka, foc -> (f)uture (o)n(C)omplete
    jy_gc ( f"""{{ x_future, x_dispatcher ->
      x_future .onComplete ( {{ x2_throwable, x2_result -> gp_xr {{ gp_yn {self.cu_yi}, '{x_yo_nethod_nm}', x2_throwable, x2_result }} }} as akka.dispatch.OnComplete, x_dispatcher )
    }}""", x_future, self .cm_context () .dispatcher ()  )

OjSg = ...
def jp_add_scala_jar () :
  global OjSg
  pu_scala_jar_fn = gf_pj ( GC_MILO_PN, 'out', f"{ gf_jn (GC_SCRIPT_FN) }.jar" )
  if gf_xi (pu_scala_jar_fn) :
    JC_LOG .trace ( f'Loading Scala jar file => { gf_to_mps (pu_scala_jar_fn) }' )
    jp_add_jar (pu_scala_jar_fn)
    OjSg = jf_jcls ('Global') # Scala Global object
    OjSg .gp_initialize ()
def jf_sc_mk_atr ( x_at_cls, x_at_params, x_at_nm, x_arf = None ) :
  fu_arf = JC_AS if x_arf is None else x_arf
  fu_at_params = OjSg .gf_jal_2_seq (x_at_params)
  return  OjSg .gf_mk_atr ( fu_arf, x_at_cls, fu_at_params, x_at_nm )

#
# Main Skeleton
#

class DRun :
  @classmethod
  def __dap_begin ( cls, xp_set_log_level ) :
    xp_set_log_level ()
    JC_LOG .info  ( f"Entering application [{GC_APP_NM}] ...\n" + "\n" .join ( gf_banner () ) )
    jp_add_scala_jar ()
    JC_LOG .debug ( f'Pyja name => {GC_PYJA_NM}' )
    if GC_PYJA_NM != gf_os_env ('SC_PYJA_NM') : raise Exception ( 'Invalid Pyja name !!!' )
    JC_LOG .debug ( f'Pyja creation date => {GC_PYJA_CD}' )
    if not gf_str_is_valid_date ( GC_PYJA_CD, '%Y.%m.%d' ) : raise Exception ( 'Pyja create date is not invalid !!!' )
    JC_LOG .debug ( f'Pyja version => {GC_PYJA_V2}' )
    if GC_PYJA_VR != gf_os_env ('SC_PYJA_VR') : raise Exception ( 'Invalid Pyja version !!!' )
    JC_LOG .info  ( f'Pyja root ({GC_PYJA_RT_SYM}) => {GC_PYJA_RT}' )
    JC_LOG .info  ( f'Pyja home ({GC_PYJA_HM_SYM}) => { gf_to_prs (GC_PYJA_HM) }' )
    JC_LOG .info  ( f'Milo path ({GC_MILO_PN_SYM}) => { gf_to_phs (GC_MILO_PN) }' )
    JC_LOG .info  ( f'OS name => {JC_OS_NM}' )
    JC_LOG .info  ( f'Process ID => {GC_THIS_PID}' )
    JC_LOG .debug ( f'KAPA home => {GC_KAPA_HM}' )
    JC_LOG .debug ( f'Java home => {GC_JAVA_HM}' )
    JC_LOG .debug ( f'Python home => {GC_PYTHON_HM}' )
    JC_LOG .info  ( f'Java version => {JC_JAVA_VR}' )
    JC_LOG .info  ( f'Groovy version => {JC_GROOVY_VR}' )
    JC_LOG .info  ( f'Scala version => {JC_SCALA_VR}' )
    JC_LOG .info  ( f'Akka version => {JC_AKKA_VR}' )
    JC_LOG .info  ( f'Python version => {GC_PYTHON_VR}' )
    JC_LOG .info  ( f'Tcl version => {GC_TCL_VR}' )
    JC_LOG .info  ( f'PyQt version => {GC_PYQT_VR}' )
    JC_LOG .debug ( f'Total CPU => {GC_TOTAL_CPU}' )
    JC_LOG .info  ( f'Total memory => {GC_TOTAL_MEMORY:,d} bytes' )
    JC_LOG .debug ( f'Available memory => {gf_available_memory():,d} bytes' )
    JC_LOG .debug ( f'Computer name => {GC_HOST_NM}' )
    JC_LOG .debug ( f'Current user => {GC_CUSR}' )
    JC_LOG .debug ( f'Executable file => {GC_THIS_EXE_FN}' )
    JC_LOG .info  ( f'Start up path => { gf_to_phs (GC_THIS_START_UP_PN) }' )
    JC_LOG .info  ( f'Script file => { gf_to_mps (GC_SCRIPT_FN) }' )
    gp_log_array ( JC_LOG .debug, 'Paths', GC_OS_ENV_PATHS )
    gp_log_array ( JC_LOG .debug, 'Command', GC_THIS_CMD )
    if len(GC_ARGV) > 0 : gp_log_array ( JC_LOG .info, 'Arguments', GC_ARGV )
  @classmethod
  def dp_it ( cls, xp_set_log_level ) :
    cls.__dap_begin (xp_set_log_level)
    try :
      DBody .dp_it ()
    except :
      jp_request_exit ( GC_EC_ERROR, gf_exception_to_list () )

#
# Your Source
#

XInsets = jf_jcls ('javafx.geometry.Insets')
XLabel  = jf_jcls ('javafx.scene.control.Label')
XPos    = jf_jcls ('javafx.geometry.Pos')
XScene  = jf_jcls ('javafx.scene.Scene')
XSlider = jf_jcls ('javafx.scene.control.Slider')
XVBox   = jf_jcls ('javafx.scene.layout.VBox')

class WAtXMain ( CjAt, TjUtil, TgWai ) :
  def __init__ (self) : super () .__init__ ()
  def preStart (self) :
    JC_LOG .debug ( self .tm_wai ('Entered ...') )
    self .wn_init ()
  def wn_init (self) :
    JC_LOG .info ( self.tm_wai ('Initializing ...') )
    self.wu_atr_fibo = jf_sc_mk_atr ( jf_jcls ('CAtFibonacci'), [], ':c' )
    self.wu_timeout = CjTimeout ( CjDuration .create ( 2, 'seconds' ) )
    self.wu_lb_no = XLabel ()
    nu_initial_no = 21
    self .wn_show_nr (nu_initial_no)
    def nf2_sldr_4_nr (it) :
      it .setMin (0)
      it .setMax (360)
      it .setValue (nu_initial_no)
      it .setShowTickLabels (True)
      it .setShowTickMarks (True)
      it .setBlockIncrement (10)
      self .tn_fx_add_cl ( it .valueProperty (), 'wn_sldr_4_nr_val_cl' )
      return it
    self.wu_sldr_4_nr = nf2_sldr_4_nr ( XSlider () )
    self.wu_lb_fibo = XLabel ( 'Fibonacci :' )
    self.wu_lb_fibo_result = XLabel ()
    def nf2_root (it) :
      it .setAlignment (XPos.CENTER)
      it .setPadding ( XInsets (20) )
      it .setSpacing (10)
      it .getChildren () .addAll ( [ self.wu_lb_no, self.wu_sldr_4_nr, self.wu_lb_fibo, self.wu_lb_fibo_result ] )
      return it
    self.wu_root = nf2_root ( XVBox () )
    def nf2_stage (it) :
      it .setTitle (GC_APP_NM)
      it .setWidth (750)
      it .setHeight (190)
      it .setScene ( XScene (self.wu_root) )
      self .tn_fx_set_eh ( it, 'onShowing', 'wn_stage_on_showing' )
      self .tn_fx_set_eh ( it, 'onShown', 'wn_stage_on_shown' )
      self .tn_fx_set_eh ( it, 'onCloseRequest', 'wn_stage_on_close_request' )
      return it
    self.wu_stage = nf2_stage (JC_FX_STAGE)
    self.wu_stage .show ()
  def wn_show_nr ( self, x_no ) : self.wu_lb_no .setText ( f'Number => {x_no}' )
  def wn_show_fibo (self) :
    nu_future = CjPatterns .ask ( self.wu_atr_fibo, CjInteger ( int ( self.wu_sldr_4_nr .getValue () ) ), self.wu_timeout )
    nu_result = CjAwait.result ( nu_future, self.wu_timeout .duration () )
    nu_fibo = int ( nu_result .toString () )
    self.wu_lb_fibo_result .setText ( f'{nu_fibo:,d}' )
  def wn_sldr_4_nr_val_cl ( self, x_obs, x_old, x_new ) :
    self .wn_show_nr ( int ( self.wu_sldr_4_nr .getValue () ) )
    self .wn_show_fibo ()
  def wn_center_on_screen (self) :
    nu_cp = QDesktopWidget () .availableGeometry () .center () # center point
    self.wu_stage .setX ( nu_cp .x () - self.wu_stage .getWidth () / 2 )
    self.wu_stage .setY ( nu_cp .y () - self.wu_stage .getHeight () / 2 )
  def wn_stage_on_showing ( self, x_ev ) :
    JC_LOG .debug ( 'Stage showing ...' )
    self .wn_center_on_screen ()
  def wn_stage_on_shown ( self, x_ev ) :
    JC_LOG .info ( 'Stage shown ...' )
  def wn_stage_on_close_request ( self, x_ev ) :
    JC_LOG .info ( self .tm_wai ( 'About to quit ...' ) )
    jp_request_exit (GC_EC_SUCCESS)

class DBody :
  @classmethod
  def dp_it (cls) :
    GC_QAPP .setStyle ('fusion')
    # 1 / 0
    pu_atr_fx = jf_mk_atr ( WAtXMain (), ':c' )

class OActorSystem :
  @classmethod
  def on_init (cls) :
    cls .__oan_config_log ( x_console = True )
    cls .__oan_create ()
    cls .__oan_set_log_level ()
  @classmethod
  def __oan_config_log ( cls, x_console ) :
    def np2_console () :
      jp_config_as_log (f'''
        <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
          <layout class="ch.qos.logback.classic.PatternLayout">
            <pattern>{JC_LOG_PATTERN}</pattern>
          </layout>
          <target>System.out</target>
        </appender>
        <root level="DEBUG">
          <appender-ref ref="STDOUT" />
        </root>
      ''')
    def np2_file () :
      pu2_log_fn = gf_pj ( GC_DOWNLOAD_PN, 'LOGS', f"{GC_APP_NM}.log" )
      pu2_log_pn = gf_pn (pu2_log_fn)
      gp_mp (pu2_log_pn)
      print ( f'Log path => {pu2_log_pn}' )
      print ( f'Log file base name => { gf_bn (pu2_log_fn) }' )
      pu2_log_jn = gf_jn (pu2_log_fn)
      jp_config_as_log (f'''
        <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
          <file>{pu2_log_fn}</file>
          <rollingPolicy class="ch.qos.logback.core.rolling.FixedWindowRollingPolicy">
            <fileNamePattern>{pu2_log_pn}/{pu2_log_jn}.%i.log</fileNamePattern>
            <minIndex>1</minIndex>
            <maxIndex>10</maxIndex>
          </rollingPolicy>
          <triggeringPolicy class="ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy">
            <maxFileSize>10MB</maxFileSize>
          </triggeringPolicy>
          <encoder>
            <pattern>{JC_LOG_PATTERN}</pattern>
          </encoder>
        </appender>
        <root level="DEBUG">
          <appender-ref ref="FILE" />
        </root>
      ''')
    if x_console : np2_console ()
    else : np2_file ()
  @classmethod
  def __oan_create (cls) :
    gp_create_as ('''
      akka {
        loggers = ["akka.event.slf4j.Slf4jLogger"]
        logging-filter = "akka.event.slf4j.Slf4jLoggingFilter"
      }
    ''')
  @classmethod
  def __oan_set_log_level (cls) :
    # jp_set_as_log_level_to_error ()
    # jp_set_as_log_level_to_warning ()
    # jp_set_as_log_level_to_info ()
    jp_set_as_log_level_to_debug ()

class OStart :
  @classmethod
  def on_main (cls) :
    OActorSystem .on_init ()
    DRun .dp_it (cls.__oan_set_log_level)
  @classmethod
  def __oan_set_log_level (cls) :
    # jp_set_log_level_to_warn ()
    # jp_set_log_level_to_info ()
    # jp_set_log_level_to_debug ()
    jp_set_log_level_to_trace ()

if __name__ == '__main__':
  OStart .on_main ()
