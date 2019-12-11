package i191210::G010;

use v5.26;
use strict;
use warnings;
use base 'Exporter';

use Config;
use Cwd;
use File::Basename;
use File::Path qw(mkpath);
use File::Spec;
use IPC::Run qw/run/;
use List::Util;
use Log::Log4perl qw(:easy);
use Package::Stash;
use POSIX;
use Time::HiRes qw(time);
use Time::Piece;
use Try::Tiny;

use constant GC_EC_SUCCESS  => 0;
use constant GC_EC_ERROR    => 1;

use constant GC_TRUE  => 1;
use constant GC_FALSE => 0;

use constant GC_FOSA => File::Spec -> catfile ( '', '' ); # (fo)lder (s)ep(a)rator
use constant GC_PASA => $Config {path_sep} ; # (pa)th (s)ep(a)rator

sub gf_os_env {
  my ($x_key) = @_;
  my $fu_r = $ENV {$x_key};
  die ( "Can't find environment variable => $x_key !!!" ) unless defined ($fu_r);
  return $fu_r;
}

sub gf_tf { return ($_[0]) ? GC_TRUE : GC_FALSE ; } # return GC_TRUE or GC_FALSE
sub gf_bn { basename $_[0] }; # (b)ase (n)ame
sub gf_xi { return gf_tf ( -e $_[0] ); } # e(xi)sts
sub gf_id { return gf_tf ( -d $_[0] ); } # (i)s (d)irectory
sub gf_if { return gf_tf ( -f $_[0] ); } # (i)s (f)ile
sub gf_pj { join ( GC_FOSA, @_ ); } # (p)ath (j)oin
sub gf_ap { File::Spec -> catfile ( Cwd::abs_path (shift) ); } # (a)bsolute (p)ath
sub gf_pn { # (p)ath (n)ame
  my ( $x_it, $x_chedk_id ) = @_;
  $x_chedk_id //= GC_FALSE;
  ( $x_chedk_id and gf_id ($x_it) ) ? $x_it : dirname ($x_it);
}
sub gf_ppn { # (p)arent (p)ath (n)ame
  my ( $x_it, $x_chedk_id ) = @_;
  $x_chedk_id //= GC_FALSE;
  my $fu_pn = gf_pn $x_it, $x_chedk_id;
  gf_ap gf_pj ( $fu_pn, '..' );
}
sub gf_on { # f(o)lder (n)ame from path name
  my ( $x_it, $x_chedk_id ) = @_;
  $x_chedk_id //= GC_FALSE;
  gf_bn ( gf_pn ( $x_it, $x_chedk_id ) );
}

use constant GC_DUCK_ID_SIZE => 7;
sub __gaf_duck_id_from_duck_name {
  my ($x_nm) = @_;
  return substr $x_nm, 0, GC_DUCK_ID_SIZE
}

use constant GC_DUCK_ST => $^T;
use constant GC_DUCK_PN => gf_os_env ('SC_DUCK_PN');
use constant GC_DUCK_NM => gf_on ( GC_DUCK_PN, GC_TRUE );
use constant GC_DUCK_ID => __gaf_duck_id_from_duck_name GC_DUCK_NM;

use constant GC_KAPA_HM => gf_os_env ('SC_KAPA_HM');
use constant GC_PYJA_HM => gf_os_env ('SC_PYJA_HM');
use constant GC_MILO_PN => gf_os_env ('SC_MILO_PN');
use constant GC_MILO_NM => gf_on ( GC_MILO_PN, GC_TRUE );
use constant GC_OLIM_PN => gf_ppn ( GC_MILO_PN, GC_TRUE );
use constant GC_OLIM_NM => gf_on ( GC_OLIM_PN, GC_TRUE );

use constant GC_ECU_PN => gf_os_env ('SC_ECU_PN');
BEGIN { mkpath GC_ECU_PN; }

use constant GC_CENTURY => 20;

use constant GC_PYJA_NM => 'Pyja';
use constant GC_PYJA_AU => 'Erskell'; # (au)thor
use constant GC_PYJA_EM => 'pyja.erskell@gmail.com'; # (Em)ail
use constant GC_PYJA_GH => 'https://github.com/PyjaErskell'; # (G)it(H)ub

