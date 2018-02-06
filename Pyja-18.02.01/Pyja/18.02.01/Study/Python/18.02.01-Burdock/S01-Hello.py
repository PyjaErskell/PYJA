#
# Python (Global)
#

import sys

sys.dont_write_bytecode = True

from datetime import datetime

GC_ST = datetime.now () # (G)lobal (C)onstant

GC_PYJA_NM = 'Pyja'

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

from PyQt5.QtCore import pyqtSignal
from PyQt5.QtCore import QCoreApplication
from PyQt5.QtCore import QObject
from PyQt5.QtCore import Qt
from PyQt5.QtCore import QThread
from PyQt5.QtWidgets import QApplication

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
import shutil
import time
import tkinter
import traceback
import types

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
    if gf_xn (bu2_it) .lower () in [ 'js', 'py', 'rb' ] :
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
GC_JAVA_HM   = gf_ap ( gf_os_env ('SC_J8_HM') )
GC_PYTHON_HM = gf_ap ( gf_os_env ('SC_PYTHON_HM') )
GC_MILO_PN   = gf_ap ( gf_os_env ('SC_MILO_PN') )

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
def gf_tcl_ver () : return GC_TCL.call ('gf_tcl_ver')
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
def gp_log_exception ( xp_out, x_title, x_ex_list ) :
  if type(x_ex_list) is not list : gp_log_header ( xp_out, 'List of reasons is not given !!!', 60 )
  else :
    gp_log_header ( xp_out, x_title, 60 )
    for bu2_it in x_ex_list : xp_out (bu2_it)

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
def __gap_call_yp ( x_yip, *x_args ) : # yip -> p(y)thon (i)d of (p)rocedure or nethod, yp -> p(y)thon (p)rocedure or nethod
  pu_yp = gf_yo (x_yip)
  pu_yp (*x_args)
def __gap_call_yo_nethod ( x_yio, x_nethod_nm, *x_args ) : # yio -> p(y)thon (i)d of (o)bject
  pu_oj = gf_yo (x_yio)
  if hasattr ( pu_oj, x_nethod_nm ) : getattr (pu_oj, x_nethod_nm) (*x_args)

LgCx = namedtuple ( 'LgCx', [ 'lu_ec', 'lu_ex' ] )

class __CgQtRun (QThread) :
  __cag_it = pyqtSignal ()
  def __init__ ( self, x_callable, *x_args ) :
    super () .__init__ ()
    self.cu_yio = gf_cllo (self)
    self.cu_lambda = x_callable
    self.cu_args = x_args
  def run (self) :
    self.__cag_it .connect ( lambda : self.cu_lambda (*self.cu_args) )
    self.__cag_it .emit ()
    gf_yo ( self.cu_yio, True )
def gp_qr ( x_callable, *x_args ) : __CgQtRun ( x_callable, *x_args ) .start () # qr -> (q)t (r)un

#
# Java (Global)
#

import jep

GC_GR = jep.findClass ('javax.script.ScriptEngineManager') () .getEngineByName ('groovy')
GC_GR .eval (f'''
  Object.metaClass.GC_EC_ERROR = {GC_EC_ERROR}
  Object.metaClass.GC_THIS_PID = {GC_THIS_PID}
''')
GC_GR .eval ('''
  gp_puts = { final x_str -> println x_str }
  Object.metaClass.gp_puts = gp_puts
  def gf_jcls (x_cls_nm) { return Class.forName (x_cls_nm) }
  final __gau_lock_4_gap_cy = new Object [0]
  Object.metaClass.__gap_cy = { final Object... x_args -> // cy -> (c)all p(y)thon
    synchronized (__gau_lock_4_gap_cy) { __gau_jep .invoke (*x_args) }
  }
  def gp_add_jar ( final String x_jar_fn ) {
    if ( ! new File (x_jar_fn) .exists () ) { throw new FileNotFoundException ( "JAR file not found => ${x_jar_fn}" ) }
    final URL pu_url = new File (x_jar_fn) .toURI () .toURL ()
    final URLClassLoader pu_cl = ClassLoader .getSystemClassLoader ()
    final fu_m = URLClassLoader.class .getDeclaredMethod 'addURL', URL.class
    fu_m.setAccessible true
    fu_m.invoke pu_cl, pu_url
  }
''')
def gf_jarray (x_py_list) :
  fu_arr_sz = len (x_py_list)
  fu_params = GC_GR .eval ( f'new Object [{fu_arr_sz}]' )
  for bu2_idx, bu2_it in enumerate ( x_py_list ) : fu_params [bu2_idx] = x_py_list [bu2_idx]
  return fu_params
