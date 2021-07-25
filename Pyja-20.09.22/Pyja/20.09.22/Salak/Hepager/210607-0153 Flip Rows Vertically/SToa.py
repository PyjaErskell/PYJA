# +-----------------------------------------------------------------------+
# :                                 Pyja                                  :
# :                    https://github.com/PyjaErskell                     :
# :               made by Erskell (pyja.erskell@gmail.com)                :
# :  released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.  :
# +-----------------------------------------------------------------------+

import sys
sys.dont_write_bytecode = True

from Global import *
import tempfile
from xml.etree.ElementTree import ElementTree
import numpy as np

def sp_do (x_xml_params_fn) :
  CjSystem.out.println ( 'TONO name => {}' .format (GC_TONO_NM) )
  
  pu_tree = ElementTree ()
  pu_tree .parse (x_xml_params_fn)
  pu_i_db_fn = pu_tree .findall ('./JobParams/inputFilePath') [0] .text
  pu_db_pn = gf_pn (pu_i_db_fn)
  pu_i_db_bn = gf_bn (pu_i_db_fn)
  pu_t_db_bn = next ( tempfile ._get_candidate_names () ) + '.txt'
  pu_t_db_fn = gf_pj ( pu_db_pn, pu_t_db_bn )
  CjSystem.out.println ( 'DB path => {}' .format (pu_db_pn) )
  CjSystem.out.println ( 'Input DB file => {}' .format (pu_i_db_bn) )
  CjSystem.out.println ( 'Temporary DB file => {}' .format (pu_t_db_bn) )
  if not gf_xi (pu_i_db_fn) : raise Exception ( 'Cannot find DB file !!!' )

  pu_charset = sf_db_file_encoding (pu_i_db_fn)
  CjSystem.out.println ( 'Charset => {}' .format (pu_charset) )
  pu_br = gf_jcls ('java.io.BufferedReader') ( gf_jcls ('java.io.InputStreamReader') ( gf_jcls ('java.io.DataInputStream') ( gf_jcls ('java.io.FileInputStream') (pu_i_db_fn) ), pu_charset ) )
  pu_bw = gf_jcls ('java.io.BufferedWriter') ( gf_jcls ('java.io.OutputStreamWriter') ( gf_jcls ('java.io.FileOutputStream') (pu_t_db_fn), pu_charset ) )
  sp_reverse ( pu_br, pu_bw )
  pu_br .close ()
  pu_bw .close ()

  CjSystem.out.println ( 'Unlink input DB file ...' )
  gp_ul (pu_i_db_fn)
  CjSystem.out.println ( 'Rename temporary DB file to original input DB file name ...' )
  gp_rn ( pu_t_db_fn, pu_i_db_fn )

def sf_db_file_encoding (x_db_fn) :
  fu_char1 = None
  fu_char2 = None
  with open ( x_db_fn, 'rb' ) as fu_fl :
    fu_char1 = fu_fl .read (1)
    fu_char2 = fu_fl .read (1)
  if fu_char1 == b'\xff' and fu_char2 == b'\xfe' :
    return 'x-UTF-16LE-BOM'
  else :
    return 'US-ASCII'

def sp_reverse ( x_br, x_bw ) :
  def pp2_write (x2_line) :
    pu2_to_write = x2_line + "\r\n"
    x_bw .write ( pu2_to_write, 0, len(pu2_to_write) )

  pp2_write ( x_br .readLine () ) # write the first line of the headers

  pv_all_lines = np.array ( [], dtype = str )

  # read file line by line
  pv_ln = x_br .readLine ()
  while pv_ln is not None :
    pv_all_lines = np .append ( pv_all_lines, np.array ([pv_ln]) )
    pv_ln = x_br .readLine ()

  for bu2_i in range ( len (pv_all_lines) - 1, -1, -1 ) :
    pp2_write ( pv_all_lines [bu2_i] )