use constant GC_PYJA_YEA => 20;
use constant GC_PYJA_MON =>  9;
use constant GC_PYJA_DAY => 22;

use constant GC_PYJA_CD => sprintf ( '%02d%02d.%02d.%02d', GC_CENTURY, GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY ); # Pyja creation date
use constant GC_PYJA_VR => sprintf ( '%02d.%02d.%02d', GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY ); # Pyja version with fixed length 8
use constant GC_PYJA_V2 => sprintf ( '%d.%d.%d', GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY ); # Pyja version without leading zero

use constant GC_KAPA_HM_SYM => '@^';
use constant GC_PYJA_HM_SYM => '@~';
use constant GC_MILO_PN_SYM => '@!';
use constant GC_DUCK_PN_SYM => '@&';
use constant GC_TEMP_PN_SYM => '@?';

use constant GC_JAVA_HM => gf_os_env ('SC_JAVA_HM');;

sub gf_commify {
  $_ = $_[0];
  while ( s/(^[+-]?\d+)(\d{3})/$1,$2/ ) {};
  return $_;
}

sub gf_rxc { # (r)un e(x)ternal (c)ommand
  my ($x_cmd) = @_;
  my $fu_out = '';
  my $fu_err = '';
  run $x_cmd, '>', \$fu_err, '2>', \$fu_err;
  my @fv_r = ();
  return @fv_r if not defined $fu_out and not defined $fu_err;
  if ( $fu_out and ! $fu_err ) {
    @fv_r = split "\n", $fu_out;
  } elsif ( ! $fu_out and $fu_err ) {
    @fv_r = split "\n", $fu_err;
  } else {
    @fv_r = split "\n", $fu_out . "\n" . $fu_err;
  }
  return @fv_r;
}

sub gf_str_is_valid_date {
  my ( $x_str, $x_format ) = @_;
  try {
    my $bu2_str = Time::Piece -> strptime ( $x_str, $x_format ) -> strftime ($x_format);
    return gf_tf ( $x_str eq $bu2_str );
  } catch {
    return GC_FALSE;
  };
}

sub gf_replace_with_px_symbol {
  my ( $xv_pn, $x_px_path, $x_px_symbol ) = @_;
  $xv_pn =~ s/\Q$x_px_path/$x_px_symbol/ig;
  return $xv_pn; 
}

sub gf_to_khs { # to (k)apa (h)ome (s)ymbol
  my ($x_pn) = @_;
  gf_replace_with_px_symbol ( $x_pn, GC_KAPA_HM, GC_KAPA_HM_SYM )
}
sub gf_to_phs { # to (p)yja (h)ome (s)ymbol
  my ($x_pn) = @_;
  gf_replace_with_px_symbol ( $x_pn, GC_PYJA_HM, GC_PYJA_HM_SYM )
}
sub gf_to_mps { # to (m)ilo (p)ath (s)ymbol
  my ($x_pn) = @_;
  gf_replace_with_px_symbol ( $x_pn, GC_MILO_PN, GC_MILO_PN_SYM )
}
sub gf_to_dps { # to (d)uck (p)ath (s)ymbol
  my ($x_pn) = @_;
  gf_replace_with_px_symbol ( $x_pn, GC_DUCK_PN, GC_DUCK_PN_SYM )
}
sub gf_to_tps { # to (t)emporary (p)ath (s)ymbol
  my ( $x_pn, $x_temp_pn ) = @_;
  gf_replace_with_px_symbol ( $x_pn, $x_temp_pn, GC_TEMP_PN_SYM )
}

Log::Log4perl -> easy_init (
  {
    level => $DEBUG,
    file  => 'STDOUT',
    layout => '[%06P,%p{1},%d{yyMMDD-HHmmss}] %m%n',
  },
);

use constant GC_LOG => Log::Log4perl -> get_logger (GC_DUCK_NM);

sub gp_log_array {
  my ( $xp_out, $x_title, @x_array ) = @_;
  $xp_out //= sub { GC_LOG -> info (@_) };
  $xp_out -> ( $x_title . ' :' ) if defined $x_title;
  while ( my ( $bu2_idx, $bu2_it ) = each (@x_array) ) { $xp_out->( "  ${\ sprintf '%2d', $bu2_idx+1 } => $bu2_it" ) }
}
  
