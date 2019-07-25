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
source "$SC_PYJA_HM/Config/Mono/x64/SSet-Mono-6.0.0.sh"
source "$SC_PYJA_HM/Config/MacPorts/x64/SSet-MacPorts.sh"
source "$SC_PYJA_HM/Config/MacPorts/x64/SSet-Ruby-2.5.3.sh"

export PATH=$SC_MONO_HM/bin:$PATH

export SC_PATH=$PATH

"$SC_RUBY_X_FN" "$SC_TONO_HM/$SC_THIS_JN.rb" "$@"
