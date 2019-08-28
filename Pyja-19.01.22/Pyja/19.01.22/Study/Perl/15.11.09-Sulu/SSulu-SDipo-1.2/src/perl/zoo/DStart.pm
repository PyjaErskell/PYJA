package zoo::DStart;

use v5.18;
use strict;
use warnings;
use Config;
use Try::Tiny;
use Devel::StackTrace;

use QtGui4;

use zoo::vi::WMain;
use zoo::da::app::DName;

BEGIN {
  use Global;
}

sub df_main {
  my $fav_rc = 0;
  my $farp2_init = sub {
    GC_LOG->info ( "Application => ${ \zoo::da::app::DName::du_apli_nm }" );
    GC_LOG->info ( "Engine => perl $^V ( \l${\( Config::compile_date () )} ) [ $Config{archname} ]" );
    gp_log_array sub { GC_LOG->info ( @_ ) }, '@INC', @INC;
    gp_log_array sub { GC_LOG->info ( @_ ) }, '$ENV{PATH}', split $Config{path_sep}, $ENV{PATH};
    gp_log_array sub { GC_LOG->debug ( @_ ) }, 'Used modules', sort keys %INC;
    if ( @ARGV ) {
      gp_log_array sub { GC_LOG->info ( @_ ) }, 'Arguments', @ARGV;
    } else {
      GC_LOG->info ( 'No arguments ...' );
    }
  };
  my $farp2_body = sub {
    my $pau2_app = sub {
      my $fau3_it = Qt::Application ( \@ARGV );
      my $fau3_org_palette = $fau3_it->palette ();
      $fau3_it->setStyle ( 'cleanlooks' ); # 'plastique', 'cleanlooks', 'motif', 'windows', 'cde'
      $fau3_it->setPalette ( $fau3_org_palette );
      return $fau3_it;
    }->();
    my $pau2_main = zoo::vi::WMain ();
    $pau2_main->raise;
    $pau2_main->show;
    $fav_rc = $pau2_app->exec;
  };
  my $farp2_fini = sub {
  };
  try {
    $farp2_init->();
    $farp2_body->();
    $farp2_fini->();
  } catch {
    GC_LOG->fatal ( '+' . '-' x 100 );
    GC_LOG->fatal ( ': Following error occurs !!!' );
    GC_LOG->fatal ( '+' . '-' x 100) ;
    GC_LOG->fatal ( $_ );
    foreach ( Devel::StackTrace->new->frames () ) { GC_LOG->fatal ( "  ${\( $_->as_string )}" ) }
    $fav_rc = 255;
  };
  return $fav_rc;
}

1;