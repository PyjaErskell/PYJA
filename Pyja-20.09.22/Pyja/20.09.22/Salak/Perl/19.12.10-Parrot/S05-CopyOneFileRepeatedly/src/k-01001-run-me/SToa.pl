#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

use v5.26;
use strict;
use warnings;

use File::Basename;

BEGIN { $ENV {'SC_DUCK_PN'} = dirname (__FILE__); }

use i191210::G010;

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

use Getopt::Long;
use POSIX qw(strftime);
use File::Copy;

sub sp_body {
  my ( $pu_success, $pu_in_fn, $pu_times, $pu_out_pn ) = sf_get_options ();
  return unless $pu_success;
  GC_LOG -> info  ( "Input file => ${\ $pu_in_fn }" );
  GC_LOG -> info  ( "Repeating times => ${\ $pu_times }" );
  GC_LOG -> info  ( "Output path => ${\ $pu_out_pn }" );
  die 'No such input file !!!' unless gf_if $pu_in_fn;
  die 'Non positive repeating times !!!' unless $pu_times > 0;
  die 'No such output path !!!' unless gf_id $pu_out_pn;
  GC_LOG -> info ( 'Copying the file repeatedly ...' );
  my $pu_px_dt = strftime "%y%m%d-%H%M%S", localtime ( time () );
  my $pu_times_fmt = '%0' . length ($pu_times) . 'd';
  my $pu_in_bn = gf_bn $pu_in_fn;
  for ( 1..$pu_times ) {
    my $bu2_px_cnt = jf_sf ( "$pu_times_fmt-$pu_times_fmt", $pu_times, $_ );
    my $bu2_out_bn = "$pu_px_dt $bu2_px_cnt $pu_in_bn";
    my $bu2_out_fn = gf_pj $pu_out_pn, $bu2_out_bn;
    GC_LOG -> info  ( "  $bu2_out_bn -> $pu_out_pn" );
    die "Cannot copy to $bu2_out_fn ... !!!" unless copy $pu_in_fn, $bu2_out_fn;
  }
}

sub sf_get_options {
  my $fu_help;
  my $fu_in_fn;
  my $fu_times;
  my $fu_out_pn;

  if ( scalar @ARGV < 1 ) { sp_usage (); return GC_FALSE; }
  {
    $SIG{__WARN__} = sub { die ($_[0]) };
    GetOptions ( 'help|h' => \$fu_help, 'in=s' => \$fu_in_fn, 'times=i' => \$fu_times, 'out=s' => \$fu_out_pn );
  }
  if ( defined ($fu_help) ) { sp_usage (); return GC_FALSE; }
  die 'Input file not given !!!' unless defined ($fu_in_fn);
  die 'Repeating times not given !!!' unless defined ($fu_times);
  die 'Output path not given !!!' unless defined ($fu_out_pn);
  die 'Unrecognized arguments : ' . join ( ' ', @ARGV ) if scalar @ARGV > 0;
  ( GC_TRUE, $fu_in_fn, $fu_times, $fu_out_pn );
}

sub sp_usage {
  GC_LOG -> info ( 'Usage :' );
  GC_LOG -> info ( '  -in    input file' );
  GC_LOG -> info ( '  -times repeating times' );
  GC_LOG -> info ( '  -out   output path' );
  GC_LOG -> info ( '  -help  show usage' );
}

sub sp_main {
  gp_run (\&sp_body);
}


sp_main ();
