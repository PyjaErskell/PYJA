#!/bin/bash

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

export SC_MILO_PN="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export SC_PYJA_HM="$( cd "$SC_MILO_PN/../../../.." && pwd )"
export SC_PYJA_VR="$( basename "${SC_PYJA_HM}" )"
export SC_PYJA_RT="$( cd "$SC_PYJA_HM/.." && pwd )"
export SC_PYJA_NM="$( basename "${SC_PYJA_RT}" )"

source "$SC_PYJA_HM/Config/SSet-KAPA.sh"
source "$SC_PYJA_HM/Config/JDK/SSet-JDK-6.sh"
source "$SC_PYJA_HM/Config/QtJambi/x32/SSet-QtJambi-4.5.2.sh"

export JAVA_HOME=$SC_J6_HM
export SC_JAVA_XMX=-Xmx1700m

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

echo "Qt Jambi home => $SC_QTJ_HM"

export DYLD_LIBRARY_PATH=$SC_QTJ_LIB_PN
export QT_PLUGIN_PATH=$SC_QTJ_PLUGIN_PN

export SC_ALL_JARS=$SC_QTJ_ALL_JARS
export SC_ALL_JAVA_LIB_PATHS="$SC_QTJ_LIB_PN"

"$SC_J6_X_FN" -d32 "$SC_JAVA_XMX" -XstartOnFirstThread -cp $SC_ALL_JARS -Djava.library.path=$SC_ALL_JAVA_LIB_PATHS com.trolltech.launcher.Launcher
