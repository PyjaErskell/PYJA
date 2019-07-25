using Gtk;
using System;
using System.IO;
 
class CMain {
  static void Main () {
    Application .Init ();
    String nl_tono_nm = new DirectoryInfo ( Environment .GetEnvironmentVariable ("SC_TONO_HM") ) .Name;
    Window nl_window = new Window (nl_tono_nm);
    nl_window.DeleteEvent += delegate ( object xl_sender, DeleteEventArgs xl_ea ) { Application .Quit (); };
    nl_window .SetSizeRequest ( 300, 200 );
    nl_window .SetPosition (WindowPosition.Center);
    nl_window .Add ( new Label ( csm_password () ) );
    nl_window .ShowAll ();
    Application .Run ();
  }
  static String csm_password () {
    long ml_st = new DateTime ( 2000, 1, 1, 0, 0, 0, DateTimeKind.Utc ) .ToFileTimeUtc ();
    long ml_et = new DateTime ( DateTime.UtcNow.Year, DateTime.UtcNow.Month, DateTime.UtcNow.Day ) .ToFileTimeUtc ();
    return ( ( ml_et - ml_st ) * (long) 2L ) .ToString () .Substring ( 3, 4 );
  }
}
