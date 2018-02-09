#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

export SC_MILO_PN="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export SC_PYJA_HM="$( cd "$SC_MILO_PN/../../.." && pwd )"
export SC_PYJA_VR="$( basename "${SC_PYJA_HM}" )"
export SC_PYJA_RT="$( cd "$SC_PYJA_HM/.." && pwd )"
export SC_PYJA_NM="$( basename "${SC_PYJA_RT}" )"

source "$SC_PYJA_HM/Config/SSet-JDK-8.sh"
source "$SC_PYJA_HM/Config/SSet-JRuby-9.1.15.0.sh"
source "$SC_PYJA_HM/Config/SSet-Python-3.6.3.sh"

export JAVA_HOME=$SC_J8_HM
export SC_JAVA_XMX=-Xmx9g

export JRUBY_HOME=$SC_JRUBY_HM

export PYTHONHOME=$SC_PYTHON_HM

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

echo "Python home => $PYTHONHOME"
echo "Jep jar file => $SC_JEP_JAR_FN"

"$SC_J8_X_FN" "$SC_JAVA_XMX" -XstartOnFirstThread -cp "$SC_JEP_JAR_FN":"$SC_JRUBY_JAR_FN" -Djava.library.path="$SC_JEP_PN" org.jruby.Main "$@"
