import sys
sys.dont_write_bytecode = True

GC_PYJA_RT_SYM = '@`'
GC_PYJA_HM_SYM = '@~'
GC_MILO_PN_SYM = '@!'

GC_EC_SUCCESS  = 0
GC_EC_ERROR    = 1

from PyQt5.QtCore import pyqtSignal
from PyQt5.QtCore import QCoreApplication
from PyQt5.QtCore import QObject
from PyQt5.QtCore import Qt
from PyQt5.QtCore import QThread
from PyQt5.QtWidgets import QApplication

GC_QAPP = QApplication ([])
GC_QAPP .setStyle ('fusion')

import jep
import os
import platform
import psutil

GC_FOSA = os.sep     # (fo)lder (s)ep(a)rator
GC_PASA = os.pathsep # (pa)th (s)ep(a)rator

GC_TOTAL_CPU = psutil .cpu_count ()
GC_TOTAL_MEMORY = psutil .virtual_memory () .total
GC_HOST_NM = platform .node ()
GC_THIS_PID = os .getpid ()

from collections import namedtuple
import ctypes
import inspect
import shutil
import time
import tkinter
import traceback
import types

def gf_os_env (x_key) : return os.environ [x_key] # (g)lobal (f)unction
def gf_str_is_valid_date ( x_str, x_format ) :
  try : time .strptime ( x_str, x_format )
  except ValueError : return False
  else : return True
def gf_rm_px ( x_str, x_px ) : # px : prefix
  return x_str [ len (x_px) : ] if x_str .startswith (x_px) else x_str

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

GC_APP_NM = gf_jn (GC_SCRIPT_FN)
GC_CMD = psutil.Process () .cmdline ()
def __gaf_argv () :
  fv_idx4ostart = 0
  for bu2_idx, bu2_it in enumerate (GC_CMD) : # bu2 -> (b)lock val(u)e nested level 2
    if gf_xn (bu2_it) .lower () in [ 'js', 'py', 'rb' ] :
      fv_idx4ostart = bu2_idx
      break
  fu_argv = GC_CMD [fv_idx4ostart+1:] if ( fv_idx4ostart + 1 ) < len(GC_CMD) else []
  return fu_argv
GC_ARGV = __gaf_argv ()
sys.argv = [GC_SCRIPT_FN] + GC_ARGV

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

GC_GR .eval ('''
  def gf_jcls (x_cls_nm) { return Class.forName (x_cls_nm) }
  final __gau_lock_4_gap_cy = new Object [0]
  Object.metaClass.__gap_cy = { final Object... x_args -> // cy -> (c)all p(y)thon
    synchronized (__gau_lock_4_gap_cy) { __gau_jep .invoke (*x_args) }
  }
''')
def gf_jarray (x_py_list) :
  fu_arr_sz = len (x_py_list)
  fu_params = GC_GR .eval ( f'new Object [{fu_arr_sz}]' )
  for bu2_idx, bu2_it in enumerate ( x_py_list ) : fu_params [bu2_idx] = x_py_list [bu2_idx]
  return fu_params
def gp_gr_call ( x_fun_nm, *x_args ) : GC_GR. invokeFunction ( x_fun_nm, gf_jarray (x_args) )
def gf_gr_call ( x_fun_nm, *x_args ) : return GC_GR. invokeFunction ( x_fun_nm, gf_jarray (x_args) )
def gf_jcls (x_cls_nm) : return gf_gr_call ( 'gf_jcls', x_cls_nm )

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
    x_target_atr .tell ( x_letter, nu_sender_atr )
def gf_mk_atr ( x_at_cls_nm, x_at_args, x_at_nm, x_arf = GC_AS ) :
  fu_at_cls = eval (x_at_cls_nm)
  fu_at_nm = x_at_cls_nm if x_at_nm == ':c' else ':a' if x_at_nm == None else x_at_nm
  fu_at = fu_at_cls (*x_at_args)
  return gf_gr_call ( 'gf_mk_atr', gf_yi (fu_at), fu_at_nm, x_arf )

