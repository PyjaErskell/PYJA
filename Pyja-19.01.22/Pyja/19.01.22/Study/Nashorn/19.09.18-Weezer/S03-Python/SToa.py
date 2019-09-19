import sys
sys.dont_write_bytecode = True
import os
import jep
import platform
import psutil
import tkinter
from PyQt5 import QtCore
def jf_cls (x_cls_nm) : return jep .findClass (x_cls_nm)
GC_FOSA = os.sep     # (fo)lder (s)ep(a)rator
GC_PASA = os.pathsep # (pa)th (s)ep(a)rator
CjSystem = jf_cls ('java.lang.System')
CjPlatform = jf_cls ('com.sun.jna.Platform')
sys.argv = [ 'Dummy script file name' ]
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
print ( 'Python version => {}' .format ( platform .python_version () ) )
print ( 'PyQt version => {}' .format ( QtCore .qVersion () ) )
print ( 'Tcl version => {}' .format ( GC_TCL.call ('gf_tcl_ver') ) )
print ( 'Folder separator => {}' .format (GC_FOSA) )
print ( 'Path separator => {}' .format (GC_PASA) )
print ( 'Is Windows ? => {}' .format ( CjPlatform .isWindows () ) )
print ( 'Total memory => {:,d} bytes' .format ( psutil .virtual_memory () .total ) )
