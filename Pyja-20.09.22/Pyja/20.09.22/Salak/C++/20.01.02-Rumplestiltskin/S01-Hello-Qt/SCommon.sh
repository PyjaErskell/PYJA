#!/bin/bash

export SC_KAPA_HM="/Library/Application Support/Bichon Frise/Kapa"

export SC_QT_HM=$SC_KAPA_HM/19.01.22/Mushama/x64/Anaconda/5.1.0
export SC_QM_X_FN=$SC_QT_HM/bin/qmake
export QT_PLUGIN_PATH=$SC_QT_HM/plugins
export DYLD_FRAMEWORK_PATH=$SC_QT_HM/lib

export SC_PERL_X_FN=/opt/local/bin/perl5.26.3

export SC_MAKE_X_FN=/usr/bin/make

export SC_MILO_PN=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export SC_OLIM_PN=$( cd "$SC_MILO_PN/.." && pwd )

export SC_PYJA_HM=$( cd "$SC_MILO_PN/../../../.." && pwd )
export SC_PYJA_NM=$( basename "$( cd "$SC_PYJA_HM/.." && pwd )" )
export SC_PYJA_VR=$( basename "${SC_PYJA_HM}" )

export SC_ECU_PN=$SC_MILO_PN/ecu

