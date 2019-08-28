package zoo::da::DApp;

use v5.18;
use strict;
use warnings;
use File::Basename;
use base 'Exporter';

use constant du_apli_ac => 'Anapanasati-DpaxD5';

my $dav_user_ac;

sub df_get_user_ac {
  die "Invalid access code" unless defined $dav_user_ac;
  return $dav_user_ac;
}

sub df_is_valid_user_ac {
  my $fau_user_ac = shift;
  my $fau_is_valid = $fau_user_ac eq "\L${\( du_apli_ac )}";
  $dav_user_ac = $fau_user_ac;
  return $fau_is_valid;
}

1;