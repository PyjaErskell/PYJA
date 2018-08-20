#
# Python (Global)
#

import sys

sys.dont_write_bytecode = True

from collections import namedtuple
from datetime import datetime
import ctypes
import getpass
import inspect
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

GC_QAPP = QApplication ([])

GC_FOSA = os.sep     # (fo)lder (s)ep(a)rator
GC_PASA = os.pathsep # (pa)th (s)ep(a)rator
GC_THIS_PID = os .getpid ()

def gf_frange ( x_start, x_end, x_step = 1.0, x_include_end = False ) :
  fv_it = x_start
  while ( fv_it < x_end if not x_include_end else fv_it <= x_end ) :
    yield fv_it
    fv_it += x_step
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

GC_THIS_CMD = psutil.Process () .cmdline ()
def __gaf_asa () : # __gaf -> (__)private (g)lobal priv(a)te (f)unction
  fu_app_nm = ...
  fu_script_fn = ...
  fv_idx4script = 0 # (f)unction (v)ariable
  for bu2_idx, bu2_it in enumerate (GC_THIS_CMD) : # bu2 -> (b)lock val(u)e nested level 2
    if gf_xn (bu2_it) .lower () in ['rb'] :
      fv_idx4script = bu2_idx
      fu_script_fn = gf_fn (bu2_it)
      fu_app_nm = gf_jn (fu_script_fn)
      break
  fu_argv = GC_THIS_CMD [fv_idx4script+1:] if ( fv_idx4script + 1 ) < len(GC_THIS_CMD) else []
  return fu_app_nm, fu_script_fn, fu_argv
GC_APP_NM, GC_SCRIPT_FN, GC_ARGV = __gaf_asa ()
GC_SCRIPT_PN = gf_pn (GC_SCRIPT_FN)
sys.argv = [ GC_SCRIPT_FN ] + GC_ARGV

gf_xi = os.path.exists # e(xi)sts
gf_id = os.path.isdir # (i)s (d)irectory
gf_if = os.path.isfile # (i)s (f)ile
gp_cp = shutil.copy # (c)o(p)y
gp_ul = os.unlink # (u)n(l)ink
gp_rf = os.remove # (r)emove (f)ile
gp_rd = os.rmdir # (r)emove (d)irectory

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
def gp_rt (x_pn) : # gp -> (g)lobal (p)rocedure, rt -> (r)emove (t)ree
  if gf_il (x_pn) : gp_ul (x_pn)
  elif gf_id (x_pn) : shutil.rmtree (x_pn)
def gp_ml ( x_src, x_link ) : # (m)ake (l)ink
  return GC_TCL.call ( 'gp_ml', x_link, x_src )

def gf_exception_to_list () :
  fv_fe = traceback.format_exception ( * sys.exc_info () )
  del fv_fe [0]
  fv_fe.reverse ()
  fv_fe = map ( ( lambda bx2 : bx2.rstrip () ), fv_fe )
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

GC_PYTHON_VR = platform .python_version ()
GC_PYQT_VR = QtCore .qVersion ()
GC_TOTAL_CPU = psutil .cpu_count ()
GC_TOTAL_MEMORY = psutil .virtual_memory () .total
GC_HOST_NM = platform .node ()
GC_CUSR = getpass .getuser ()
GC_THIS_EXE_FN = gf_fn (sys.executable)
GC_DESKTOP_PN = QStandardPaths .writableLocation (QStandardPaths.DesktopLocation)

def gf_process (x_pid) : return psutil.Process (x_pid)
def gf_available_memory () : return psutil .virtual_memory () .available

class __DgLongLiveObjects :
  __dau_it = {}
  @classmethod
  def df_cllo ( cls, x_it, *x_args ) : # cllo -> (c)reate (l)ong (l)ive (o)bject
    fu_yo = ... # yo -> p(y)thon (o)bject
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
def gf_ym ( x_yi, x_method_nm, *x_args ) : # from p(y)thon id, call (m)ethod
  pu_yo = gf_yo (x_yi)
  if hasattr ( pu_yo, x_method_nm ) : return getattr ( pu_yo, x_method_nm ) (*x_args)

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