def gp_gr_call ( x_fun_nm, *x_args ) : GC_GR. invokeFunction ( x_fun_nm, gf_jarray (x_args) )
def gf_gr_call ( x_fun_nm, *x_args ) : return GC_GR. invokeFunction ( x_fun_nm, gf_jarray (x_args) )
def gp_puts (x_str) : gp_gr_call ('gp_puts', x_str )
print = gp_puts
def gf_jcls (x_cls_nm) : return gf_gr_call ( 'gf_jcls', x_cls_nm )
def gp_add_jar (x_jar_fn) : return gf_gr_call ( 'gp_add_jar', x_jar_fn )

def __gap_add_default_jars () :
  pu_jar_fns = [
    gf_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'akka-actor_2.12-2.5.9.jar' ),
    gf_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'config-1.3.2.jar' ),
    gf_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-library.jar' ),
  ]
  for bu2_jar_fn in pu_jar_fns : gp_add_jar (bu2_jar_fn)
__gap_add_default_jars ()

CgActorRef = gf_jcls ('akka.actor.ActorRef')
CgAwait = gf_jcls ('scala.concurrent.Await')
CgDuration = gf_jcls ('scala.concurrent.duration.Duration')

GC_GR .eval ('''
  class __CgFxApp extends javafx.application.Application {
    private static long __casv_yio
    private static String __casv_yo_nethod_nm
    def static csn_launch ( final long x_yio, final String x_yo_nethod_nm ) { __casv_yio = x_yio; __casv_yo_nethod_nm = x_yo_nethod_nm; launch this }
    void start ( final javafx.stage.Stage x_stage ) { __gap_cy '__gap_call_yo_nethod', __casv_yio, __casv_yo_nethod_nm, this, x_stage }
  }
  def gp_fx_start ( final long x_yio, final String x_yo_nethod_nm ) { Thread .start { __CgFxApp .csn_launch x_yio, x_yo_nethod_nm } }
  def gp_fx_set_on ( final Object x_xo, final String x_xo_nethod_nm, final long x_yio, final String x_yo_nethod_nm, final String... x_params = ['it'] ) { // xo -> f(x) (o)bject
    pu_params = x_params .join ', '
    x_xo ."$x_xo_nethod_nm" evaluate ( "{ ${pu_params} -> __gap_cy '__gap_call_yo_nethod', ${x_yio}, '${x_yo_nethod_nm}', ${pu_params} }" )
  }
  def gp_xr ( final long x_yio, final String x_yo_nethod_nm, final Object... x_args ) {
    javafx.application.Platform.runLater { __gap_cy ( '__gap_call_yo_nethod', x_yio, x_yo_nethod_nm, *x_args ) }
  }
''')
def gp_fx_start ( x_yo_nethod ) : gp_gr_call ( 'gp_fx_start', gf_yi (x_yo_nethod.__self__), x_yo_nethod.__name__ )
def gp_fx_set_on ( x_xo_nethod, x_yo_nethod, *x_args ) : gp_gr_call ( 'gp_fx_set_on', x_xo_nethod.__self__, x_xo_nethod.__name__, gf_yi (x_yo_nethod.__self__), x_yo_nethod.__name__, *x_args )
def gp_xr ( x_yo_nethod, *x_args ) : gp_gr_call ( 'gp_xr', gf_yi (x_yo_nethod.__self__), x_yo_nethod.__name__, *x_args )

