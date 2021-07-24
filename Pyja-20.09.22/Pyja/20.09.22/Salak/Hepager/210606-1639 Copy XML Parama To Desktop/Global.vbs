' +-----------------------------------------------------------------------+
' :                                 Pyja                                  :
' :                    https://github.com/PyjaErskell                     :
' :               made by Erskell (pyja.erskell@gmail.com)                :
' :  released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.  :
' +-----------------------------------------------------------------------+

Dim gu_r

Set gu_r = CreateObject ("ruby.object.2.4")

Function gf_er (x_code) ' (er)ubyize
  Set gf_er = gu_r.erubyize (x_code)
End Function

gf_er("" & _
  "-> (x_tono_hm) {" & vbCrLf & _
  "  pu_src_pn = x_tono_hm" & vbCrLf & _
  "  $LOAD_PATH .unshift pu_src_pn unless $LOAD_PATH .include? pu_src_pn" & vbCrLf & _
  "  $GC_TONO_HM = x_tono_hm" & vbCrLf & _
  "  require 'Global'" & vbCrLf & _
  "}" _
).call(GC_TONO_HM)

