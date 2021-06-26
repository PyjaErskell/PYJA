#ifndef GMC_INCLUDED_201011_1558
#define GMC_INCLUDED_201011_1558

#include <iostream>
#include <jni.h>

#include <QApplication>
#include <QFileInfo>
#include <QFont>
#include <QFontDatabase>
#include <QListWidget>
#include <QMainWindow>
#include <QScreen>
#include <QTimer>
#include <QVBoxLayout>

#include <CgLazy.hpp>
#include <DgOriginalSorcePath.hpp>

// (g)lobal priv(a)te (m)acro (f)unction join two symbols
#define __gamf_join_sym_2( x_sym_1, x_sym_2 ) x_sym_1##x_sym_2
// (g)lobal (m)acro (f)unction join two symbols
#define gmf_join_sym_2( x_sym_1, x_sym_2 ) __gamf_join_sym_2( x_sym_1, x_sym_2 )
// line with prefix
#define gmf_line_prfx(x_prfx) gmf_join_sym_2 ( x_prfx, __LINE__ )
// (g)lobal (m)acro (p)rocedure (b)lock (r)un
#define gmp_br(x_block) auto gmf_line_prfx (_) = [] { x_block; return true; } ()

namespace Global {
  extern QApplication * gtl_qapp;
  extern std::string gf_os_env ( const std::string & );
  extern void gp_set_app_font ( const QString & );
  extern JavaVM * jtl_jvm;
  extern JNIEnv * jtl_jnv;
  extern jclass JL_CLS_OBJECT;
  extern jclass JL_CLS_INTEGER;
  extern jclass JL_CLS_LONG;
  extern jclass JL_CLS_FLOAT;
  extern jclass JL_CLS_DOUBLE;
  extern jclass JL_CLS_SCRIPT_ENGINE_MANAGER;
  extern jclass JL_CLS_SCRIPT_ENGINE;
  extern jclass JL_CLS_INVOCABLE;
  extern jstring jf_jo2js ( const jobject ); // java object to java string using toString ()
  extern std::string jf_js2css ( const jstring ); // java string to c++ std::string
  #define jmf_jo2css(x_jo) jf_js2css ( jf_jo2js (x_jo) )
  extern void jp_tixo (); // (t)hrow (i)f e(x)ception (o)ccurred
  #define jmf_tixo(xm_it) [&] { const auto gmf_line_prfx(__fau_it_) = jtl_jnv -> xm_it; jp_tixo (); return gmf_line_prfx(__fau_it_); } ()
  #define jmp_tixo(xn_it) jtl_jnv -> xn_it, jp_tixo ()
  #define jmf_fc(...) jmf_tixo ( FindClass (__VA_ARGS__) )
  #define jmf_gmid(...) jmf_tixo ( GetMethodID (__VA_ARGS__) )
  #define jmf_com(...) jmf_tixo ( CallObjectMethod (__VA_ARGS__) )
  #define jmf_cim(...) jmf_tixo ( CallIntMethod (__VA_ARGS__) )
  #define jmf_clm(...) jmf_tixo ( CallLongMethod (__VA_ARGS__) )
  #define jmf_cfm(...) jmf_tixo ( CallFloatMethod (__VA_ARGS__) )
  #define jmf_cdm(...) jmf_tixo ( CallDoubleMethod (__VA_ARGS__) )
  #define jmf_no(...) jmf_tixo ( NewObject (__VA_ARGS__) )
  #define jmf_nsu(...) jmf_tixo ( NewStringUTF (__VA_ARGS__) )
  #define jmf_noa(...) jmf_tixo ( NewObjectArray (__VA_ARGS__) )
  #define jmp_soae(...) jmp_tixo ( SetObjectArrayElement (__VA_ARGS__) )
  extern jobject jf_ni ( const jint ); // (n)ew (I)nteger
  extern jobject jf_nl ( const jlong ); // (n)ew (L)ong
  extern jobject jf_nf ( const jfloat ); // (n)ew (F)loat
  extern jobject jf_nd ( const jdouble ); // (n)ew (D)ouble
  extern jint jf_iv ( const jobject ); // Class Integer's (i)nt(V)alue
  extern jlong jf_lv ( const jobject ); // Class Long's (l)ong(V)alue
  extern jfloat jf_fv ( const jobject ); // Class Float's (f)loat(V)alue
  extern jdouble jf_dv ( const jobject ); // Class Double's (d)ouble(V)alue
  extern jobjectArray jf_noa ( const std::list <jobject> & ); // (n)ew java (o)bject (a)rray
  extern jobject jf_script_engine ( const char * ); // create script engine by it's name
  extern jobject jf_gr_e ( const char * ); // (gr)oovy (e)val
  extern jobject jf_gr_if ( const char *, const std::list <jobject> & ); // groovy (i)nvoke (f)unction
  extern jobject jf_gr_g ( const char * ); // groovy (g)et
}

#endif
