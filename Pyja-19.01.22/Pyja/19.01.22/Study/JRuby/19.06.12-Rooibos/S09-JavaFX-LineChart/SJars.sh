#!/bin/bash

export SC_JARS=$SC_TONO_HM/ecu/ORun.jar
export SC_JARS=$SC_KAPA_HM/19.01.22/Cumuni/Akka/2.5.19/akka-actor_2.12-2.5.19.jar:$SC_JARS
export SC_JARS=$SC_KAPA_HM/19.01.22/Cumuni/Groovy/2.5.5/indy/groovy-2.5.5-indy.jar:$SC_JARS
export SC_JARS=$SC_KAPA_HM/19.01.22/Cumuni/Groovy/2.5.5/indy/groovy-jsr223-2.5.5-indy.jar:$SC_JARS
export SC_JARS=$SC_KAPA_HM/19.01.22/Cumuni/Scala/2.12.8/lib/scala-library.jar:$SC_JARS
export SC_JARS=$JRUBY_HOME/lib/jruby.jar:$SC_JARS

export SC_JAVA_LPS=$SC_TONO_HM/ecu
