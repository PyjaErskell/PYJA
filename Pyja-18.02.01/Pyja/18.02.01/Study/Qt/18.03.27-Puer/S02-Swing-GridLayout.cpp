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
#include <QTimer>

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

#define af_tap3( x_it, x_param, x_block ) [&] ( auto & x_param ) -> auto & { x_block; return x_param; } (x_it)
#define af_tap( x_it, x_block ) af_tap3 ( x_it, it, x_block )

Q_DECLARE_METATYPE(jobject)

namespace Global {
  auto __gav_gp_init_was_done = false;

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
        __dav_was_lgcx_processed = true;
        __dav_ec = x_ec;
        __dav_ex = xr_ex;
        __dap_before_exit ();
        __dap_exit ();
      }
    }
  }

  void gp_request_exit ( at_c(int), at_cr(QStringList) );

  #define ap_xi( x_expr, x_cond, x_err_msg ) if ( x_expr x_cond ) { gp_request_exit ( GC_EC_ERROR, { x_err_msg } ); } 
  #define ap_br(x_block) auto af_ = [] { x_block; return AC_IGNORE; } ()
  #define ay_b(x_block) [&] { x_block }
  #define ay_br(x_block) ay_b(x_block) ()

  JNIEnv * jtl_jnv = nullptr;
  JavaVM * jtl_jvm = nullptr;

  ap_br (
    JavaVMInitArgs fl_jvm_args;
    JavaVMOption fl_jvm_options[1];
    fl_jvm_options [0] .optionString = ( char * ) af_qc ( gf_os_env ("SC_JAVA_XMX") );
    fl_jvm_args.version = JNI_VERSION_1_8;
    fl_jvm_args.nOptions = 1;
    fl_jvm_args.options = fl_jvm_options;
    fl_jvm_args.ignoreUnrecognized = JNI_TRUE;
    ap_xi ( JNI_CreateJavaVM ( & jtl_jvm, ( void ** ) & jtl_jnv, & fl_jvm_args ), != JNI_OK, af_w ( "Cannot create JVM !!!" ) );
  );

  #define zy(x_it) jtl_jnv ->x_it

  at_ca CjObject = zy ( FindClass("java/lang/Object") );
  at_ca CjClass  = zy ( FindClass("java/lang/Class") );

  #define zt_call Q_INVOKABLE void
  #define zt_o(x_param) at_c (jobject) x_param

  auto jf_s ( zt_o(x_jstr) ) { // get string from jstring
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
  auto jf_om ( zt_o(x_oj), at_c(jmethodID) x_mi, ... ) { // call (o)bject (m)ethod
    va_list fl_args;
    va_start ( fl_args, x_mi );
    at_ca fu_oj = zf_xie ( CallObjectMethodV ( x_oj, x_mi, fl_args ) );
    va_end (fl_args);
    return fu_oj;
  }
  void jp_on ( zt_o(x_oj), at_c(jmethodID) x_mi, ... ) { // call (o)bject (n)ethod
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
    ap_xi ( gf_if (xr_jar_fn), != true, af_w ( "Cannot find jar file => %1" ) .arg (xr_jar_fn) );
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

  auto jf_i ( zt_o(x_it) ) {
    static at_ca fsu_mi = jf_mi ( jf_fc ("java/lang/Integer"), "intValue", "()I" );
    return zf_xie ( CallIntMethod ( x_it, fsu_mi ) );
  }
  auto jf_ni ( at_c(int) x_it ) { // create java integer
    static at_ca fsu_cls = jf_fc ("java/lang/Integer");
    static at_ca fsu_mi = jf_mi ( fsu_cls, "<init>", "(I)V" );
    return zf_xie ( NewObject ( fsu_cls, fsu_mi, (jint) x_it ) );
  }
  auto jf_nl ( at_c ( long long ) x_it ) { // create java long
    static at_ca fsu_cls = jf_fc ("java/lang/Long");
    static at_ca fsu_mi = jf_mi ( fsu_cls, "<init>", "(J)V" );
    return zf_xie ( NewObject ( fsu_cls, fsu_mi, (jlong) x_it ) );
  }

  ap_br (
    foreach ( at_cr(CgQS) br2_jar_fn, QStringList ({
      gf_pj ({ GC_MILO_PN, "exe", "DgQt.jar" }),
      gf_pj ({ GC_PYJA_HM, "Library", "Groovy", "2.4.14", "embeddable", "groovy-all-2.4.14-indy.jar" }),
      gf_pj ({ GC_PYJA_HM, "Library", "Logback", "1.2.3", "logback-classic-1.2.3.jar" }),
      gf_pj ({ GC_PYJA_HM, "Library", "Logback", "1.2.3", "logback-core-1.2.3.jar" }),
      gf_pj ({ GC_PYJA_HM, "Library", "SLF4J", "1.7.25", "slf4j-api-1.7.25.jar" }),
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
  auto jy_se ( zt_o(x_se), at_cr(CgQS) xr_script ) { // (s)cript (e)val
    return jf_om (
      x_se,
      jf_mi ( jf_fc ("javax/script/ScriptEngine"), "eval", "(Ljava/lang/String;)Ljava/lang/Object;" ),
      jf_ns (xr_script )
    );
  }
  auto jy_ge ( at_cr(CgQS) xr_str ) { return jy_se ( GC_GR, xr_str ); } // (g)roovy (e)val

  at_ca GC_GROOVY_VR = jf_s ( jy_ge ( "GroovySystem.version" ) );

  ap_br (
    jy_ge ( R"(
      { ->
        final def pu_env = System .getenv ()
        if ( ! pu_env.SC_JAVA_LIBRARY_PATH ) throw new Exception ( "Cannot find SC_JAVA_LIBRARY_PATH environment variable" )
        System.setProperty "java.library.path", pu_env.SC_JAVA_LIBRARY_PATH
        final def pu_sys_paths = ClassLoader.class .getDeclaredField "sys_paths"
        pu_sys_paths .setAccessible true
        pu_sys_paths .set null, null
      } ()
    )" );
  );

  ap_br ( jy_ge ( CgQS ( "GC_APP_NM = '%1'" ) .arg (GC_APP_NM) ); );

  ap_br (
    jy_ge ( R"(
      gf_tid = { Thread .currentThread () .getId () }
      GC_THIS_TID = gf_tid ()
    )" );
  );

  at_ca JC_NULL = jy_ge ("null");

  at_ca JC_TRUE  = jy_ge ("true");
  at_ca JC_FALSE = jy_ge ("false");

  auto jy_gm ( zt_o(x_oj), at_cr(CgQS) xr_nm, at_cr(QList<jobject>) xr_args ) { // (g)roovy invoke (m)ethod
    static at_ca ysu_mi = jf_mi ( jf_fc ("javax/script/Invocable"), "invokeMethod", "(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;" );
    return jf_om ( GC_GR, ysu_mi, x_oj, jf_ns (xr_nm), jf_noa ( CjObject, xr_args ) );
  }
  auto jy_gc ( zt_o(x_closure), at_cr(QList<jobject>) xr_args ) { // (g)roovy invoke (c)losure
    return jy_gm ( x_closure, "call", xr_args );
  }
  auto jy_gf ( at_cr(CgQS) xr_nm, at_cr(QList<jobject>) xr_args ) { // (g)roovy invoke (f)unction
    static at_ca ysu_mi = jf_mi ( jf_fc ("javax/script/Invocable"), "invokeFunction", "(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;" );
    return jf_om ( GC_GR, ysu_mi, jf_ns (xr_nm), jf_noa ( CjObject, xr_args ) );
  }

  ap_br (
    at_ca pu_dt_fmt = "yyyy-MM-dd HH:mm:ss";
    jy_ge ( CgQS ( "GC_ST = new Date () .parse ( '%1', '%2' )" ) .arg ( pu_dt_fmt, GC_ST .toString (pu_dt_fmt) ) );
    jy_ge ( CgQS ( R"(
      GC_EC_NONE     = %1
      GC_EC_SHUTDOWN = %2
      GC_EC_SUCCESS  = %3
      GC_EC_ERROR    = %4
    )" ) .arg ( CgQSn(GC_EC_NONE), CgQSn(GC_EC_SHUTDOWN), CgQSn(GC_EC_SUCCESS), CgQSn(GC_EC_ERROR) ) );
    jy_ge ( CgQS ( "GC_THIS_PID = %1" ) .arg ( CgQSn(GC_THIS_PID) ) );
    jy_ge ( "gp_puts = { final x_str -> println x_str }" );
    jy_ge ( R"(
      GC_LOG = org.slf4j.LoggerFactory .getILoggerFactory () .with { bx2_lc ->
        reset ()
        getLogger ("GC_LOG") .with { bx3_log ->
          addAppender ( new ch.qos.logback.core.ConsoleAppender () .with { bx4_ca ->
            setContext (bx2_lc)
            setEncoder ( new ch.qos.logback.classic.encoder.PatternLayoutEncoder () .with {
              setContext (bx2_lc)
              setPattern ( "[${ String.format ( '%06d', GC_THIS_PID ) },%.-1level,%date{yyMMdd-HHmmss}] %msg%n" )
              start ()
              it
            } )
            start ()
            bx4_ca
          } )
          bx3_log
        }
      }
      gp_set_log_level_to_info = { GC_LOG.level = ch.qos.logback.classic.Level.INFO }
      gp_set_log_level_to_debug = { GC_LOG.level = ch.qos.logback.classic.Level.DEBUG }
      gp_set_log_level_to_trace = { GC_LOG.level = ch.qos.logback.classic.Level.TRACE }
      gp_set_log_level_to_debug ()
      gp_log_array = { final xp_out = GC_LOG.&info, final x_title, final x_array ->
        xp_out "${x_title} => "
        x_array.eachWithIndex { final bx2_it, final bx2_idx -> xp_out "  ${ (bx2_idx+1) .toString() .padLeft(2) } : $bx2_it" }
      }
      gp_log_header = { final xp_out = GC_LOG.&info, final x_header, final x_line_width = 60 ->
        xp_out '+' + '-' * x_line_width
        xp_out ": ${x_header}"
        xp_out '+' + '-' * x_line_width
      }
      gp_log_exception = { final xp_out = GC_LOG.&error, final x_title, final x_ex ->
        gp_log_header xp_out, x_title
        x_ex .each { xp_out "  ${it}" }
      }
      gp_request_exit = { final int x_ec, final x_ex = [] ->
        def pp2_before_exit = {
          if (x_ex) gp_log_exception "Following error occurs !!!", x_ex
          if ( x_ec != GC_EC_SUCCESS && !x_ex ) { gp_log_header ( GC_LOG.&error, "Unknown error occurs !!!" ); }
          switch (x_ec) {
            case GC_EC_NONE : GC_LOG .error "Undefined exit code (GC_EC_NONE), check your logic !!!"; break
            case GC_EC_SHUTDOWN : GC_LOG .info "Exit code from shutdown like ctrl+c, ..."; break
            default :
              if ( x_ec < 0 ) GC_LOG .error "Negative exit code ${x_ec}, should consider using a positive value !!!"
              else GC_LOG .info "Exit code => ${x_ec}"
              break
          }
          GC_LOG .info "Elapsed ${ ( new Date () .getTime () - GC_ST .getTime () ) / 1000.0 } ..."
        }
        def pp2_exit = {
          switch (x_ec) {
            case GC_EC_NONE : System .exit (GC_EC_ERROR); break
            case GC_EC_SHUTDOWN : break
            default :
              if ( x_ec < 0 ) System .exit (GC_EC_ERROR)
              else System .exit (x_ec)
              break
          }
        }
        pp2_before_exit ()
        pp2_exit ()
      }
      addShutdownHook { gp_request_exit GC_EC_SHUTDOWN, [ 'Shutdown occurred !!!' ] }
    )" );
  );
  void jp_puts ( at_cr(CgQS) xr_str ) { jy_gf ( "gp_puts", { jf_ns (xr_str) } ); }
  at_ca __jau_log = jy_ge ("GC_LOG");
  void jp_set_log_level_to_info ()  { jy_gf ( "gp_set_log_level_to_info",  {} ); }
  void jp_set_log_level_to_debug () { jy_gf ( "gp_set_log_level_to_debug", {} ); }
  void jp_set_log_level_to_trace () { jy_gf ( "gp_set_log_level_to_trace", {} ); }
  namespace JC_LOG {
    void info  ( at_cr(CgQS) xr_msg ) { jy_gm ( __jau_log, "info",  { jf_ns (xr_msg) } ); }
    void error ( at_cr(CgQS) xr_msg ) { jy_gm ( __jau_log, "error", { jf_ns (xr_msg) } ); }
    void trace ( at_cr(CgQS) xr_msg ) { jy_gm ( __jau_log, "trace", { jf_ns (xr_msg) } ); }
    void debug ( at_cr(CgQS) xr_msg ) { jy_gm ( __jau_log, "debug", { jf_ns (xr_msg) } ); }
    void warn  ( at_cr(CgQS) xr_msg ) { jy_gm ( __jau_log, "warn",  { jf_ns (xr_msg) } ); }
  }
  void jp_log_array ( void xp_out (at_cr(CgQS)), at_cr(CgQS) xr_title, at_cr(QStringList) xr_lst ) {
    if ( ! xr_title .isEmpty () ) { xp_out ( CgQS ( "%1 :" ) .arg (xr_title) ); }
    for ( auto bl2_idx = 0; bl2_idx < xr_lst .size (); ++bl2_idx ) {
      xp_out ( CgQS ( "  %1 => %2" ) .arg ( CgQSn (bl2_idx+1) .rightJustified (2), xr_lst .at (bl2_idx) ) );
    }
  }
  void jp_log_array ( at_cr(CgQS) xr_title, at_cr(QStringList) xr_lst ) { jp_log_array ( & JC_LOG::info, xr_title, xr_lst ); }
  void jp_log_header ( void xp_out (at_cr(CgQS)), at_cr(CgQS) xr_header, at_c(int) x_line_width = 60 ) {
    at_ca pu_ln = CgQS ('-') .repeated (x_line_width);
    xp_out ( CgQS ( "+%1" ) .arg (pu_ln) );
    xp_out ( CgQS ( ": %1" ) .arg (xr_header) );
    xp_out ( CgQS ( "+%1" ) .arg (pu_ln) );
  }
  void jp_log_header ( at_cr(CgQS) xr_header, at_c(int) x_line_width = 60 ) { jp_log_header ( & JC_LOG::info, xr_header, x_line_width ); }
  void jp_log_exception ( void xp_out (at_cr(CgQS)), at_cr(CgQS) xr_title, at_cr(QStringList) xr_ex ) {
    jp_log_header ( xp_out, xr_title );
    foreach ( at_ca & br2_it, xr_ex ) { xp_out (br2_it); }
  }
  void jp_log_exception ( at_cr(CgQS) xr_title, at_cr(QStringList) xr_ex ) { jp_log_exception ( & JC_LOG::error, xr_title, xr_ex ); }

  namespace __DjExit {
    void __dap_before_exit () {
      at_ca pu_ec = __DgExit::__dav_ec;
      at_ca pu_ex = __DgExit::__dav_ex;
      if ( ! pu_ex .isEmpty () ) { jp_log_exception ( & JC_LOG::error, "Following error occurs !!!", pu_ex ); }
      if ( pu_ec != GC_EC_SUCCESS && pu_ex .isEmpty () ) { jp_log_header ( & JC_LOG::error, "Unknown error occurs !!!" ); }
      switch (pu_ec) {
        case GC_EC_NONE : JC_LOG::error ( "Undefined exit code (GC_EC_NONE), check your logic !!!" ); break;
        case GC_EC_SHUTDOWN : JC_LOG::info ( "Exit code from shutdown like ctrl+c, ..." ); break;
        default :
          if ( pu_ec < 0 ) { JC_LOG::error ( CgQS ( "Negative exit code (%1), should consider using a positive value !!!" ) .arg (pu_ec) ); } 
          else { JC_LOG::info ( CgQS ( "Exit code => %1" ) .arg (pu_ec) ); }
          break;
      }
      JC_LOG::info ( CgQS ( "Elapsed %1 ..." ) .arg ( GC_ST .msecsTo ( QDateTime::currentDateTime () ) / 1000.0 ) );
    }
    void dp_it ( at_c(int) x_ec, at_cr(QStringList) xr_ex ) {
      if ( __DgExit::__dav_was_lgcx_processed == false ) {
        __DgExit::__dav_was_lgcx_processed = true;
        __DgExit::__dav_ec = x_ec;
        __DgExit::__dav_ex = xr_ex;
        __dap_before_exit ();
        __DgExit::__dap_exit ();
      }
    }
  }

  #define zf_qo(xt_qo) ( long long ) xt_qo
  #define ZC_QO zf_qo (this)

  void gp_init () {
    jy_ge ( CgQS ( "GC_QAPP = %1" ) .arg ( zf_qo (qApp) ) );
    __gav_gp_init_was_done = true;
  }

  void gp_request_exit ( at_c(int) x_ec, at_cr(QStringList) xr_ex ) {
    if ( __gav_gp_init_was_done ) {
      __DjExit::dp_it ( x_ec, xr_ex );
    } else {
      __DgExit::dp_it ( x_ec, xr_ex );
    }
  }

  class __CgQnProcessor : public QObject {
    Q_OBJECT
  public :
    explicit __CgQnProcessor () : QObject (Q_NULLPTR) { jy_ge ( CgQS ( "GC_QN_PROCESSOR = %1" ) .arg (ZC_QO) ); }
    zt_call cn_do () { jy_ge ( "gp_qn_from_queue ()" ); }
  };
  auto * __gatl_xx = new __CgQnProcessor ();
  ap_br (
    jy_ge ( CgQS ( R"(
      gp_sr = { final Closure xp_it -> javax.swing.SwingUtilities .invokeLater { xp_it () } }
      __gau_queue_4_%1 = []
      __gau_lock_4_%1 = new Object ()
      %1 = { final int x_ct = DgQt.DC_CT_DC, final long x_qo, final String x_mn, final Object... x_args ->
        final pu_caller_tid = gf_tid ()
        final pu_nargs = x_args .size ()
        final PC_MAX_NARGS = 10

        if ( pu_nargs > 0 && GC_THIS_TID != pu_caller_tid ) {
          synchronized (__gau_lock_4_%1) {
            __gau_queue_4_%1 << [ x_ct, x_qo, x_mn, x_args ]
            if (GC_QN_PROCESSOR) { DgQt .dp_i0 ( GC_QN_PROCESSOR, 'cn_do', DgQt.DC_CT_QC ) }
          }
          return
        }
        switch (pu_nargs) {
          case 0 .. PC_MAX_NARGS :
            DgQt ."dp_i${pu_nargs}" ( x_qo, x_mn, x_ct, *x_args )
            break
          default :
            gp_request_exit GC_EC_ERROR, [ "Maximum size of x_args of %1 must be ${PC_MAX_NARGS}" ]
            break
        }
      }
      %1_from_queue = { -> 
        synchronized (__gau_lock_4_%1) {
          __gau_queue_4_%1 .each {
            def ( bu2_ct, bu2_qo, bu2_mn, bu2_args ) = it
            %1 ( bu2_ct, bu2_qo, bu2_mn, *bu2_args )
          }
          __gau_queue_4_%1 .clear ()
        }
      } 
    )" ) .arg ("gp_qn") );
  );

  ap_br (
    jy_ge ( R"(
      gp_xr = { final Closure xp_it -> javafx.application.Platform .runLater { xp_it () } }
      class CgFxApp extends javafx.application.Application {
        private static Closure __casp_start
        static void csn_launch ( final Closure xp_it ) { __casp_start = xp_it; launch this }
        void start ( final javafx.stage.Stage x_stage ) { __casp_start ( this, x_stage ) }
      }
    )" );
  );

  ap_br ( signal ( SIGINT, [] ( int xl_sig_num ) { __DgExit::dp_it ( xl_sig_num, { CgQS ( "Interrupt signal (%1) received !!!" ) .arg ( CgQSn (xl_sig_num) ) } ); } ); );
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
    jp_puts ( __gaf_banner () .join ('\n') );
    JC_LOG::debug ( CgQS ( "Pyja name => %1" ). arg (GC_PYJA_NM) );
    if ( GC_PYJA_NM != gf_os_env ("SC_PYJA_NM") ) { ap_throw ( "Invalid Pyja name" ); }
    JC_LOG::debug ( CgQS ( "Pyja creation date => %1" ) .arg (GC_PYJA_CD) );
    if ( ! gf_str_is_valid_date ( GC_PYJA_CD, "yyyy.MM.dd" ) ) { ap_throw ( "Pyja create date is not invalid !!!" ); }
    JC_LOG::debug ( CgQS ( "Pyja version => %1" ) .arg (GC_PYJA_V2) );
    JC_LOG::info  ( CgQS ( "Pyja root (%1) => %2" ) .arg ( GC_PYJA_RT_SYM,  gf_2uhs (GC_PYJA_RT) ) );
    JC_LOG::info  ( CgQS ( "Pyja home (%1) => %2" ) .arg ( GC_PYJA_HM_SYM, gf_2prs (GC_PYJA_HM) ) );
    JC_LOG::info  ( CgQS ( "Milo path (%1) => %2" ) .arg ( GC_MILO_PN_SYM, gf_2phs (GC_MILO_PN) ) );
    JC_LOG::info  ( CgQS ( "Qt home => %1" ) .arg (GC_QT_HM) );
    JC_LOG::debug ( CgQS ( "Qt version => %1" ) .arg (QT_VERSION_STR) );
    JC_LOG::info  ( CgQS ( "Java home => %1" ) .arg (GC_JAVA_HM) );
    JC_LOG::info  ( CgQS ( "Groovy version => %1" ) .arg (GC_GROOVY_VR) );
    JC_LOG::debug ( CgQS ( "Current user home (%1) => %2" ) .arg ( GC_CUSR_HM_SYM, GC_CUSR_HM ) );
    JC_LOG::debug ( CgQS ( "Computer name => %1" ) .arg (GC_HOST_NM) );
    JC_LOG::debug ( CgQS ( "Process ID => %1" ) .arg ( CgQSn (GC_THIS_PID) ) );
    JC_LOG::debug ( CgQS ( "Executable file => %1" ) .arg ( gf_2phs (AC_THIS_EXE_FN) ) );
    JC_LOG::debug ( CgQS ( "Start up path => %1" ) .arg ( gf_2phs (GC_THIS_START_UP_PN) ) );
    jp_log_array ( & JC_LOG::debug, "Paths", GC_OS_ENV_PATHS );
    if ( AC_CMD .size () > 0 ) jp_log_array ( & JC_LOG::debug, "Command", AC_CMD );
    if ( AC_ARGV .size () > 0 ) jp_log_array ( "Arguments", AC_ARGV );
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
#include <QObject>

class WMain : public QObject {
  Q_OBJECT
public :
  explicit WMain () : QObject (Q_NULLPTR) { wn_init (); }
  void wn_init () { jy_ge ( CgQS ( R"(
    import javax.swing.*
    import java.awt.event.*
    import java.awt.*

    { ->
      final def bu2_qo = %1
      final def bu2_fm
      final def bu2_lb_header
      final def bu2_pl_control
      final def bu2_bn_ok
      final def bu2_lb_status

      def bv2_cnt = 0

      def pp3_new_main_fm = { ->
        bu2_fm = new JFrame () .with {
          setTitle GC_APP_NM
          setSize 400, 400
          setLayout new GridLayout ( 3, 1 )
          setLocationRelativeTo null
          addWindowListener ( [
            windowClosing : { gp_qn GC_QAPP, 'quit' }
          ] as WindowAdapter )
          setVisible true
          it
        }
        bu2_lb_header = new JLabel ( 'This is JFrame with GridLayout', JLabel.CENTER )
        bu2_pl_control = new JPanel ( layout : new FlowLayout () )
        bu2_bn_ok = new JButton ( "Click me with count ${bv2_cnt+1}" ) .with {
          it .actionPerformed = {
            bv2_cnt ++
            gp_qn bu2_qo, 'wn_bn_ok', bu2_bn_ok, bu2_fm, bu2_lb_status, bv2_cnt
          }
          bu2_pl_control .add it
          it
        }
        bu2_lb_status = new JLabel ( text : '', horizontalAlignment : JLabel.CENTER, size : [ 350, 100 ] )
        [ bu2_lb_header, bu2_pl_control, bu2_lb_status ] .each { bu2_fm .add it }
      }

      pp3_new_main_fm ()
    } ()
  )" ) .arg (ZC_QO) ); }
  zt_call wn_bn_ok ( zt_o(x_bn_ok), zt_o(x_fm), zt_o(x_lb_status), zt_o(x_cnt) ) {
    jy_gm ( x_fm, "setTitle", { jf_ns ( CgQS ( "%1 (%2)" ) .arg ( GC_APP_NM, CgQSn ( jf_i (x_cnt) ) ) ) } );
    jy_gm ( x_lb_status, "setText", { jf_ns ( CgQS ( "(%1) Hello Swing from Qt" ) .arg ( jf_i (x_cnt) ) ) } );
    jy_gm ( x_bn_ok, "setText", { jf_ns ( CgQS ( "Click me with count %1" ) .arg ( jf_i (x_cnt) + 1 ) ) } );
  }
};

#include "S02-Swing-GridLayout.moc"

namespace DBody {
  int df_it () {
    QTimer::singleShot ( 0, [] { new WMain (); } );
    return AC_QAPP .exec ();
  }
}

namespace OStart {
  void main () {
    // jp_set_log_level_to_info ();
    DRun::dp_it ();
  }
}

int main ( int xl_argc, char * xtl_argv [] ) {
  at_c(QApplication) fu_app ( xl_argc, xtl_argv );
  gp_init ();
  OStart::main ();
}

