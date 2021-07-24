# +-----------------------------------------------------------------------+
# :                                 Pyja                                  :
# :                    https://github.com/PyjaErskell                     :
# :               made by Erskell (pyja.erskell@gmail.com)                :
# :  released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.  :
# +-----------------------------------------------------------------------+

import sys

GC_MAIN = sys.modules ['__main__']

import os
import jep

def gf_jcls (x_it) : return jep .findClass (x_it)

GC_FOSA = os.sep     # (fo)lder (s)ep(a)rator
GC_PASA = os.pathsep # (pa)th (s)ep(a)rator

def gf_pj ( * x_args ) : return GC_FOSA .join (x_args) # (p)ath (j)oin
gf_xi = os.path .exists # e(xi)sts
gf_np = os.path .normpath # (n)orm(p)ath
gf_bn = os.path .basename # (b)ase(n)ame

def gp_set_os_env ( x_key, x_val ) :
  os.environ [x_key] = x_val

gp_set_os_env ( 'QT_PLUGIN_PATH', GC_MAIN .SC_QT_PLUGIN_PATH )
gp_set_os_env ( 'QT_AUTO_SCREEN_SCALE_FACTOR', '1' )

import platform
from PyQt5 import QtCore
from PyQt5.QtCore import QStandardPaths

GC_PYTHON_VR = platform .python_version ()
GC_PYQT_VR = QtCore .qVersion ()
GC_DESKTOP_PN = gf_np ( QStandardPaths .writableLocation (QStandardPaths.DesktopLocation) )

import tkinter

GC_TONO_HM = GC_MAIN .SC_TONO_HM
GC_TONO_NM = gf_bn (GC_TONO_HM)

sys.argv = [GC_TONO_NM]

GC_TCL = tkinter.Tcl ()
GC_TCL .eval ( """
  proc gf_il {x_it} { # (i)s (l)ink
    return [ expr { [file type $x_it] eq "link" } ]
  }
  proc gp_ml { x_link x_target } { # (m)ake (l)ink
    file link -symbolic $x_link $x_target
  }
  proc gp_cp { x_src x_dst { x_force 0 } } { # (c)o(p)y
    if {$x_force} {
      file copy -force $x_src $x_dst
    } else {
      file copy $x_src $x_dst
    }
  }
""")
def gf_il (x_it) :
  return GC_TCL .call ( 'gf_il', x_it ) == 1
def gp_ml ( x_src, x_link ) :
  return GC_TCL .call ( 'gp_ml', x_link, x_src )
def gp_cp ( x_src, x_dst, x_force = False ) :
  return GC_TCL .call ( 'gp_cp', x_src, x_dst, x_force )

def gf_do (x_xml_params_fn) :
  GC_MAIN .sf_do (x_xml_params_fn)
