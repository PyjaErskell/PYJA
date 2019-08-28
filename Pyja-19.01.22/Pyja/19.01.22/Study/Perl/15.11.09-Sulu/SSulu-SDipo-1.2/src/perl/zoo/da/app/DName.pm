package zoo::da::app::DName;

use v5.18;
use strict;
use warnings;
use File::Basename;
use base 'Exporter';

use constant du_apli_nm => ( fileparse ( $ENV{'ELSM'} ) ) [0];

our @EXPORT = qw ( du_apli_nm );
