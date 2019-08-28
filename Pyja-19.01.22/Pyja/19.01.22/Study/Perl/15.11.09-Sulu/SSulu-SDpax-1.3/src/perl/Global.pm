package Global;

use v5.18;
use strict;
use warnings;
use Log::Log4perl;
use File::Basename;
use base 'Exporter';

use zoo::da::app::DName;

Log::Log4perl->init ( \<<KASH_CONFIG );
  log4perl.rootLogger = DEBUG, screen
  log4perl.appender.screen = Log::Log4perl::Appender::ScreenColoredLevels
  log4perl.appender.screen.stderr = 0
  log4perl.appender.screen.layout = PatternLayout
  log4perl.appender.screen.layout.ConversionPattern = [%d] %5p : %m%n
KASH_CONFIG

use constant GC_LOG => Log::Log4perl->get_logger ( zoo::da::app::DName::du_apli_nm );

sub gp_log_array {
  my ( $xrp_level, $x_title, @x_array ) = @_;
  $xrp_level->( "$x_title =>" );
  while ( my ( $bau_idx, $bau_it ) = each ( @x_array ) ) { $xrp_level->( "  ${\( sprintf '%2d', $bau_idx+1 )} => $bau_it" ) }
}

our @EXPORT = qw( GC_APLI_S_NM GC_LOG gp_log_array );
