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

export JAVA_HOME=$SC_J8_HM
export SC_JAVA_XMX=-Xmx9g

source "$SC_PYJA_HM/Config/MacPorts/x64/SSet-MacPorts.sh"
source "$SC_PYJA_HM/Config/MacPorts/x64/SSet-Ruby-2.5.3.sh"

export SC_PATH=$PATH

echo "PYJA name => $SC_PYJA_NM"
echo "PYJA version => $SC_PYJA_VR"
echo "PYJA root => $SC_PYJA_RT"
echo "PYJA home => $SC_PYJA_HM"
echo "MILO path => $SC_MILO_PN"
echo "TONO home => $SC_TONO_HM"
echo "KAPA home => $SC_KAPA_HM"

echo "PATH => $SC_PATH"

echo "Java home => $JAVA_HOME"
echo "Java maximum heap size option => $SC_JAVA_XMX"

"$SC_RUBY_X_FN" "$SC_TONO_HM/$SC_THIS_JN.rb" "$@"
