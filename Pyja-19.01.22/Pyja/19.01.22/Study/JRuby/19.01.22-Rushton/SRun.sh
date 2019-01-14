#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

export SC_THIS_BN="$( basename "${BASH_SOURCE[0]}" )"
export SC_THIS_JN=${SC_THIS_BN%.*}

export SC_MILO_PN="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export SC_PYJA_HM="$( cd "$SC_MILO_PN/../../.." && pwd )"
export SC_PYJA_VR="$( basename "${SC_PYJA_HM}" )"
export SC_PYJA_RT="$( cd "$SC_PYJA_HM/.." && pwd )"
export SC_PYJA_NM="$( basename "${SC_PYJA_RT}" )"

source "$SC_PYJA_HM/Config/SSet-KAPA.sh"
source "$SC_MILO_PN/SSet-QtJambi-4.8.6-x64.sh"
source "$SC_PYJA_HM/Config/JRuby/SSet-JRuby-9.2.5.0.sh"

export JAVA_HOME=$SC_J8_HM

export JRUBY_HOME=$SC_JRUBY_HM
export RUBYLIB=$SC_MILO_PN

export DYLD_LIBRARY_PATH=$SC_QTJ_LIB_PN
export QT_PLUGIN_PATH=$SC_QTJ_PLUGIN_PN

export SC_PATH=$PATH

echo "PATH => $SC_PATH"

echo "MILO path => $SC_MILO_PN"
echo "KAPA home => $SC_KAPA_HM"
echo "PYJA name => $SC_PYJA_NM"
echo "PYJA version => $SC_PYJA_VR"
echo "PYJA root => $SC_PYJA_RT"
echo "PYJA home => $SC_PYJA_HM"

echo "Java home => $JAVA_HOME"
echo "Java maximum heap size option => $SC_JAVA_XMX"

echo "JRuby home => $JRUBY_HOME"
echo "Qt Jambi home => $SC_QTJ_HM"

export SC_ALL_JARS="$SC_MILO_PN/ecu/ORun.jar":"$SC_JRUBY_JAR_FN"

"$SC_J8_X_FN" "$SC_JAVA_XMX" -cp $SC_ALL_JARS ORun "$@"