sub gp_log_header {
  my ( $xp_out, $x_header, $x_line_width ) = @_;
  $xp_out //= sub { GC_LOG -> info (@_) };
  $x_line_width //= 60;
  $xp_out -> ( '+' . '-' x $x_line_width );
  $xp_out -> ( ": $x_header" );
  $xp_out -> ( '+' , '-' x $x_line_width );
}

sub gp_log_exception {
  my ( $xp_out, $x_title, $x_why ) = @_;
  $xp_out //= sub { GC_LOG -> error (@_) };
  gp_log_header ( $xp_out, $x_title );
  my @pu_why = split / at /i, $x_why;
  foreach (@pu_why) { $xp_out -> ("  ${\ gf_to_mps $_ }"); };
}

sub gf_banner {
  my ( $x_leading_space, $x_margin_inside ) = @_;
  $x_leading_space //= 0;
  $x_margin_inside //= 2;

  my @fu_msgs = (
    "${\GC_PYJA_NM} ${\GC_PYJA_V2}",
    "${\GC_OLIM_NM} : ${\GC_MILO_NM}",
    "Duck (${\GC_DUCK_NM})",
    "began running at ${\ strftime '%Y-%m-%d %H:%M:%S', localtime GC_DUCK_ST }",
    '',
    GC_PYJA_GH,
    "made by ${\GC_PYJA_AU} (${\GC_PYJA_EM})",
    'released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.',
  );
  my $fu_msl = List::Util::max ( map { length $_ } @fu_msgs ); # max string length
  my $fu_ls = $x_leading_space; # leading space before box
  my $fu_mg = $x_margin_inside; # margin inside box
  my $fu_ll = $fu_mg + $fu_msl + $fu_mg; # line length inside box
  my $fu_line = ' ' x $fu_ls . '+' . '-' x $fu_ll . '+';
  my $ff2_get_string = sub {
    my ($x2_str) = @_;
    my $fu2_sl = length $x2_str; # string lentgh
    my $fu2_lm = int ( ( $fu_ll - $fu2_sl ) / 2.0 ); # left margin inside box
    my $fu2_rm = $fu_ll - ( $fu2_sl + $fu2_lm ); # right margin inside box
    return ' ' x $fu_ls . ':' . ' ' x $fu2_lm . $x2_str . ' ' x $fu2_rm . ':';
  };
  my @fu_r =  ( $fu_line, ( map { $ff2_get_string -> ($_) } @fu_msgs ), $fu_line );
  return @fu_r;
}

sub gf_elapsed {
  my ( $x_st, $x_et ) = @_;
  return $x_et - $x_st;
}

use Inline Config => DIRECTORY => GC_ECU_PN;

use Inline (
  Java => <<'KASH_EOS',
  import java.util.ArrayList;
  class J010 {
    static class CjObjectArray {
      final private ArrayList <Object> cu_al;
      public CjObjectArray () { cu_al = new ArrayList <Object> (); }
      public Object [] to_a () { return cu_al .toArray (); }
      public void cn_add ( Integer x_it ) { cu_al .add (x_it); }
      public void cn_add ( Long x_it ) { cu_al .add (x_it); }
      public void cn_add ( Double x_it ) { cu_al .add (x_it); }
      public void cn_add ( Float x_it ) { cu_al .add (x_it); }
      public void cn_add ( String x_it ) { cu_al .add (x_it); }
    }
    public static CjObjectArray jf_oa () { return new CjObjectArray (); }
    public static String jf_sf ( String x_format, CjObjectArray x_args ) { return String .format ( x_format, x_args .to_a () ); }
  }
KASH_EOS
  STUDY => [ 
    'java.lang.System',
  ],
  PACKAGE => 'main',
  J2SDK => GC_JAVA_HM,
  JNI => 1,
  AUTOSTUDY => 1,
  EXTRA_JAVAC_ARGS => '-encoding UTF-8',
  EXTRA_JAVA_ARGS => '-Dfile.encoding=UTF8 -Dclient.encoding.override＝UTF-8',
);

