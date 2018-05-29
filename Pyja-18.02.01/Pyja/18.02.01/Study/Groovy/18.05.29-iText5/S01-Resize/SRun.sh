#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

export SC_THIS_BN="$( basename "${BASH_SOURCE[0]}" )"
export SC_THIS_JN=${SC_THIS_BN%.*}

export SC_MILO_PN="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export SC_PYJA_HM="$( cd "$SC_MILO_PN/../../../.." && pwd )"
export SC_PYJA_VR="$( basename "${SC_PYJA_HM}" )"
export SC_PYJA_RT="$( cd "$SC_PYJA_HM/.." && pwd )"
export SC_PYJA_NM="$( basename "${SC_PYJA_RT}" )"

source "$SC_PYJA_HM/Config/SSet-JDK-8.sh"
source "$SC_PYJA_HM/Config/SSet-QtJambi-4.8.6.sh"

export JAVA_HOME=$SC_J8_HM
export SC_JAVA_XMX=-Xmx9g

export SC_GROOVY_JAR_FN=$SC_PYJA_HM/Library/Groovy/2.4.15/embeddable/groovy-all-2.4.15-indy.jar
export SC_ITEXT_JAR_FN=$SC_PYJA_HM/Library/iText/5.5.12/itext5-itextpdf-5.5.12.jar

export DYLD_LIBRARY_PATH=$SC_QTJ_LIB_PN
export QT_PLUGIN_PATH=$SC_QTJ_PLUGIN_PN

export SC_PATH=$PATH

echo "PATH => $SC_PATH"

echo "MILO path => $SC_MILO_PN"
echo "PYJA name => $SC_PYJA_NM"
echo "PYJA version => $SC_PYJA_VR"
echo "PYJA root => $SC_PYJA_RT"
echo "PYJA home => $SC_PYJA_HM"

echo "Java home => $JAVA_HOME"
echo "Java maximum heap size option => $SC_JAVA_XMX"

echo "Groovy jar file => $SC_GROOVY_JAR_FN"

echo "Qt Jambi home => $SC_QTJ_HM"
echo "Qt Jambi library path => $SC_QTJ_LIB_PN"
echo "Qt Jambi plugin path => $SC_QTJ_PLUGIN_PN"

"$SC_J8_X_FN" "$SC_JAVA_XMX" -XstartOnFirstThread -cp "$SC_QTJ_JAR_FN":"$SC_GROOVY_JAR_FN":"$SC_ITEXT_JAR_FN" -Djava.library.path="$SC_QTJ_LIB_PN" org.codehaus.groovy.tools.GroovyStarter --main groovy.ui.GroovyMain "$SC_MILO_PN/$SC_THIS_JN.groovy" "$@"
