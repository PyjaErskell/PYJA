#
# Python (Global)
#

import sys

sys.dont_write_bytecode = True

import os
import getpass
import platform
import psutil

from datetime import datetime

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
sys.argv = [ GC_SCRIPT_FN ] + GC_ARGV

def gf_python_ver () : return platform .python_version ()
def gf_pyqt_ver () : return QtCore .qVersion ()
def gf_cpu_count () : return psutil .cpu_count ()
def gf_total_memory () : return psutil .virtual_memory () .total
def gf_available_memory () : return psutil .virtual_memory () .available
def gf_host_name () : return platform .node ()
def gf_current_user () : return getpass .getuser ()
def gf_this_pid () : return os .getpid ()
def gf_this_exe_file_name () : return gf_fn (sys.executable)
def gf_this_cmd () : return GC_THIS_CMD
def gf_app_name () : return GC_APP_NM
def gf_script_file_name () : return GC_SCRIPT_FN
def gf_argv () : return GC_ARGV

def gf_desktop_pn () : return QStandardPaths .writableLocation (QStandardPaths.DesktopLocation)

#
# Java (Global)
#

import jep

def jf_jcls (x_cls_nm) : return jep.findClass (x_cls_nm)

CjByteArrayInputStream  = jf_jcls ('java.io.ByteArrayInputStream')
CjByteArrayOutputStream = jf_jcls ('java.io.ByteArrayOutputStream')
CjCalendar = jf_jcls ('java.util.Calendar')

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
