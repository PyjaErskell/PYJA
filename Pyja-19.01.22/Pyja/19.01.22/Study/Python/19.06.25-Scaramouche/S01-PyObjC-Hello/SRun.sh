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
source "$SC_PYJA_HM/Config/Python/x64/SSet-macOS-Python-2.7.sh"

export JAVA_HOME=$SC_J8_HM
export SC_JAVA_XMX=-Xmx9g

export PYTHONPATH=$SC_JEP_PN

export SC_PATH=$PATH

export SC_JARS=$SC_TONO_HM/ecu/ORun.jar
export SC_JARS=$SC_KAPA_HM/19.01.22/Cumuni/Groovy/2.5.5/indy/groovy-2.5.5-indy.jar:$SC_JARS
export SC_JARS=$SC_KAPA_HM/19.01.22/Cumuni/Groovy/2.5.5/indy/groovy-jsr223-2.5.5-indy.jar:$SC_JARS
export SC_JARS=$SC_JEP_JAR_FN:$SC_JARS

export SC_JAVA_LPS=$SC_TONO_HM/ecu
export SC_JAVA_LPS=$SC_JEP_PN:$SC_JAVA_LPS

"$SC_J8_X_FN" "$SC_JAVA_XMX" -Dfile.encoding=UTF-8 -cp "$SC_JARS" -Djava.library.path="$SC_JAVA_LPS" ORun "$@"