GC_GR .eval ('''
  def __gaf_default_as ( final String x_as_nm ) {
    final fu_cfg = com.typesafe.config.ConfigFactory .parseString """akka { loglevel = "ERROR" }"""
    return akka.actor.ActorSystem .create ( x_as_nm, fu_cfg )
  }
  Object.metaClass.GC_AS = __gaf_default_as 'GC_AS'
  def gf_as () { return GC_AS }
''')
GC_AS = gf_gr_call ('gf_as')

def __gaf_root_logger ( x_level, x_handler, x_format, x_datefmt = '%y%m%d-%H%M%S' ) :
  fu_root = logging.root
  fu_root.handlers = []
  fu_root.setLevel (x_level)
  if x_handler is not None :
    x_handler.setFormatter ( logging.Formatter ( x_format, datefmt = x_datefmt ) )
    fu_root.addHandler (x_handler)
  return fu_root
GC_LOG = __gaf_root_logger ( logging.DEBUG, logging.StreamHandler (sys.stdout), '[%(process)04d,%(levelname)-.1s,%(asctime)s] %(message)s' )
def gp_set_log_level_to_info () : GC_LOG .setLevel (logging.INFO)
def gp_set_log_level_to_debug () : GC_LOG .setLevel (logging.DEBUG)

class __DgExit : # (__)private mo(D)ule (g)lobal
  __dav_cx = LgCx ( GC_EC_NONE, None )
  __dav_was_lgcx_processed = False
  @classmethod
  def dp_it ( cls, x_cx ) :
    GC_LOG .debug ( f'Received LgCx ({x_cx.lu_ec})' )
    if cls.__dav_was_lgcx_processed == False :
      cls.__dav_was_lgcx_processed = True
      cls.__dav_cx = x_cx
      cls.__dap_before_exit ()
      cls.__dap_exit ()
  @classmethod
  def __dap_before_exit (cls) :
    GC_AS .terminate ()
    CgAwait .ready ( GC_AS .whenTerminated (), CgDuration .Inf () )
    pu_ec = cls.__dav_cx.lu_ec
    pu_llos = gf_llos ()
    if len(pu_llos) > 0 :
      GC_LOG .warning ( f'You did not delete {len(pu_llos)} llo(s) with gp_dllo () function after using llo(s) !!!' )
      gp_log_dict ( GC_LOG.warning, 'Undeleted python llo(s)', pu_llos )
    pu_ex = cls.__dav_cx.lu_ex
    if pu_ex is not None : gp_log_exception ( GC_LOG .error, 'Following error occurs !!!', pu_ex )
    if pu_ec != GC_EC_SUCCESS and pu_ex is None : gp_log_header ( GC_LOG .error, 'Unknown error occurs !!!', 60 )
    if pu_ec == GC_EC_NONE : GC_LOG .error ( 'Undefined exit code (GC_EC_NONE), check your logic !!!' )
    elif pu_ec == GC_EC_SHUTDOWN : GC_LOG .info ( 'Exit code from shutdown like ctrl+c, ...' )
    elif pu_ec < 0 : GC_LOG .error ( f'Negative exit code ({pu_ec}), should consider using a positive value !!!' )
    else : GC_LOG .info ( 'Exit code => {}' .format (pu_ec) )
    GC_LOG .info ( 'Elapsed {} ...' .format ( datetime.now () - GC_ST ) )
  @classmethod
  def __dap_exit (cls) :
    pu_ec = cls.__dav_cx.lu_ec
    if pu_ec == GC_EC_NONE : os._exit (GC_EC_ERROR)
    elif pu_ec == GC_EC_SHUTDOWN : pass
    elif pu_ec < 0 : os._exit (GC_EC_ERROR)
    else : os._exit (pu_ec)
def gp_request_exit ( x_ec, x_ex_list = None ) : __DgExit .dp_it ( LgCx ( x_ec, x_ex_list ) )

