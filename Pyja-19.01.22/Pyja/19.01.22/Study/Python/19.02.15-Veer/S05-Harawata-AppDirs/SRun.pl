#
# Global
#

BEGIN {
  package Global;

  use v5.18;
  use strict;
  use warnings;
  use base 'Exporter';

  use Cwd 'abs_path';
  use File::Basename;
  use File::Spec::Functions qw(canonpath);

  use constant GC_TRUE  => 1;
  use constant GC_FALSE => 0;

  sub gf_ap {
    my ( $x_it, $x_canonical ) = @_;
    $x_canonical //= GC_TRUE;
    my $fu_it = abs_path ($x_it);
    return $x_canonical ? canonpath ($fu_it) : $fu_it
  }
  sub gf_on {
    my ($x_pn) = @_;
    return basename ($x_pn);
  }

  sub gf_os_env {
    my ($x_key) = @_;
    my $fu_val = $ENV{$x_key};
    die ("Can't find environment variable => ${\ $x_key }") unless defined ($fu_val);
    return $fu_val;
  }
  sub gp_set_os_env {
    my ( $x_key, $x_val ) = @_;
    $ENV{$x_key} = $x_val;
  }

  use lib "${\ gf_ap ( gf_os_env ('SC_PERL_HM'), GC_FALSE ) }/site/lib";
  use lib "${\ gf_ap ( gf_os_env ('SC_PERL_HM'), GC_FALSE ) }/vendor/lib";

  use Config;
  use Log::Log4perl qw(:easy);

  $INC{"${\(__PACKAGE__)}.pm"}++; 

  use constant GC_ARGV => @ARGV;

  use constant GC_FOSA => File::Spec -> catfile ( '', '' ); # (fo)lder (s)ep(a)rator
  use constant GC_PASA => $Config{path_sep} ; # (pa)th (s)ep(a)rator

  sub gf_pj { join ( GC_FOSA, @_ ); }

  use constant GC_OS_ENV_PATHS => split GC_PASA, gf_os_env 'SC_PATH';
  use constant GC_THIS_START_UP_PN => gf_ap ( abs_path () );

  use constant GC_KAPA_HM_SYM => '@^';
  use constant GC_PYJA_RT_SYM => '@`';
  use constant GC_PYJA_HM_SYM => '@~';
  use constant GC_MILO_PN_SYM => '@!';
  use constant GC_TONO_HM_SYM => '@*';

  use constant GC_KAPA_HM => gf_ap ( gf_os_env ('SC_KAPA_HM') );
  use constant GC_TONO_HM => gf_ap ( gf_os_env ('SC_TONO_HM') );
  use constant GC_MILO_PN => gf_ap ( gf_os_env ('SC_MILO_PN') );
  use constant GC_PYJA_HM => gf_ap ( gf_os_env ('SC_PYJA_HM') );
  use constant GC_PYJA_RT => gf_ap ( gf_os_env ('SC_PYJA_RT') );
  use constant GC_PYJA_NM => gf_os_env ('SC_PYJA_NM');
  use constant GC_PYJA_VR => gf_os_env ('SC_PYJA_VR');

  use constant GC_APP_NM => gf_on (GC_TONO_HM);

  Log::Log4perl -> easy_init (
    {
      level => $DEBUG,
      file  => 'STDOUT',
      layout => '[%06P,%p{1},%d{yyMMDD-HHmmss}] %m%n',
    },
  );
  use constant GC_LOG => Log::Log4perl -> get_logger (GC_APP_NM);

  sub gp_log_array {
    my ( $xp_out, $x_title, @x_array ) = @_;
    $xp_out -> ( $x_title . ' :' ) if defined $x_title;
    while ( my ( $bu2_idx, $bu2_it ) = each (@x_array) ) { $xp_out->( "  ${\ sprintf '%2d', $bu2_idx+1 } => $bu2_it" ) }
  }

  sub gf_replace_with_px_symbol {
    my ( $x_pn, $x_px_path, $x_px_symbol ) = @_;
    if ( index ( $x_pn, $x_px_path ) == 0 ) {
      my $bu2_pn_sz = length ($x_pn);
      my $bu2_px_path_sz = length ($x_px_path);
      return $bu2_pn_sz == $bu2_px_path_sz ? $x_px_symbol : gf_pj $x_px_symbol, substr ( $x_pn, $bu2_px_path_sz + 1 )
    } else { return $x_pn; }
  }

  sub gf_to_khs { # to (k)apa (h)ome (s)ysmbol
    my ($x_pn) = @_;
    gf_replace_with_px_symbol ( $x_pn, GC_KAPA_HM, GC_KAPA_HM_SYM )
  }
  sub gf_to_prs { # to (p)yja (r)oot (s)ymbol
    my ($x_pn) = @_;
    gf_replace_with_px_symbol ( $x_pn, GC_PYJA_RT, GC_PYJA_RT_SYM )
  }
  sub gf_to_phs { # to (p)yja (h)ome (s)ymbol
    my ($x_pn) = @_;
    gf_replace_with_px_symbol ( $x_pn, GC_PYJA_HM, GC_PYJA_HM_SYM )
  }
  sub gf_to_mps { # to (m)ilo (p)ath (s)ymbol
    my ($x_pn) = @_;
    gf_replace_with_px_symbol ( $x_pn, GC_MILO_PN, GC_MILO_PN_SYM )
  }
  sub gf_to_ths { # to (t)ono (h)ome (s)ysmbol
    my ($x_pn) = @_;
    gf_replace_with_px_symbol ( $x_pn, GC_TONO_HM, GC_TONO_HM_SYM )
  }
  sub gf_to_kms { # to khs or mps
    my ($x_pn) = @_;
    my $fu_khs = gf_to_khs ($x_pn);
    return $x_pn eq $fu_khs ? gf_to_mps $x_pn : $fu_khs;
  }

  our @EXPORT = qw (
    GC_TRUE
    GC_FALSE

    gf_ap
    gf_on

    gf_os_env
    gp_set_os_env

    GC_ARGV

    GC_FOSA
    GC_PASA

    gf_pj

    GC_OS_ENV_PATHS
    GC_THIS_START_UP_PN

    GC_KAPA_HM_SYM
    GC_PYJA_RT_SYM
    GC_PYJA_HM_SYM
    GC_MILO_PN_SYM
    GC_TONO_HM_SYM

    GC_KAPA_HM
    GC_TONO_HM
    GC_MILO_PN
    GC_PYJA_HM
    GC_PYJA_RT
    GC_PYJA_NM
    GC_PYJA_VR

    GC_APP_NM
    GC_LOG

    gp_log_array

    gf_replace_with_px_symbol
    gf_to_khs
    gf_to_prs
    gf_to_phs
    gf_to_mps
    gf_to_ths
    gf_to_kms
  );
}

