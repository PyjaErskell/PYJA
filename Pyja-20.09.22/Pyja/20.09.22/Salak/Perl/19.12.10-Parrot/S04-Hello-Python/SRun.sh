#!/bin/bash

export SC_KAPA_HM="/Library/Application Support/Bichon Frise/Kapa"

export SC_JAVA_HM=$SC_KAPA_HM/19.11.01/Mushama/x64/Amazon/Corretto/8.232.09.1
export LD_LIBRARY_PATH=$SC_JAVA_HM/jre/lib/server

export SC_PYTHON_HM=$SC_KAPA_HM/19.01.22/Mushama/x64/Anaconda/5.1.0
export TCL_LIBRARY=$SC_PYTHON_HM/lib/tcl8.6
export QT_PLUGIN_PATH=$SC_PYTHON_HM/plugins
export SC_JEP_PN=$SC_PYTHON_HM/lib/python3.6/site-packages/jep
export SC_JEP_JAR_FN=$SC_JEP_PN/jep-3.7.1.jar
export PYTHONHOME=$SC_PYTHON_HM
export LD_LIBRARY_PATH=$SC_PYTHON_HM/lib:$LD_LIBRARY_PATH

export SC_MILO_PN=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export SC_PYJA_HM=$( cd "$SC_MILO_PN/../../../.." && pwd )
export SC_PYJA_NM=$( basename "$( cd "$SC_PYJA_HM/.." && pwd )" )
export SC_PYJA_VR=$( basename "${SC_PYJA_HM}" )

export SC_ECU_PN=$SC_MILO_PN/ecu

"/opt/local/bin/perl5.26.3" -CS -I "$SC_MILO_PN/src/k-09001-perl" "$SC_MILO_PN/src/k-01001-run-me/SToa.pl" "$@"
