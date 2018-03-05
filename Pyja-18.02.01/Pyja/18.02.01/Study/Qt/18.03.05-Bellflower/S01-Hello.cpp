//
// Global
//

#include <csignal>
#include <QApplication>
#include <QCoreApplication>
#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QHostInfo>
#include <QTextStream>
#include <QWidget>

#define AC_QAPP (*qApp)

#define CgQS QString
#define CgQSn QString::number

#define at_ca const auto
#define at_ct(x_cls) const x_cls * const

#define af_c(x_std_str) ( (x_std_str) .c_str () )
#define af_qc(x_qt_str) af_c ( x_qt_str .toStdString () )
#define af_fl CgQS ( "%1 [%2]" ) .arg ( gf_2mps (__FILE__), CgQSn (__LINE__) .rightJustified ( 3, '0' ) )
#define af_w(x_msg) af_fl .append ( " %1" ) .arg (x_msg)
#define af_wl( x_fmt, ... ) "%s " x_fmt, af_qc (af_fl), __VA_ARGS__
#define af_qcw(x_msg) af_qc ( af_w (x_msg) )
#define ap_throw(x_msg) throw std::runtime_error ( af_qcw (x_msg) )

namespace Global {
  at_ca GC_ST = QDateTime::currentDateTime ();

  at_ca GC_PYJA_NM = CgQS ("Pyja");

  at_ca GC_PJYA_CEN = int (20);
  at_ca GC_PYJA_YEA = int (18);
  at_ca GC_PYJA_MON = int ( 2);
  at_ca GC_PYJA_DAY = int ( 1);

  at_ca GC_PYJA_VER_MAJ = GC_PYJA_YEA; // Major
  at_ca GC_PYJA_VER_MIN = GC_PYJA_MON; // Minor
  at_ca GC_PYJA_VER_PAT = GC_PYJA_DAY; // Patch

  at_ca GC_PYJA_CD = CgQS ("%1%2.%3.%4") .arg ( // Pyja creation date
    CgQSn (GC_PJYA_CEN) .rightJustified ( 2, '0' ),
    CgQSn (GC_PYJA_YEA) .rightJustified ( 2, '0' ),
    CgQSn (GC_PYJA_MON) .rightJustified ( 2, '0' ), 
    CgQSn (GC_PYJA_DAY) .rightJustified ( 2, '0' ) 
  );
  at_ca GC_PYJA_VR = CgQS ("%1.%2.%3") .arg ( // Pyja version with fixed length 8
    CgQSn (GC_PYJA_VER_MAJ) .rightJustified ( 2, '0' ), CgQSn (GC_PYJA_VER_MIN) .rightJustified ( 2, '0' ), CgQSn (GC_PYJA_VER_PAT) .rightJustified ( 2, '0' )
  );
  at_ca GC_PYJA_V2 = CgQS ("%1.%2.%3") .arg ( CgQSn (GC_PYJA_VER_MAJ), CgQSn (GC_PYJA_VER_MIN), CgQSn (GC_PYJA_VER_PAT) );// Pyja version without leading zero

  at_ca GC_EC_NONE     = int (-200);
  at_ca GC_EC_SHUTDOWN = int (-199);
  at_ca GC_EC_SUCCESS  = int (   0);
  at_ca GC_EC_ERROR    = int (   1);

  at_ca GC_FOSA = QDir::separator ();     // (fo)lder (s)ep(a)rator
  at_ca GC_PASA = QDir::listSeparator (); // (pa)th (s)ep(a)rator

  at_ca GC_APP_NM = CgQS (AC_APP_NM);

  at_ca GC_HOST_NM = QHostInfo::localHostName ();
  at_ca GC_THIS_PID = QCoreApplication::applicationPid ();
  at_ca GC_THIS_START_UP_PN = QDir::currentPath ();

  auto gf_os_env ( const CgQS & xr_nm ) { return qEnvironmentVariable ( af_qc (xr_nm) ); }
  auto gf_str_is_valid_date ( const CgQS & xr_str, const CgQS & xr_format ) { return QDateTime::fromString ( xr_str, xr_format ) .isValid (); }

  QTextStream __gal_stdout (stdout);
  auto * gf_stdout () { return & __gal_stdout; }
  #define AC_STDOUT ( * gf_stdout () )

