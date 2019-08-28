use v5.18;
use strict;
use warnings;

use zoo::DStart;

sub sp_main {
  my $pau_ec = zoo::DStart::df_main ();
  exit ( $pau_ec );
}

sp_main;
