#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

export SC_THIS_BN="$( basename "${BASH_SOURCE[0]}" )"
export SC_THIS_JN=${SC_THIS_BN%.*}

export SC_MILO_PN="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export SC_PYJA_HM="$( cd "$SC_MILO_PN/../../.." && pwd )"
export SC_PYJA_VR="$( basename "${SC_PYJA_HM}" )"
export SC_PYJA_RT="$( cd "$SC_PYJA_HM/.." && pwd )"
export SC_PYJA_NM="$( basename "${SC_PYJA_RT}" )"

source "$SC_PYJA_HM/Config/SSet-JDK-8.sh"
source "$SC_PYJA_HM/Config/SSet-Qt-5.10.0.sh"

export JAVA_HOME=$SC_J8_HM
export SC_JAVA_XMX=-Xmx9g

export DYLD_FRAMEWORK_PATH=$SC_QT_HM/lib
export LD_LIBRARY_PATH=$JAVA_HOME/jre/lib/server
export QT_PLUGIN_PATH=$SC_QT_HM/plugins

export SC_JAVA_LIBRARY_PATH=$SC_MILO_PN/exe

export SC_PATH=$PATH

echo "PATH => $SC_PATH"

echo "MILO path => $SC_MILO_PN"
echo "PYJA name => $SC_PYJA_NM"
echo "PYJA version => $SC_PYJA_VR"
echo "PYJA root => $SC_PYJA_RT"
echo "PYJA home => $SC_PYJA_HM"

echo "Java home => $JAVA_HOME"
echo "Java maximum heap size option => $SC_JAVA_XMX"

echo "Qt home => $SC_QT_HM"
echo "QT_PLUGIN_PATH => $QT_PLUGIN_PATH"

echo "DYLD_FRAMEWORK_PATH => $DYLD_FRAMEWORK_PATH"
echo "LD_LIBRARY_PATH => $LD_LIBRARY_PATH"

echo "Java library path => $SC_JAVA_LIBRARY_PATH"

export SC_X_FN=$1
shift

$SC_MILO_PN/$SC_X_FN "$@"
