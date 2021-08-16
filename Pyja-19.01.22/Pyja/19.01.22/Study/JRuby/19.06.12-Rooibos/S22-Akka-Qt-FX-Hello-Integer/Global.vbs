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
  "-> ( x_vbs_fn, x_tono_hm) {" & vbCrLf & _
  "  $LOAD_PATH .unshift x_tono_hm unless $LOAD_PATH .include? x_tono_hm" & vbCrLf & _
  "  $GC_VBS_FN = x_vbs_fn" & vbCrLf & _
  "  $GC_TONO_HM = x_tono_hm" & vbCrLf & _
  "  require 'CrGlobal'" & vbCrLf & _
  "}" _
).call WScript.ScriptFullName, GC_TONO_HM

