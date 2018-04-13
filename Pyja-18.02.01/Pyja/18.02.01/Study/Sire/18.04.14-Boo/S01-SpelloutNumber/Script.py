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

def gp_c1 ( x_it, x_1 ) : eval (x_it) (x_1)
def gp_c2 ( x_it, x_1, x_2 ) : eval (x_it) ( x_1, x_2 )
def gp_c3 ( x_it, x_1, x_2, x_3 ) : eval (x_it) ( x_1, x_2, x_3 )
def gp_c4 ( x_it, x_1, x_2, x_3, x_4 ) : eval (x_it) ( x_1, x_2, x_3, x_4 )
def gp_c5 ( x_it, x_1, x_2, x_3, x_4, x_5 ) : eval (x_it) ( x_1, x_2, x_3, x_4, x_5 )
def gp_c6 ( x_it, x_1, x_2, x_3, x_4, x_5, x_6 ) : eval (x_it) ( x_1, x_2, x_3, x_4, x_5, x_6 )
def gp_c7 ( x_it, x_1, x_2, x_3, x_4, x_5, x_6, x_7 ) : eval (x_it) ( x_1, x_2, x_3, x_4, x_5, x_6, x_7 )
def gp_c8 ( x_it, x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8 ) : eval (x_it) ( x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8 )
def gp_c9 ( x_it, x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9 ) : eval (x_it) ( x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9 )
def gp_c10 ( x_it, x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9, x_10 ) : eval (x_it) ( x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9, x_10 )

def gf_c1 ( x_it, x_1 ) : return eval (x_it) (x_1)
def gf_c2 ( x_it, x_1, x_2 ) : return eval (x_it) ( x_1, x_2 )
def gf_c3 ( x_it, x_1, x_2, x_3 ) : return eval (x_it) ( x_1, x_2, x_3 )
def gf_c4 ( x_it, x_1, x_2, x_3, x_4 ) : return eval (x_it) ( x_1, x_2, x_3, x_4 )
def gf_c5 ( x_it, x_1, x_2, x_3, x_4, x_5 ) : return eval (x_it) ( x_1, x_2, x_3, x_4, x_5 )
def gf_c6 ( x_it, x_1, x_2, x_3, x_4, x_5, x_6 ) : return eval (x_it) ( x_1, x_2, x_3, x_4, x_5, x_6 )
def gf_c7 ( x_it, x_1, x_2, x_3, x_4, x_5, x_6, x_7 ) : return eval (x_it) ( x_1, x_2, x_3, x_4, x_5, x_6, x_7 )
def gf_c8 ( x_it, x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8 ) : return eval (x_it) ( x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8 )
def gf_c9 ( x_it, x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9 ) : return eval (x_it) ( x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9 )
def gf_c10 ( x_it, x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9, x_10 ) : return eval (x_it) ( x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9, x_10 )

from PyQt5.QtCore import pyqtSignal
from PyQt5.QtCore import QCoreApplication
from PyQt5.QtCore import QObject
from PyQt5.QtCore import Qt
from PyQt5.QtCore import QThread
from PyQt5.QtWidgets import QApplication
from PyQt5.QtWidgets import QMessageBox

GC_QAPP = QApplication ([])
def gp_show_error ( x_msg = None ) :
  pu_msg = gf_exception_to_list () [0] if x_msg is None else x_msg
  QMessageBox .critical ( None, GC_APP_NM, pu_msg, QMessageBox.Ok )

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

GC_CMD = psutil.Process () .cmdline ()
sys.executable = GC_CMD [0]

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

GC_THIS_WFD_FN = gf_ap ( gf_os_env ('SC_THIS_WFD_FN') );
GC_THIS_WFD_PN = gf_pn (GC_THIS_WFD_FN)
GC_THIS_START_UP_PN = gf_ap ( os.getcwd () )

GC_APP_NM = gf_on (GC_THIS_WFD_PN)
GC_SCRIPT_FN = gf_pj ( GC_THIS_WFD_PN, f"{GC_APP_NM}.py" )
GC_ARGV = []
sys.argv = [ GC_SCRIPT_FN ] + GC_ARGV

GC_THIS_EXE_FN = gf_fn (sys.executable)
GC_THIS_EXE_JN = gf_jn (GC_THIS_EXE_FN)
GC_THIS_EXE_XN = gf_xn (GC_THIS_EXE_FN)
GC_THIS_EXE_BN = gf_bn (GC_THIS_EXE_FN)
GC_THIS_EXE_PN = gf_pn (GC_THIS_EXE_FN)
GC_THIS_EXE_ON = gf_on (GC_THIS_EXE_FN)

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

def gp_log_stream_write ( x_logger, x_msg ) :
  for bu2_handler in x_logger.handlers :
    bu2_handler.stream.write (x_msg)
    bu2_handler.stream.flush ()
