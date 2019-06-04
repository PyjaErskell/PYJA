#include <SToa.h>

#include <functional>
#include <iostream>
#include <memory>
#include <mutex>
#include <string>
#include <thread>

#include <QApplication>
#include <QCoreApplication>
#include <QDateTime>
#include <QDebug>
#include <QDesktopWidget>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QHostInfo>
#include <QMainWindow>
#include <QMetaObject>
#include <QObject>
#include <QPushButton>
#include <QScreen>
#include <QtCore>
#include <QTextStream>
#include <QTimer>
#include <QVBoxLayout>

Q_DECLARE_METATYPE(jobject)

//---------------------------------------------------------------
// Global
//---------------------------------------------------------------

namespace Global {
  const auto GC_QT_VR = QT_VERSION_STR;

  auto qf_to_css ( const QString & xru_qstr ) { return xru_qstr .toStdString (); } // Qt String to C++ Standard String
  auto qf_to_cs ( const QString & xru_qstr ) { return xru_qstr .toStdString () .c_str (); } // Qt String to C String

  template < class T > class CgLazy {
    public:
      CgLazy () : __cavf_init ( [] () { T fv_it {}; return fv_it; } ) {}
      CgLazy ( std ::function < T () > xvf_initializer ) : __cavf_init ( std ::move (xvf_initializer) ) {}
      T * operator -> () const { return __cam_operate (); }
      T & operator * () { return * __cam_operate (); }
      const T & operator * () const { return * __cam_operate (); }
      CgLazy ( CgLazy && xrrv_other ) noexcept { // rrv = (r) value (r)eference (v)ariable
        std ::lock_guard < std ::mutex > lock (xrrv_other.__cav_mtx);
        if ( ! xrrv_other.__cav_was_init ) {
          __cavf_init = move (xrrv_other.__cavf_init);
          __cav_was_init = false;
        } else {
          __cavf_init = move (xrrv_other.__cavf_init);
          __cav_was_init = true;
          __cav_ptr = move (xrrv_other.__cav_ptr);
        }
      }
      CgLazy & operator = ( std ::function < T () > xvf_it ) noexcept { return * this = CgLazy <T> ( std ::move (xvf_it) ); }
      CgLazy & operator = ( CgLazy && xrrv_other) noexcept {
        std ::lock_guard < std ::mutex > lock1 (__cav_mtx);
        std ::lock_guard < std ::mutex > lock2 (xrrv_other.__cav_mtx);
        if (!xrrv_other.__cav_was_init) {
          __cavf_init = move (xrrv_other.__cavf_init);
          __cav_was_init = false;
        } else {
          __cavf_init = move (xrrv_other.__cavf_init);
          __cav_was_init = true;
          __cav_ptr = move (xrrv_other.__cav_ptr);
        }
        return *this;
      }
    private:
      T * __cam_operate () const {
        std ::lock_guard < std ::mutex > lock(__cav_mtx);
        if (!__cav_was_init) {
          __cav_ptr = std ::unique_ptr <T> ( new T ( __cavf_init () ) );
          __cav_was_init = true;
        }
        return __cav_ptr .get ();
      }
      mutable std ::mutex __cav_mtx;
      mutable bool __cav_was_init = false;
      std ::function < T () > __cavf_init;
      mutable std ::unique_ptr <T> __cav_ptr;
  };

  JNIEnv * jtl_jnv = nullptr;

  #define zy(x_it) ( jtl_jnv ->x_it )

  auto __jaf_na ( const std ::list <jobject> & xru_lst ) { // (n)ew java object (a)rray
    static const auto fsu_cls = zy ( FindClass ( "java/lang/Object" ) );
    const auto fu_it = zy ( NewObjectArray ( xru_lst .size (), fsu_cls, NULL ) );
    auto fv_jo = xru_lst .begin ();
    for ( jsize bv2_idx = 0; bv2_idx < (jsize) ( xru_lst .size () ); ++bv2_idx ) {
      zy ( SetObjectArrayElement ( fu_it, bv2_idx, *fv_jo ) );
      fv_jo ++;
    }
    return fu_it;
  }
  auto __jay_oy ( const jobject x_jo, const jmethodID x_mi, ... ) { // call (o)bject (m)ethod
    va_list fl_args;
    va_start ( fl_args, x_mi );
    const auto fu_jo = zy ( CallObjectMethodV ( x_jo, x_mi, fl_args ) );
    va_end (fl_args);
    return fu_jo;
  }

