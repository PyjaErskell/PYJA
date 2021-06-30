# +-----------------------------------------------------------------------+
# :                                 Pyja                                  :
# :                    https://github.com/PyjaErskell                     :
# :               made by Erskell (pyja.erskell@gmail.com)                :
# :  released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.  :
# +-----------------------------------------------------------------------+

import sys
__gau_n = sys.modules ['__main__'] .__sau_n
gu_n = type ( '', (), { '__getattr__' : lambda self, x_attr : __gau_n [x_attr] } ) ()
sys.argv = [gu_n.GC_TONO_HM]

import os
import jep

GC_FOSA = os.sep     # (fo)lder (s)ep(a)rator
GC_PASA = os.pathsep # (pa)th (s)ep(a)rator

def gf_te (x_str) : return eval (x_str)
def gf_jcls (x_it) : return jep .findClass (x_it)

CjArrayList = gf_jcls ('java.util.ArrayList')

def gf_2ja ( * x_args ) : # to (j)ava (a)rray
  fu_al = CjArrayList ()
  for bu2_it in x_args : fu_al .add (bu2_it)
  return fu_al .toArray ()
def gf_nf ( x_nm, * x_args ) : return __gau_n .callMember ( x_nm, gf_2ja ( * x_args ) ) # call (n)ashorn (f)unction
def gf_nm ( x_oj, x_nm, * x_args ) : return x_oj .callMember ( x_nm, gf_2ja ( * x_args ) ) # call (n)ashorn object's (m)ethod