def gp_log_stream_write_line ( x_logger, x_msg ) : gp_log_stream_write ( x_logger, '{}\n' .format (x_msg) )
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

#
# Java (Global)
#

from jpype import *
startJVM ( getDefaultJVMPath (), gf_os_env ('SC_JAVA_XMX'), '-Djava.class.path={}' .format ( gf_pj ( GC_PYJA_HM, 'Library', 'Groovy', '2.4.14', 'embeddable', 'groovy-all-2.4.14-indy.jar' ) ) )

GC_GR = javax.script.ScriptEngineManager () .getEngineByName ('groovy')
GC_GR .eval (f'''
  Object.metaClass.GC_EC_ERROR = {GC_EC_ERROR}
  Object.metaClass.GC_THIS_PID = {GC_THIS_PID}
''')
GC_GR .eval ('''
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
def gp_add_jar (x_jar_fn) :
  try :
    gp_gr_call ( 'gp_add_jar', x_jar_fn )
  except :
    gp_show_error ()

def __gap_add_default_jars () :
  pu_jar_fns = [
    gf_pj ( GC_PYJA_HM, 'Library', 'AppDirs', '1.0.0', 'appdirs-1.0.0.jar' ),
    gf_pj ( GC_PYJA_HM, 'Library', 'JNA', '4.5.1', 'jna-4.5.1.jar' ),
    gf_pj ( GC_PYJA_HM, 'Library', 'JNA', '4.5.1', 'jna-platform-4.5.1.jar' ),
    gf_pj ( GC_PYJA_HM, 'Library', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
    gf_pj ( GC_PYJA_HM, 'Library', 'SLF4J', '1.7.25', 'slf4j-nop-1.7.25.jar' ),
  ]
  for bu2_jar_fn in pu_jar_fns : gp_add_jar (bu2_jar_fn)
__gap_add_default_jars ()

GC_LOG_PN = gf_ap ( JPackage ('net') .harawata.appdirs.AppDirsFactory .getInstance () .getUserLogDir ( GC_APP_NM, GC_PYJA_V2, GC_PYJA_NM ) )
gp_mp (GC_LOG_PN)
GC_LOG_FN = gf_pj ( GC_LOG_PN, 'log.txt' )
def __gaf_root_logger ( x_level, x_handler, x_format, x_datefmt = '%y%m%d-%H%M%S' ) :
  fu_root = logging.root
  fu_root.handlers = []
  fu_root.setLevel (x_level)
  if x_handler is not None :
    x_handler.setFormatter ( logging.Formatter ( x_format, datefmt = x_datefmt ) )
    fu_root.addHandler (x_handler)
  return fu_root
GC_LOG = __gaf_root_logger ( logging.DEBUG, logging.FileHandler ( GC_LOG_FN, 'w' ), '[%(process)06d,%(levelname)-.1s,%(asctime)s] %(message)s' )
def gp_set_log_level_to_info () : GC_LOG .setLevel (logging.INFO)
def gp_set_log_level_to_debug () : GC_LOG .setLevel (logging.DEBUG)

def gp_log_error (x_str) : GC_LOG .error (x_str)
def gp_log_info (x_str) : GC_LOG .info (x_str)
def gp_log_warning (x_str) : GC_LOG .warning (x_str)
def gp_log_debug (x_str) : GC_LOG .debug (x_str)

GC_LICENSE = 'GNU AGPL v3'

class DBegin :
  @classmethod
  def dp_it (cls) :
    cls.__dap_begin ()
  @classmethod
  def __dap_begin (cls) :
    gp_log_stream_write_line ( GC_LOG, "\n".join ( cls .__daf_banner () ) )
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
      'released under the {}, see <http://www.gnu.org/licenses/>.' .format (GC_LICENSE),
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

DBegin .dp_it ()

#
# Your Script
#

GC_LOG .info ( f"Entering { gf_to_mps (__file__) } ..." )

for bu2_jar_fn in [
  gf_pj ( GC_PYJA_HM, 'Library', 'ICU4J', '60.2', 'icu4j-60_2.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'ICU4J', '60.2', 'icu4j-charset-60_2.jar' ),
  gf_pj ( GC_PYJA_HM, 'Library', 'ICU4J', '60.2', 'icu4j-localespi-60_2.jar' ),
] : gp_add_jar (bu2_jar_fn)

CRuleBasedNumberFormat = JPackage ('com').ibm.icu.text.RuleBasedNumberFormat

class DSpellout :
  __dau_rbnf = CRuleBasedNumberFormat (CRuleBasedNumberFormat.SPELLOUT)
  @classmethod
  def df_it ( cls, x_no ) :
    return cls.__dau_rbnf .format (x_no)