  QMessageLogger * __gatl_log = nullptr;
  #define AC_LOG (*__gatl_log)
  auto __gav_log_lvl = QtDebugMsg;
  const CgQS __gau_log_lvl_hd [] = { "D", "W", "C", "F", "I" };
  void __gap_log_msg_handler ( const QtMsgType x_type, const QMessageLogContext &, const CgQS & xr_msg ) {
    if ( __gav_log_lvl == QtInfoMsg && x_type == QtDebugMsg ) return;
    at_ca pu_dt = QDateTime::currentDateTime () .toString ("yyMMdd-hhmmss");
    __gal_stdout << CgQS ( "[%1,%2,%3] %4" ) .arg ( CgQSn (GC_THIS_PID) .rightJustified ( 4, '0' ), __gau_log_lvl_hd [x_type], pu_dt, xr_msg ) << endl;
  }
  void __gap_log_init () {
    qInstallMessageHandler (__gap_log_msg_handler);
    __gatl_log = new QMessageLogger ( __FILE__, __LINE__, Q_FUNC_INFO );
  }
  void gp_set_log_level_to_info () { __gav_log_lvl = QtInfoMsg; }
  void gp_set_log_level_to_debug () { __gav_log_lvl = QtDebugMsg; }
  typedef void (QMessageLogger::*TgtMLn) ( const char *, ... ) const;
  TgtMLn gtl_debug    = & QMessageLogger::debug;
  TgtMLn gtl_warning  = & QMessageLogger::warning;
  TgtMLn gtl_critical = & QMessageLogger::critical;
  TgtMLn gtl_fatal    = & QMessageLogger::fatal;
  TgtMLn gtl_info     = & QMessageLogger::info;
  void gp_log_array ( at_ct (QMessageLogger) xt_ml, TgtMLn xtl_out, const CgQS & xr_title, const QStringList & xr_lst ) {
    #define p_ap_out ( xt_ml ->*xtl_out )
    if ( ! xr_title .isEmpty () ) { p_ap_out ( "%s :", af_qc (xr_title) ); }
    for ( auto bvu2_idx = 0; bvu2_idx < xr_lst .size (); ++bvu2_idx ) {
      p_ap_out ( "  %2d => %s", bvu2_idx+1, af_qc ( xr_lst .at (bvu2_idx) ) );
    }
    #undef p_ap_out
  }
  void gp_log_array ( const CgQS & xr_title, const QStringList & xr_msgs ) { gp_log_array ( & AC_LOG, gtl_info, xr_title, xr_msgs ); }
  void gp_log_header ( at_ct (QMessageLogger) xt_ml, TgtMLn xtl_out, const CgQS & xr_header, const int x_line_width = 60 ) {
    #define p_ap_out ( xt_ml ->*xtl_out )
    at_ca pu_ln = std::string ( x_line_width, '-' );
    p_ap_out ( "+%s",  af_c  (pu_ln) );
    p_ap_out ( ": %s", af_qc (xr_header) );
    p_ap_out ( "+%s",  af_c  (pu_ln) );
    #undef p_ap_out
  }
  void gp_log_exception ( at_ct (QMessageLogger) xt_ml, TgtMLn xtl_out, const CgQS & xr_title, const QStringList & xr_ex ) {
    #define p_ap_out ( xt_ml ->*xtl_out )
    gp_log_header ( xt_ml, xtl_out, xr_title );
    foreach ( at_ca & br2_it, xr_ex ) { p_ap_out ( af_qc (br2_it) ); }
    #undef p_ap_out
  }

