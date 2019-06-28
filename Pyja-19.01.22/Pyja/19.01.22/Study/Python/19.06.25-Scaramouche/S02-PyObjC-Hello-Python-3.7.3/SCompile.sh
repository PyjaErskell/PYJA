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

source "$SC_PYJA_HM/Config/SSet-KAPA.sh"
source "$SC_PYJA_HM/Config/JDK/x64/SSet-JDK-8.sh"
source "$SC_PYJA_HM/Config/Perl/x64/SSet-macOS-Perl-5.18.sh"
source "$SC_PYJA_HM/Config/Python/x64/SSet-macOS-Python-2.7.sh"

export SC_PATH=$PATH

"$SC_PERL_X_FN" "$SC_TONO_HM/$SC_THIS_JN.pl" "$@"
