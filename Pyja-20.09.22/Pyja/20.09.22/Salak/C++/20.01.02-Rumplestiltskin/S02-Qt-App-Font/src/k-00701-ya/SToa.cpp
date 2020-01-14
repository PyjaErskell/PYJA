//---------------------------------------------------------------
// Global
//---------------------------------------------------------------

#include <QApplication>
#include <QFileInfo>
#include <QFont>
#include <QFontDatabase>

namespace Global {
  QApplication * GTL_QAPP;
  const long GC_STD_VR = __cplusplus;
  const QString GC_COMPILER_VR = __VERSION__;
  const QString GC_QT_VR = QT_VERSION_STR;
  QString gf_os_env ( const QString & xru_key ) {
    const auto fu_r = std::getenv ( xru_key .toStdString () .c_str () );
    if ( fu_r == NULL ) { throw std::runtime_error ( QString ( "Can't find environment variable => %1 !!!" ) .arg (xru_key) .toStdString () ); }
    return QString (fu_r);
  }
  QString gf_bn ( const QString & xru_it ) { return QFileInfo (xru_it) .fileName (); }
  void gp_set_app_font ( const QString & xru_fn ) {
    const auto pu_id = QFontDatabase::addApplicationFont (xru_fn);
    if ( pu_id < 0 ) return;
    const auto pu_family = QFontDatabase::applicationFontFamilies (pu_id) .at (0);
    auto pv_font = QFont (pu_family);
    // pv_font .setPointSize (10);
    QApplication::setFont (pv_font);
  }
}

//---------------------------------------------------------------
// Your Source
//---------------------------------------------------------------

#include <QListWidget>
#include <QMainWindow>
#include <QScreen>
#include <QTimer>
#include <QVBoxLayout>

using namespace Global;

auto sf_hello ( const QString & xru_str, const int x_no ) { return QString ( "Hello %1" ) .arg ( xru_str .repeated (x_no) ); }

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
    setWindowTitle ( QString ( "%1 : %2" ) .arg ( gf_bn ( gf_os_env ("SC_OLIM_PN") ) ) .arg ( gf_bn ( gf_os_env ("SC_MILO_PN") ) ) );
    auto ntl_cw = new QWidget ();
    auto ntl_lo = new QVBoxLayout ();
    __watl_lw = new QListWidget ();
    ntl_lo -> addWidget (__watl_lw);
    ntl_cw -> setLayout (ntl_lo);
    setCentralWidget (ntl_cw);
    resize ( 700, 330 );
    show ();
    raise ();
    __wan_center_on_screen ();
  }
  void __wan_body (void) {
    wn_say ( QString ( "C++ standard version => %1" ) .arg (GC_STD_VR) );
    wn_say ( QString ( "Compiler version => %1" ) .arg (GC_COMPILER_VR) );
    wn_say ( QString ( "Qt version => %1" ) .arg (GC_QT_VR) );
    wn_say ( QString ( "C++ Qt hello (English) => %1" ) .arg ( sf_hello ( "CPP-Qt-", 7 ) ) );
    wn_say ( QString ( "C++17 sum of numbers => %1" ) .arg ( QString ("%L1") .arg ( sf_sum ( 700000000, 12, 49, 15, 51, 94, 21, 63 ) ) ) );
    wn_say ( QString ( "Application font family => %1" ) .arg ( QApplication::font () .family () ) );
    wn_say ( QString ( "C++ Qt hello (Korean) => %1" ) .arg ( sf_hello ( "씨피피-큐티-", 3 ) ) );
  }
  void __wan_center_on_screen (void) {
    const auto nu_cp = QGuiApplication::primaryScreen () -> geometry () .center (); // center point
    move ( nu_cp .x () - width () / 2, nu_cp .y () - height () / 2 );
  }
};

#include "SToa.moc"

void sp_body (void) {
  new WMain ();
  GTL_QAPP -> exec ();
}

void sp_main (void) {
  sp_body ();
}

int main ( int xl_argc, char ** xtl_argv ) {
  GTL_QAPP = new QApplication ( xl_argc, xtl_argv );
  gp_set_app_font ( gf_os_env ("SC_APP_FONT_FN") );
  sp_main ();
}
