# encoding: utf-8

#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

import sys

sys.dont_write_bytecode = True

import jep

GC_OR = jep .findClass ('ORun')
GC_PS = GC_OR.ol_ps
GC_GR = GC_OR.ol_gr

import platform
import traceback

GC_PYTHON_VR = platform .python_version ()

def gf_joa_to_yoa (x_joa) : return [ bx2_it for bx2_it in x_joa ] # (j)ava (o)bject (a)rray (to) p(y)thon (o)bject (a)rray
def gf_yoa_to_joa (x_yoa) :
  fu_joa = GC_OR .om_new_joa ( len (x_yoa) )
  for bu2_idx, bu2_it in enumerate (x_yoa) : fu_joa [bu2_idx] = x_yoa [bu2_idx]
  return fu_joa

def gf_gg (x_it) : return GC_GR .get (x_it)
def gy_ge (x_str) : return GC_GR .eval (x_str)
def gy_gf ( x_fn_nm, * x_args ) : return GC_GR. invokeFunction ( x_fn_nm, gf_yoa_to_joa (x_args) )

def gf_sf ( x_format, * x_args ) : return gy_gf ( 'gf_sf', x_format, * x_args ) # java (s)tring (f)ormat
def gf_to_ths (x_it) : return gy_gf ( 'gf_to_ths', x_it )
def gp_request_exit ( x_ec, x_ex_list = [] ) : gy_gf ( 'gp_request_exit', x_ec, x_ex_list )

GC_EC_NONE = gf_gg ('GC_EC_NONE')
GC_EC_SHUTDOWN = gf_gg ('GC_EC_SHUTDOWN')
GC_EC_SUCCESS = gf_gg ('GC_EC_SUCCESS')
GC_EC_ERROR = gf_gg ('GC_EC_ERROR')

GC_TONO_NM = gf_gg ('GC_TONO_NM')
GC_TONO_HM = gf_gg ('GC_TONO_HM')
GC_TONO_HM_SYM = gf_gg ('GC_TONO_HM_SYM')
GC_TONO_OS_ENV_PATHS = gf_joa_to_yoa ( gf_gg ('GC_TONO_OS_ENV_PATHS') )
GC_TONO_ARGV = gf_joa_to_yoa (GC_OR.ol_args)
GC_TONO_SCRIPT_FN = GC_OR.ou_py_fn

__file__ = GC_TONO_SCRIPT_FN
sys.argv = [__file__] + GC_TONO_ARGV

def gf_wai ( x_msg = None ) :
  fu_frame = sys ._getframe () .f_back
  fu_fn = gf_to_ths (fu_frame.f_code.co_filename)
  fu_func_nm = fu_frame.f_code.co_name
  fu_ln_no = fu_frame.f_lineno
  fu_msg = '{}::{} [{:03}]' .format ( fu_fn, fu_func_nm, fu_ln_no )
  if x_msg is None : return fu_msg
  return '{0} {1}' .format ( fu_msg, x_msg )

class TgWai : # (T)rait (g)lobal 
  @staticmethod
  def __tasm_wai ( x_name, x_msg = None ) : # tasm -> (t)rait priv(a)te (s)tatic (m)ethod
    mu_frame = sys ._getframe () .f_back.f_back # mu -> (m)ethod val(u)e
    mu_fn = gf_to_ths (mu_frame.f_code.co_filename)
    mu_func_nm = mu_frame.f_code.co_name
    mu_ln_no = mu_frame.f_lineno
    mu_msg = '{}::{}.{} [{:03}]' .format ( mu_fn, x_name, mu_func_nm, mu_ln_no )
    if x_msg is None : return mu_msg
    return '{0} {1}' .format ( mu_msg, x_msg )
  @classmethod
  def tcm_wai ( cls, x_msg = None ) : return cls .__tasm_wai ( cls.__name__, x_msg ) # tcm -> (t)rait (c)lass (m)ethod
  def tm_wai ( self, x_msg = None ) : return self.__class__ .__tasm_wai ( self.__class__.__name__, x_msg ) # tm -> (t)rait public instance (m)ethod

def gf_exception_to_list () :
  fv_fe = traceback .format_exception ( * sys .exc_info () )
  del fv_fe [0]
  fv_fe .reverse ()
  fu_it = []
  for bu2_it in fv_fe :
    for bu3_it in bu2_it .rstrip () .splitlines () :
      fu_it .append ( bu3_it .replace ( GC_TONO_HM, GC_TONO_HM_SYM ) )
  return list (fu_it)

