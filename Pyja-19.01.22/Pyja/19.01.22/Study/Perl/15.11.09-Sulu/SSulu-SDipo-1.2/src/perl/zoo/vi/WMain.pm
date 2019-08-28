package zoo::vi::WMain;

use v5.18;
use strict;
use warnings;
use Try::Tiny;

use QtGui4;
use QtCore4;
use QtCore4::isa qw ( Qt::MainWindow );
use QtCore4::slots 
  waon_input_pb_clicked => [],
  waon_process_pb_clicked => [],
  waon_init_as => [],
  wuon_display_msg => [ 'QString', 'int' ],
;

use utf8::all;
use DateTime;
use File::Spec;
use File::Slurp;
use File::Basename;
use MIME::Base64;
use Method::Signatures;

use zoo::da::DApp;
use zoo::da::app::DName;

BEGIN {
  use Global;
}

sub NEW {
  my $class = shift;
  $class->SUPER::NEW (@_);

  this->wan_init_1;
  this->wan_init_ui;
  this->wan_init_menu;

  this->wuon_display_msg ( '준비' );
}

sub wan_init_1 {
  this->wan_set_recent_pn ( File::Spec->catfile ( $ENV{ELSM}, '~', 'LICS' ) );
}

func wan_set_recent_pn ( Str $x_pn ) {
  die ( "Can't find path : <$x_pn>" ) unless -e $x_pn;
  this->{wav_recent_pn} = $x_pn;
  GC_LOG->debug ( "wav_recent_pn => ${\( this->{wav_recent_pn} )}" );
}

sub wan_init_ui {
  this->{wau_menubar} = menuBar ();
  this->{wau_status_bar} = statusBar ();

  this->{wau_input_lb} = Qt::Label ( '입력' );
  this->{wau_input_hl} = sub { 
    this->{wau_input_le} = sub { my $fau2_it = Qt::LineEdit (); $fau2_it->setReadOnly (1); return $fau2_it; }->();
    this->{wau_input_pb} = Qt::PushButton ( '...' );
    this->{wau_process_pb} = sub { my $fau2_it = Qt::PushButton ( '처리' ); $fau2_it->setEnabled (0); return $fau2_it; }->();
    my $fau_it = Qt::HBoxLayout ();
    $fau_it->addWidget ( $_ ) for( this->{wau_input_le}, this->{wau_input_pb}, this->{wau_process_pb} );
    return $fau_it;
  }->();

  this->{wau_output_lb} = Qt::Label ( '결과' );
  this->{wau_output_hl} = sub { 
    this->{wau_output_le} = sub { my $fau2_it = Qt::LineEdit (); $fau2_it->setReadOnly (1); return $fau2_it; }->();
    my $fau_it = Qt::HBoxLayout ();
    $fau_it->addWidget ( $_ ) for( this->{wau_output_le} );
    return $fau_it;
  }->();

  this->{wau_log_lb} = Qt::Label ( '로그' );
  this->{wau_log_hl} = sub { 
    this->{wau_log_te} = sub { my $fau2_it = Qt::TextEdit (); $fau2_it->setReadOnly (1); return $fau2_it; }->();
    my $fau_it = Qt::HBoxLayout ();
    $fau_it->addWidget ( $_ ) for( this->{wau_log_te} );
    return $fau_it;
  }->();

  this->{wau_gl} = sub {
    my $fau_it = Qt::GridLayout ();
    $fau_it->addWidget ( this->{wau_input_lb}, 0, 0, Qt::AlignRight () );
    $fau_it->addLayout ( this->{wau_input_hl}, 0, 1 );
    $fau_it->addWidget ( this->{wau_output_lb}, 1, 0, Qt::AlignRight () );
    $fau_it->addLayout ( this->{wau_output_hl}, 1, 1 );
    $fau_it->addWidget ( this->{wau_log_lb}, 2, 0, Qt::AlignRight () | Qt::AlignTop () );
    $fau_it->addLayout ( this->{wau_log_hl}, 2, 1 );
    return $fau_it;
  }->();

  this->{wau_widget} = sub {
    my $fau_it = Qt::Widget ( this );
    $fau_it->setLayout ( this->{wau_gl} );
    setCentralWidget ( $fau_it );
    return $fau_it;
  }->();

  setWindowTitle ( zoo::da::app::DName::du_apli_nm );
  setWindowState ( Qt::WindowMaximized () );

  this->connect ( this->{wau_input_pb}, SIGNAL 'clicked()', this, SLOT 'waon_input_pb_clicked()' );
  this->connect ( this->{wau_process_pb}, SIGNAL 'clicked()', this, SLOT 'waon_process_pb_clicked()' );
} 

