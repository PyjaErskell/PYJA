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
source "$SC_MILO_PN/SSet-QtJambi-4.5.2-x32.sh"

export JAVA_HOME=$SC_J_HM

export SC_GROOVY_HM=$SC_KAPA_HM/19.01.22/Cumuni/Groovy/2.4.16

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

echo "Groovy home => $SC_GROOVY_HM"
echo "Qt Jambi home => $SC_QTJ_HM"

export SC_ALL_JARS="$SC_GROOVY_HM/lib/groovy-2.4.16.jar"
export SC_ALL_JARS="$SC_QTJ_JAR_FN":$SC_ALL_JARS

export SC_ALL_JAVA_LIB_PATHS="$SC_QTJ_LIB_PN"

"$SC_J_X_FN" -XstartOnFirstThread -d$SC_J_D "$SC_JAVA_XMX" -Dfile.encoding=UTF-8 -cp $SC_ALL_JARS -Djava.library.path=$SC_ALL_JAVA_LIB_PATHS org.codehaus.groovy.tools.GroovyStarter --main groovy.ui.GroovyMain "$@"
