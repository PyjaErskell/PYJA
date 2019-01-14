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
source "$SC_MILO_PN/SSet-Anaconda-5.1.0-x64.sh"

export JAVA_HOME=$SC_J8_HM

export PYTHONHOME=$SC_PYTHON_HM

export LD_LIBRARY_PATH=$SC_PYTHON_HM/lib

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

echo "Python home => $PYTHONHOME"
echo "Jep jar file => $SC_JEP_JAR_FN"

echo "LD_LIBRARY_PATH => $LD_LIBRARY_PATH"

export SC_ALL_JARS="$SC_MILO_PN/ecu/ORun.jar":"$SC_JEP_JAR_FN"
export SC_ALL_JAVA_LIB_PATHS="$SC_JEP_PN"

"$SC_J8_X_FN" "$SC_JAVA_XMX" -cp $SC_ALL_JARS -Djava.library.path=$SC_ALL_JAVA_LIB_PATHS ORun "$@"
