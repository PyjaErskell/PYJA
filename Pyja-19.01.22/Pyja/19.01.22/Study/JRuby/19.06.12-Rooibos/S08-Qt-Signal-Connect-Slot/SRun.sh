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
source "$SC_PYJA_HM/Config/QtJambi/x64/SSet-QtJambi-4.8.6.sh"

export SC_JAVA_XMX=-Xmx9g

export JAVA_HOME=$SC_J8_HM

export JRUBY_HOME=$SC_KAPA_HM/19.01.22/Cumuni/JRuby/9.2.5.0
export RUBYLIB=$SC_TONO_HM

export DYLD_LIBRARY_PATH=$SC_QTJ_LIB_PN
export QT_PLUGIN_PATH=$SC_QTJ_PLUGIN_PN

export SC_PATH=$PATH

source "$SC_TONO_HM/SJars.sh"

"$SC_J8_X_FN" "$SC_JAVA_XMX" -Dfile.encoding=UTF-8 -cp "$SC_JARS" -Djava.library.path="$SC_JAVA_LPS" ORun "$@"