  auto gf_wd () { return QDir::currentPath (); } // current (w)orking (d)irectory
  auto gf_id ( const CgQS & xr_it ) { return QDir (xr_it) .exists (); } // (i)s (d)irectory
  auto gf_b2fs ( const CgQS & xr_it ) { return CgQS (xr_it) .replace ( '\\', '/' ) ;} // replace backslash to forwardslash
  auto gf_clpa ( const CgQS & xr_it ) { return QDir::cleanPath ( CgQS (xr_it) ); } // (cl)ean (pa)th
  auto gf_pj ( const QStringList & xr_lst ) { return gf_clpa ( xr_lst .join (GC_FOSA) ); } // (p)ath (j)oin
  auto gf_ap ( const CgQS & xr_it, const bool x_canonical = true ) { // (a)bsolute (p)ath
    at_ca fu_dir = QDir (xr_it);
    at_ca fu_pn = (x_canonical) ? fu_dir .canonicalPath () : fu_dir . absolutePath ();
    if ( ! fu_pn .isEmpty () ) { return fu_pn; }
    #ifdef Q_OS_WIN
      at_ca fu_fs = gf_b2fs (xr_it);
      if ( fu_fs .startsWith ("//") || fu_fs .at (1) == ':' ) return gf_clpa (xr_it);
    #else
      if ( xr_it .at (0) == '/' ) return gf_clpa (xr_it);
    #endif
    return gf_pj ({ gf_wd (), xr_it });
  }
  auto gf_fn ( const CgQS & xr_fn ) { return gf_clpa (xr_fn); }
  auto gf_bn ( const CgQS & xr_fn ) { return QFileInfo (xr_fn) .fileName (); }
  auto gf_jn ( const CgQS & xr_fn ) { return QFileInfo (xr_fn) .completeBaseName (); }
  auto gf_xn ( const CgQS & xr_fn ) { return QFileInfo (xr_fn) .suffix (); }
  auto gf_pn ( const CgQS & xr_fn ) { return QFileInfo (xr_fn) .path (); }
  auto gf_on ( const CgQS & xr_pn ) { return QDir (xr_pn) .dirName (); }

  #define AC_THIS_EXE_FN ( AC_QAPP .applicationFilePath () )
  #define AC_THIS_EXE_PN ( AC_QAPP .applicationDirPath () )
  #define AC_CMD ( AC_QAPP .arguments () )
  #define AC_ARGV ( AC_QAPP .arguments () .mid (1) )

  const CgQS GC_PYJA_RT_SYM ("@`");
  const CgQS GC_PYJA_HM_SYM ("@~");
  const CgQS GC_MILO_PN_SYM ("@!");
  const CgQS GC_CUSR_HM_SYM ("~");

  at_ca GC_PYJA_RT = gf_ap ( gf_os_env ("SC_PYJA_RT") );
  at_ca GC_PYJA_HM = gf_ap ( gf_os_env ("SC_PYJA_HM" ) );
  at_ca GC_MILO_PN = gf_ap ( gf_os_env ("SC_MILO_PN") );

  at_ca GC_QT_HM = gf_ap ( gf_os_env ("SC_QT_HM") );

  at_ca GC_CUSR_HM = QDir::homePath ();

  auto gf_replace_pn_w_px_sym ( const CgQS & xr_pn, const CgQS & xr_px_pa, const CgQS & xr_px_sym ) { // (p)ath (n)ame, (w)ith (p)refi(x) (sym)bol
    at_ca fu_pn = gf_ap (xr_pn);
    if ( fu_pn .startsWith ( xr_px_pa, Qt::CaseInsensitive ) ) {
      if ( xr_pn .size () == xr_px_pa .size () ) return xr_px_sym;
      return gf_pj ({ xr_px_sym, fu_pn .right ( xr_pn .size () - xr_px_pa .size () ) });
    }
    return fu_pn;
  }
  auto gf_2prs ( const CgQS & xr_pn ) { return gf_replace_pn_w_px_sym ( xr_pn, GC_PYJA_RT, GC_PYJA_RT_SYM ); } // to(2) (p)yja (r)oot (s)ymbol
  auto gf_2phs ( const CgQS & xr_pn ) { return gf_replace_pn_w_px_sym ( xr_pn, GC_PYJA_HM, GC_PYJA_HM_SYM ); } // to(2) (p)yja (h)ome (s)ymbol
  auto gf_2mps ( const CgQS & xr_pn ) { return gf_replace_pn_w_px_sym ( xr_pn, GC_MILO_PN, GC_MILO_PN_SYM ); } // to(2) (m)ilo (p)ath (s)ymbol
  auto gf_2uhs ( const CgQS & xr_pn ) { return gf_replace_pn_w_px_sym ( xr_pn, GC_CUSR_HM, GC_CUSR_HM_SYM ); } // to(2) current (u)ser (h)ome (s)ymbol

  at_ca GC_OS_ENV_PATHS = gf_os_env ("SC_PATH") .split (GC_PASA);

