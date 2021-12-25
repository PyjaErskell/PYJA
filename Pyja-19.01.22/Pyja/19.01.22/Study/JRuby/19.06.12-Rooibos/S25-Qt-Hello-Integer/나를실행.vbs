Option Explicit

Function sf_global (x_tono_hm)
  Dim fu_fso, fu_tf, fu_s, fu_r
  Set fu_fso = CreateObject ("Scripting.FileSystemObject")
  Set fu_tf = fu_fso.OpenTextFile ( x_tono_hm & "\src\vbs\Global.vbs" )
  fu_s = fu_tf.ReadAll ()
  fu_r = "Option Explicit" & vbCrLf & vbCrLf & "Const GC_TONO_HM = """ & x_tono_hm & """" & vbCrLf & fu_s
  sf_global = fu_r
End Function
Execute sf_global ("C:\ProgramData\Bichon Frise\Pyja\19.01.22\Study\JRuby\19.06.12-Rooibos\S25-Qt-Hello-Integer")

Sub sp_do ()
  gf_er "require 'src/cruby/run/SToa'"
End Sub

sp_do