  auto __jaf_to_css ( const jobject x_jstr ) { // Java String to C++ Standard String
    const auto fu_jstr = (jstring) x_jstr;
    jboolean fv_is_copy = false;
    const char * ftl_utf = zy ( GetStringUTFChars ( fu_jstr, & fv_is_copy ) );
    auto fl_css = std ::string (ftl_utf);
    zy ( ReleaseStringUTFChars ( fu_jstr, ftl_utf ) );
    return fl_css;
  }

  auto jf_i ( const jobject x_jo ) {
    static const auto fsu_cls = zy ( FindClass ( "java/lang/Integer") );
    static const auto fsu_mi = zy ( GetMethodID ( fsu_cls, "intValue", "()I" ) );
    return zy ( CallIntMethod ( x_jo, fsu_mi ) );
  }
 
  auto jf_ns ( const char * xtl_str ) { return zy ( NewStringUTF (xtl_str) ) ; }

  jobject __jal_gr; // (Gr)oovy

  const auto JTC_GR = CgLazy <jobject> ( [] () { return __jal_gr; } );

  auto jy_ge ( const char * xtl_script ) { // (g)roovy (e)val
    static const auto ysu_mi = zy ( GetMethodID ( zy ( FindClass ("javax/script/ScriptEngine") ), "eval", "(Ljava/lang/String;)Ljava/lang/Object;" ) );
    return __jay_oy ( * JTC_GR, ysu_mi, jf_ns (xtl_script) );
  }
  auto jy_ge ( const QString & xru_script ) { return jy_ge ( qf_to_cs (xru_script) ); }
  auto jy_gf ( const char * xtl_function_nm, const std ::list <jobject> & xru_args = {} ) { // (g)roovy invoke (f)unction
    static const auto ysu_mi = zy (  GetMethodID ( zy ( FindClass ("javax/script/Invocable") ), "invokeFunction", "(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;" ) );
    return __jay_oy ( * JTC_GR, ysu_mi, jf_ns (xtl_function_nm), __jaf_na (xru_args) );
  }
  auto jf_gg ( const char * xtl_key ) { // (g)roovy (g)et
    static const auto ysu_mi = zy (  GetMethodID ( zy ( FindClass ("javax/script/ScriptEngine") ), "get", "(Ljava/lang/String;)Ljava/lang/Object;" ) );
    return __jay_oy ( * JTC_GR, ysu_mi, jf_ns (xtl_key) );
  }
  auto jf_gg ( const QString & xru_key ) { return jf_gg ( qf_to_cs (xru_key) ); }
  auto jp_gp ( const char * xtl_key, const jobject x_val ) { // (g)roovy put
    static const auto ysu_mi = zy (  GetMethodID ( zy ( FindClass ("javax/script/ScriptEngine") ), "put", "(Ljava/lang/String;Ljava/lang/Object;)V" ) );
    return __jay_oy ( * JTC_GR, ysu_mi, jf_ns (xtl_key), x_val );
  }
  auto jp_gp ( const QString & xru_key , const jobject x_val ) { jp_gp ( qf_to_cs (xru_key), x_val ); }

  void jp_println ( const char * xtl_msg ) { jy_gf ( "gp_println", { jf_ns (xtl_msg) } ); }
  void jp_println ( const jobject x_jo ) { jy_gf ( "gp_println", {x_jo} ); }

  auto jf_joc ( const jobject x_jo ) { return jy_gf ( "gf_joc", {x_jo} ); }
  auto jf_cls ( const char * xtl_nm ) { return jy_gf ( "gf_cls", { jf_ns (xtl_nm) } ); }
  auto jf_to_s ( const jobject x_jo ) { return jy_gf ( "gf_to_s", {x_jo} ); }
  auto jf_sf ( const char * xtl_format, const std ::list <jobject> & xru_args ) { return jy_gf ( "gf_sf", { jf_ns (xtl_format), __jaf_na (xru_args) } ); } // String .format
  auto jy_oy ( const jobject x_jo, const char * xtl_yethod_nm, const std ::list <jobject> & xru_args = {} ) { return jy_gf ( "gy_oy", { x_jo, jf_ns (xtl_yethod_nm), __jaf_na (xru_args) } ); }
  #define JOY jy_oy
  auto jf_to_ths ( const char * xtl_it ) { return __jaf_to_css ( ( jy_gf ( "gf_to_ths", { jf_ns (xtl_it) } ) ) ); }
  auto jf_new ( const jobject x_cls, const std ::list <jobject> & xru_args = {} ) { return JOY ( x_cls, "newInstance", xru_args ); }
  auto jf_to_css ( const jobject x_jo ) { return __jaf_to_css ( jf_to_s (x_jo) ); } // Java Object to C++ Standard String
  auto jf_to_cs ( const jobject x_jo ) { return jf_to_css (x_jo) .c_str (); } // Java Object to C String
  auto jf_to_qs ( const jobject x_jo ) { return QString ::fromUtf8 ( jf_to_cs (x_jo) ); } // Java Object to QString
  
