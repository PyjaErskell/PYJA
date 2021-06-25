# +-----------------------------------------------------------------------+
# :                                 Pyja                                  :
# :                    https://github.com/PyjaErskell                     :
# :               made by Erskell (pyja.erskell@gmail.com)                :
# :  released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.  :
# +-----------------------------------------------------------------------+

from Global import *

def sp_main () :
  # reading the first line of the headers to be ignored
  pv_ln = gu_n.br .readLine ()

  # read file line by line
  pv_ln = gu_n.br .readLine ()
  while pv_ln is not None :
    bu2_str = "안녕)Hello( ]" + pv_ln + "[ )olleH(녕안"
    bu2_to_write = bu2_str [::-1] + "\r\n"
    gu_n.bw .write ( bu2_to_write, 0, len(bu2_to_write) )
    pv_ln = gu_n.br .readLine ()

sp_main ()
