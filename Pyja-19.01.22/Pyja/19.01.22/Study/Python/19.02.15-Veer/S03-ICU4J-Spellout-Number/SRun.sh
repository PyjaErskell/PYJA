#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

export SC_THIS_BN="$( basename "${BASH_SOURCE[0]}" )"
export SC_THIS_JN=${SC_THIS_BN%.*}

export SC_TONO_HM="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export SC_MILO_PN="$( cd "$SC_TONO_HM/.." && pwd )"
export SC_PYJA_HM="$( cd "$SC_MILO_PN/../../.." && pwd )"
export SC_PYJA_RT="$( cd "$SC_PYJA_HM/.." && pwd )"
export SC_PYJA_NM="$( basename "${SC_PYJA_RT}" )"
export SC_PYJA_VR="$( basename "${SC_PYJA_HM}" )"

source "$SC_PYJA_HM/Config/SSet-KAPA.sh"
source "$SC_PYJA_HM/Config/ActivePerl/x64/SSet-ActivePerl-5.26.3.sh"
source "$SC_PYJA_HM/Config/OpenJDK/x64/SSet-JDK-11.0.2.sh"
source "$SC_PYJA_HM/Config/OpenJFX/x64/SSet-JFX-11.sh"
source "$SC_PYJA_HM/Config/Anaconda/x64/SSet-Anaconda-5.1.0.sh"

export PERL5LIB="$SC_PERL_HM/lib"

export DYLD_LIBRARY_PATH="$SC_PERL_HM/lib/CORE"
export LD_LIBRARY_PATH="$SC_PYTHON_HM/lib"

export SC_PATH=$PATH

"$SC_PERL_EXE_FN" "$SC_TONO_HM/$SC_THIS_JN.pl" "$@"
