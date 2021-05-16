#!/bin/bash

export SC_MILO_PN=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export SC_OLIM_PN=$( cd "$SC_MILO_PN/.." && pwd )

export SC_MILO_NM=$( basename "${SC_MILO_PN}" )
export SC_OLIM_NM=$( basename "${SC_OLIM_PN}" )

export SC_OLMI_NM="$SC_OLIM_NM : $SC_MILO_NM"

export SC_PYJA_HM=$( cd "$SC_MILO_PN/../../../.." && pwd )
export SC_PYJA_NM=$( basename "$( cd "$SC_PYJA_HM/.." && pwd )" )
export SC_PYJA_VR=$( basename "${SC_PYJA_HM}" )

export SC_ECU_PN=$SC_MILO_PN/ecu

export SC_KAPA_HM="/Library/Application Support/Bichon Frise/Kapa"

export SC_QT_HM=$SC_KAPA_HM/19.01.22/Mushama/x64/Anaconda/5.1.0

export SC_JAVA_HM=$SC_KAPA_HM/19.11.01/Mushama/x64/Amazon/Corretto/8.232.09.1

export PATH=/usr/bin:/bin:/usr/sbin:/sbin
