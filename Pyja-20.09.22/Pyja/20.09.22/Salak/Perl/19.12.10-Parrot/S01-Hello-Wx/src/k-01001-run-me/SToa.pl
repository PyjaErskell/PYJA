#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

use v5.26;
use strict;
use warnings;

use Cwd;
use File::Basename;
use File::Spec;
use List::MoreUtils qw(first_index);

BEGIN {
  my $bu_fosa = File::Spec -> catfile ( '', '' ); # (fo)lder (s)ep(a)rator
  my $bf2_pj = sub { join ( $bu_fosa, @_ ); }; # (p)ath (j)oin
  my $bf2_ap = sub { File::Spec -> catfile ( Cwd::abs_path (shift) ); }; # (a)bsolute (p)ath
  my $bu_duck_pn = File::Spec -> rel2abs ( dirname (__FILE__) );
  my $bu_milo_pn = sub {
    my @fu2_arr = ( split ( "\Q${\ $bu_fosa }", $bu_duck_pn ) );
    my $fu2_idx = first_index { $_ eq 'src' } @fu2_arr;
    $bf2_pj -> ( @fu2_arr [ 0 .. $fu2_idx-1 ] );
  } -> ();
  my $bu_pyja_hm = $bf2_ap -> ( $bf2_pj -> ( $bu_milo_pn, '..', '..', '..', '..' ) );
  my $bu_ecu_pn = $bf2_pj -> ( $bu_milo_pn, 'ecu' );
  unshift ( @INC, $bf2_pj -> ( $bu_milo_pn, 'src', 'k-09001-perl' ) );
  $ENV {'SC_DUCK_PN'} = $bu_duck_pn;
  $ENV {'SC_PYJA_HM'} = $bu_pyja_hm;
  $ENV {'SC_PYJA_NM'} = basename $bf2_ap -> ( $bf2_pj -> ( $bu_pyja_hm, '..' ) );
  $ENV {'SC_PYJA_VR'} = basename $bu_pyja_hm;
  $ENV {'SC_MILO_PN'} = $bu_milo_pn;
  $ENV {'SC_ECU_PN'} = $bu_ecu_pn;
}

use i191210::G010;

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

package WMain;

use v5.26;
use strict;
use warnings;

use Wx qw( wxMAJOR_VERSION wxMINOR_VERSION );
use utf8;
use Config;
use i191210::G010;

use base qw(Wx::App);

sub OnInit {
  my ($self) = @_;
  $self->{wu_frm} = Wx::Frame -> new ( undef, -1, "${\GC_OLIM_NM} : ${\GC_MILO_NM}", [ -1, -1 ], [ 600, 250 ] );
  $self->{wu_lbx} = Wx::ListBox -> new ($self->{wu_frm});
  $self -> wn_show ( "\$] => $]" );
  $self -> wn_show ( "\$^V => $^V" );
  $self -> wn_show ( "\$Config{api_versionstring} => $Config{api_versionstring}" );
  $self -> wn_show ( "\$\$ => $$" );
  $self -> wn_show ( "\$^X => $^X" );
  $self -> wn_show ( "wxPerl version => $Wx::VERSION" );
  $self -> wn_show ( "wxWidgets version => ${\ Wx::wxMAJOR_VERSION }.${\ Wx::wxMINOR_VERSION }" );
  $self -> wn_show ( "Wx::wxVERSION_STRING => ${\ Wx::wxVERSION_STRING }" );
  $self -> wn_show ( "Hello english => ${\ main::sf_hello ( 'PERL-', 6 ) }" );
  $self -> wn_show ( "Hello korea => ${\ main::sf_hello ( '펄-', 25 ) }" );
  $self -> SetTopWindow ($self->{wu_frm});
  $self->{wu_frm} -> Center ();
  $self->{wu_frm} -> Show (1);
}

sub wn_show {
  my ( $self, $x_line ) = @_;
  $self->{wu_lbx} -> Append ($x_line);
}

package main;

sub sf_hello {
  my ( $x_it, $x_repeat ) = @_;
  return 'Hello ' . $x_it x $x_repeat . ' !!!'
}

sub sp_body {
  my $pu_m = WMain -> new ();
  $pu_m -> MainLoop;
}

sub sp_main {
  gp_run (\&sp_body);
}

sp_main ();