  auto jf_ni ( const int x_int ) { return jy_ge ( QString ("new Integer (%1)") .arg ( QString ::number (x_int) ) ); } // Create Java Integer
  auto jf_nl ( const long x_long ) { return jy_ge ( QString ("new Long (%1)") .arg ( QString ::number (x_long) ) ); } // Create Java Long
  auto jf_nd ( const double x_double ) { return jy_ge ( QString ("new Double (%1)") .arg ( QString ::number (x_double) ) ); } // Create Java Double

  #define zf_wai(x_msg) ( std ::string (__PRETTY_FUNCTION__) ) .append (" [") .append ( jf_to_ths (__FILE__) ) .append (":") .append ( jf_to_css ( jf_sf ( "%04d", { jf_ni (__LINE__) } ) ) ) .append ("] ") .append (x_msg) .c_str ()

  const auto JTC_AS = CgLazy <jobject> ( [] () { return jf_gg ("GC_AS"); } ); // (A)ctor(S)ystem
  const auto __jatu_log = CgLazy <jobject> ( [] () { return jf_gg ("GC_LOG"); } );

  namespace JC_LOG {
    void info  ( const char * xtl_msg ) { JOY ( * __jatu_log, "info",  { jf_ns (xtl_msg) } ); }
    void info  ( const char * xtl_msg, const std ::list <jobject> & xru_args ) { JOY ( * __jatu_log, "info",  { jf_ns (xtl_msg), __jaf_na (xru_args) } ); }
    void info  ( const jobject x_jo ) { JOY ( * __jatu_log, "info",  { jf_to_s (x_jo) } ); }
    void error ( const char * xtl_msg ) { JOY ( * __jatu_log, "error", { jf_ns (xtl_msg) } ); }
    void error ( const char * xtl_msg, const std ::list <jobject> & xru_args ) { JOY ( * __jatu_log, "error",  { jf_ns (xtl_msg), __jaf_na (xru_args) } ); }
    void error ( const jobject x_jo ) { JOY ( * __jatu_log, "error",  { jf_to_s (x_jo) } ); }
    void trace ( const char * xtl_msg ) { JOY ( * __jatu_log, "trace", { jf_ns (xtl_msg) } ); }
    void trace ( const char * xtl_msg, const std ::list <jobject> & xru_args ) { JOY ( * __jatu_log, "trace",  { jf_ns (xtl_msg), __jaf_na (xru_args) } ); }
    void trace ( const jobject x_jo ) { JOY ( * __jatu_log, "trace",  { jf_to_s (x_jo) } ); }
    void debug ( const char * xtl_msg ) { JOY ( * __jatu_log, "debug", { jf_ns (xtl_msg) } ); }
    void debug ( const char * xtl_msg, const std ::list <jobject> & xru_args ) { JOY ( * __jatu_log, "debug",  { jf_ns (xtl_msg), __jaf_na (xru_args) } ); }
    void debug ( const jobject x_jo ) { JOY ( * __jatu_log, "debug",  { jf_to_s (x_jo) } ); }
    void warn  ( const char * xtl_msg ) { JOY ( * __jatu_log, "warn",  { jf_ns (xtl_msg) } ); }
    void warn  ( const char * xtl_msg, const std ::list <jobject> & xru_args ) { JOY ( * __jatu_log, "warn",  { jf_ns (xtl_msg), __jaf_na (xru_args) } ); }
    void warn  ( const jobject x_jo ) { JOY ( * __jatu_log, "warn",  { jf_to_s (x_jo) } ); }
  }

  #define zf_lazy_cls(x_cls_nm) CgLazy <jobject> ( [] () { return jf_cls (#x_cls_nm); } )
  
  const auto CjtDouble = zf_lazy_cls (java.lang.Double);
  const auto CjtException = zf_lazy_cls (java.lang.Exception);
  const auto CjtInteger = zf_lazy_cls (java.lang.Integer);
  const auto CjtLong = zf_lazy_cls (java.lang.Long);
  const auto CjtObject = zf_lazy_cls (java.lang.Object);
  const auto CjtString = zf_lazy_cls (java.lang.String);

  void jp_tr ( const jobject x_cls, const char * xtl_msg ) { zy ( ThrowNew ( (jclass) x_cls, xtl_msg ) ); }