sub gf_joa {
  my $fu_joa = J010 -> jf_oa ();
  foreach (@_) { $fu_joa -> cn_add ($_); }
  return $fu_joa;
}

our @EXPORT = ();
sub __gap_export {
  foreach ( Package::Stash -> new (__PACKAGE__) -> list_all_symbols ('CODE') ) {
    push @EXPORT, $_ if /^[g][cufp]_/i;
  }
}
__gap_export ();

#---------------------------------------------------------------
# Main Skeleton
#---------------------------------------------------------------

sub __gap_check_duck_naming_rule (_) {
  my $x_nm = shift;
  state $psu_nm_rx = '^[[:lower:]\-\d]*$';
  state $psu_id_rx = '^[[:lower:]]-\d{' . ( GC_DUCK_ID_SIZE - 2 ) . '}\D*$';
  die ( "Invalid characters for duck name ($x_nm) !!!" ) unless $x_nm =~ m!$psu_nm_rx!;
  die ( "Invalid duck id (${\ __gaf_duck_id_from_duck_name $x_nm }) inside duck name ($x_nm) !!!") unless $x_nm =~ m!$psu_id_rx!;
}

sub gp_run {
  my ($xp_it) = @_;
  my $pv_ec = GC_EC_SUCCESS;
  my $pp2_begin = sub {
    say ( join ( "\n", gf_banner () ) );
    GC_LOG -> info  ( "Kapa home (${\ GC_KAPA_HM_SYM }) => ${\ GC_KAPA_HM }" );
    GC_LOG -> info  ( "Pyja home (${\ GC_PYJA_HM_SYM }) => ${\ GC_PYJA_HM }" );
    GC_LOG -> info  ( "Milo path (${\ GC_MILO_PN_SYM }) => ${\ gf_to_phs GC_MILO_PN }" );
    GC_LOG -> info  ( "Duck path (${\ GC_DUCK_PN_SYM }) => ${\ gf_to_mps GC_DUCK_PN }" );
    GC_LOG -> info  ( "Duck id => ${\ GC_DUCK_ID }" );
    GC_LOG -> debug ( "Path ecu => ${\ gf_to_mps GC_ECU_PN }" );
    GC_LOG -> info  ( "\$^V => $^V" );
    GC_LOG -> info  ( "Java version => ${\ java::lang::System -> getProperty ('java.version') }" );
    GC_LOG -> info  ( "Java home => ${\ gf_to_khs GC_JAVA_HM }" );

    my $pu2_pyja_nm = gf_os_env ('SC_PYJA_NM');
    my $pu2_pyja_vr = gf_os_env ('SC_PYJA_VR');
    my $pu2_ecu_on = gf_bn (GC_ECU_PN);

    die ( "Pyja name is invalid => $pu2_pyja_nm !!!" ) unless GC_PYJA_NM eq $pu2_pyja_nm;
    die ( "Pyja version is invalid => $pu2_pyja_vr !!!" ) unless GC_PYJA_VR eq $pu2_pyja_vr;
    die ( 'Pyja create date is not valid !!!' ) unless gf_str_is_valid_date GC_PYJA_CD, '%Y.%m.%d';
    die ( "Invalid ecu name => $pu2_ecu_on" ) unless 'ecu' eq $pu2_ecu_on;
    foreach ( reverse ( split ( "\Q${\ GC_FOSA }", GC_DUCK_PN ) ) ) { last if m/^src$/; __gap_check_duck_naming_rule; }
    gp_log_array undef, 'Arguments', @ARGV if scalar @ARGV > 0;
  };
  my $pp2_end = sub {
    gp_log_array sub { GC_LOG -> debug (@_) }, 'Loaded modules', sort { fc ($a) cmp fc ($b) } keys %INC;
  };
  try {
    $pp2_begin -> ();
    $xp_it -> ();
    $pp2_end -> ();
  } catch {
    $pv_ec = GC_EC_ERROR;
    gp_log_exception ( undef, "Following error occurs !!!", $_ );
  };
  GC_LOG -> info ( "Exit code => $pv_ec" );
  GC_LOG -> info ( "Elapsed ${\ gf_elapsed ( GC_DUCK_ST, time () ) } ..." );
  exit ($pv_ec);
}

1;