  namespace __DgExit {
    auto __dav_ec = GC_EC_NONE;
    auto __dav_ex = QStringList ();
    auto __dav_was_lgcx_processed = false;
    void __dap_before_exit () {
      at_ca pu_ec = __dav_ec;
      at_ca pu_ex = __dav_ex;
      if ( ! pu_ex .isEmpty () ) { gp_log_exception ( & AC_LOG, gtl_critical, "Following error occurs !!!", pu_ex ); }
      if ( pu_ec != GC_EC_SUCCESS && pu_ex .isEmpty () ) { gp_log_header ( & AC_LOG, gtl_critical, "Unknown error occurs !!!" ); }
      switch (pu_ec) {
        case GC_EC_NONE : AC_LOG .critical ( "Undefined exit code (GC_EC_NONE), check your logic !!!" ); break;
        case GC_EC_SHUTDOWN : AC_LOG .info ( "Exit code from shutdown like ctrl+c, ..." ); break;
        default :
          if ( pu_ec < 0 ) { AC_LOG .critical ( "Negative exit code (%d), should consider using a positive value !!!", pu_ec ); } 
          else { AC_LOG .info ( "Exit code => %d", pu_ec ); }
          break;
      }
      AC_LOG .info ( "Elapsed %.3f ...", GC_ST .msecsTo ( QDateTime::currentDateTime () ) / 1000.0 );
    }
    void __dap_exit () {
      at_ca pu_ec = __dav_ec;
      switch (pu_ec) {
        case GC_EC_NONE : exit (GC_EC_ERROR); break;
        case GC_EC_SHUTDOWN : break;
        default :
          if ( pu_ec < 0 ) { exit (GC_EC_ERROR); } 
          else { exit (pu_ec); }
          break;
      }
    }
    void dp_it ( const int x_ec, const QStringList & xr_ex ) {
      if ( __dav_was_lgcx_processed == false ) {
        AC_LOG .debug ( "Received exit code %d", x_ec );
        __dav_was_lgcx_processed = true;
        __dav_ec = x_ec;
        __dav_ex = xr_ex;
        __dap_before_exit ();
        __dap_exit ();
      }
    }
  }
  void gp_request_exit ( const int x_ec, const QStringList & xr_ex ) { __DgExit::dp_it ( x_ec, xr_ex ); }
  void __gap_signal_handler ( int xl_sig_num ) { gp_request_exit ( xl_sig_num, { CgQS ( "Interrupt signal (%1) received !!!" ) .arg ( CgQSn (xl_sig_num) ) } ); }

  void gp_init () {
    __gap_log_init ();
    signal ( SIGINT, __gap_signal_handler );
  }
}

//
// Main Skeleton
//

using namespace Global;
namespace DBody { int df_it (); }