  void jp_request_exit ( const jobject x_ec, const std ::list <jobject> & xru_ex = {} ) { jy_gf ( "gp_request_exit", { x_ec, __jaf_na (xru_ex) } ); }

  void jp_sa ( const jobject x_jo, const char * xtl_a_nm, const jobject x_value ) { jy_gf ( "gp_sa", { x_jo, jf_ns (xtl_a_nm), x_value } ); }
  auto jf_ga ( const jobject x_jo, const char * xtl_a_nm ) { return jy_gf ( "gf_ga", { x_jo, jf_ns (xtl_a_nm) } ); }

  const auto GTC_QAPP = ( [] () {
    int fl_argc = 0;
    char * ftl_argv [] = {};
    return new QApplication ( fl_argc, ftl_argv );
  }) ();
}

//---------------------------------------------------------------
// Your Source
//---------------------------------------------------------------

using namespace Global;

class WMain : public QMainWindow {
  Q_OBJECT
public :
  explicit WMain () : QMainWindow (Q_NULLPTR) { __wan_init (); }
protected :
  void showEvent ( QShowEvent * xtl_ev ) {
    JC_LOG ::info ( zf_wai ( "Entering ..." ) );
    QMainWindow ::showEvent (xtl_ev);
    QMetaObject ::invokeMethod ( this, "__waon_after_shown", Qt::ConnectionType::QueuedConnection );
    JC_LOG ::info ( zf_wai ( "Leaving ..." ) );
  }
  void closeEvent ( QCloseEvent * ) {
    JC_LOG ::info ( zf_wai ( "Entering ..." ) );
    __wan_quit ();
    JC_LOG ::info ( zf_wai ( "Leaving ..." ) );
  }
private :
  QPushButton * __watl_pb;
  jobject __wal_integer;
  QTimer * __watl_timer;
  void __wan_init () {
    JC_LOG ::info ( zf_wai ( "Entering ..." ) );

    auto ntl_cw = new QWidget ();
    auto ntl_lo = new QVBoxLayout ();
    __watl_pb = new QPushButton ();

    __wal_integer = jf_new ( jf_cls ("CInteger") );
    __wan_set_pb_text ( JOY ( __wal_integer, "cm_current" ) );
    connect ( __watl_pb, & QPushButton ::clicked, [&] () { 
      JC_LOG ::info ( qf_to_cs ( __watl_pb ->text () ) );
      __wan_set_pb_text ( JOY ( __wal_integer, "cm_next" ) );
    } );
    __watl_pb ->setSizePolicy ( QSizePolicy ::Expanding, QSizePolicy ::Fixed );
    ntl_lo ->addWidget (__watl_pb);
    ntl_cw ->setLayout (ntl_lo);

    setWindowTitle ( jf_to_cs ( jf_gg ("GC_TONO_NM") ) );
    setCentralWidget (ntl_cw);
    resize ( 350, 150 );
    show ();
    raise ();
    __wan_move_center ();

    __watl_timer = new QTimer (this);
    connect ( __watl_timer, & QTimer ::timeout, [&] () { __watl_pb ->click (); } );

    JC_LOG ::info ( zf_wai ( "Leaving ..." ) );
  }
  void __wan_set_pb_text ( jobject xl_cnt ) { __watl_pb ->setText ( jf_to_qs ( jf_sf ( "Ciao, %,d !", { xl_cnt } ) ) ); }
  void __wan_move_center () {
    const auto nu_cp = QGuiApplication ::primaryScreen () ->geometry () .center (); // center point
    move ( nu_cp .x () - width () / 2, nu_cp .y () - height () / 2 );
  }
  void __wan_quit () {
    JC_LOG ::info ( zf_wai ( "About to quit ..." )  );
    jp_request_exit ( jf_gg ("GC_EC_SUCCESS") );
  }
private slots :
  void __waon_after_shown () {
    JC_LOG ::info ( zf_wai ( "Entering ..." ) );
    __watl_timer ->start (100);
    JC_LOG ::info ( zf_wai ( "Leaving ..." ) );
  }
};

#include "SToa.moc"

namespace DBody {
  void dp_it () {
    JC_LOG ::info  ( "Qt version => {}", { jf_ns (GC_QT_VR) } );
    new WMain ();
    GTC_QAPP -> exec ();
  }
}

JNIEXPORT void JNICALL Java_SToa_sp_1main ( JNIEnv * xtl_jnv, jclass, const jobject x_gr ) {
  jtl_jnv = xtl_jnv; __jal_gr = x_gr;
  DBody ::dp_it ();
}
