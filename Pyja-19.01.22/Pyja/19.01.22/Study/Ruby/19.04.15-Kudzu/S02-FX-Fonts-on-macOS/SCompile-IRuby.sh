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
source "$SC_PYJA_HM/Config/JRuby/SSet-JRuby-9.2.5.0.sh"

export JAVA_HOME=$SC_J8_HM

export JRUBY_HOME=$SC_JRUBY_HM
export RUBYLIB=$SC_MILO_PN

export SC_PATH=$PATH

echo "PATH => $SC_PATH"

echo "MILO path => $SC_MILO_PN"
echo "KAPA home => $SC_KAPA_HM"
echo "PYJA name => $SC_PYJA_NM"
echo "PYJA version => $SC_PYJA_VR"
echo "PYJA root => $SC_PYJA_RT"
echo "PYJA home => $SC_PYJA_HM"

echo "Java home => $JAVA_HOME"

echo "JRuby home => $JRUBY_HOME"

export SC_ALL_JARS="$SC_JRUBY_JAR_FN"

"$SC_J8_X_FN" -cp $SC_ALL_JARS org.jruby.Main "$SC_TONO_HM/$SC_THIS_JN.rb" "$@"