sub wan_init_menu {
  my $nau_exit_action = Qt::Action ( '종료', this );
  $nau_exit_action->setShortcut( Qt::KeySequence ( 'Ctrl+Q' ) );
  Qt::Object::connect ( $nau_exit_action, SIGNAL 'triggered()', qApp (), SLOT 'quit()' );
  this->{wau_file_menu} = this->{wau_menubar}->addMenu ( '파일' );
  this->{wau_file_menu}->addAction ( $nau_exit_action );
}

sub waon_input_pb_clicked {
  my $nau_input_fn = Qt::FileDialog::getOpenFileName ( this, '요청 파일 열기', this->{wav_recent_pn}, 'REQ (*.req)' );
  $nau_input_fn or return;
  this->wan_set_recent_pn ( dirname ( $nau_input_fn ) );
  this->wuon_display_msg ( "요청 파일 => <$nau_input_fn>" );
  this->{wau_input_le}->setText ( $nau_input_fn );
  my $nau_output_fn = File::Spec->catfile ( dirname ( $nau_input_fn ), "${\( ( fileparse ( $nau_input_fn, qr/\.[^.]*/ ) ) [0] )}.lic" );
  this->wuon_display_msg ( "라이센스 파일 => <$nau_output_fn>" );
  this->{wau_output_le}->setText ( $nau_output_fn );
  this->{wau_process_pb}->setEnabled (1);
  this->wuon_display_msg ( '<처리> 버튼을 눌러 라이센스 파일을 생성하시오' );
  this->activateWindow;
}

sub waon_process_pb_clicked {
  my $nau_user_ac = zoo::da::DApp::df_get_user_ac;
  my $nau_req_content = read_file ( this->{wau_input_le}->text );
  this->wuon_display_msg ( "요청 파일의 내용 : <$nau_req_content>" );
  my $nau_req_code = decode_base64 ( $nau_req_content );
  this->wuon_display_msg ( "요청 코드 : <$nau_req_code>" );
  my $narf_get_lic_code = sub {
    my $fav_lic = "";
    my $fav_i = 42;
    while ($nau_req_code =~ /(.)/gs) { 
      my $bau_char = $1;
      my $bau_mul = $fav_i * $bau_char;
      $fav_lic .= $bau_mul;
      $fav_i += 1;
    }
    return $fav_lic;
  };
  my $nau_lic_code = $narf_get_lic_code->();
  this->wuon_display_msg ( "라이센스 코드 : <$nau_lic_code>" );
  my $pau_lic_content = encode_base64 ( $nau_lic_code, "" );
  this->wuon_display_msg ( "라이센스 파일의 내용 : <$pau_lic_content>" );
  write_file ( this->{wau_output_le}->text, $pau_lic_content );
  this->wuon_display_msg ( "라이센스 파일 생성 완료 !!!" );
}

sub showEvent {
  Qt::Timer::singleShot ( 0, this, SLOT 'waon_init_as()' );
}

sub waon_init_as { # init after show
  my $nap_user_ac = sub {
    my $pau_ac = Qt::InputDialog::getText (
      this,
      zoo::da::app::DName::du_apli_nm,
      '접근 코드 입력',
      Qt::LineEdit::Password (),
      '',
    );
  }->();
  if ( ! defined ( $nap_user_ac ) || ! zoo::da::DApp::df_is_valid_user_ac ( $nap_user_ac ) ) {
    Qt::MessageBox::critical ( 
      this, 
      "에러" , 
      "접근 불가 !!!", 
      Qt::MessageBox::Ok (), 
      Qt::MessageBox::NoButton ()
    );
    qApp->quit;
  }
}

func wuon_display_msg ( Str $x_msg = "", Int $x_timeout = 5000 ) {
  this->{wau_status_bar}->showMessage ( $x_msg, $x_timeout );
  this->{wau_log_te}->append ( "${\( DateTime->now->hms )} - ${\( $x_msg )}" );
  this->{wau_log_te}->moveCursor ( Qt::TextCursor::End () );
  this->{wau_log_te}->ensureCursorVisible ();
}

1;
