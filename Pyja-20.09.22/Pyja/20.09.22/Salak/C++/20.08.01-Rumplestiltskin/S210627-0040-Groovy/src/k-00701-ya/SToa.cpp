#include <Global.cpp>

using namespace Global;

gmp_br (
  jf_gr_e ( R"PASH_EOS(
//---------------------------------------------------------------
// Your Source
//---------------------------------------------------------------

sf_hello = { x_str, x_no -> "Hello ${ x_str * x_no } !!!" }
sf_sum = { ... x_args -> x_args*.value .sum () }
  )PASH_EOS" );
);

auto sf_hello ( const QString & xru_str, const int x_no ) { return QString ( "Hello %1 !!!" ) .arg ( xru_str .repeated (x_no) ); }

template < typename ... TArgs >
auto sf_sum ( TArgs ... x_args ) { return ( 0 + ... + x_args ); }

class WMain : public QMainWindow {
  Q_OBJECT
public :
  explicit WMain (void) : QMainWindow (Q_NULLPTR) {
    __wan_init ();
    QTimer::singleShot ( 0, [this] { __wan_body (); } ); 
  }
  void wn_say ( const QString & xru_line ) {
    __watl_lw -> addItem (xru_line);
    __watl_lw -> setCurrentRow ( __watl_lw -> count () - 1 );
  }
private :
  QListWidget * __watl_lw;
  void __wan_init (void) {
    setWindowTitle ( gf_os_env ("SC_OLMI_NM") .c_str () );
    auto ntl_cw = new QWidget ();
    auto ntl_lo = new QVBoxLayout ();
    __watl_lw = new QListWidget ();
    ntl_lo -> addWidget (__watl_lw);
    ntl_cw -> setLayout (ntl_lo);
    setCentralWidget (ntl_cw);
    resize ( 830, 390 );
    show ();
    raise ();
    __wan_center_on_screen ();
  }
  void __wan_body (void) {
    wn_say ( QString ( "C++ standard version => %1" ) .arg (__cplusplus) );
    wn_say ( QString ( "Compiler version => %1" ) .arg (__VERSION__) );
    wn_say ( QString ( "Qt version => %1" ) .arg (QT_VERSION_STR) );
    wn_say ( QString ( "Java version => %1" ) .arg ( jf_js2css ( (jstring) jf_gr_g ("GC_JAVA_VERSION_STR") ) .c_str () ) );
    wn_say ( QString ( "Groovy version => %1" ) .arg ( jf_js2css ( (jstring) jf_gr_g ("GC_GROOVY_VERSION_STR") ) .c_str () ) );
    wn_say ( QString ( "Application font family => %1" ) .arg ( QApplication::font () .family () ) );
    wn_say ( QString ( "C++ Qt hello (English) => %1" ) .arg ( sf_hello ( "CPP-Qt-", 7 ) ) );
    wn_say ( QString ( "C++ Qt hello (Korean) => %1" ) .arg ( sf_hello ( "씨피피-큐티-", 3 ) ) );
    wn_say ( QString ( "C++17 sum of numbers (Integer) => %1" ) .arg ( QString ("%L1") .arg ( sf_sum ( 700000000, 12, 49, 15, 51, 94, 21, 63 ) ) ) );
    wn_say ( QString ( "C++17 sum of numbers (Long) => %1" ) .arg ( QString ("%L1") .arg ( sf_sum ( 70000000000, 12, 49, 15, 51, 94, 21, 63 ) ) ) );
    wn_say ( QString ( "C++17 sum of numbers (Float) => %1" ) .arg ( QString ("%L1") .arg ( sf_sum ( 3.4E+038f, 12, 49, 15, 51, 94, 21, 63 ) ) ) );
    wn_say ( QString ( "C++17 sum of numbers (Double) => %1" ) .arg ( QString ("%L1") .arg ( sf_sum ( 1.7E+308, 12, 49, 15, 51, 94, 21, 63 ) ) ) );
    wn_say ( QString ( "Groovy hello (English) => %1" ) .arg ( jmf_jo2css ( jf_gr_if ( "sf_hello", { jmf_nsu ("Groovy-"), jf_ni (7) } ) ) .c_str () ) );
    wn_say ( QString ( "Groovy hello (Korean) => %1" ) .arg ( jmf_jo2css ( jf_gr_if ( "sf_hello", { jmf_nsu ("그루비-"), jf_ni (9) } ) ) .c_str () ) );
    const auto nu_12 = jf_ni (12);
    const auto nu_49 = jf_ni (49);
    const auto nu_15 = jf_ni (15);
    const auto nu_51 = jf_ni (51);
    const auto nu_94 = jf_ni (94);
    const auto nu_21 = jf_ni (21);
    const auto nu_63 = jf_ni (63);
    wn_say ( QString ( "Groovy sum of numbers (Integer) => %1" ) .arg ( QString ("%L1") .arg ( jf_iv ( jf_gr_if ( 
      "sf_sum", { jf_ni (700000000), nu_12, nu_49, nu_15, nu_51, nu_94, nu_21, nu_63 } 
    ) ) ) ) );
    wn_say ( QString ( "Groovy sum of numbers (Long) => %1" ) .arg ( QString ("%L1") .arg ( jf_lv ( jf_gr_if ( 
      "sf_sum", { jf_nl (70000000000), nu_12, nu_49, nu_15, nu_51, nu_94, nu_21, nu_63 } 
    ) ) ) ) );
    wn_say ( QString ( "Groovy sum of numbers (Float) => %1" ) .arg ( QString ("%L1") .arg ( jf_fv ( jf_gr_if ( 
      "sf_sum", { jf_nf (3.4E+038f), nu_12, nu_49, nu_15, nu_51, nu_94, nu_21, nu_63 }
    ) ) ) ) );
    wn_say ( QString ( "Groovy sum of numbers (Double) => %1" ) .arg ( QString ("%L1") .arg ( jf_dv ( jf_gr_if ( 
      "sf_sum", { jf_nd (1.7E+308), nu_12, nu_49, nu_15, nu_51, nu_94, nu_21, nu_63 }
    ) ) ) ) );
  }
  void __wan_center_on_screen (void) {
    const auto nu_cp = QGuiApplication::primaryScreen () -> geometry () .center (); // center point
    move ( nu_cp .x () - width () / 2, nu_cp .y () - height () / 2 );
  }
};

#include "SToa.moc"


void sp_body (void) {
  gp_set_app_font ( gf_os_env ("SC_APP_FONT_FN") .c_str () );
  new WMain ();
  gtl_qapp -> exec ();
}

void sp_main (void) {
  sp_body ();
}

int main ( int xl_argc, char ** xtl_argv ) {
  __gap_210627_0059 ();
  std::cout << "Entering " << GMX_FILE << " ..." << std::endl;
  std::cout << "Starting " << Q_FUNC_INFO << " ..." << std::endl;
  gtl_qapp = new QApplication ( xl_argc, xtl_argv );
  sp_main ();
}
