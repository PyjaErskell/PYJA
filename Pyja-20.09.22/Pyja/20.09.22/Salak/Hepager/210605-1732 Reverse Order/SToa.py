# +-----------------------------------------------------------------------+
# :                                 Pyja                                  :
# :                    https://github.com/PyjaErskell                     :
# :               made by Erskell (pyja.erskell@gmail.com)                :
# :  released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.  :
# +-----------------------------------------------------------------------+

from Global import *

import numpy as np

def sp_main () :
  # reading the first line of the headers to be ignored
  pv_ln = gu_n.br .readLine ()

  pv_all_lines = np.array ( [], dtype = str )

  # read file line by line
  pv_ln = gu_n.br .readLine ()
  while pv_ln is not None :
    pv_all_lines = np .append ( pv_all_lines, np.array ([pv_ln]) )
    pv_ln = gu_n.br .readLine ()

  for bu2_i in range ( len (pv_all_lines) - 1, -1, -1 ) :
    bu2_to_write = pv_all_lines [bu2_i] + "\r\n"
    gu_n.bw .write ( bu2_to_write, 0, len(bu2_to_write) )

sp_main ()
