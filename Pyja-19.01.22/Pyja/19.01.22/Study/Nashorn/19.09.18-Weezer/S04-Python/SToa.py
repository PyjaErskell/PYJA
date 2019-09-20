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
def sp_test () :
  print ( '+--------------------------------------------------------------------' )
  print ( ': Python' )
  print ( '+--------------------------------------------------------------------' )
  print ( '[PY] Python version => {}' .format ( platform .python_version () ) )
  print ( '[PY] PyQt version => {}' .format ( QtCore .qVersion () ) )
  print ( '[PY] Folder separator => {}' .format (GC_FOSA) )
  print ( '[PY] Path separator => {}' .format (GC_PASA) )
  print ( '[PY] Is Windows ? => {}' .format ( CjPlatform .isWindows () ) )
  print ( '[PY] Total memory => {:,d} bytes' .format ( psutil .virtual_memory () .total ) )
  print ( '[PY] GC_GR class name => {}' .format (GC_GR.__class__.__name__) )
  print ( '[PY] GC_PY class name => {}' .format (GC_PY.__class__.__name__) )
  print ( '[PY] gu_na class name => {}' .format (gu_na.__class__.__name__) )
  print ( '[PY] gu_gr class name => {}' .format (gu_gr.__class__.__name__) )
  print ( '[PY] GC_GR java name => {}' .format (GC_GR.java_name) )
  print ( '[PY] GC_PY java name => {}' .format (GC_PY.java_name) )
  print ( '[PY] gu_na java name => {}' .format (gu_na.java_name) )
  print ( '[PY] gu_gr java name => {}' .format (gu_gr.java_name) )
  print ( "[PY] gu_na's GC_TONO_HM => {}" .format ( gu_na ['GC_TONO_HM'] ) )
  print ( "[PY] gu_gr's GC_KAPA_HM => {}" .format ( gu_gr ['GC_KAPA_HM'] ) )
