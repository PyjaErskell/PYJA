#!/bin/bash

__SAC_KAPA_HM=/Library/Application\ Support/Bichon\ Frise/Kapa
__SAC_JAVA_HM=$__SAC_KAPA_HM/19.11.01/Mushama/x64/Amazon/Corretto/8.232.09.1
__SAC_PYTHON_HM=$__SAC_KAPA_HM/19.01.22/Mushama/x64/Anaconda/5.1.0
__SAC_JEP_PN=$__SAC_PYTHON_HM/lib/python3.6/site-packages/jep
__SAC_JEP_JAR_FN=$__SAC_JEP_PN/jep-3.7.1.jar

export PYTHONHOME=$__SAC_PYTHON_HM
export LD_LIBRARY_PATH=$PYTHONHOME/lib
export PATH=$PYTHONHOME:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

if test "x$*" = "x"
then
  "$__SAC_JAVA_HM/bin/java" -classpath "$__SAC_JEP_JAR_FN" -Djava.library.path="$__SAC_JEP_PN" jep.Run "$__SAC_JEP_PN/console.py"
else
  "$__SAC_JAVA_HM/bin/java" -classpath "$__SAC_JEP_JAR_FN" -Djava.library.path="$__SAC_JEP_PN" jep.Run $@
fi

