#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

export SC_VBS_FN=샘플이름.vbs

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
source "$SC_PYJA_HM/Config/JRuby/SSet-JRuby-9.2.5.0.sh"
source "$SC_PYJA_HM/Config/QtJambi/x64/SSet-QtJambi-4.8.6.sh"

export SC_JAVA_XMX=-Xmx9g

export JAVA_HOME=$SC_J8_HM

export JRUBY_HOME=$SC_JRUBY_HM
export RUBYLIB=$SC_TONO_HM

export DYLD_LIBRARY_PATH=$SC_QTJ_LIB_PN
export QT_PLUGIN_PATH=$SC_QTJ_PLUGIN_PN

export SC_PATH=$PATH

echo "PYJA name => $SC_PYJA_NM"
echo "PYJA version => $SC_PYJA_VR"
echo "PYJA root => $SC_PYJA_RT"
echo "PYJA home => $SC_PYJA_HM"
echo "MILO path => $SC_MILO_PN"
echo "TONO home => $SC_TONO_HM"
echo "KAPA home => $SC_KAPA_HM"


export SC_JARS=$SC_TONO_HM/ecu/ORun.jar
export SC_JARS=$SC_KAPA_HM/19.01.22/Cumuni/Akka/2.5.19/akka-actor_2.12-2.5.19.jar:$SC_JARS
export SC_JARS=$SC_KAPA_HM/19.01.22/Cumuni/Groovy/2.5.5/indy/groovy-2.5.5-indy.jar:$SC_JARS
export SC_JARS=$SC_KAPA_HM/19.01.22/Cumuni/Groovy/2.5.5/indy/groovy-jsr223-2.5.5-indy.jar:$SC_JARS
export SC_JARS=$SC_KAPA_HM/19.01.22/Cumuni/Scala/2.12.8/lib/scala-library.jar:$SC_JARS
export SC_JARS=$JRUBY_HOME/lib/jruby.jar:$SC_JARS
export SC_JARS=$SC_QTJ_JAR_FN:$SC_JARS

export SC_JAVA_LPS=$SC_TONO_HM/ecu
export SC_JAVA_LPS=$SC_QTJ_LIB_PN:$SC_JAVA_LPS

echo "PATH => $SC_PATH"

echo "Java home => $JAVA_HOME"
echo "Java maximum heap size option => $SC_JAVA_XMX"

"$SC_J8_X_FN" -XstartOnFirstThread "$SC_JAVA_XMX" -Dfile.encoding=UTF-8 -cp "$SC_JARS" -Djava.library.path="$SC_JAVA_LPS" ORun "$@"
