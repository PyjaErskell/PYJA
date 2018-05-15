#
# Python (Global)
#

import sys

sys.dont_write_bytecode = True

from PyQt5.QtCore import QDateTime

GC_ST = QDateTime .currentDateTime () # (G)lobal (C)onstant

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

from PyQt5 import QtCore
from PyQt5.QtCore import pyqtSignal
from PyQt5.QtCore import QCoreApplication
from PyQt5.QtCore import QObject
from PyQt5.QtCore import Qt
from PyQt5.QtCore import QThread
from PyQt5.QtCore import QTimer
from PyQt5.QtWidgets import QApplication

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

def gf_banner ( x_leading_space = 0, x_margin_inside = 2 ) :
  fu_msgs = [
    '{} {}' .format ( GC_PYJA_NM, GC_APP_NM ),
    '',
    'ran on {}' .format (  GC_ST .toString ('yyyy-MM-dd HH:mm:ss') ),
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
def gp_log_exception ( xp_out, x_title, x_ex_list ) :
  if type(x_ex_list) is not list : gp_log_header ( xp_out, 'List of reasons is not given !!!', 60 )
  else :
    gp_log_header ( xp_out, x_title, 60 )
    for bu2_it in x_ex_list : xp_out (bu2_it)

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

def gp_yn ( x_yi, x_nethod_nm, *x_args ) : # call p(y)thon (n)ethod
  pu_yo = gf_yo (x_yi)
  if hasattr ( pu_yo, x_nethod_nm ) : getattr ( pu_yo, x_nethod_nm ) (*x_args)

class __CgQtRun (QThread) :
  __cag_it = pyqtSignal ()
  def __init__ ( self, x_callable, *x_args ) :
    super () .__init__ ()
    self.cu_yi = gf_cllo (self)
    self.cu_lambda = x_callable
    self.cu_args = x_args
  def run (self) :
    self.__cag_it .connect ( lambda : self.cu_lambda (*self.cu_args) )
    self.__cag_it .emit ()
    gf_yo ( self.cu_yi, True )

#
# Java (Global)
#

import jep

JC_GR = jep.findClass ('javax.script.ScriptEngineManager') () .getEngineByName ('groovy')

JC_GR .put ( 'GC_JEP', JC_JEP )

def jy_ge (x_str) : return JC_GR .eval (x_str)

jy_ge ('''
  gf_tid = { Thread .currentThread () .getId () }
  GC_THIS_TID = gf_tid ()
''')

jy_ge (f'''
  GC_ST = new Date () .parse ( 'yyyy-MM-dd HH:mm:ss', '{ GC_ST .toString ('yyyy-MM-dd HH:mm:ss') }' )
  GC_APP_NM = '{GC_APP_NM}'
  GC_EC_NONE     = {GC_EC_NONE}
  GC_EC_SHUTDOWN = {GC_EC_SHUTDOWN}
  GC_EC_SUCCESS  = {GC_EC_SUCCESS}
  GC_EC_ERROR    = {GC_EC_ERROR}
  GC_THIS_PID = {GC_THIS_PID}
''')

jy_ge ('''
  gf_ga = { final Object x_oj, final String x_attr_nm -> // get attribute of groovy object
    x_oj.metaClass.getAttribute x_oj, x_attr_nm
  }
  gp_puts = { final x_str -> println x_str }
  gf_jcls = { final String x_cls_nm -> return Class.forName (x_cls_nm) }
  gp_add_jar = { final String x_jar_fn ->
    if ( ! new File (x_jar_fn) .exists () ) { throw new FileNotFoundException ( "JAR file not found => ${x_jar_fn}" ) }
    final URL pu_url = new File (x_jar_fn) .toURI () .toURL ()
    final URLClassLoader pu_cl = ClassLoader .getSystemClassLoader ()
    final fu_m = URLClassLoader.class .getDeclaredMethod 'addURL', URL.class
    fu_m.setAccessible true
    fu_m.invoke pu_cl, pu_url
  }
''')

def jf_jarray (x_py_list) :
  fu_arr_sz = len (x_py_list)
  fu_params = jy_ge ( f'new Object [{fu_arr_sz}]' )
  for bu2_idx, bu2_it in enumerate ( x_py_list ) : fu_params [bu2_idx] = x_py_list [bu2_idx]
  return fu_params
def jy_gf ( x_nm, *x_args ) : return JC_GR. invokeFunction ( x_nm, jf_jarray (x_args) )
def jy_gm ( x_oj, x_nm, *x_args ) : return JC_GR. invokeMethod ( x_oj, x_nm, jf_jarray (x_args) )
def jy_gc ( x_closure, *x_args ) : return jy_gm ( x_closure, 'call', *x_args )
def jf_ga ( x_oj, x_attr_nm ) : return jy_gf ( 'gf_ga', x_oj, x_attr_nm )
def jp_puts (x_str) : jy_gf ( 'gp_puts', x_str )
def jf_jcls (x_cls_nm) : return jy_gf ( 'gf_jcls', x_cls_nm )
def jp_add_jar (x_jar_fn) : jy_gf ( 'gp_add_jar', x_jar_fn )


for bu2_jar_fn in [
  gf_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'akka-actor_2.12-2.5.9.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'config-1.3.2.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-library.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'JNA', '4.5.1', 'jna-4.5.1.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'JNA', '4.5.1', 'jna-platform-4.5.1.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-classic-1.2.3.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-core-1.2.3.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
] : jp_add_jar (bu2_jar_fn)

CjActorRef = jf_jcls ('akka.actor.ActorRef')
CjAwait = jf_jcls ('scala.concurrent.Await')
CjDuration = jf_jcls ('scala.concurrent.duration.Duration')
CjPlatform  = jf_jcls ('com.sun.jna.Platform')

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
  gp_set_log_level_to_info = { GC_LOG.level = ch.qos.logback.classic.Level.INFO }
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
  __gav_was_exit_processed = false
  gp_request_exit = { final long x_ec, final x_ex = [] ->
    def pp2_before_exit = {
      if (x_ex) gp_log_exception "Following error occurs !!!", x_ex
      if ( x_ec != GC_EC_SUCCESS && !x_ex ) { gp_log_header ( GC_LOG.&error, "Unknown error occurs !!!" ); }
      switch (x_ec) {
        case GC_EC_NONE : GC_LOG .error "Undefined exit code (GC_EC_NONE), check your logic !!!"; break
        case GC_EC_SHUTDOWN : GC_LOG .info "Exit code from shutdown like ctrl+c, ..."; break
        default :
          if ( x_ec < 0 ) GC_LOG .error "Negative exit code ${x_ec}, should consider using a positive value !!!"
          else GC_LOG .info "Exit code => ${x_ec}"
          break
      }
      GC_LOG .info "Elapsed ${ ( new Date () .getTime () - GC_ST .getTime () ) / 1000.0 } ..."
    }
    def pp2_exit = {
      switch (x_ec) {
        case GC_EC_NONE : System .exit (GC_EC_ERROR); break
        case GC_EC_SHUTDOWN : break
        default :
          if ( x_ec < 0 ) System .exit (GC_EC_ERROR)
          else System .exit ( x_ec .intValue () )
          break
      }
    }
    if ( __gav_was_exit_processed ) return
    pp2_before_exit ()
    __gav_was_exit_processed = true
    pp2_exit ()
  }
  addShutdownHook { gp_request_exit GC_EC_SHUTDOWN, [ 'Shutdown occurred !!!' ] }
''')

JC_LOG = jy_ge ('GC_LOG')
def jp_set_log_level_to_info ()  : jy_gf ( 'gp_set_log_level_to_info'  )
def jp_set_log_level_to_debug () : jy_gf ( 'gp_set_log_level_to_debug' )
def jp_set_log_level_to_trace () : jy_gf ( 'gp_set_log_level_to_trace' )

jy_ge ('''
  __gau_lock_4_{0} = new Object [0]
  Object.metaClass.{0} = {{ final long x_yi, final String x_nethod_nm, final Object... x_args ->
    synchronized (__gau_lock_4_{0}) {{ GC_JEP .invoke ( '{0}', x_yi, x_nethod_nm, *x_args ) }}
  }}
''' .format ('gp_yn') )
jy_ge ( 'gp_sr = { final Closure xp_it -> javax.swing.SwingUtilities .invokeLater { xp_it () } }' )
jy_ge ('''
  gp_xr = { final Closure xp_it -> javafx.application.Platform .runLater { xp_it () } }
  class CgFxApp extends javafx.application.Application {
    private static Closure __casp_start
    static void csn_launch ( final Closure xp_it ) { __casp_start = xp_it; launch this }
    void start ( final javafx.stage.Stage x_stage ) { __casp_start ( this, x_stage ) }
  }
  gf_new_scene = { final Closure xp_it -> new javafx.embed.swing.JFXPanel () .with { xp_it () } }
  def gp_fx_set_on ( final Object x_xo, final String x_xo_nethod_nm, final long x_yi, final String x_nethod_nm, final String... x_params = ['it'] ) { // xo -> f(x) (o)bject
    pu_params = x_params .join ', '
    x_xo ."$x_xo_nethod_nm" evaluate ( "{ ${pu_params} -> gp_yn ${x_yi}, '${x_nethod_nm}', ${pu_params} }" )
  }
  def gp_xr ( final long x_yi, final String x_nethod_nm, final Object... x_args ) {
    javafx.application.Platform.runLater { gp_yn ( x_yi, x_nethod_nm, *x_args ) }
  }
''')
def jp_fx_set_on ( x_xo_nethod, x_yo_nethod, *x_args ) : jy_gf ( 'gp_fx_set_on', x_xo_nethod.__self__, x_xo_nethod.__name__, gf_yi (x_yo_nethod.__self__), x_yo_nethod.__name__, *x_args )
def jp_xr ( x_yo_nethod, *x_args ) : jy_gf ( 'gp_xr', gf_yi (x_yo_nethod.__self__), x_yo_nethod.__name__, *x_args )

JC_AS = jy_ge ( '''Object.metaClass.{0} = akka.actor.ActorSystem .create '{0}', com.typesafe.config.ConfigFactory .parseString ( 'akka {{ loglevel = "ERROR" }}' )''' .format ('GC_AS') )
jy_ge ('''
  class CgAt extends akka.actor.AbstractActor { // (A)c(t)or
    final private long __cau_at_yi
    CgAt ( final long x_yi_at ) { this.__cau_at_yi = x_yi_at }
    void preStart () { gp_yn this.__cau_at_yi, 'cn_pre_start', this }
    akka.actor.AbstractActor.Receive createReceive () {
      return receiveBuilder () .match ( Object.class, { it -> gp_yn this.__cau_at_yi, 'receive', it, getSender () } ) .build ()
    }
    void postStop () { gp_yn this.__cau_at_yi, 'cn_post_stop' }
  }
  def gf_mk_atr ( final long x_yi_at, final String x_at_nm, final akka.actor.ActorRefFactory x_arf ) { // atr -> (a)c(t)or (r)eference
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
  def cn_pre_start ( self, x_org_at ) :
    self.cu_org_at = x_org_at
    if hasattr ( self, 'preStart' ) : getattr ( self, 'preStart' ) ()
  def cn_post_stop (self) :
    if hasattr ( self, 'postStop' ) : getattr ( self, 'postStop' ) ()
    gf_yo ( self.cu_yi, True )
  def getSelf (self) : return self.cu_org_at .getSelf ()
  def getContext (self) : return self.cu_org_at .getContext ()
  def tell ( self, x_atr_target, x_letter, x_atr_sender = None ) :
    nu_atr_sender = self .getSelf () if x_atr_sender == None else x_atr_sender
    x_atr_target .tell ( x_letter, nu_atr_sender )
def jf_mk_atr ( x_at, x_at_nm, x_arf = JC_AS ) :
  fu_at_nm = x_at.__class__.__name__ if x_at_nm == ':c' else ':a' if x_at_nm == None else x_at_nm
  return jy_gf ( 'gf_mk_atr', gf_yi (x_at), fu_at_nm, x_arf )

def jp_request_exit ( x_ec, x_ex_list = None ) :
  JC_AS .terminate ()
  CjAwait .ready ( JC_AS .whenTerminated (), CjDuration .Inf () )
  pu_llos = gf_llos ()
  if len(pu_llos) > 0 :
    JC_LOG .warn ( f'You did not delete {len(pu_llos)} llo(s) with gp_dllo () function after using llo(s) !!!' )
    gp_log_dict ( JC_LOG .warn, 'Undeleted python llo(s)', pu_llos )
  jy_gf ( 'gp_request_exit', x_ec, x_ex_list )

def jp_qr ( x_callable, *x_args ) :  # qr -> (q)t (r)un
  if ( CjPlatform .isMac () ) : x_callable (*x_args)
  else : __CgQtRun ( x_callable, *x_args ) .start ()

#
# Main Skeleton
#

class DRun :
  __dav_ec = GC_EC_NONE
  __dav_ex_list = None
  @classmethod
  def __dap_begin (cls) :
    jp_puts ( "\n" .join ( gf_banner () ) )
    JC_LOG .debug ( f'Pyja name => {GC_PYJA_NM}' )
    if GC_PYJA_NM != gf_os_env ('SC_PYJA_NM') : raise Exception ( 'Invalid Pyja name !!!' )
    JC_LOG .debug ( f'Pyja creation date => {GC_PYJA_CD}' )
    if not gf_str_is_valid_date ( GC_PYJA_CD, '%Y.%m.%d' ) : raise Exception ( 'Pyja create date is not invalid !!!' )
    JC_LOG .debug ( f'Pyja version => {GC_PYJA_V2}' )
    if GC_PYJA_VR != gf_os_env ('SC_PYJA_VR') : raise Exception ( 'Invalid Pyja version !!!' )
    JC_LOG .info  ( f'Pyja root ({GC_PYJA_RT_SYM}) => {GC_PYJA_RT}' )
    JC_LOG .info  ( f'Pyja home ({GC_PYJA_HM_SYM}) => { gf_to_prs (GC_PYJA_HM) }' )
    JC_LOG .info  ( f'Milo path ({GC_MILO_PN_SYM}) => { gf_to_phs (GC_MILO_PN) }' )
    JC_LOG .debug ( f'Java home => {GC_JAVA_HM}' )
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
      cls.__dav_ec = GC_EC_SUCCESS
    except :
      cls.__dav_ec = GC_EC_ERROR
      cls.__dav_ex_list = gf_exception_to_list ()
    finally :
      jp_request_exit ( cls.__dav_ec, cls.__dav_ex_list )

#
# Your Source
#

from PyQt5.QtGui import QFont
from PyQt5.QtGui import QFontDatabase
from PyQt5.QtWidgets import QDesktopWidget
from PyQt5.QtWidgets import QLabel
from PyQt5.QtWidgets import QMainWindow
from PyQt5.QtWidgets import QPushButton
from PyQt5.QtWidgets import QSizePolicy
from PyQt5.QtWidgets import QVBoxLayout
from PyQt5.QtWidgets import QWidget

class WAtFxMain (CjAt) :
  LNextFont = jy_ge ( "class {0} {{}}" .format ('LNextFont') )
  def __init__ ( self, x_atr_qt_main, x_stage ) :
    super () .__init__ ()
    self.wu_atr_qt_main = x_atr_qt_main
    self.wu_stg = x_stage
    jp_xr ( self .wn_init )
  def preStart (self) :
    self .tell ( self.wu_atr_qt_main, WAtQtMain.LAtrFxMainCreated () )
  def receive ( self, x_letter, x_atr_sender ) :
    nu_l = x_letter
    nu_lcn = nu_l.java_name
    JC_LOG .debug ( f'{self.__class__.__name__} : Received {nu_lcn}' )
    if ( nu_lcn == 'LNextFont' ) : jp_xr ( self.wn_change_font, None, False )
  def wn_init (self) :
    jp_fx_set_on ( self.wu_stg.setOnCloseRequest, self.wn_quit )
    self.wu_root = jf_jcls ('javafx.scene.layout.VBox') ()
    self.wu_scene = jf_jcls ('javafx.scene.Scene') (self.wu_root)
    self.wu_bn = jf_jcls ('javafx.scene.control.Button') ()
    self.wu_lb = jf_jcls ('javafx.scene.control.Label') ()
    self.wu_fnt_families = jf_jcls ('javafx.scene.text.Font') .getFamilies ()
    JC_LOG .info ( f'{self.__class__.__name__} : Total fonts => {len(self.wu_fnt_families)}' )
    self.wv_fnt_idx = len(self.wu_fnt_families) - 1
    self.wv_msg = ''
    jp_fx_set_on ( self.wu_bn.setOnAction, self.wn_change_font )
    self.wn_change_font ( None, False )
    self.wu_root .setAlignment ( jf_jcls ('javafx.geometry.Pos') . CENTER )
    self.wu_root .setSpacing (10)
    self.wu_root .getChildren () .addAll ( [ self.wu_bn, self.wu_lb ] )
    self.wu_stg .setTitle (f'{GC_APP_NM} - JavaFx')
    self.wu_stg .setWidth (650)
    self.wu_stg .setHeight (250)
    self.wu_stg .setScene (self.wu_scene)
    self .wn_move_center ()
    self.wu_stg .show ()
  def wn_move_center (self) :
    nu_vb = jf_jcls ('javafx.stage.Screen') .getPrimary () .getVisualBounds ()
    nu_cx, nu_cy = int(nu_vb.getWidth()/2), int(nu_vb.getHeight()/2)
    self.wu_stg .setX ( nu_cx - self.wu_stg.getWidth()/2 )
    self.wu_stg .setY ( nu_cy - self.wu_stg.getHeight() )
  def wn_change_font ( self, x_ev, x_tell = True ) :
    if self.wv_fnt_idx >= len(self.wu_fnt_families) : self.wv_fnt_idx = 0
    nu_fnt_nm = self.wu_fnt_families [self.wv_fnt_idx]
    if self.wv_msg != '' : JC_LOG .info ( f'JavaFx -> {self.wv_msg}' )
    nu_nt = f'({self.wv_fnt_idx+1}/{len(self.wu_fnt_families)})'
    self.wv_msg = f'0^0 {nu_nt} ({nu_fnt_nm})'
    self.wu_bn .setText ( f"Say '{self.wv_msg}'" )
    self.wu_bn .setStyle ( f"-fx-font-family : '{nu_fnt_nm}'; -fx-font-size : 17px;" )
    self.wu_lb .setText ( f'{nu_nt} Font name : {nu_fnt_nm}' )
    self .wn_move_center ()
    self.wv_fnt_idx += 1
    if x_tell : self .tell ( self.wu_atr_qt_main, WAtQtMain.LNextFont () )
  def wn_quit ( self, x_ev ) : GC_QAPP .quit ()

class WAtQtMain (CjAt) :
  LAtrFxMainCreated = jy_ge ( "class {0} {{}}" .format ('LAtrFxMainCreated') )
  LNextFont = jy_ge ( "class {0} {{}}" .format ('LNextFont') )
  def __init__ (self) :
    super () .__init__ ()
    self .wn_init ()
  def receive ( self, x_letter, x_atr_sender ) :
    nu_l = x_letter
    nu_lcn = nu_l.java_name
    JC_LOG .debug ( f'{self.__class__.__name__} : Received {nu_lcn}' )
    if ( nu_lcn == 'LAtrFxMainCreated' ) : jp_qr ( self.wu_wgt .setEnabled, True )
    elif ( nu_lcn == 'LNextFont' ) : jp_qr ( self.wn_change_font, False )
  def wn_init (self) :
    self.wu_yi = gf_yi (self)
    self.wu_wgt = QMainWindow ()
    self.wu_wgt .setWindowTitle (f'{GC_APP_NM} - PyQt')
    self.wu_cw = QWidget ()
    self.wu_lo = QVBoxLayout ()
    self.wu_pb = QPushButton ()
    self.wu_pb .setSizePolicy ( QSizePolicy.Expanding, QSizePolicy.Fixed )
    self.wu_pb .pressed .connect (self.wn_change_font)
    self.wu_lb = QLabel ()
    self.wu_lb .setAlignment (Qt.AlignCenter)
    for bu2_qo in [ QWidget (), self.wu_pb, self.wu_lb ] : self.wu_lo .addWidget (bu2_qo)
    self.wu_cw .setLayout (self.wu_lo)
    self.wu_fnt_families = QFontDatabase () .families ()
    JC_LOG .info ( f'{self.__class__.__name__} : Total fonts => {len(self.wu_fnt_families)}' )
    self.wv_fnt_idx = len(self.wu_fnt_families) - 1
    self.wv_msg = ''
    self .wn_change_font (False)
    self.wu_wgt .setCentralWidget (self.wu_cw)
    self.wu_wgt .resize ( 650, 250 )
    self.wu_wgt .setEnabled (False)
    self.wu_wgt .show ()
    self.wu_wgt .raise_ ()
    self .wn_move_center ()
    jy_ge ( f'''Thread .start {{ CgFxApp .csn_launch ( {{ final x_app, final x_stage -> gp_yn {self.wu_yi}, 'wn_fx_start', x_app, x_stage }} ) }}''' )
  def wn_fx_start ( self, x_app, x_stage ) :
    self.wu_atr_fx_main = jf_mk_atr ( WAtFxMain ( self .getSelf (), x_stage ), ':c' )
  def wn_change_font ( self, x_tell = True ) :
    if self.wv_fnt_idx >= len(self.wu_fnt_families) : self.wv_fnt_idx = 0
    nu_fnt_nm = self.wu_fnt_families [self.wv_fnt_idx]
    if self.wv_msg != '' : JC_LOG .info ( f'PyQt -> {self.wv_msg}' )
    nu_nt = f'({self.wv_fnt_idx+1}/{len(self.wu_fnt_families)})'
    self.wv_msg = f'0^0 {nu_nt} ({nu_fnt_nm})'
    self.wu_pb .setText ( f"Say '{self.wv_msg}'" )
    self.wu_pb .setFont ( QFont ( nu_fnt_nm, 17 ) )
    self.wu_lb .setText ( f'{nu_nt} Font name : {nu_fnt_nm}' )
    self .wn_move_center ()
    self.wv_fnt_idx += 1
    if x_tell : self .tell ( self.wu_atr_fx_main, WAtFxMain.LNextFont () )
  def wn_move_center (self) :
    nu_cp = QDesktopWidget () .availableGeometry () .center () # center point
    self.wu_wgt .move ( nu_cp.x() - self.wu_wgt.width()/2 , nu_cp.y() )

class DBody :
  @classmethod
  def dp_it (cls) :
    GC_QAPP .setStyle ('fusion')
    pu_atr_main = jf_mk_atr ( WAtQtMain (), ':c' )
    GC_QAPP .exec_ ()

class OStart :
  @classmethod
  def main (cls) :
    jp_set_log_level_to_info ()
    DRun .dp_it ()
  
if __name__ == '__main__':
  OStart .main ()
