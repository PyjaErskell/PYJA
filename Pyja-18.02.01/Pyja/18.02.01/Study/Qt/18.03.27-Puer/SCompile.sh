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
source "$SC_PYJA_HM/Config/SSet-JRuby-9.1.15.0.sh"
source "$SC_PYJA_HM/Config/SSet-Qt-5.10.0.sh"

export JAVA_HOME=$SC_J8_HM
export SC_JAVA_XMX=-Xmx9g

export JRUBY_HOME=$SC_JRUBY_HM

export SC_INC_PATH=$JAVA_HOME/include
export SC_INC_PATH=$SC_INC_PATH:$JAVA_HOME/include/darwin

export SC_LIB=$JAVA_HOME/jre/lib/server/libjvm.dylib

export SC_PATH=$PATH

echo "PATH => $SC_PATH"

echo "MILO path => $SC_MILO_PN"
echo "PYJA name => $SC_PYJA_NM"
echo "PYJA version => $SC_PYJA_VR"
echo "PYJA root => $SC_PYJA_RT"
echo "PYJA home => $SC_PYJA_HM"

echo "Java home => $JAVA_HOME"
echo "Java maximum heap size option => $SC_JAVA_XMX"

echo "JRuby home => $JRUBY_HOME"
echo "JRuby jar file => $SC_JRUBY_JAR_FN"

echo "Include path => $SC_INC_PATH"
echo "Lib path => $SC_LIB"

echo "Qt home => $SC_QT_HM"

"$SC_J8_X_FN" "$SC_JAVA_XMX" -cp "$SC_JRUBY_JAR_FN" org.jruby.Main "$SC_MILO_PN/$SC_THIS_JN.rb" "$@"
