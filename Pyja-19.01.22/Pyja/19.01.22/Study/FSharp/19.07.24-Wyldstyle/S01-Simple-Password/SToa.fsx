open System
open System.Drawing
open System.IO
open System.Windows.Forms

let SC_TONO_NM = ( new DirectoryInfo ( Environment .GetEnvironmentVariable ("SC_TONO_HM") ) ) .Name
let su_password =
  let fu_st = ( new DateTime ( 2000, 1, 1, 0, 0, 0, DateTimeKind.Utc ) ) .ToFileTimeUtc ()
  let fu_et = ( new DateTime ( DateTime.UtcNow.Year, DateTime.UtcNow.Month, DateTime.UtcNow.Day ) ) .ToFileTimeUtc ()
  ( ( ( fu_et - fu_st ) * 2L ) .ToString () ) . [ 3 .. 6 ]
let su_fm = new Form ( Text = SC_TONO_NM, StartPosition = FormStartPosition.CenterScreen, Width = 350 )
let su_lb = new Label ( Text = sprintf "%s" su_password, TextAlign = ContentAlignment.MiddleCenter, Dock = DockStyle.Fill )
su_fm.Controls .Add (su_lb)
Application .Run (su_fm)
