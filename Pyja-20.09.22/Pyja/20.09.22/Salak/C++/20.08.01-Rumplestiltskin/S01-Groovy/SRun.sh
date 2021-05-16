#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/SCommon.sh"

export SC_APP_FONT_FN=$SC_KAPA_HM/19.11.01/Cumuni/Fonts/20.01.14/NanumGothicCoding.ttf

export SC_JAVA_XMX=-Xmx9g

export QT_PLUGIN_PATH=$SC_QT_HM/plugins

export LD_LIBRARY_PATH=$SC_JAVA_HM/jre/lib/server

export SC_GROOVY_HM=$SC_KAPA_HM/19.11.01/Cumuni/Groovy/3.0.8

export SC_JARS=$SC_GROOVY_HM/indy/groovy-3.0.8-indy.jar
export SC_JARS=$SC_JARS:$SC_GROOVY_HM/indy/groovy-jsr223-3.0.8-indy.jar

"$SC_ECU_PN/SToa" "$@"
