import jep
import platform
from java.lang import System

def gf_jcls (x_it) : return jep .findClass (x_it)

CjArrayList = gf_jcls ('java.util.ArrayList')

def gf_2ja ( * x_args ) : # to (j)ava (a)rray
  fu_al = CjArrayList ()
  for bu2_it in x_args : fu_al .add (bu2_it)
  return fu_al .toArray ()

print ( 'Java version (자바 버전) => ' + System .getProperty ("java.version") )
System.out .printf ( 'Python version (파이썬 버전) => %s\n', gf_2ja ( platform .python_version () ) )
System.out .println ( "Hello Python (안녕 파이썬) !!!" )
