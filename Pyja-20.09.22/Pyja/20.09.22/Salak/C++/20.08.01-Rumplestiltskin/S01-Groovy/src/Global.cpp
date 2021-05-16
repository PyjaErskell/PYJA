#include <Global.hpp>

namespace Global {
  gmp_br (
    std::cout << "Original source path (" << DgOriginalSorcePath::du_sym << ") => " << DgOriginalSorcePath::du_it << std::endl;
    std::cout << "Entering " << GMX_FILE << " ..." << std::endl;
  );

  QApplication * gtl_qapp;

  std::string gf_os_env ( const std::string & xru_key ) {
    const auto fu_r = std::getenv ( xru_key .c_str () );
    if ( fu_r == NULL ) { throw std::runtime_error ( "Can't find environment variable => " + xru_key + " !!!" ); }
    return fu_r;
  }

  void gp_set_app_font ( const QString & xru_fn ) {
    const auto pu_id = QFontDatabase::addApplicationFont (xru_fn);
    if ( pu_id < 0 ) return;
    const auto pu_family = QFontDatabase::applicationFontFamilies (pu_id) .at (0);
    auto pv_font = QFont (pu_family);
    QApplication::setFont (pv_font);
  }

  JavaVM * jtl_jvm = nullptr;
  JNIEnv * jtl_jnv = nullptr;
  gmp_br (
    std::cout << "Creating Java VM ..." << std::endl;
    const auto PC_SZ_OPTS = 3;
    const auto PC_XMX = gf_os_env ("SC_JAVA_XMX");
    const auto PC_CP = "-Djava.class.path=" + gf_os_env ("SC_JARS");
    JavaVMInitArgs pl_args;
    JavaVMOption pl_option [PC_SZ_OPTS];
    pl_option [0] .optionString = ( char * ) PC_XMX .c_str ();
    pl_option [1] .optionString = ( char * ) "-Dfile.encoding=UTF8";
    pl_option [2] .optionString = ( char * ) PC_CP .c_str ();
    pl_args.version = JNI_VERSION_1_8;
    pl_args.nOptions = PC_SZ_OPTS;
    pl_args.options = pl_option;
    pl_args.ignoreUnrecognized = JNI_FALSE;
    if ( JNI_CreateJavaVM ( & jtl_jvm, ( void ** ) & jtl_jnv, & pl_args ) != JNI_OK ) { throw std::runtime_error ( "Cannot create JVM !!!" ); }
  );
  jclass JL_CLS_OBJECT;
  jclass JL_CLS_INTEGER;
  jclass JL_CLS_LONG;
  jclass JL_CLS_FLOAT;
  jclass JL_CLS_DOUBLE;
  jclass JL_CLS_SCRIPT_ENGINE_MANAGER;
  jclass JL_CLS_SCRIPT_ENGINE;
  jclass JL_CLS_INVOCABLE;
  gmp_br (
    JL_CLS_OBJECT = jtl_jnv -> FindClass ("java/lang/Object");
    JL_CLS_INTEGER = jtl_jnv -> FindClass ("java/lang/Integer");
    JL_CLS_LONG = jtl_jnv -> FindClass ("java/lang/Long");
    JL_CLS_FLOAT = jtl_jnv -> FindClass ("java/lang/Float");
    JL_CLS_DOUBLE = jtl_jnv -> FindClass ("java/lang/Double");
    JL_CLS_SCRIPT_ENGINE_MANAGER = jtl_jnv -> FindClass ("javax/script/ScriptEngineManager");
    JL_CLS_SCRIPT_ENGINE = jtl_jnv -> FindClass ("javax/script/ScriptEngine");
    JL_CLS_INVOCABLE = jtl_jnv -> FindClass ("javax/script/Invocable");
  );
  jstring jf_jo2js ( const jobject x_jo ) {
    static const auto fsu_mid_2js = jtl_jnv -> GetMethodID ( JL_CLS_OBJECT, "toString", "()Ljava/lang/String;" );
    return (jstring) ( jtl_jnv -> CallObjectMethod ( x_jo, fsu_mid_2js ) );
  }
  std::string jf_js2css ( const jstring x_jstring ) {
    jboolean fv_is_copy = false;
    const char * ftl_utf = jtl_jnv -> GetStringUTFChars ( x_jstring, & fv_is_copy );
    auto fl_css = std::string (ftl_utf);
    jtl_jnv -> ReleaseStringUTFChars ( x_jstring, ftl_utf );
    return fl_css;
  }  
  void jp_tixo () {
    const auto pu_xo = jtl_jnv -> ExceptionOccurred ();
    if (pu_xo) { throw std::runtime_error ( jmf_jo2css (pu_xo) ); }
  }
  jobject jf_ni ( const jint x_int ) {
    static const auto fsu_mid_i_c = jmf_gmid ( JL_CLS_INTEGER, "<init>", "(I)V" );
    const auto fu_it = jmf_no ( JL_CLS_INTEGER, fsu_mid_i_c, x_int );
    if ( fu_it == NULL ) { throw std::runtime_error ( "Cannot create Integer => " + std::to_string (x_int) + " !!!" ); }
    return fu_it;
  }
  jobject jf_nl ( const jlong x_long ) {
    static const auto fsu_mid_l_c = jmf_gmid ( JL_CLS_LONG, "<init>", "(J)V" );
    const auto fu_it = jmf_no ( JL_CLS_LONG, fsu_mid_l_c, x_long );
    if ( fu_it == NULL ) { throw std::runtime_error ( "Cannot create Long => " + std::to_string (x_long) + " !!!" ); }
    return fu_it;
  }
  jobject jf_nf ( const jfloat x_float ) {
    static const auto fsu_mid_f_c = jmf_gmid ( JL_CLS_FLOAT, "<init>", "(F)V" );
    const auto fu_it = jmf_no ( JL_CLS_FLOAT, fsu_mid_f_c, x_float );
    if ( fu_it == NULL ) { throw std::runtime_error ( "Cannot create Float => " + std::to_string (x_float) + " !!!" ); }
    return fu_it;
  }
  jobject jf_nd ( const jdouble x_double ) {
    static const auto fsu_mid_d_c = jmf_gmid ( JL_CLS_DOUBLE, "<init>", "(D)V" );
    const auto fu_it = jmf_no ( JL_CLS_DOUBLE, fsu_mid_d_c, x_double );
    if ( fu_it == NULL ) { throw std::runtime_error ( "Cannot create Double => " + std::to_string (x_double) + " !!!" ); }
    return fu_it;
  }
  jint jf_iv ( const jobject x_jo ) {
    static const auto fsu_mid_i_iv = jmf_gmid ( JL_CLS_INTEGER, "intValue", "()I" );
    return jmf_cim ( x_jo, fsu_mid_i_iv );
  }
  jlong jf_lv ( const jobject x_jo ) {
    static const auto fsu_mid_l_lv = jmf_gmid ( JL_CLS_LONG, "longValue", "()J" );
    return jmf_clm ( x_jo, fsu_mid_l_lv );
  }
  jfloat jf_fv ( const jobject x_jo ) {
    static const auto fsu_mid_f_fv = jmf_gmid ( JL_CLS_FLOAT, "floatValue", "()F" );
    return jmf_cfm ( x_jo, fsu_mid_f_fv );
  }
  jdouble jf_dv ( const jobject x_jo ) {
    static const auto fsu_mid_d_dv = jmf_gmid ( JL_CLS_DOUBLE, "doubleValue", "()D" );
    return jmf_cdm ( x_jo, fsu_mid_d_dv );
  }
  jobjectArray jf_noa ( const std::list <jobject> & xru_lst ) {
    const auto fu_it = jmf_noa ( xru_lst .size (), JL_CLS_OBJECT, NULL );
    auto fv_jo = xru_lst .begin ();
    for ( jsize bv2_idx = 0; bv2_idx < (jsize) ( xru_lst .size () ); ++ bv2_idx ) {
      jmp_soae ( fu_it, bv2_idx, * fv_jo );
      fv_jo ++;
    }
    return fu_it;
  }
  jobject jf_script_engine ( const char * xtl_engine_nm ) {
    static const auto fsu_mid_sem_c = jmf_gmid ( JL_CLS_SCRIPT_ENGINE_MANAGER, "<init>", "()V" );
    static const auto fsu_mid_sem_gebn = jmf_gmid ( JL_CLS_SCRIPT_ENGINE_MANAGER, "getEngineByName", "(Ljava/lang/String;)Ljavax/script/ScriptEngine;" );
    const auto fu_it = jmf_com ( jmf_no ( JL_CLS_SCRIPT_ENGINE_MANAGER, fsu_mid_sem_c ), fsu_mid_sem_gebn, jmf_nsu (xtl_engine_nm) );
    if ( fu_it == NULL ) { throw std::runtime_error ( "Cannot create ScriptEngine => " + std::string (xtl_engine_nm) + " !!!" ); }
    return fu_it;
  }
  gmp_br ( std::cout << "Creating Groovy script engine ..." << std::endl; );
  const jobject __JAC_GR = jf_script_engine ("Groovy");
  jobject jf_gr_e ( const char * xtl_script ) {
    static const auto fsu_mid_se_eval = jmf_gmid ( JL_CLS_SCRIPT_ENGINE, "eval", "(Ljava/lang/String;)Ljava/lang/Object;" );
    return jmf_com ( __JAC_GR, fsu_mid_se_eval, jmf_nsu (xtl_script) );
  }
  gmp_br (
    jf_gr_e ( R"PASH_EOS(
//---------------------------------------------------------------
// Global
//---------------------------------------------------------------

gf_sys_props = { x_key ->
  final fu_it = System .getProperty (x_key)
  if ( fu_it == null ) { throw new NullPointerException ( "System property not found => ${x_key}" ) }
  fu_it
}
GC_JAVA_VERSION_STR = gf_sys_props ('java.version')
GC_GROOVY_VERSION_STR = GroovySystem.version

__gap_export_all_to_object_meta_class = {
  this.binding.variables .each { x_key, x_value -> if ( ! x_key .startsWith ('_') ) { Object.metaClass."$x_key" = x_value } }
}
__gap_export_all_to_object_meta_class ()
    )PASH_EOS" );
  );
  jobject jf_gr_if ( const char * xtl_function_nm, const std::list <jobject> & xru_args = {} ) {
    static const auto fsu_mid_i_if = jmf_gmid ( JL_CLS_INVOCABLE, "invokeFunction", "(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;" );
    return jmf_com ( __JAC_GR, fsu_mid_i_if, jmf_nsu (xtl_function_nm), jf_noa (xru_args) );
  }
  jobject jf_gr_g ( const char * xtl_key ) {
    static const auto fsu_mid_se_get = jmf_gmid ( JL_CLS_SCRIPT_ENGINE, "get", "(Ljava/lang/String;)Ljava/lang/Object;" );
    const auto fu_it = jmf_com ( __JAC_GR, fsu_mid_se_get, jmf_nsu (xtl_key) );
    if ( fu_it == NULL ) { throw std::runtime_error ( "Groovy get : can't find key => " + std::string (xtl_key) + " !!!" );  }
    return fu_it;
  }
}