#
# Main Skeleton
#

package DRun {
  use v5.18;
  use warnings;
  use Global;

  sub dp_it {
    my ($xp_it) = @_;
    __dap_begin ();
    $xp_it -> ();
  }
  sub __dap_begin {
    GC_LOG -> info ( "Application name => ${\ GC_APP_NM }" );
    GC_LOG -> info ( "Pyja name => ${\ GC_PYJA_NM }" );
    GC_LOG -> info ( "Pyja version => ${\ GC_PYJA_VR }" );
    GC_LOG -> info ( "Pyja root (${\ GC_PYJA_RT_SYM }) => ${\ GC_PYJA_RT }" );
    GC_LOG -> info ( "Pyja home (${\ GC_PYJA_HM_SYM }) => ${\ gf_to_prs GC_PYJA_HM }" );
    GC_LOG -> info ( "Milo path (${\ GC_MILO_PN_SYM }) => ${\ gf_to_phs GC_MILO_PN }" );
    GC_LOG -> info ( "Tono home (${\ GC_TONO_HM_SYM }) => ${\ gf_to_mps GC_TONO_HM }" );
    GC_LOG -> info ( "Start up path => ${\ gf_to_mps GC_THIS_START_UP_PN }" );
    gp_log_array sub { GC_LOG -> info (@_) }, 'Paths', GC_OS_ENV_PATHS;
    GC_LOG -> info ( "Kapa home (${\ GC_KAPA_HM_SYM }) => ${\ GC_KAPA_HM }" );
  }
}

#
# Your Source
#

package DBody {
  use v5.18;
  use warnings;
  use Global;

  sub dp_it {
    gp_set_os_env 'JAVA_HOME', gf_os_env 'SC_J8_HM';
    my $pu_java_xmx = gf_os_env 'SC_JAVA_XMX';
    gp_set_os_env 'PYTHONHOME', gf_os_env 'SC_PYTHON_HM';
    GC_LOG -> info ( "Java home => ${\ gf_to_khs gf_os_env 'JAVA_HOME' }" );
    GC_LOG -> info ( "Java maximum heap size option => $pu_java_xmx" );
    GC_LOG -> info ( "Python home => ${\ gf_to_khs gf_os_env 'PYTHONHOME' }" );
    GC_LOG -> info ( "Jep jar file => ${\ gf_to_khs gf_os_env 'SC_JEP_JAR_FN' }" );
    my @pu_all_jars = (
      gf_pj ( GC_MILO_PN, 'ecu', 'ORun.jar' ),
      gf_os_env ('SC_JEP_JAR_FN'),
      gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Akka', '2.5.19', 'akka-actor_2.12-2.5.19.jar' ),
      gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.5', 'indy', 'groovy-2.5.5-indy.jar' ),
      gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.5', 'indy', 'groovy-jsr223-2.5.5-indy.jar' ),
      gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'JNA', '5.1.0', 'jna-5.1.0.jar' ),
      gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'JNA', '5.1.0', 'jna-platform-5.1.0.jar' ),
      gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Logback', '1.2.3', 'logback-classic-1.2.3.jar' ),
      gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Logback', '1.2.3', 'logback-core-1.2.3.jar' ),
      gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Scala', '2.12.8', 'lib', 'scala-library.jar' ),
      gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
      gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Typesafe', 'Config', '1.3.3', 'config-1.3.3.jar' ),

      gf_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Harawata', 'AppDirs', '1.0.0', 'appdirs-1.0.0.jar' ),
    );
    gp_log_array sub { GC_LOG -> info (@_) }, 'Jar files', map { gf_to_kms $_ } @pu_all_jars;
    my @pu_all_java_lib_paths = (
      gf_os_env ('SC_JEP_PN'),
    );
    gp_log_array sub { GC_LOG -> info (@_) }, 'Java library paths', map { gf_to_kms $_ } @pu_all_java_lib_paths;
    my $pu_rc = system (
      gf_os_env ('SC_J8_X_FN'),
      $pu_java_xmx,
      '-cp', join ( GC_PASA, @pu_all_jars ),
      "-Djava.library.path=${\ join ( GC_PASA, @pu_all_java_lib_paths ) }",
      'ORun',
      gf_pj ( GC_TONO_HM, 'SToa.py' ),
      GC_ARGV,
    );
    exit $pu_rc >> 8 if $pu_rc;
  }
}

package OStart { sub main { DRun::dp_it (\&DBody::dp_it); } }

package main { OStart::main (); }
