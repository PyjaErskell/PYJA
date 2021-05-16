#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/SCommon.sh"

export SC_PERL_X_FN=/opt/local/bin/perl5.26.3

export SC_QM_X_FN=$SC_QT_HM/bin/qmake

export SC_MAKE_X_FN=/usr/bin/make

export SC_INC_PATH=$SC_ECU_PN
export SC_INC_PATH=$SC_INC_PATH:$SC_JAVA_HM/include
export SC_INC_PATH=$SC_INC_PATH:$SC_JAVA_HM/include/darwin

export SC_LIBS=$SC_JAVA_HM/jre/lib/server/libjvm.dylib

"$SC_PERL_X_FN" -CS -I "$SC_MILO_PN/src/k-09001-perl" "$SC_MILO_PN/src/k-01001-make/SToa.pl" "$@"