GC_GR .eval ('''
  def gf_mk_rb_sym ( final String x_nm ) { return org.jruby.RubySymbol .newSymbol ( __gau_jr, x_nm ) }
''')
def gf_mk_rb_sym (x_nm) : return gf_gr_call ( 'gf_mk_rb_sym', x_nm )

CgRubySymbol = gf_jcls ('org.jruby.RubySymbol')

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

class WAtQtMain (CgAt) :
  def __init__ (self) :
    super () .__init__ ()
    self .wn_init ()
  def wn_init (self) :
    self.wu_atr_fx_main = ...
    self.wu_wgt = QMainWindow ()
    self.wu_wgt .setWindowTitle (f'{GC_APP_NM} - PyQt')
    self.wu_cw = QWidget ()
    self.wu_lo = QVBoxLayout ()
    self.wu_pb = QPushButton ()
    self.wu_pb .setSizePolicy ( QSizePolicy.Expanding, QSizePolicy.Fixed )
    self.wu_pb .pressed .connect (self.won_change_font)
    self.wu_lb = QLabel ()
    self.wu_lb .setAlignment (Qt.AlignCenter)
    for bu2_qo in [ QWidget (), self.wu_pb, self.wu_lb ] : self.wu_lo .addWidget (bu2_qo)
    self.wu_cw .setLayout (self.wu_lo)
    self.wu_fnt_families = QFontDatabase () .families ()
    GC_LOG .info ( f'{self.__class__.__name__} : Total fonts => {len(self.wu_fnt_families)}' )
    self.wv_fnt_idx = len(self.wu_fnt_families) - 1
    self.wv_msg = ''
    self .wn_change_font (False)
    self.wu_wgt .setCentralWidget (self.wu_cw)
    self.wu_wgt .resize ( 650, 250 )
    self.wu_wgt .show ()
    self.wu_wgt .raise_ ()
    self .wn_move_center ()
  def receive ( self, x_letter, x_sender_atr ) :
    if ( x_letter.getClass () == CgRubySymbol ) :
      bu2_nm = x_letter .asJavaString ()
      if ( bu2_nm == 'LNextFont' ) :
        if self.wu_atr_fx_main == ... : self.wu_atr_fx_main = x_sender_atr
        gp_qr ( self.wn_change_font, False )
      elif ( bu2_nm == 'LQuit' ) : gp_qr ( GC_QAPP .quit )
  def wn_move_center (self) :
    nu_cp = QDesktopWidget () .availableGeometry () .center () # center point
    self.wu_wgt .move ( nu_cp.x() - self.wu_wgt.width()/2 , nu_cp.y() )
  def won_change_font (self) : self .wn_change_font ()
  def wn_change_font ( self, x_tell = True ) :
    if self.wv_fnt_idx >= len(self.wu_fnt_families) : self.wv_fnt_idx = 0
    nu_fnt_nm = self.wu_fnt_families [self.wv_fnt_idx]
    if self.wv_msg != '' : GC_LOG .info ( f'PyQt -> {self.wv_msg}' )
    nu_nt = f'({self.wv_fnt_idx+1}/{len(self.wu_fnt_families)})'
    self.wv_msg = f'0^0 {nu_nt} ({nu_fnt_nm})'
    self.wu_pb .setText ( f"Say '{self.wv_msg}'" )
    self.wu_pb .setFont ( QFont ( nu_fnt_nm, 17 ) )
    self.wu_lb .setText ( f'{nu_nt} Font name : {nu_fnt_nm}' )
    self .wn_move_center ()
    self.wv_fnt_idx += 1

    if x_tell and self.wu_atr_fx_main is not ... : self .tell ( self.wu_atr_fx_main, gf_mk_rb_sym ('LNextFont') )
