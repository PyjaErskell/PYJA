import sys
sys.dont_write_bytecode = True
import os
import jep
import platform
import psutil
import tkinter
from PyQt5 import QtCore

def gf_py_e (x_str) : return eval (x_str)

def gy_gr_e (x_str) : return GC_GR .eval (x_str)
def gf_gr_g (x_key) : return GC_GR .get (x_key)
def gp_gr_p ( x_key, x_val ) : GC_GR .put ( x_key, x_val )
def gy_gr_f ( x_name, * x_args ) : return GC_GR. invokeFunction ( x_name, gf_yoa_to_joa (x_args) )

def gy_na_f ( x_name, * x_args ) : return gy_gr_f ( 'gy_na_f', x_name, * x_args )

def gf_joa_to_yoa (x_joa) : return [ bx2_it for bx2_it in x_joa ] # (j)ava (o)bject (a)rray (to) p(y)thon (o)bject (a)rray
def gf_yoa_to_joa (x_yoa) :
  fu_joa = gy_gr_e ( 'new Object [{}]' .format ( len (x_yoa) ) )
  for bu2_idx, bu2_it in enumerate (x_yoa) : fu_joa [bu2_idx] = x_yoa [bu2_idx]
  return fu_joa
class __CgSimpleToDot (object) :
  def __init__ ( self, x_it ) :
    self .__it = x_it
  def __getattr__ ( self, x_attr ) :
    return self .__it [x_attr]
gu_na = __CgSimpleToDot (__gau_na)
gu_gr = __CgSimpleToDot (__gau_gr)

GC_FOSA = os.sep     # (fo)lder (s)ep(a)rator
GC_PASA = os.pathsep # (pa)th (s)ep(a)rator
CjSystem = gy_gr_f ( 'gf_cls', 'java.lang.System' )
CjPlatform = gu_gr .gf_cls .call ('com.sun.jna.Platform')

def sf_sum ( x_1, x_2, x_3 ) : return x_1 + x_2 + x_3

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
  print ( '[PY] __gau_na class name => {}' .format (__gau_na.__class__.__name__) )
  print ( '[PY] __gau_gr class name => {}' .format (__gau_gr.__class__.__name__) )
  print ( '[PY] GC_GR java name => {}' .format (GC_GR.java_name) )
  print ( '[PY] GC_PY java name => {}' .format (GC_PY.java_name) )
  print ( '[PY] __gau_na java name => {}' .format (__gau_na.java_name) )
  print ( '[PY] __gau_gr java name => {}' .format (__gau_gr.java_name) )
  print ( "[PY] gu_na's GC_TONO_HM => {}" .format (gu_na.GC_TONO_HM) )
  print ( "[PY] gu_gr's GC_KAPA_HM => {}" .format (gu_gr.GC_KAPA_HM) )
  print ( "[PY] Call gu_gr's function with array => {}" .format ( gu_gr .gf_pj .call ( gf_yoa_to_joa ( [ 'a', 'bb', 'ccc' ] ) ) ) )
  gp_gr_p ( 'su_foo' , 'this is foo' )
  print ( "[PY] Test gp_gr_p and gf_gr_g => {}" .format ( gf_gr_g ('su_foo') ) )
  print ( "[PY] Call gu_na's function => {}" .format ( gy_na_f ( 'sf_sum',  1, 20, 3000000000000000  ) ))
