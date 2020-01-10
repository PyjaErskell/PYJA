#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/SCommon.sh"

"$SC_PERL_X_FN" -CS -I "$SC_MILO_PN/src/k-09001-perl" "$SC_MILO_PN/src/k-01001-compile/SToa.pl" "$@"
