#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

export SC_THIS_BN="$( basename "${BASH_SOURCE[0]}" )"
export SC_THIS_JN=${SC_THIS_BN%.*}

export SC_APP_PN="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export SC_MILO_PN="$( cd "$SC_APP_PN/.." && pwd )"
export SC_PYJA_HM="$( cd "$SC_MILO_PN/../../.." && pwd )"
export SC_PYJA_VR="$( basename "${SC_PYJA_HM}" )"
export SC_PYJA_RT="$( cd "$SC_PYJA_HM/.." && pwd )"
export SC_PYJA_NM="$( basename "${SC_PYJA_RT}" )"

source "$SC_PYJA_HM/Config/SSet-KAPA.sh"
source "$SC_PYJA_HM/Config/OpenJDK/x64/SSet-JDK-11.0.2.sh"
source "$SC_PYJA_HM/Config/OpenJFX/x64/SSet-JFX-11.sh"
source "$SC_PYJA_HM/Config/Anaconda/x64/SSet-Anaconda-5.1.0.sh"
export SC_JAVA_XMX=-Xmx9g

export JAVA_HOME=$SC_J11_HM

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

export SC_ALL_JARS="$SC_MILO_PN/ecu/ORun.jar"
export SC_ALL_JARS="$SC_JEP_JAR_FN":$SC_ALL_JARS

export SC_ALL_JARS="$SC_KAPA_HM/19.01.22/Cumuni/Akka/2.5.19/akka-actor_2.12-2.5.19.jar":$SC_ALL_JARS
export SC_ALL_JARS="$SC_KAPA_HM/19.01.22/Cumuni/Groovy/2.5.5/indy/groovy-2.5.5-indy.jar":$SC_ALL_JARS
export SC_ALL_JARS="$SC_KAPA_HM/19.01.22/Cumuni/Groovy/2.5.5/indy/groovy-jsr223-2.5.5-indy.jar":$SC_ALL_JARS
export SC_ALL_JARS="$SC_KAPA_HM/19.01.22/Cumuni/JNA/5.1.0/jna-5.1.0.jar":$SC_ALL_JARS
export SC_ALL_JARS="$SC_KAPA_HM/19.01.22/Cumuni/JNA/5.1.0/jna-platform-5.1.0.jar":$SC_ALL_JARS
export SC_ALL_JARS="$SC_KAPA_HM/19.01.22/Cumuni/Logback/1.2.3/logback-classic-1.2.3.jar":$SC_ALL_JARS
export SC_ALL_JARS="$SC_KAPA_HM/19.01.22/Cumuni/Logback/1.2.3/logback-core-1.2.3.jar":$SC_ALL_JARS
export SC_ALL_JARS="$SC_KAPA_HM/19.01.22/Cumuni/Scala/2.12.8/lib/scala-library.jar":$SC_ALL_JARS
export SC_ALL_JARS="$SC_KAPA_HM/19.01.22/Cumuni/SLF4J/1.7.25/slf4j-api-1.7.25.jar":$SC_ALL_JARS
export SC_ALL_JARS="$SC_KAPA_HM/19.01.22/Cumuni/Typesafe/Config/1.3.3/config-1.3.3.jar":$SC_ALL_JARS

export SC_ALL_JAVA_LIB_PATHS="$SC_JEP_PN"

export SC_ALL_MODULE_PATHS="$SC_FX11_HM/lib"

export SC_ALL_MODULES=javafx.controls

"$SC_J11_X_FN" "$SC_JAVA_XMX" --module-path $SC_ALL_MODULE_PATHS --add-modules=$SC_ALL_MODULES -cp $SC_ALL_JARS -Djava.library.path=$SC_ALL_JAVA_LIB_PATHS ORun "$SC_APP_PN/SToa.py" "$@"
