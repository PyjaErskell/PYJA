#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

export SC_THIS_BN="$( basename "${BASH_SOURCE[0]}" )"
export SC_THIS_JN=${SC_THIS_BN%.*}

export SC_TONO_HM="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export SC_MILO_PN="$( cd "$SC_TONO_HM/.." && pwd )"
export SC_PYJA_HM="$( cd "$SC_MILO_PN/../../.." && pwd )"
export SC_PYJA_VR="$( basename "${SC_PYJA_HM}" )"
export SC_PYJA_RT="$( cd "$SC_PYJA_HM/.." && pwd )"
export SC_PYJA_NM="$( basename "${SC_PYJA_RT}" )"

source "$SC_PYJA_HM/Config/MacPorts/x64/SSet-MacPorts.sh"
source "$SC_PYJA_HM/Config/MacPorts/x64/SSet-Perl-5.26.3.sh"

export ELSM=$SC_TONO_HM
"$SC_PERL_X_FN" -I"$SC_TONO_HM/src/perl" "$SC_TONO_HM/src/perl/SZoo.pl"