def gp_te ( x_callable, * x_args ) : # (t)ry (e)xcept
  try : x_callable ( * x_args )
  except : gp_request_exit ( GC_EC_ERROR, gf_exception_to_list () )

GC_LOG = gf_gg ('GC_LOG')

def gp_log_array ( xp_out, x_title, x_array ) :
  if x_title is not None : xp_out ( '{} :' .format (x_title) )
  for bu2_idx, bu2_it in enumerate ( x_array, start = 1 ) : xp_out ( '  {:2d} => {}' .format ( bu2_idx, bu2_it ) )
def gp_log_dict ( xp_out, x_title, x_dict ) :
  if x_title is not None : xp_out ( '{} :' .format (x_title) )
  for bu2_idx, bu2_it in enumerate ( sorted ( list ( x_dict .keys () ) ), start = 1 ) : xp_out ( '  {:2d} : {} => {}' .format ( bu2_idx, bu2_it, x_dict [bu2_it] ) )
def gp_log_header ( xp_out, x_header, x_line_width ) :
  xp_out ( '+' + '-' * x_line_width )
  xp_out ( ': {}' .format (x_header) )
  xp_out ( '+' + '-' * x_line_width )

#---------------------------------------------------------------
# Main Skeleton
#---------------------------------------------------------------

class DRun :
  @classmethod
  def __dap_begin (cls) :
    GC_LOG .info ( 'Python version => {}' .format (GC_PYTHON_VR) )
    GC_LOG .info ( 'Script file => {}' .format ( gf_to_ths (GC_TONO_SCRIPT_FN) ) )
    gp_log_array ( GC_LOG.debug, 'Paths', GC_TONO_OS_ENV_PATHS )
    if len (GC_TONO_ARGV) > 0 : gp_log_array ( GC_LOG.info, 'Arguments', GC_TONO_ARGV )
  @classmethod
  def dp_it (cls) :
    cls.__dap_begin ()
    DBody .dp_it ()

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

# following link is referred
# https://gist.github.com/kaloprominat/6105220

from AppKit import NSApp
from AppKit import NSApplication
from AppKit import NSApplicationActivateIgnoringOtherApps
from AppKit import NSObject
from AppKit import NSRunningApplication
from AppKit import NSWindow
from PyObjCTools import AppHelper

# Cocoa prefers composition to inheritance. The members of an object's
# delegate will be called upon the happening of certain events. Once we define
# methods with particular names, they will be called automatically
class WDelegate ( NSObject, TgWai ) :
  def windowWillClose_ ( self, x_notification ) :
    '''Called automatically when the window is closed'''
    gp_te ( self.wn_will_close, x_notification )
  def wn_will_close ( self, x_notification ) :
    # Terminate the application
    GC_LOG .info ( self .tm_wai ( 'About to quit ...' ) )
    gp_request_exit (GC_EC_SUCCESS)

class DBody :
  @classmethod
  def dp_it (cls) :
    # Create a new application instance ...
    pu_app = NSApplication .sharedApplication ()

    # ... and create its delgate.  Note the use of the
    # Objective C constructors below, because Delegate
    # is a subcalss of an Objective C class, NSObject
    pu_delegate = WDelegate .alloc () .init ()
    # Tell the application which delegate object to use.
    pu_app .setDelegate_ (pu_delegate)

    # Now we can can start to create the window ...
    pu_frame = ( ( 0, 0 ), ( 250.0, 100.0 ) )
    # (Don't worry about these parameters for the moment. They just specify
    # the type of window, its size and position etc)
    pu_window = NSWindow .alloc () .initWithContentRect_styleMask_backing_defer_ ( pu_frame, 15, 2, 0 )
    # ... tell it which delegate object to use (here it happens
    # to be the same delegate as the application is using)...
    pu_window .setDelegate_ (pu_delegate)
    # ... and set some properties. Unicode strings are preferred.
    pu_window .setTitle_ (GC_TONO_NM)
    # All set. Now we can show the window ...
    pu_window .center ()
    pu_window .orderFrontRegardless ()

    # ... and start the application
    AppHelper .runEventLoop ()

def sp_main () :
  gp_te ( DRun.dp_it )

if __name__ == '__main__':
  sp_main ()