class CgQo (QObject) :
  def __init__ (self) :
    super () .__init__ ()
    self.cu_yi = gf_yi (self)

#
# Java (Global)
#

def jy_ge (x_str) : return JC_GR .eval (x_str)

jy_ge ('''
  gf_jcls = { final String x_cls_nm -> return Class.forName (x_cls_nm) }
  gf_is_instance = { final x_cls, final x_oj -> x_cls .isInstance (x_oj) }
  gp_sr = { final Closure xp_it -> // (S)wing (r)un
    javax.swing.SwingUtilities .invokeLater { xp_it () }
  } 
  gp_xr = { final Closure xp_it -> // JavaF(x) (r)un
    javafx.application.Platform .runLater { xp_it () }
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
def jp_add_jar (x_jar_fn) : jy_gf ( 'gp_add_jar', x_jar_fn )

CjActorRef              = jf_jcls ('akka.actor.ActorRef')
CjAwait                 = jf_jcls ('scala.concurrent.Await')
CjBigInteger            = jf_jcls ('java.math.BigInteger')
CjByteArrayInputStream  = jf_jcls ('java.io.ByteArrayInputStream')
CjByteArrayOutputStream = jf_jcls ('java.io.ByteArrayOutputStream')
CjCalendar              = jf_jcls ('java.util.Calendar')
CjDuration              = jf_jcls ('scala.concurrent.duration.Duration')
CjMath                  = jf_jcls ('java.lang.Math')
CjPatterns              = jf_jcls ('akka.pattern.Patterns')
CjString                = jf_jcls ('java.lang.String')
CjSystem                = jf_jcls ('java.lang.System')
CjTimeout               = jf_jcls ('akka.util.Timeout')

def jf_elapsed (x_st) : # get elpased from given start time of java.util.Date
  fu_cd = CjCalendar .getInstance ()
  fu_cd .setTime (x_st)
  fu_st = datetime ( fu_cd .get (CjCalendar.YEAR), fu_cd .get (CjCalendar.MONTH) + 1, fu_cd .get (CjCalendar.DAY_OF_MONTH), fu_cd .get (CjCalendar.HOUR_OF_DAY), fu_cd .get (CjCalendar.MINUTE), fu_cd .get (CjCalendar.SECOND) )
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

def jy_be (x_str) : return JC_JR .eval (x_str) # be -> JRu(b)y (e)val
def jy_bf ( x_nm, *x_args ) : return JC_JR. invokeFunction ( x_nm, jf_script_params (x_args) )
def jy_bm ( x_oj, x_nm, *x_args ) : return JC_JR. invokeMethod ( x_oj, x_nm, jf_script_params (x_args) )

jy_bf ( 'gp_set_const', 'GC_PYTHON_VR', GC_PYTHON_VR )
jy_bf ( 'gp_set_const', 'GC_TCL_VR', GC_TCL_VR )
jy_bf ( 'gp_set_const', 'GC_PYQT_VR', GC_PYQT_VR )
jy_bf ( 'gp_set_const', 'GC_TOTAL_CPU', GC_TOTAL_CPU )
jy_bf ( 'gp_set_const', 'GC_TOTAL_MEMORY', GC_TOTAL_MEMORY )
jy_bf ( 'gp_set_const', 'GC_HOST_NM', GC_HOST_NM )
jy_bf ( 'gp_set_const', 'GC_CUSR', GC_CUSR )
jy_bf ( 'gp_set_const', 'GC_THIS_EXE_FN', GC_THIS_EXE_FN )
jy_bf ( 'gp_set_const', 'GC_THIS_CMD', GC_THIS_CMD )
jy_bf ( 'gp_set_const', 'GC_ARGV', GC_ARGV )
jy_bf ( 'gp_set_const', 'GC_DESKTOP_PN', GC_DESKTOP_PN )

JC_AS = jy_ge ('GC_AS')
JC_LOG = JC_AS .log ()
def jp_set_log_level_to_info () :  jy_gf ( 'gp_set_log_level_to_info' )
def jp_set_log_level_to_debug () : jy_gf ( 'gp_set_log_level_to_debug' )

def jp_request_exit ( x_ec, x_ex_list = None ) : jy_bf ( 'gp_request_exit', x_ec, x_ex_list )

jy_ge ('''
  class CgAt4Py extends akka.actor.AbstractActor { // (A)c(t)or for Python
    final private long __cau_yi_at
    CgAt4Py ( final long x_yi_at ) {
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
  gf_mk_atr_4_py = { final long x_yi_at, final String x_at_nm, final akka.actor.ActorRefFactory x_arf -> // atr -> (a)c(t)or (r)eference
    switch (x_at_nm) {
      case ':a' : return x_arf .actorOf ( akka.actor.Props .create ( CgAt4Py, x_yi_at ) )
      default : return x_arf .actorOf ( akka.actor.Props .create ( CgAt4Py, x_yi_at ), x_at_nm )
    }
  }
''')
class CjAt (QObject) :
  def __init__ (self) :
    super () .__init__ ()
    self.cu_yi = gf_cllo (self)
  def cn_create ( self, x_at_org ) :
    try :
      self.cu_at_org = x_at_org
      if hasattr ( self, 'create' ) : getattr ( self, 'create' ) ()
    except : jp_request_exit ( GC_EC_ERROR, gf_exception_to_list () )
  def cn_pre_start (self) :
    try :
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
def jf_mk_atr ( x_at, x_at_nm, x_arf = None ) :
  global JC_AS
  fu_arf = JC_AS if x_arf is None else x_arf
  fu_at_nm = x_at.__class__.__name__ if x_at_nm == ':c' else ':a' if x_at_nm == None else x_at_nm
  return jy_gf ( 'gf_mk_atr_4_py', gf_yi (x_at), fu_at_nm, fu_arf )

class TjUtil :
  def tn_fx_set_eh ( self, x_xo, x_xo_eh_nm, x_yo_nethod_nm ) : # xo -> F(x) (o)bject, eh -> fx (e)vent (h)andler
    jy_gc ( f"""{{ x_xo ->
      x_xo.{x_xo_eh_nm} = {{ x2_ev -> gp_yn {self.cu_yi}, '{x_yo_nethod_nm}', x2_ev }}
    }}""", x_xo  )
  def tn_fx_add_cl ( self, x_property, x_yo_nethod_nm ) : # cl -> (c)hange (l)istener
    jy_gc ( f"""{{ x_property ->
      x_property .addListener ( {{ x2_obs, x2_old, x2_new -> gp_yn {self.cu_yi}, '{x_yo_nethod_nm}', x2_obs, x2_old, x2_new }} as javafx.beans.value.ChangeListener )
    }}""", x_property  )
  def tn_ak_fut_oc ( self, x_future, x_yo_nethod_nm ) : # ak -> (ak)ka, fut -> (fut)ure, oc -> (o)n(C)omplete
    jy_gc ( f"""{{ x_future, x_dispatcher ->
      x_future .onComplete ( {{ x2_throwable, x2_result -> gp_xr {{ gp_yn {self.cu_yi}, '{x_yo_nethod_nm}', x2_throwable, x2_result }} }} as akka.dispatch.OnComplete, x_dispatcher )
    }}""", x_future, self .getContext () .dispatcher ()  )

#
# Main Skeleton
#

class DRun :
  @classmethod
  def dp_it (cls) :
    try :
      jy_bf ( 'gp_begin' )
      DBody .dp_it ()
    except :
      jp_request_exit ( GC_EC_ERROR, gf_exception_to_list () )

#
# Your Source
#

Insets = jf_jcls ('javafx.geometry.Insets')
Label  = jf_jcls ('javafx.scene.control.Label')
Pos    = jf_jcls ('javafx.geometry.Pos')
Scene  = jf_jcls ('javafx.scene.Scene')
Slider = jf_jcls ('javafx.scene.control.Slider')
VBox   = jf_jcls ('javafx.scene.layout.VBox')

class WAtMain ( CjAt, TjUtil, TgWai ) :
  def __init__ ( self, x_atr_fibo ) :
    super () .__init__ ()
    self.wu_atr_fibo = x_atr_fibo
  def create (self) : self .wn_init ()
  def wn_init (self) :
    JC_LOG .info ( self.tm_wai ('Initializing ...') )
    # self.wu_atr_fibo = jf_mk_atr ( CAtFibonacci (), ':c' )
    self.wu_timeout = CjTimeout ( CjDuration .create ( 2, 'seconds' ) )
    self.wu_lb_no = Label ()
    nu_initial_no = 21
    self .wn_show_no (nu_initial_no)
    def nf2_sldr_4_no (it) :
      it .setMin (0)
      it .setMax (360)
      it .setValue (nu_initial_no)
      it .setShowTickLabels (True)
      it .setShowTickMarks (True)
      it .setBlockIncrement (10)
      self .tn_fx_add_cl ( it .valueProperty (), 'wn_cl_sldr_4_no_val' )
      return it
    self.wu_sldr_4_no = nf2_sldr_4_no ( Slider () )
    self.wu_lb_fibo = Label ( 'Fibonacci :' )
    self.wu_lb_fibo_result = Label ()
    def nf2_root (it) :
      it .setAlignment (Pos.CENTER)
      it .setPadding ( Insets (20) )
      it .setSpacing (10)
      it .getChildren () .addAll ( [ self.wu_lb_no, self.wu_sldr_4_no, self.wu_lb_fibo, self.wu_lb_fibo_result ] )
      return it
    self.wu_root = nf2_root ( VBox () )
    def nf2_stage (it) :
      it .setTitle (GC_APP_NM)
      it .setWidth (750)
      it .setHeight (190)
      it .setScene ( Scene (self.wu_root) )
      self .tn_fx_set_eh ( it, 'onShown', 'wn_on_shown' )
      self .tn_fx_set_eh ( it, 'onCloseRequest', 'wn_on_quit' )
      it .centerOnScreen ()
      it .show ()
      it .toFront ()
      return it
    self.wu_stage = nf2_stage (JC_FX_STAGE)
  def wn_show_no ( self, x_no ) : self.wu_lb_no .setText ( f'Number => {x_no}' )
  def wn_show_fibo (self) :
    nu_future = CjPatterns .ask ( self.wu_atr_fibo, int ( self.wu_sldr_4_no .getValue () ), self.wu_timeout )
    nu_result = CjAwait.result ( nu_future, self.wu_timeout .duration () )
    nu_fibo = int ( nu_result .toString () )
    self.wu_lb_fibo_result .setText ( f'{nu_fibo:,d}' )
  def wn_cl_sldr_4_no_val ( self, x_obs, x_old, x_new ) :
    self .wn_show_no ( int ( self.wu_sldr_4_no .getValue () ) )
    self .wn_show_fibo ()
  def wn_on_shown ( self, x_ev ) :
    JC_LOG .info ( self.tm_wai ( 'Stage shown ...' ) )
    self .wn_show_fibo ()
  def wn_on_quit ( self, x_ev ) :
    JC_LOG .info ( self.tm_wai ( 'About to quit ...' ) )
    jp_request_exit (GC_EC_SUCCESS)

class DBody :
  @classmethod
  def dp_it (cls) :
    GC_QAPP .setStyle ('fusion')
    pu_atr_fibo = jy_bf ( 'gf_mk_atr', jy_be ('CAtFibonacci'), [], ':c' )
    pu_atr = jf_mk_atr ( WAtMain (pu_atr_fibo), ':c' )

class OStart :
  @classmethod
  def main (cls) :
    jp_set_log_level_to_info ()
    DRun .dp_it ()

if __name__ == '__main__' :
  OStart .main ()
