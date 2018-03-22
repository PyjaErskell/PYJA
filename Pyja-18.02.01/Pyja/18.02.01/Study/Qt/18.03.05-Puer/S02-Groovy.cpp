//
// Global
//

#include <csignal>
#include <jni.h>
#include <QCoreApplication>
#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QHostInfo>
#include <QTextStream>

#define AC_QAPP (*qApp)
#define AC_IGNORE true

#define CgQS QString
#define CgQSn QString::number

#define __aaf_join_sym( x_sym1, x_sym2 ) x_sym1##x_sym2
#define af_join_sym( x_sym1, x_sym2 ) __aaf_join_sym( x_sym1, x_sym2 )
#define af_ln_nm(x_px) af_join_sym ( x_px, __LINE__ )
#define af_ af_ln_nm (_)

#define at_c(x_type) const x_type
#define at_ca at_c(auto)
#define at_ct(x_type) const x_type * const
#define at_cr(x_type) const x_type &

#define af_c(x_std_str) ( (x_std_str) .c_str () )
#define af_qc(x_qstr) af_c ( x_qstr .toStdString () )
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

  auto gf_os_env ( at_cr(CgQS) xr_nm ) { return qEnvironmentVariable ( af_qc (xr_nm) ); }
  auto gf_str_is_valid_date ( at_cr(CgQS) xr_str, at_cr(CgQS) xr_format ) { return QDateTime::fromString ( xr_str, xr_format ) .isValid (); }

  auto __gaf_banner ( at_c(int) x_leading_space = 0, at_c(int) x_margin_inside = 2 ) {
    at_c(QStringList) fu_msgs = {
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
    at_ca ff2_get_line = [&] () { return CgQS (' ') .repeated (fu_ls) + '+' + CgQS ('-') .repeated (fu_ll) + '+'; }; // ff2 -> (f)unction inside (f)unction nested level (2)
    at_ca ff2_get_string = [&] ( at_cr(CgQS) xr2_str ) {
      at_ca fu2_sl = xr2_str .size (); // string lentgh
      at_ca fu2_lm = (int) ( ( fu_ll - fu2_sl ) / 2.0 ); // left margin inside box
      at_ca fu2_rm = fu_ll - ( fu2_sl + fu2_lm ); // right margin inside box
      return CgQS (' ') .repeated (fu_ls) + ':' + CgQS (' ') .repeated (fu2_lm) + xr2_str + CgQS (' ') .repeated (fu2_rm) + ':';
    };
    at_ca fu_r = [&] () {
      auto fv2_r = QStringList ( ff2_get_line () );
      std::transform ( fu_msgs .begin (), fu_msgs .end (), std::back_inserter (fv2_r), [&] ( at_ca & xr3_it ) { return ff2_get_string (xr3_it); } );
      fv2_r << ff2_get_line ();
      return fv2_r;
    } ();
    return fu_r;
  }

  QTextStream __gal_stdout (stdout);
  auto * gf_stdout () { return & __gal_stdout; }
  #define AC_STDOUT ( * gf_stdout () )

  auto __gav_log_lvl = QtDebugMsg;
  at_c(CgQS) __gau_log_lvl_hd [] = { "D", "W", "C", "F", "I" };
  void __gap_log_msg_handler ( at_c(QtMsgType) x_type, at_cr(QMessageLogContext), at_cr(CgQS) xr_msg ) {
    if ( __gav_log_lvl == QtInfoMsg && x_type == QtDebugMsg ) return;
    at_ca pu_dt = QDateTime::currentDateTime () .toString ("yyMMdd-hhmmss");
    __gal_stdout << CgQS ( "[%1,%2,%3] %4" ) .arg ( CgQSn (GC_THIS_PID) .rightJustified ( 6, '0' ), __gau_log_lvl_hd [x_type], pu_dt, xr_msg ) << endl;
  }
  auto * __gatl_log = [] () {
    qInstallMessageHandler (__gap_log_msg_handler);
    return new QMessageLogger ( __FILE__, __LINE__, Q_FUNC_INFO );
  } ();
  auto * gf_log () { return __gatl_log; }
  #define AC_LOG ( * gf_log () )
  typedef void (QMessageLogger::*TgtMLn) ( at_ct(char), ... ) const;
  TgtMLn gtl_debug    = & QMessageLogger::debug;
  TgtMLn gtl_warning  = & QMessageLogger::warning;
  TgtMLn gtl_critical = & QMessageLogger::critical;
  TgtMLn gtl_fatal    = & QMessageLogger::fatal;
  TgtMLn gtl_info     = & QMessageLogger::info;
  void gp_log_array ( at_ct(QMessageLogger) xt_ml, TgtMLn xtl_out, at_cr(CgQS) xr_title, at_cr(QStringList) xr_lst ) {
    #define ap2_out ( xt_ml ->*xtl_out )
    if ( ! xr_title .isEmpty () ) { ap2_out ( "%s :", af_qc (xr_title) ); }
    for ( auto bl2_idx = 0; bl2_idx < xr_lst .size (); ++bl2_idx ) {
      ap2_out ( "  %2d => %s", bl2_idx+1, af_qc ( xr_lst .at (bl2_idx) ) );
    }
    #undef ap2_out
  }
  void gp_log_array ( at_cr(CgQS) xr_title, at_cr(QStringList) xr_msgs ) { gp_log_array ( & AC_LOG, gtl_info, xr_title, xr_msgs ); }
  void gp_log_header ( at_ct(QMessageLogger) xt_ml, TgtMLn xtl_out, at_cr(CgQS) xr_header, at_c(int) x_line_width = 60 ) {
    #define ap2_out ( xt_ml ->*xtl_out )
    at_ca pu_ln = std::string ( x_line_width, '-' );
    ap2_out ( "+%s",  af_c  (pu_ln) );
    ap2_out ( ": %s", af_qc (xr_header) );
    ap2_out ( "+%s",  af_c  (pu_ln) );
    #undef ap2_out
  }
  void gp_log_exception ( at_ct(QMessageLogger) xt_ml, TgtMLn xtl_out, at_cr(CgQS) xr_title, at_cr(QStringList) xr_ex ) {
    #define ap2_out ( xt_ml ->*xtl_out )
    gp_log_header ( xt_ml, xtl_out, xr_title );
    foreach ( at_ca & br2_it, xr_ex ) { ap2_out ( af_qc (br2_it) ); }
    #undef ap2_out
  }

  auto gf_wd () { return QDir::currentPath (); } // current (w)orking (d)irectory
  auto gf_id ( at_cr(CgQS) xr_pn ) { return QDir (xr_pn) .exists (); } // (i)s (d)irectory
  auto gf_if ( at_cr(CgQS) xr_fn ) { return QFile (xr_fn) .exists (); } // (i)s (f)ile
  auto gf_b2fs ( at_cr(CgQS) xr_it ) { return CgQS (xr_it) .replace ( '\\', '/' ) ;} // replace backslash to forwardslash
  auto gf_clpa ( at_cr(CgQS) xr_it ) { return QDir::cleanPath ( CgQS (xr_it) ); } // (cl)ean (pa)th
  auto gf_pj ( at_cr(QStringList) xr_lst ) { return gf_clpa ( xr_lst .join (GC_FOSA) ); } // (p)ath (j)oin
  auto gf_ap ( at_cr(CgQS) xr_it, at_c(bool) x_canonical = true ) { // (a)bsolute (p)ath
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
  auto gf_fn ( at_cr(CgQS) xr_fn ) { return gf_clpa (xr_fn); }
  auto gf_bn ( at_cr(CgQS) xr_fn ) { return QFileInfo (xr_fn) .fileName (); }
  auto gf_jn ( at_cr(CgQS) xr_fn ) { return QFileInfo (xr_fn) .completeBaseName (); }
  auto gf_xn ( at_cr(CgQS) xr_fn ) { return QFileInfo (xr_fn) .suffix (); }
  auto gf_pn ( at_cr(CgQS) xr_fn ) { return QFileInfo (xr_fn) .path (); }
  auto gf_on ( at_cr(CgQS) xr_pn ) { return QDir (xr_pn) .dirName (); }

  #define AC_THIS_EXE_FN ( AC_QAPP .applicationFilePath () )
  #define AC_THIS_EXE_PN ( AC_QAPP .applicationDirPath () )
  #define AC_CMD ( AC_QAPP .arguments () )
  #define AC_ARGV ( AC_QAPP .arguments () .mid (1) )

  at_c(CgQS) GC_PYJA_RT_SYM ("@`");
  at_c(CgQS) GC_PYJA_HM_SYM ("@~");
  at_c(CgQS) GC_MILO_PN_SYM ("@!");
  at_c(CgQS) GC_CUSR_HM_SYM ("~");

  at_ca GC_PYJA_RT = gf_ap ( gf_os_env ("SC_PYJA_RT") );
  at_ca GC_PYJA_HM = gf_ap ( gf_os_env ("SC_PYJA_HM" ) );
  at_ca GC_MILO_PN = gf_ap ( gf_os_env ("SC_MILO_PN") );

  at_ca GC_QT_HM   = gf_ap ( gf_os_env ("SC_QT_HM") );
  at_ca GC_JAVA_HM = gf_ap ( gf_os_env ("SC_J8_HM") );

  at_ca GC_CUSR_HM = QDir::homePath ();

  auto gf_replace_pn_w_px_sym ( at_cr(CgQS) xr_pn, at_cr(CgQS) xr_px_pa, at_cr(CgQS) xr_px_sym ) { // (p)ath (n)ame, (w)ith (p)refi(x) (sym)bol
    at_ca fu_pn = gf_ap (xr_pn);
    if ( fu_pn .startsWith ( xr_px_pa, Qt::CaseInsensitive ) ) {
      if ( xr_pn .size () == xr_px_pa .size () ) return xr_px_sym;
      return gf_pj ({ xr_px_sym, fu_pn .right ( xr_pn .size () - xr_px_pa .size () ) });
    }
    return fu_pn;
  }
  auto gf_2prs ( at_cr(CgQS) xr_pn ) { return gf_replace_pn_w_px_sym ( xr_pn, GC_PYJA_RT, GC_PYJA_RT_SYM ); } // to(2) (p)yja (r)oot (s)ymbol
  auto gf_2phs ( at_cr(CgQS) xr_pn ) { return gf_replace_pn_w_px_sym ( xr_pn, GC_PYJA_HM, GC_PYJA_HM_SYM ); } // to(2) (p)yja (h)ome (s)ymbol
  auto gf_2mps ( at_cr(CgQS) xr_pn ) { return gf_replace_pn_w_px_sym ( xr_pn, GC_MILO_PN, GC_MILO_PN_SYM ); } // to(2) (m)ilo (p)ath (s)ymbol
  auto gf_2uhs ( at_cr(CgQS) xr_pn ) { return gf_replace_pn_w_px_sym ( xr_pn, GC_CUSR_HM, GC_CUSR_HM_SYM ); } // to(2) current (u)ser (h)ome (s)ymbol

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
    void dp_it ( at_c(int) x_ec, at_cr(QStringList) xr_ex ) {
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

  void gp_request_exit ( at_c(int) x_ec, at_cr(QStringList) xr_ex ) { __DgExit::dp_it ( x_ec, xr_ex ); }

  #define ap_xi( x_expr, x_cond, x_err_msg ) if ( x_expr x_cond ) { gp_request_exit ( GC_EC_ERROR, { x_err_msg } ); } 
  #define ap_br(x_block) auto af_ = [] { x_block; return AC_IGNORE; } ()
  #define ay_b(x_block) [&] { x_block }
  #define ay_br(x_block) ay_b(x_block) ()

  JNIEnv * __jatl_jnv = nullptr;
  JavaVM * __jatl_jvm = nullptr;
  auto * jf_jnv () { return __jatl_jnv; }
  auto * jf_jvm () { return __jatl_jvm; }

  ap_br (
    JavaVMInitArgs fl_jvm_args;
    JavaVMOption fl_jvm_options[1];
    fl_jvm_options [0] .optionString = ( char * ) af_qc ( gf_os_env ("SC_JAVA_XMX") );
    fl_jvm_args.version = JNI_VERSION_1_8;
    fl_jvm_args.nOptions = 1;
    fl_jvm_args.options = fl_jvm_options;
    fl_jvm_args.ignoreUnrecognized = JNI_TRUE;
    ap_xi ( JNI_CreateJavaVM ( & __jatl_jvm, ( void ** ) & __jatl_jnv, & fl_jvm_args ), != JNI_OK, af_w ( "Can't create JVM !!!" ) );
  );

  #define zy(x_it) jf_jnv () ->x_it

  at_ca CjObject = zy ( FindClass("java/lang/Object") );
  at_ca CjClass  = zy ( FindClass("java/lang/Class") );

  auto jf_s ( at_c(jobject) x_jstr ) { // get string from jstring
    jboolean fv_is_copy = false;
    at_ct(char) ft_utf = zy ( GetStringUTFChars ( (jstring) x_jstr, & fv_is_copy ) );
    at_ca fu_qstr = CgQS (ft_utf);
    zy ( ReleaseStringUTFChars ( (jstring) x_jstr, ft_utf ) );
    return fu_qstr;
  }

  template < typename T >
  auto jf_o2s ( at_cr(T) xr_oj ) { // Java object to string
    at_ca fu_mi_2str = zy ( GetMethodID ( CjObject, "toString", "()Ljava/lang/String;" ) );
    return jf_s ( zy ( CallObjectMethod ( xr_oj, fu_mi_2str ) ) );
  }

  void jp_xie () { // e(x)it (i)f (e)xception occurred
    at_ca pu_ex = zy ( ExceptionOccurred () );
    if (pu_ex) { gp_request_exit ( GC_EC_ERROR, { jf_o2s (pu_ex) } ); }
  }

  template < typename T > at_cr(T) jf_xie ( at_cr(T) xr_it ) { jp_xie (); return xr_it; }

  #define zf_xie(x_it) jf_xie ( zy (x_it) )
  #define zp_xie(x_it) zy (x_it), jp_xie ()

  auto jf_ns ( at_cr(CgQS) xr_qstr ) { return zf_xie ( NewStringUTF ( af_qc (xr_qstr) ) ); } // (n)ew (s)tring
  auto jf_fc ( at_cr(CgQS) xr_cls_nm ) { return zf_xie ( FindClass ( af_qc (xr_cls_nm) ) ); } // (f)ind (c)lass
  auto jf_mi ( at_c(jclass) x_cls, at_cr(CgQS) xr_nm, at_cr(CgQS) xr_sig ) { return zf_xie ( GetMethodID ( x_cls, af_qc (xr_nm), af_qc (xr_sig) ) ); } // (m)ethod (i)d
  auto jf_no ( at_c(jclass) x_cls, at_c(jmethodID) x_mi, ... ) { // (n)ew (o)bject
    va_list fl_args;
    va_start ( fl_args, x_mi );
    at_ca fu_oj = zf_xie ( NewObjectV ( x_cls, x_mi, fl_args ) );
    va_end (fl_args);
    return fu_oj;
  }
  auto jf_noa ( at_c(jclass) x_cls, at_cr(QList<jobject>) xr_lst ) { // (n)ew (o)bject (a)rray
    at_ca fu_oa = zf_xie ( NewObjectArray ( xr_lst .size (), x_cls, NULL ) );
    for ( auto bl2_idx = 0; bl2_idx < xr_lst .size (); ++bl2_idx ) { zp_xie ( SetObjectArrayElement ( fu_oa, bl2_idx, xr_lst .at (bl2_idx) ) ); }
    return fu_oa;
  }
  auto jf_om ( at_c(jobject) x_oj, at_c(jmethodID) x_mi, ... ) { // call (o)bject (m)ethod
    va_list fl_args;
    va_start ( fl_args, x_mi );
    at_ca fu_oj = zf_xie ( CallObjectMethodV ( x_oj, x_mi, fl_args ) );
    va_end (fl_args);
    return fu_oj;
  }
  void jp_on ( at_c(jobject) x_oj, at_c(jmethodID) x_mi, ... ) { // call (o)bject (n)ethod
    va_list pl_args;
    va_start ( pl_args, x_mi );
    zp_xie ( CallObjectMethodV ( x_oj, x_mi, pl_args ) );
    va_end (pl_args);
  }
  auto jf_sm ( at_c(jclass) x_cls, at_c(jmethodID) x_si, ... ) { // call (s)tatic object (m)ethod
    va_list fl_args;
    va_start ( fl_args, x_si );
    at_ca fu_oj = zf_xie ( CallStaticObjectMethodV ( x_cls, x_si, fl_args ) );
    va_end (fl_args);
    return fu_oj;
  }
  void jp_sn ( at_c(jclass) x_cls, at_c(jmethodID) x_si, ... ) { // call (s)tatic object (n)ethod
    va_list pl_args;
    va_start ( pl_args, x_si );
    zp_xie ( CallStaticObjectMethodV ( x_cls, x_si, pl_args ) );
    va_end (pl_args);
  }
  auto jf_si ( at_c(jclass) x_cls, at_cr(CgQS) xr_nm, at_cr(CgQS) xr_sig ) { return zf_xie ( GetStaticMethodID ( x_cls, af_qc (xr_nm), af_qc (xr_sig) ) ); } // (s)tatic method (i)d
  void jp_add_jar ( at_cr(CgQS) xr_jar_fn ) {
    ap_xi ( gf_if (xr_jar_fn), != true, af_w ( "Can't find jar file => %1" ) .arg (xr_jar_fn) );
    at_ca pu_cls_file = jf_fc ("java/io/File");
    at_ca pu_cls_cl = jf_fc ("java/lang/ClassLoader");
    at_ca pu_url = jf_om (
      jf_om (
        jf_no ( pu_cls_file, jf_mi ( pu_cls_file, "<init>", "(Ljava/lang/String;)V" ), jf_ns (xr_jar_fn) ),
        jf_mi ( pu_cls_file, "toURI", "()Ljava/net/URI;" )
      ),
      jf_mi ( jf_fc ("java/net/URI"), "toURL", "()Ljava/net/URL;" )
    );
    at_ca pu_cl = jf_sm ( pu_cls_cl, jf_si ( pu_cls_cl, "getSystemClassLoader", "()Ljava/lang/ClassLoader;" ) );
    at_ca pu_m = jf_om (
      jf_fc ("java/net/URLClassLoader"),
      jf_mi ( CjClass, "getDeclaredMethod", "(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;" ),
      jf_ns ("addURL"),
      jf_noa ( CjClass, { jf_fc ("java/net/URL") } )
    );
    jp_on (
      pu_m,
      jf_mi ( jf_fc ("java/lang/reflect/AccessibleObject"), "setAccessible", "(Z)V" ),
      JNI_TRUE
    );
    jp_on (
      pu_m,
      jf_mi ( jf_fc ("java/lang/reflect/Method"), "invoke", "(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;" ),
      pu_cl,
      jf_noa ( CjObject, {pu_url} )
    );
  }

  auto jf_i ( at_c(jobject) x_it ) {
    static at_ca ysu_cls = jf_fc ("java/lang/Integer");
    return zf_xie ( CallIntMethod ( x_it, jf_mi ( ysu_cls, "intValue", "()I" ) ) );
  }

  ap_br (
    foreach ( at_cr(CgQS) br2_jar_fn, QStringList ({
      gf_pj ({ GC_PYJA_HM, "Library", "Groovy", "2.4.14", "embeddable", "groovy-all-2.4.14-indy.jar" }),
    }) ) { jp_add_jar (br2_jar_fn); }
  );

  auto jf_script_engine ( at_cr(CgQS) xr_ngin_nm ) { // (s)cript (e)ngine
    at_ca fu_cls_sem = jf_fc ("javax/script/ScriptEngineManager");
    return jf_om (
      jf_no ( fu_cls_sem, jf_mi ( fu_cls_sem, "<init>", "()V" ) ),
      jf_mi ( fu_cls_sem, "getEngineByName", "(Ljava/lang/String;)Ljavax/script/ScriptEngine;" ),
      jf_ns (xr_ngin_nm)
    );
  }
  at_ca GC_GR = jf_script_engine ("Groovy");
  auto jy_se ( at_cr(jobject) xr_se, at_cr(CgQS) xr_script ) { // (s)cript (e)val
    return jf_om (
      xr_se,
      jf_mi ( jf_fc ("javax/script/ScriptEngine"), "eval", "(Ljava/lang/String;)Ljava/lang/Object;" ),
      jf_ns (xr_script )
    );
  }
  auto jy_ge ( at_cr(CgQS) xr_str ) { return jy_se ( GC_GR, xr_str ); } // (g)roovy (e)val

  at_ca GC_GROOVY_VR = jf_s ( jy_ge ( "GroovySystem.version" ) );

  at_ca JC_TRUE  = jy_ge ("true");
  at_ca JC_FALSE = jy_ge ("false");

  auto jy_gm ( at_cr(jobject) xr_oj, at_cr(CgQS) xr_nm, at_cr(QList<jobject>) xr_args ) { // (g)roovy invoke (m)ethod
    static at_ca ysu_mi = jf_mi ( jf_fc ("javax/script/Invocable"), "invokeMethod", "(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;" );
    return jf_om ( GC_GR, ysu_mi, xr_oj, jf_ns (xr_nm), jf_noa ( CjObject, xr_args ) );
  }
  auto jy_gf ( at_cr(CgQS) xr_nm, at_cr(QList<jobject>) xr_args ) { // (g)roovy invoke (f)unction
    static at_ca ysu_mi = jf_mi ( jf_fc ("javax/script/Invocable"), "invokeFunction", "(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;" );
    return jf_om ( GC_GR, ysu_mi, jf_ns (xr_nm), jf_noa ( CjObject, xr_args ) );
  }

  ap_br ( signal ( SIGINT, [] ( int xl_sig_num ) { gp_request_exit ( xl_sig_num, { CgQS ( "Interrupt signal (%1) received !!!" ) .arg ( CgQSn (xl_sig_num) ) } ); } ); );
}

//
// Main Skeleton
//

using namespace Global;
namespace DBody { int df_it (); }

namespace DRun {
  auto __dav_ec = GC_EC_NONE;
  auto __dav_ex = QStringList ();
  void __dap_begin () {
    AC_STDOUT << __gaf_banner () .join ('\n') << endl;
    AC_LOG .debug ( "Pyja name => %s" , af_qc (GC_PYJA_NM) );
    if ( GC_PYJA_NM != gf_os_env ("SC_PYJA_NM") ) { ap_throw ( "Invalid Pyja name" ); }
    AC_LOG .debug ( "Pyja creation date => %s" , af_qc (GC_PYJA_CD) );
    if ( ! gf_str_is_valid_date ( GC_PYJA_CD, "yyyy.MM.dd" ) ) { ap_throw ( "Pyja create date is not invalid !!!" ); }
    AC_LOG .debug ( "Pyja version => %s" , af_qc (GC_PYJA_V2) );
    AC_LOG .info  ( "Pyja root (%s) => %s" , af_qc (GC_PYJA_RT_SYM), af_qc ( gf_2uhs (GC_PYJA_RT) ) );
    AC_LOG .info  ( "Pyja home (%s) => %s" , af_qc (GC_PYJA_HM_SYM), af_qc ( gf_2prs (GC_PYJA_HM) ) );
    AC_LOG .info  ( "Milo path (%s) => %s" , af_qc (GC_MILO_PN_SYM), af_qc ( gf_2phs (GC_MILO_PN) ) );
    AC_LOG .info  ( "Qt home => %s", af_qc (GC_QT_HM) );
    AC_LOG .debug ( "Qt version => %s", QT_VERSION_STR );
    AC_LOG .info  ( "Java home => %s", af_qc (GC_JAVA_HM) );
    AC_LOG .info  ( "Groovy version => %s", af_qc (GC_GROOVY_VR) );
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
    } catch ( at_cr(std::exception) br2_ex ) {
      __dav_ec = GC_EC_ERROR;
      __dav_ex << br2_ex .what () << af_w ( "Application error !!!" );
    }
    gp_request_exit ( __dav_ec, __dav_ex );
  }
}

//
// Your Source
//

#include <QApplication>
#include <QDesktopWidget>
#include <QGridLayout>
#include <QHeaderView>
#include <QLabel>
#include <QLineEdit>
#include <QMainWindow>
#include <QSizePolicy>
#include <QSpacerItem>
#include <Qt>
#include <QTableWidget>
#include <QVBoxLayout>
#include <QWidget>

ap_br (
  foreach ( at_cr(CgQS) br2_jar_fn, QStringList ({
    gf_pj ({ GC_PYJA_HM, "Library", "AppDirs", "1.0.0", "appdirs-1.0.0.jar" }),
    gf_pj ({ GC_PYJA_HM, "Library", "JNA", "4.5.1", "jna-4.5.1.jar" }),
    gf_pj ({ GC_PYJA_HM, "Library", "JNA", "4.5.1", "jna-platform-4.5.1.jar" }),
    gf_pj ({ GC_PYJA_HM, "Library", "SLF4J", "1.7.25", "slf4j-api-1.7.25.jar" }),
    gf_pj ({ GC_PYJA_HM, "Library", "SLF4J", "1.7.25", "slf4j-nop-1.7.25.jar" }),
  }) ) { jp_add_jar (br2_jar_fn); }
);

class WMain : public QMainWindow {
  Q_OBJECT
public :
  at_c(CgQS) wu_app_nm = "Groovy";
  at_c(CgQS) wu_app_vr = GC_GROOVY_VR;
  at_c(CgQS) wu_app_au = "Strachan";
  explicit WMain ( QWidget * xtl_parent = nullptr ) : QMainWindow (xtl_parent) { wn_init (); }
  void wn_init () {
    resize ( 650, 350 );
    setWindowTitle (GC_APP_NM);
    auto * mtl_cw = new QWidget ();
    auto * mtl_lo = new QVBoxLayout ();
    mtl_lo ->addLayout ( wm_init_info () );
    mtl_lo ->addWidget ( wm_init_appdirs () );
    mtl_cw ->setLayout (mtl_lo);
    setCentralWidget (mtl_cw);
    wn_move_center ();
  }
  QGridLayout * wm_init_info () {
    auto * mtl_it = new QGridLayout ();
    mtl_it ->addWidget ( new QLabel ("Application name"),    0, 0, Qt::AlignRight | Qt::AlignCenter );
    mtl_it ->addWidget ( new QLabel ("Application version"), 1, 0, Qt::AlignRight | Qt::AlignCenter );
    mtl_it ->addWidget ( new QLabel ("Application author"),  2, 0, Qt::AlignRight | Qt::AlignCenter );
    at_ca mf2_le = [] ( auto x2_str ) {
      auto * ftl2_it = new QLineEdit ();
      ftl2_it ->setText (x2_str);
      ftl2_it ->setReadOnly (true);
      return ftl2_it;
    };
    mtl_it ->addWidget ( mf2_le (wu_app_nm), 0, 1, Qt::AlignLeft | Qt::AlignCenter );
    mtl_it ->addWidget ( mf2_le (wu_app_vr), 1, 1, Qt::AlignLeft | Qt::AlignCenter );
    mtl_it ->addWidget ( mf2_le (wu_app_au), 2, 1, Qt::AlignLeft | Qt::AlignCenter );
    for ( int bl2_row = 0; bl2_row < 3; bl2_row++ ) { mtl_it ->addItem ( new QSpacerItem ( 1, 1, QSizePolicy::Expanding, QSizePolicy::Minimum ), bl2_row, 2 ); }
    return mtl_it;
  }
  QTableWidget * wm_init_appdirs () {
    auto * mtl_it = new QTableWidget ( 6, 2 );
    mtl_it ->setHorizontalHeaderLabels ({ "Item", "Directory" });
    mtl_it ->horizontalHeader () ->setStretchLastSection (true);
    mtl_it ->verticalHeader () ->setVisible (false);
    at_ca mp2_set_item = [&] ( auto x2_row, auto x2_item, auto x2_path ) {
      mtl_it ->setItem ( x2_row, 0, new QTableWidgetItem (x2_item) );
      mtl_it ->setItem ( x2_row, 1, new QTableWidgetItem (x2_path) );
    };
    ay_br (
      at_ca pu2_ad = jy_ge ( "net.harawata.appdirs.AppDirsFactory .getInstance ()" );
      at_ca pu_nm = jf_ns (wu_app_nm);
      at_ca pu_vr = jf_ns (wu_app_vr);
      at_ca pu_au = jf_ns (wu_app_au);
      mp2_set_item ( 0, "User data path",   gf_2uhs ( jf_s ( jy_gm ( pu2_ad, "getUserDataDir",   { pu_nm, pu_vr, pu_au } ) ) ) );
      mp2_set_item ( 1, "User config path", gf_2uhs ( jf_s ( jy_gm ( pu2_ad, "getUserConfigDir", { pu_nm, pu_vr, pu_au } ) ) ) );
      mp2_set_item ( 2, "User cache path",  gf_2uhs ( jf_s ( jy_gm ( pu2_ad, "getUserCacheDir",  { pu_nm, pu_vr, pu_au } ) ) ) );
      mp2_set_item ( 3, "User log path",    gf_2uhs ( jf_s ( jy_gm ( pu2_ad, "getUserLogDir",    { pu_nm, pu_vr, pu_au } ) ) ) );
      mp2_set_item ( 4, "Site data path",   gf_2uhs ( jf_s ( jy_gm ( pu2_ad, "getSiteDataDir",   { pu_nm, pu_vr, pu_au } ) ) ) );
      mp2_set_item ( 5, "Site config path", gf_2uhs ( jf_s ( jy_gm ( pu2_ad, "getSiteConfigDir", { pu_nm, pu_vr, pu_au } ) ) ) );
    );
    mtl_it ->resizeColumnsToContents ();
    return mtl_it;
  }
  void wn_move_center () {
    at_ca nu_cp = ( new QDesktopWidget () ) ->availableGeometry () .center (); // center point
    move ( nu_cp.x() - width()/2, nu_cp.y() - height()/2 );
  }
};

#include "S02-Groovy.moc"

namespace DBody {
  int df_it () {
    WMain fl_w;
    fl_w .show ();
    fl_w .raise ();
    return AC_QAPP .exec ();
  }
}

namespace OStart {
  void main () {
    // gp_set_log_level_to_info ();
    DRun::dp_it ();
  }
}

int main ( int xl_argc, char * xtl_argv [] ) {
  at_c(QApplication) fu_app ( xl_argc, xtl_argv );
  OStart::main ();
}