GC_GR .eval ('''
  class __CgAt extends akka.actor.AbstractActor { // (A)c(t)or
    final private long __cau_yi_at
    __CgAt ( final long x_yi_at ) { this.__cau_yi_at = x_yi_at }
    void preStart () { __gap_cy '__gap_call_yo_nethod', this.__cau_yi_at, 'cn_pre_start', this }
    akka.actor.AbstractActor.Receive createReceive () {
      return receiveBuilder () .match ( Object.class, { it -> __gap_cy '__gap_call_yo_nethod', this.__cau_yi_at, 'receive', it, getSender () } ) .build ()
    }
    void postStop () { __gap_cy '__gap_call_yo_nethod', this.__cau_yi_at, 'cn_post_stop' }
  }
  def gf_mk_atr ( final long x_yi_at, final String x_at_nm, final akka.actor.ActorRefFactory x_arf ) { // atr -> (a)c(t)or (r)eference
    switch (x_at_nm) {
      case ':a' : return x_arf .actorOf ( akka.actor.Props .create ( __CgAt, x_yi_at ) )
      default : return x_arf .actorOf ( akka.actor.Props .create ( __CgAt, x_yi_at ), x_at_nm )
    }
  }
''')
class CgAt :
  def __init__ (self) :
    self.cu_yio = gf_cllo (self)
  def cn_pre_start ( self, x_org_at ) :
    self.cu_org_at = x_org_at
    if hasattr ( self, 'preStart' ) : getattr ( self, 'preStart' ) ()
  def cn_post_stop (self) :
    if hasattr ( self, 'postStop' ) : getattr ( self, 'postStop' ) ()
    gf_yo ( self.cu_yio, True )
  def getSelf (self) : return self.cu_org_at .getSelf ()
  def getContext (self) : return self.cu_org_at .getContext ()
  def tell ( self, x_target_atr, x_letter, x_sender_atr = None ) :
    nu_sender_atr = self .getSelf () if x_sender_atr == None else x_sender_atr
    x_target_atr .tell ( gf_cllo (x_letter), nu_sender_atr )
def gf_mk_atr ( x_at, x_at_nm, x_arf = GC_AS ) :
  fu_at_nm = x_at.__class__.__name__ if x_at_nm == ':c' else ':a' if x_at_nm == None else x_at_nm
  return gf_gr_call ( 'gf_mk_atr', gf_yi (x_at), fu_at_nm, x_arf )

#
# Main Skeleton
#

