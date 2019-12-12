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

package WMain;

use v5.26;
use strict;
use warnings;

use Config;
use utf8;
use Wx qw( wxDefaultPosition wxMAJOR_VERSION wxMINOR_VERSION );
use Wx::Event qw( EVT_ACTIVATE EVT_CLOSE );

use i191210::G010;

use base qw(Wx::App);

sub OnInit {
  my ($self) = @_;
  GC_LOG -> info ( "${\ ref $self } : Initializing ..." );
  $self->{wu_fra} = Wx::Frame -> new ( undef, -1, "${\GC_OLIM_NM} : ${\GC_MILO_NM}", wxDefaultPosition, [ 660, 300 ] );
  $self->{wu_lbx} = Wx::ListBox -> new ($self->{wu_fra});
  EVT_ACTIVATE ( $self->{wu_fra}, \&wn_fra_activate );
  EVT_CLOSE ( $self->{wu_fra}, \&wn_fra_close );
  $self -> SetTopWindow ($self->{wu_fra});
  $self->{wu_fra} -> Center ();
  $self->{wu_fra} -> Show (1);
  $self -> wn_init ();
  1;
}

sub wn_init {
  my ($self) = @_;
  $self -> wn_say ( "\$^V => $^V" );
  $self -> wn_say ( "wxPerl version => $Wx::VERSION" );
  $self -> wn_say ( "wxWidgets version => ${\wxMAJOR_VERSION}.${\wxMINOR_VERSION}" );
  $self -> wn_say ( "Java version => ${\ java::lang::System -> getProperty ('java.version') }" );
  $self -> wn_say ( "Groovy version => ${\ jf_ge ('GroovySystem.version') }" );
  $self -> wn_say ( "Perl hello (English) => ${\ main::sf_perl_hello ( 'PERL-', 6 ) }" );
  $self -> wn_say ( "Perl hello (Korean) => ${\ main::sf_perl_hello ( '펄-', 25 ) }" );
  $self -> wn_say ( "Java string format 'int : %,d, long : %,d' => ${\ jf_sf ( 'int : %,d, long : %,d', 314159265, 314159265358979 ) }" );
  $self -> wn_say ( "Java string format 'English : %s, Korean : %s' => ${\ jf_sf ( 'English : %s, Korean : %s', 'JAVA', '자바' ) }" );
  $self -> wn_say ( "Groovy hello (English) => ${\ jf_gf ( 'sf_hello', 'GROOVY-', 6 ) -> toString () }" );
  $self -> wn_say ( "Groovy hello (Korean) => ${\ jf_gf ( 'sf_hello', '그루비-', 6 ) -> toString () }" );
  $self -> wn_say ( "Groovy sum of numbers => ${\ jf_sf ( '%,d', jf_gf ( 'sf_sum', 700000000, 12, 49, 15, 51, 94, 21, 63 ) ) }" );
}

sub wn_say {
  my ( $self, $x_line ) = @_;
  $self->{wu_lbx} -> Append ($x_line);
}

sub wn_fra_activate {
  my ( $self, $x_ev ) = @_;
  GC_LOG -> debug ( "${\ ref $self } : Activated ..." );
  $x_ev -> Skip;
}

sub wn_fra_close {
  my ( $self, $x_ev ) = @_;
  GC_LOG -> info ( "${\ ref $self } : Closing ..." );
  $x_ev -> Skip;
}

package main;

sub sf_perl_hello {
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
