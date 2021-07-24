# +-----------------------------------------------------------------------+
# :                                 Pyja                                  :
# :                    https://github.com/PyjaErskell                     :
# :               made by Erskell (pyja.erskell@gmail.com)                :
# :  released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.  :
# +-----------------------------------------------------------------------+

import sys
sys.dont_write_bytecode = True

from Global import *

def sf_do (x_xml_params_fn) :
  gp_cp ( x_xml_params_fn, GC_DESKTOP_PN, True )