class DRun :
  __dav_ec = GC_EC_NONE
  __dav_ex_list = None
  @classmethod
  def dp_it (cls) :
    try :
      cls.__dap_begin ()
      DBody .dp_it ()
      cls.__dav_ec = GC_QAPP .exec_ ()
    except :
      cls.__dav_ec = GC_EC_ERROR
      cls.__dav_ex_list = gf_exception_to_list ()
    finally :
      GC_LOG .info ( f'GC_QAPP exited' )
      gp_request_exit ( cls.__dav_ec, cls.__dav_ex_list )
  @classmethod
  def __dap_begin (cls) :
    print ( "\n".join ( cls .__daf_banner () ) )
    GC_LOG .debug ( f'Pyja name => {GC_PYJA_NM}' )
    if GC_PYJA_NM != gf_os_env ('SC_PYJA_NM') : raise Exception ( 'Invalid Pyja name !!!' )
    GC_LOG .debug ( f'Pyja creation date => {GC_PYJA_CD}' )
    if not gf_str_is_valid_date ( GC_PYJA_CD, '%Y.%m.%d' ) : raise Exception ( 'Pyja create date is not invalid !!!' )
    GC_LOG .debug ( f'Pyja version => {GC_PYJA_V2}' )
    if GC_PYJA_VR != gf_os_env ('SC_PYJA_VR') : raise Exception ( 'Invalid Pyja version !!!' )
    GC_LOG .info  ( f'Pyja root ({GC_PYJA_RT_SYM}) => {GC_PYJA_RT}' )
    GC_LOG .info  ( f'Pyja home ({GC_PYJA_HM_SYM}) => { gf_to_prs (GC_PYJA_HM) }' )
    GC_LOG .info  ( f'Milo path ({GC_MILO_PN_SYM}) => { gf_to_phs (GC_MILO_PN) }' )
    GC_LOG .debug ( f'Java home => {GC_JAVA_HM}' )
    GC_LOG .debug ( f'Python home => {GC_PYTHON_HM}' )
    GC_LOG .debug ( f'Total CPU => {GC_TOTAL_CPU}' )
    GC_LOG .debug ( f'Total memory => {GC_TOTAL_MEMORY:,d} bytes' )
    GC_LOG .debug ( f'Available memory => {gf_os_available_memory():,d} bytes' )
    GC_LOG .debug ( f'Computer name => {GC_HOST_NM}' )
    GC_LOG .debug ( f'Current user => {GC_CUSR}' )
    GC_LOG .debug ( f'Process ID => {GC_THIS_PID}' )
    GC_LOG .debug ( f'Executable file => {GC_THIS_EXE_FN}' )
    GC_LOG .info  ( f'Start up path => { gf_to_phs (GC_THIS_START_UP_PN) }' )
    GC_LOG .info  ( f'Script file => { gf_to_mps (GC_SCRIPT_FN) }' )
    gp_log_array ( GC_LOG.debug, 'Paths', GC_OS_ENV_PATHS )
    if len(GC_CMD) > 0 : gp_log_array ( GC_LOG .debug, 'Command', GC_CMD )
    if len(GC_ARGV) > 0 : gp_log_array ( GC_LOG .info, 'Arguments', GC_ARGV )
  @classmethod
  def __daf_banner ( cls, x_leading_space = 0, x_margin_inside = 2 ) :
    fu_msgs = [
      '{} {}' .format ( GC_PYJA_NM, GC_APP_NM ),
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

#
# Your Source
#

class CAtPrinter (CgAt) :
  LGreeting = namedtuple ( 'LGreeting', ['lu_it'] )
  def __init__ ( self, x_atr_main ) :
    super () .__init__ ()
    self.cu_atr_main = x_atr_main
  def receive ( self, x_yi_letter, x_sender_atr ) :
    nu_letter = gf_yo ( x_yi_letter, True )
    GC_LOG .debug ( f'{self.__class__.__name__} : Received {nu_letter}' )
    if isinstance ( nu_letter, self.LGreeting ) :
      self .tell ( self.cu_atr_main, WAtFxMain .LDisplay (nu_letter.lu_it) )
      GC_LOG .info (nu_letter.lu_it)

class CAtGreeter (CgAt) :
  LWhoToGreet = namedtuple ( 'LWhoToGreet', ['lu_who'] )
  LGreet = namedtuple ( 'LGreet', [] )
  def __init__ ( self, x_msg, x_atr_printer ) :
    super () .__init__ ()
    self.cu_msg = x_msg
    self.cu_atr_printer = x_atr_printer
  def receive ( self, x_yi_letter, x_sender_atr ) :
    nu_letter = gf_yo ( x_yi_letter, True )
    GC_LOG .debug ( f'{self.__class__.__name__} : Received {nu_letter}' )
    if isinstance ( nu_letter, self.LWhoToGreet ) : self.cv_greeting = f'{self.cu_msg} {nu_letter.lu_who}'
    elif isinstance ( nu_letter, self.LGreet ) : self .tell ( self.cu_atr_printer, CAtPrinter .LGreeting (self.cv_greeting) )

class WAtFxMain (CgAt) :
  LDisplay = namedtuple ( 'LDisplay', ['lu_msg'] )
  def __init__ ( self, x_stage ) :
    super () .__init__ ()
    self.wu_stg = x_stage
    gp_xr (self.wn_init)
  def wn_init (self) :
    gp_fx_set_on ( self.wu_stg.setOnShown, self.won_shown )
    gp_fx_set_on ( self.wu_stg.setOnCloseRequest, self.won_close_request )
    self.wu_root = gf_jcls ('javafx.scene.layout.StackPane') ()
    self.wu_scene = gf_jcls ('javafx.scene.Scene') (self.wu_root)
    self.wu_lv = gf_jcls ('javafx.scene.control.ListView') ()
    self.wu_root .getChildren () .addAll ([self.wu_lv])
    self.wu_stg .setTitle (GC_APP_NM)
    self.wu_stg .setWidth (777)
    self.wu_stg .setHeight (555)
    self.wu_stg .setScene (self.wu_scene)
    self.wu_stg .show ()
  def preStart (self) :
    nv_sn = 0
    def np2_greet ( x2_it, x2_who ) :
      nonlocal nv_sn
      nv_sn += 1
      self .tell ( x2_it, CAtGreeter .LWhoToGreet ( f'({nv_sn:03d}) {x2_who}' ) )
      self .tell ( x2_it, CAtGreeter .LGreet () )
    self.wu_atr_printer  = gf_mk_atr ( CAtPrinter ( self .getSelf () ), ':c' )
    self.wu_atr_hello    = gf_mk_atr ( CAtGreeter ( '-----HELLOHELLOHELLO-----', self.wu_atr_printer ), ':a' )
    self.wu_atr_howdy    = gf_mk_atr ( CAtGreeter ( 'HOWDY', self.wu_atr_printer ), ':a' )
    self.wu_atr_good_day = gf_mk_atr ( CAtGreeter ( 'HAVE*A*GOOD*DAY', self.wu_atr_printer ), ':a' )
    for bu2_who in [ 'Python', 'PyQt', 'Jep' ] : np2_greet ( self.wu_atr_hello, bu2_who )
    for bu2_who in [ 'JavaFx', 'Groovy', 'Scala', 'Akka', 'Django', 'Play', 'Jep' ] : np2_greet ( self.wu_atr_howdy, bu2_who )
    for bu2_who in [
      'Programming with Python, JRuby, Scala, ...',
      'You can use Qt and JavaFx for GUI',
      'You can use enormous libraries from Python, Java, Ruby, ...',
      'Build powerful real concurrent applications more easily using JVM Akka ...',
      'Create a cross platform Windows, macOS application',
      'Pyja - Python rubY Java Anything',
      'Pyja - Python rubY Java Anything',
      'Pyja - Python rubY Java Anything',
      'Pyja - Python rubY Java Anything',
      'Pyja - Python rubY Java Anything',
      'Pyja - Python rubY Java Anything',
    ] : np2_greet ( self.wu_atr_good_day, bu2_who )
  def receive ( self, x_yi_letter, x_sender_atr ) :
    nu_letter = gf_yo ( x_yi_letter, True )
    GC_LOG .debug ( f'{self.__class__.__name__} : Received {nu_letter}' )
    if isinstance ( nu_letter, self.LDisplay ) : gp_xr ( self.wn_display, nu_letter.lu_msg )
  def wn_display ( self, x_msg ) : self.wu_lv .getItems () .add (x_msg)
  def won_shown ( self, x_ev ) :
    GC_LOG .info ( f'{self.__class__.__name__} => OnShown')
  def won_close_request ( self, x_ev ) :
    GC_LOG .info ( f'{self.__class__.__name__} => OnCloseRequest')
    GC_QAPP .quit ()

class DBody :
  @classmethod
  def dp_it (cls) :
    gp_fx_start (cls.dp_fx_start)
  @classmethod
  def dp_fx_start ( cls, x_app, x_stage ) :
    try : gf_mk_atr ( WAtFxMain (x_stage), ':c' )
    except : gp_request_exit ( GC_EC_ERROR, gf_exception_to_list () )
    
class OStart :
  @classmethod
  def main (cls) :
    gp_set_log_level_to_info ()
    DRun .dp_it ()
  
if __name__ == '__main__':
  OStart .main ()
