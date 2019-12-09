
Imports Glabol
Imports System.Drawing
Imports System.Windows.Forms

'---------------------------------------------------------------
' Global
'---------------------------------------------------------------

Public Class Glabol
  Public Shared Dim gu_r = CreateObject ("ruby.object.2.4")
  Shared Sub New ()
    gf_er ("" & _
      "-> (x_milo_pn) {" & vbCrLf & _
      "  pu_src_pn = x_milo_pn + '\src'" & vbCrLf & _
      "  $LOAD_PATH .unshift pu_src_pn unless $LOAD_PATH .include? pu_src_pn" & vbCrLf & _
      "  $GC_MILO_PN = x_milo_pn" & vbCrLf & _
      "  require 'SToa'" & vbCrLf & _
      "}" _
    ) .call ( IO.Directory .GetParent ( IO.Path .GetDirectoryName (Reflection.Assembly.GetExecutingAssembly.Location) ) .ToString () )
  End Sub
  Public Shared Function gf_er ( x_code As String ) ' (er)ubyize
    Return gu_r .erubyize (x_code)
  End Function
End Class

'---------------------------------------------------------------
' Your Source
'---------------------------------------------------------------

Public Class WMain
  Inherits Form
  Dim wu_lbx As New ListBox
  Public Sub New ()
    Me.Size = New Size ( 500, 200 )
    Me .CenterToScreen ()
    wu_lbx.Dock = DockStyle.Fill
    AddHandler Me.Shown, AddressOf wn_shown
    Me.Controls .Add (wu_lbx)
  End Sub
  Private Sub wn_shown ( x_sender As Object, x_eas As EventArgs)
    Me.Text = String .Format ( "{0} : {1}", gf_er ("$GC_OLIM_NM") .to_s, gf_er ("$GC_TONO_NM") .to_s )
    With wu_lbx .Items
      .Add ( ".NET version => " & Environment.Version .ToString () )
      .Add ( "$0 => " & gf_er ("$0") .to_s )
      .Add ( "$$ => " & gf_er ("$$") .to_s )
      .Add ( "RUBY_VERSION => " & gf_er ("RUBY_VERSION") .to_s )
      .Add ( "RUBY_PLATFORM => " & gf_er ("RUBY_PLATFORM") .to_s )
      .Add ( "RUBY_RELEASE_DATE => " & gf_er ("RUBY_RELEASE_DATE") .to_s )
      .Add ( "Ruby sprintf ""%1$*2$s %2$d %1$s"", ""Hello"", 8 => " & gf_er ("$gf_sf") .call ( "%1$*2$s %2$d %1$s", "Hello", 8 ) )
      .Add ( "Ruby sprintf ""%1$*2$s %2$d %1$s"", ""Korea (한글)"", 20 => " & gf_er ("$gf_sf") .call ( "%1$*2$s %2$d %1$s", "Korea (한글)", 20 ) )
    End With
  End Sub
  Public Shared Sub Main()
    Application .Run ( New WMain () )
  End Sub 
End Class