namespace DRun {
  auto __dav_ec = GC_EC_NONE;
  auto __dav_ex = QStringList ();
  auto __daf_banner ( const int x_leading_space = 0, const int x_margin_inside = 2 ) {
    const QStringList fu_msgs = {
      CgQS ( "%1 %2" ) .arg ( GC_PYJA_NM, GC_APP_NM ),
      "",
      CgQS ( "ran on %1" ) .arg ( GC_ST .toString ( "yyyy-MM-dd HH:mm:ss" ) ),
      "released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.",
    };
    at_ca fu_msl = fu_msgs .at ( std::distance (
      fu_msgs .begin (),
      std::max_element (
        fu_msgs .begin (), fu_msgs .end (), 
        [] ( at_ca & xr2_s1, at_ca & xr2_s2 ) { return xr2_s1 .size () < xr2_s2 .size (); }
      )
    ) ) .size (); // max string length
    at_ca fu_ls = x_leading_space; // leading space before box
    at_ca fu_mg = x_margin_inside; // margin inside box
    at_ca fu_ll = fu_mg + fu_msl + fu_mg; // line length inside box
    at_ca ff2_get_line = [=] () { return CgQS (' ') .repeated (fu_ls) + '+' + CgQS ('-') .repeated (fu_ll) + '+'; }; // ff2 -> (f)unction inside (f)unction nested level (2)
    at_ca ff2_get_string = [=] ( const CgQS & xr2_str ) {
      at_ca fu2_sl = xr2_str .size (); // string lentgh
      at_ca fu2_lm = (int) ( ( fu_ll - fu2_sl ) / 2.0 ); // left margin inside box
      at_ca fu2_rm = fu_ll - ( fu2_sl + fu2_lm ); // right margin inside box
      return CgQS (' ') .repeated (fu_ls) + ':' + CgQS (' ') .repeated (fu2_lm) + xr2_str + CgQS (' ') .repeated (fu2_rm) + ':';
    };
    at_ca fu_r = [=] () {
      auto fv2_r = QStringList ( ff2_get_line () );
      std::transform (
        fu_msgs .begin (), fu_msgs .end (), std::back_inserter (fv2_r),
        [ff2_get_string] ( at_ca & xr3_it ) { return ff2_get_string (xr3_it); }
      );
      fv2_r << ff2_get_line ();
      return fv2_r;
    } ();
    return fu_r;
  }
  void __dap_begin () {
    AC_STDOUT << __daf_banner () .join ('\n') << endl;
    AC_LOG .debug ( "Pyja name => %s" , af_qc (GC_PYJA_NM) );
    if ( GC_PYJA_NM != gf_os_env ("SC_PYJA_NM") ) { ap_throw ( "Invalid Pyja name" ); }
    AC_LOG .debug ( "Pyja creation date => %s" , af_qc (GC_PYJA_CD) );
    if ( ! gf_str_is_valid_date ( GC_PYJA_CD, "yyyy.MM.dd" ) ) { ap_throw ( "Pyja create date is not invalid !!!" ); }
    AC_LOG .debug ( "Pyja version => %s" , af_qc (GC_PYJA_V2) );
    AC_LOG .info  ( "Pyja root (%s) => %s" , af_qc (GC_PYJA_RT_SYM), af_qc ( gf_2uhs (GC_PYJA_RT) ) );
    AC_LOG .info  ( "Pyja home (%s) => %s" , af_qc (GC_PYJA_HM_SYM), af_qc ( gf_2prs (GC_PYJA_HM) ) );
    AC_LOG .info  ( "Milo path (%s) => %s" , af_qc (GC_MILO_PN_SYM), af_qc ( gf_2phs (GC_MILO_PN) ) );
    AC_LOG .info  ( "Qt home => %s", af_qc (GC_QT_HM) );
    AC_LOG .info  ( "Qt version => %s", QT_VERSION_STR );
    AC_LOG .debug ( "Current user home (%s) => %s", af_qc (GC_CUSR_HM_SYM), af_qc (GC_CUSR_HM) );
    AC_LOG .debug ( "Computer name => %s", af_qc (GC_HOST_NM) );
    AC_LOG .debug ( "Process ID => %s", af_qc ( CgQSn (GC_THIS_PID) ) );
    AC_LOG .debug ( "Executable file => %s", af_qc ( gf_2phs (AC_THIS_EXE_FN) ) );
    AC_LOG .debug ( "Start up path => %s", af_qc ( gf_2phs (GC_THIS_START_UP_PN) ) );
    gp_log_array ( & AC_LOG, gtl_debug, "Paths", GC_OS_ENV_PATHS );
    if ( AC_CMD .size () > 0 ) gp_log_array ( & AC_LOG, gtl_debug, "Command", AC_CMD );
    if ( AC_ARGV .size () > 0 ) gp_log_array ( "Arguments", AC_ARGV );
  }
  void dp_it () {
    try {
      __dap_begin ();
      __dav_ec = DBody::df_it ();
    } catch ( const std::exception & br2_ex ) {
      __dav_ec = GC_EC_ERROR;
      __dav_ex << br2_ex .what () << af_w ( "Application error !!!" );
    }
    gp_request_exit ( __dav_ec, __dav_ex );
  }
}

//
// Your Source
//

#include <QMainWindow>
#include <QPushButton>

class WMain : public QMainWindow {
  Q_OBJECT
public :
  explicit WMain ( QWidget * xtl_parent = nullptr ) : QMainWindow (xtl_parent) {
    resize ( 300, 150 );
    setWindowTitle (GC_APP_NM);
    _wotl_btn = new QPushButton ( CgQS ( "Hello from Qt %1 !!!" ) .arg (QT_VERSION_STR), this );
    _wotl_btn ->setGeometry ( QRect ( QPoint ( 50, 50 ) , QSize ( 200, 50 ) ) );
    connect ( _wotl_btn, &QPushButton::clicked, [=] () { AC_LOG .info ( "%s", af_qc ( _wotl_btn ->text () ) ); } );
  }
protected :
  QPushButton * _wotl_btn;
};

#include "S01-Hello.moc"

namespace DBody {
  int df_it () {
    WMain fl_w;
    fl_w .show ();
    return AC_QAPP .exec ();
  }
}

namespace OStart {
  void main () {
    gp_set_log_level_to_info ();
    DRun::dp_it ();
  }
}

int main ( int xl_argc, char * xtl_argv [] ) {
  const QApplication fu_app ( xl_argc, xtl_argv );
  gp_init ();
  OStart::main ();
}


