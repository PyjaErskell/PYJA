#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

BEGIN {
  package Global;

  use v5.18;
  use strict;
  use warnings;
  use base 'Exporter';

  $INC{"${\(__PACKAGE__)}.pm"}++;

  use Config;
  use Cwd 'abs_path';
  use Data::Dumper;
  use File::Basename;
  use File::Path;
  use File::Spec::Functions qw (canonpath);
  use List::Util qw (max);
  use POSIX;
  use Time::HiRes qw (time);
  use Time::Piece;

  use constant GC_TONO_ST => time;

  use constant GC_TRUE  => 1;
  use constant GC_FALSE => 0;

  use constant GC_KAPA_HM_SYM => '@^';
  use constant GC_PYJA_RT_SYM => '@`';
  use constant GC_PYJA_HM_SYM => '@~';
  use constant GC_MILO_PN_SYM => '@!';
  use constant GC_TONO_HM_SYM => '@*';

  use constant GC_EC_NONE     => -200;
  use constant GC_EC_SHUTDOWN => -199;
  use constant GC_EC_SUCCESS  => 0;
  use constant GC_EC_ERROR    => 1;

  use constant GC_FOSA => File::Spec -> catfile ( '', '' ); # (fo)lder (s)ep(a)rator
  use constant GC_PASA => $Config {path_sep} ; # (pa)th (s)ep(a)rator

  sub gf_xi {
    my ($x_it) = @_;
    return ( -e $x_it ) ? GC_TRUE : GC_FALSE;
  }
  sub gf_id {
    my ($x_it) = @_;
    return ( -d $x_it ) ? GC_TRUE : GC_FALSE;
  }
  sub gf_if {
    my ($x_it) = @_;
    return ( -f $x_it ) ? GC_TRUE : GC_FALSE;
  }
  sub gf_ap {
    my ( $x_it, $x_canonical ) = @_;
    $x_canonical //= GC_TRUE;
    my $fu_it = abs_path ($x_it);
    return $x_canonical ? canonpath ($fu_it) : $fu_it
  }
  sub gf_xn { # e(x)tension (n)ame
    my ($x_fn) = @_;
    my $fu_bn = basename $x_fn;
    my $fu_pos = rindex $fu_bn, '.';
    return '' if $fu_pos < 1;
    substr $fu_bn, $fu_pos + 1;
  }
  sub gf_jn { # (j)ust (n)ame without extension
    my ($x_fn) = @_;
    my $fu_bn = basename $x_fn;
    ( fileparse $fu_bn, qr/\.[^.]*/ ) [0];
  }
  sub gf_pn { # (p)ath (n)ame
    my ( $x_it, $x_check_id ) = @_;
    $x_check_id //= GC_FALSE;
    return ( $x_check_id and gf_id ($x_it) ) ? $x_it : dirname ($x_it);
  }
  sub gf_bn {
    my ($x_fn) = @_;
    return basename ($x_fn);
  }
  sub gf_on { # f(o)lder (n)ame
    my ( $x_it, $x_check_id ) = @_;
    $x_check_id //= GC_FALSE;
    return gf_bn gf_pn ( $x_it, $x_check_id );
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
  sub gp_mp {
    my ($x_pn) = @_;
    mkpath $x_pn if ! gf_id $x_pn;
  }
  sub gp_rp { # (r)emove (p)ath
    my ($x_pn) = @_;
    rmtree $x_pn if gf_id $x_pn;
    say gf_id ($x_pn);
  }
  sub gp_ep { # (e)mpty out (p)ath
    my ($x_pn) = @_;
    return unless gf_id $x_pn;
    foreach my $bu2_it ( glob gf_pj ( $x_pn, '*' ) ) {
      unlink $bu2_it if gf_if $bu2_it;
      rmtree $bu2_it if gf_id $bu2_it;
    }
  }
  sub gf_pj { join ( GC_FOSA, @_ ); }
  sub gf_str_is_valid_date {
    my ( $x_str, $x_format ) = @_;
    eval {
      Time::Piece -> strptime ( $x_str ,$x_format );
    }; if ($@) {
      return GC_FALSE;
    }
    return GC_TRUE;
  }

  use constant GC_PYJA_NM => 'Pyja';
  use constant GC_PYJA_AU => 'Erskell'; # (au)thor

  use constant GC_PJYA_CEN => 20;
  use constant GC_PYJA_YEA => 19;
  use constant GC_PYJA_MON =>  1;
  use constant GC_PYJA_DAY => 22;

  use constant GC_PYJA_CD => sprintf '%02d%02d.%02d.%02d', GC_PJYA_CEN, GC_PYJA_YEA ,GC_PYJA_MON, GC_PYJA_DAY; # Pyja creation date
  use constant GC_PYJA_VR => sprintf '%02d.%02d.%02d', GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY; # Pyja version with fixed length 8
  use constant GC_PYJA_V2 => "${\GC_PYJA_YEA}.${\GC_PYJA_MON}.${\GC_PYJA_DAY}"; # Pyja version without leading zero

  use constant GC_PYJA_VER_MAJ => GC_PYJA_YEA; # Major 
  use constant GC_PYJA_VER_MIN => GC_PYJA_MON; # Minor
  use constant GC_PYJA_VER_PAT => GC_PYJA_DAY; # Patch

  use constant GC_KAPA_HM => gf_os_env 'SC_KAPA_HM';
  use constant GC_TONO_HM => gf_os_env 'SC_TONO_HM';
  use constant GC_MILO_PN => gf_os_env 'SC_MILO_PN';
  use constant GC_PYJA_HM => gf_os_env 'SC_PYJA_HM';
  use constant GC_PYJA_RT => gf_os_env 'SC_PYJA_RT';

  use constant GC_MILO_NM => gf_bn GC_MILO_PN;

  use constant GC_TONO_NM => gf_on GC_TONO_HM, GC_TRUE;
  use constant GC_TONO_ARGV => @ARGV;
  use constant GC_TONO_PID => $$;
  use constant GC_TONO_SCRIPT_FN => __FILE__;
  use constant GC_TONO_OS_ENV_PATHS => split GC_PASA, gf_os_env 'SC_PATH';
  use constant GC_TONO_START_UP_PN => gf_ap ( abs_path () );

  use constant gu_debug => 10;
  use constant gu_info  => 20;
  use constant gu_warn  => 30;
  use constant gu_error => 40;

  my $__gav_level = gu_debug;

  sub gp_set_log_level {
    my ($x_level) = @_;
    $__gav_level = $x_level;
  }
  sub gp_log {
    my ( $x_level, $x_msg ) = @_;
    return if $x_level < $__gav_level;
    state $psu_ls = {
      gu_debug, 'D',
      gu_info , 'I',
      gu_warn , 'W',
      gu_error, 'E',
    };
    say "[${\ sprintf '%06d', GC_TONO_PID },${\ $psu_ls -> {$x_level} },${\ strftime '%y%m%d-%H%M%S', localtime }] $x_msg";
  }
  sub gp_log_debug {
    my ($x_msg) = @_;
    gp_log gu_debug, $x_msg;
  }
  sub gp_log_info {
    my ($x_msg) = @_;
    gp_log gu_info, $x_msg;
  }
  sub gp_log_warn {
    my ($x_msg) = @_;
    gp_log gu_warn, $x_msg;
  }
  sub gp_log_error {
    my ($x_msg) = @_;
    gp_log gu_error, $x_msg;
  }
  sub gp_log_array {
    my ( $x_title, $xr_array, $xp_out ) = @_;
    my @pu_array = @$xr_array;
    $xp_out //= \&gp_log_info;
    $xp_out -> ( $x_title . ' :' ) if defined $x_title;
    while ( my ( $bu2_idx, $bu2_it ) = each (@pu_array) ) { $xp_out -> ( "  ${\ sprintf '%2d', $bu2_idx+1 } => $bu2_it" ) }
  }
  sub gp_log_header {
    my ( $x_header, $xp_out, $x_line_width ) = @_;
    $xp_out //= \&gp_log_info;
    $x_line_width //= 60;
    $xp_out -> ( '+' . '-' x $x_line_width );
    $xp_out -> ( ": $x_header" );
    $xp_out -> ( '+' . '-' x $x_line_width );
  }
  sub gp_log_why {
    my ( $x_title, $xv_why, $xp_out ) = @_;
    $xp_out //= \&gp_log_error;
    gp_log_header $x_title, $xp_out ;
    chomp $xv_why;
    $xv_why =~ s/${\GC_TONO_HM}/${\GC_TONO_HM_SYM}/;
    $xp_out -> ($xv_why);
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

  sub gp_os_exit {
    my ($x_ec) = @_;
    exit $x_ec;
  }
  sub __gap_before_exit {
    my ( $x_ec, $x_why ) = @_;
    gp_log_why 'Following error occurs !!!', $x_why if $x_why;
    gp_log_header 'Unknown error occurs !!!', \&gp_log_error if $x_ec != GC_EC_SUCCESS and ! defined $x_why;
    if ( $x_ec == GC_EC_NONE ) { gp_log_error 'Undefined exit code (GC_EC_NONE), check your logic !!!'; }
    elsif ( $x_ec == GC_EC_SHUTDOWN ) { gp_log_info 'Exit from shutdown like ctrl+c, ...'; }
    else {
      if ( $x_ec < 0 ) { gp_log_error "Negative exit code $x_ec, should consider using a positive value !!!"; }
      else { gp_log_info "Exit code => $x_ec"; }
    }
    my $pu_elapsed = Time::Seconds -> new ( time - GC_TONO_ST  ) -> pretty;
    gp_log_info "Elapsed $pu_elapsed ...";
  }
  sub gp_request_exit {
    my ( $x_ec, $x_why ) = @_;
    &__gap_before_exit;
    if ( $x_ec == GC_EC_NONE ) { gp_os_exit GC_EC_ERROR; }
    elsif ( $x_ec == GC_EC_SHUTDOWN ) {}
    else {
      if ( $x_ec < 0 ) { gp_os_exit GC_EC_ERROR; }
      else { gp_os_exit $x_ec; }
    }
  }

  sub gf_banner {
    my ( $x_leading_space, $x_margin_inside ) = @_;
    $x_leading_space //= 0;
    $x_margin_inside //= 2;
    my @fu_msgs = (
      "${\GC_PYJA_NM} ${\GC_PYJA_V2}",
      GC_MILO_NM,
      "${\GC_TONO_NM} <${\ gf_bn GC_TONO_SCRIPT_FN }>",
      '',
      "made by ${\GC_PYJA_AU}",
      "ran on ${\ strftime '%y-%m-%d %H:%M:%S', localtime (GC_TONO_ST) }",
      'released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.',
    );
    my $fu_msl = max ( map { length $_ } @fu_msgs ); # max string length
    my $fu_ls = $x_leading_space; # leading space before box
    my $fu_mg = $x_margin_inside; # margin inside box
    my $fu_ll = $fu_mg + $fu_msl + $fu_mg; # line length inside box
    state $fsu_line = ' ' x $fu_ls . '+' . '-' x $fu_ll . '+';
    state $fsf2_get_string = sub {
      my ($x2_str) = @_;
      my $fu2_sl = length $x2_str; # string lentgh
      my $fu2_lm = int ( ( $fu_ll - $fu2_sl ) / 2.0 ); # left margin inside box
      my $fu2_rm = $fu_ll - ( $fu2_sl + $fu2_lm ); # right margin inside box
      return ' ' x $fu_ls . ':' . ' ' x $fu2_lm . $x2_str . ' ' x $fu2_rm . ':';
    };
    my @fu_r = ( $fsu_line, ( map { $fsf2_get_string -> ($_) } @fu_msgs ) , $fsu_line );
    return @fu_r;
  }

  our @EXPORT = qw (
    GC_TONO_ST

    GC_TRUE
    GC_FALSE

    GC_KAPA_HM_SYM
    GC_PYJA_RT_SYM
    GC_PYJA_HM_SYM
    GC_MILO_PN_SYM
    GC_TONO_HM_SYM

    GC_EC_NONE
    GC_EC_SHUTDOWN
    GC_EC_SUCCESS
    GC_EC_ERROR

    GC_FOSA
    GC_PASA

    gf_xi
    gf_id
    gf_if
    gf_ap
    gf_xn
    gf_jn
    gf_pn
    gf_bn
    gf_on
    gf_os_env
    gp_set_os_env
    gp_mp
    gp_rp
    gp_ep
    gf_pj
    gf_str_is_valid_date

    GC_PYJA_NM
    GC_PYJA_AU

    GC_PJYA_CEN
    GC_PYJA_YEA
    GC_PYJA_MON
    GC_PYJA_DAY

    GC_PYJA_CD
    GC_PYJA_VR
    GC_PYJA_V2

    GC_PYJA_VER_MAJ
    GC_PYJA_VER_MIN
    GC_PYJA_VER_PAT

    GC_KAPA_HM
    GC_TONO_HM
    GC_MILO_PN
    GC_PYJA_HM
    GC_PYJA_RT

    GC_MILO_NM

    GC_TONO_NM
    GC_TONO_ARGV
    GC_TONO_PID
    GC_TONO_SCRIPT_FN
    GC_TONO_OS_ENV_PATHS
    GC_TONO_START_UP_PN

    gu_debug
    gu_info
    gu_warn
    gu_error

    gp_set_log_level
    gp_log
    gp_log_debug
    gp_log_info
    gp_log_warn
    gp_log_error
    gp_log_array
    gp_log_header
    gp_log_why

    gf_replace_with_px_symbol
    gf_to_khs
    gf_to_prs
    gf_to_phs
    gf_to_mps
    gf_to_ths
    gf_to_kms

    gp_os_exit
    gp_request_exit

    gf_banner
  );
}

#---------------------------------------------------------------
# Main Skeleton
#---------------------------------------------------------------

package DRun {
  use v5.18;
  use strict;
  use warnings;

  use Global;
  use Data::Dumper;
  use Try::Tiny;

  sub dp_it {
    try {
      __dap_begin ();
      DBody::dp_it ();
    } catch {
      gp_request_exit GC_EC_ERROR, $_;
    }
  }
  sub __dap_begin {
    say join "\n", gf_banner ();
    gp_log_debug "Pyja name => ${\GC_PYJA_NM}";
    die 'Invalid Pyja name !!!' unless GC_PYJA_NM eq gf_os_env 'SC_PYJA_NM';
    gp_log_debug "Pyja creation date => ${\GC_PYJA_CD}";
    die 'Pyja create date is not invalid !!!' unless gf_str_is_valid_date GC_PYJA_CD, '%Y.%m.%d';
    gp_log_debug "Pyja version => ${\GC_PYJA_V2}";
    die 'Invalid Pyja version !!!' unless GC_PYJA_VR eq gf_os_env 'SC_PYJA_VR';
    gp_log_info  "Kapa home (${\GC_KAPA_HM_SYM}) => ${\GC_KAPA_HM}";
    gp_log_info  "Pyja root (${\GC_PYJA_RT_SYM}) => ${\GC_PYJA_RT}";
    gp_log_info  "Pyja home (${\GC_PYJA_HM_SYM}) => ${\ gf_to_prs GC_PYJA_HM }";
    gp_log_info  "Milo path (${\GC_MILO_PN_SYM}) => ${\ gf_to_phs GC_MILO_PN }";
    gp_log_info  "Tono home (${\GC_TONO_HM_SYM}) => ${\ gf_to_mps GC_TONO_HM }";
    gp_log_debug "Process ID => ${\GC_TONO_PID}";
    gp_log_info  "Start up path => ${\ gf_to_mps GC_TONO_START_UP_PN }";
    gp_log_info  "Script file => ${\ gf_to_ths GC_TONO_SCRIPT_FN }";
    gp_log_array 'Paths', [GC_TONO_OS_ENV_PATHS];
    gp_log_array 'Arguments', [GC_TONO_ARGV] if GC_TONO_ARGV;
  }
}

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

package DBody {
  use v5.18;
  use strict;
  use warnings;

  use Global;
  use Data::Dumper;
  use File::Temp;

  sub dp_it {
    # 1 / 0;
    my $pu_ecu_pn = gf_pj GC_TONO_HM, 'ecu';
    gp_mp $pu_ecu_pn;
    gp_ep $pu_ecu_pn;
    gp_log_info "Erasable folder for common use => ${\ gf_to_ths $pu_ecu_pn }";
    my $pu_javac_x_fn = gf_os_env 'SC_J8C_X_FN';
    gp_log_info "Java compiler executable file => ${\ gf_to_kms $pu_javac_x_fn }";
    my $pu_jar_x_fn = gf_os_env 'SC_J8R_X_FN';
    gp_log_info "Jar executable file => ${\ gf_to_kms $pu_jar_x_fn }";

    my $pp2_compile_java = sub {
      my ($x2_bn) = @_;
      my $pu2_src_fn = gf_pj GC_TONO_HM, $x2_bn;
      gp_log_header "Compiling ${\ gf_to_ths $pu2_src_fn } ...";
      my $pu2_tmp_pn = File::Temp -> newdir ();
      gp_log_info "Temporary path => $pu2_tmp_pn";
      my $pu2_cls_o_pn = $pu2_tmp_pn;
      my $pp3_compile = sub {
        gp_log_info 'Generating class file ...';
        system ( $pu_javac_x_fn, '-Xlint:deprecation', '-cp', gf_os_env ('SC_JEP_JAR_FN'), '-d', $pu2_cls_o_pn, $pu2_src_fn ) == 0 or die "[$?] Error during gernationg class file !!!";
      };
      my $pp3_jar = sub {
        gp_log_info 'Making jar file ...';
        my $pu3_jar_fn = gf_pj $pu_ecu_pn, "${\ gf_jn $pu2_src_fn }.jar";
        gp_log_info "Output JAR file => ${\ gf_to_ths $pu3_jar_fn }";
        system ( $pu_jar_x_fn, '-cvf', $pu3_jar_fn, '-C', $pu2_cls_o_pn, '.' ) == 0 or die "[$?] Error during making jar !!!";
      };
      $pp3_compile -> ();
      $pp3_jar -> ();
    };

    $pp2_compile_java -> ('ORun.java');
    gp_request_exit GC_EC_SUCCESS;
  }
}

package main {
  use Global;

  sub sp_main {
    # gp_set_log_level gu_info;
    DRun::dp_it ();
  }

  sp_main ();
}
