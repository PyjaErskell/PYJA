@ECHO OFF
SETLOCAL

SET PATH=%SystemRoot%\system32

SET SC_THIS_BN=%~NX0
SET SC_THIS_JN=%~N0

PUSHD "%~DP0"
CD "%~DP0"
SET SC_MILO_PN=%CD%
CD "%SC_MILO_PN%\..\..\.."
SET SC_PYJA_HM=%CD%
FOR %%F IN (%SC_PYJA_HM%) DO SET SC_PYJA_VR=%%~NXF
CD "%SC_PYJA_HM%\.."
SET SC_PYJA_RT=%CD%
FOR %%F IN (%SC_PYJA_RT%) DO SET SC_PYJA_NM=%%~NXF
POPD

CALL "%SC_PYJA_HM%\Config\SSet-KAPA.bat"
CALL "%SC_MILO_PN%\SSet-QtJambi-4.5.2-x32.bat"

SET JAVA_HOME=%SC_J_HM%

SET SC_GROOVY_HM=%SC_KAPA_HM%\19.01.22\Cumuni\Groovy\2.4.16

SET QT_PLUGIN_PATH=%SC_QTJ_PLUGIN_PN%

SET SC_PATH=%PATH%

ECHO PATH =^> %SC_PATH%

ECHO MILO path =^> %SC_MILO_PN%
ECHO KAPA home =^> %SC_KAPA_HM%
ECHO PYJA name =^> %SC_PYJA_NM%
ECHO PYJA version =^> %SC_PYJA_VR%
ECHO PYJA root =^> %SC_PYJA_RT%
ECHO PYJA home =^> %SC_PYJA_HM%

ECHO KAPA home =^> %SC_KAPA_HM%

ECHO Java home =^> %JAVA_HOME%
ECHO Java maximum heap size option =^> %SC_JAVA_XMX%

ECHO Groovy home =^> %SC_GROOVY_HM%
ECHO Qt Jambi home =^> %SC_QTJ_HM%

SET SC_ALL_JARS="%SC_GROOVY_HM%\lib\groovy-2.4.16.jar"
SET SC_ALL_JARS="%SC_QTJ_JAR_FN%";%SC_ALL_JARS%

SET SC_ALL_JAVA_LIB_PATHS="%SC_QTJ_LIB_PN%"

"%SC_J_X_FN%" "%SC_JAVA_XMX%" -Dfile.encoding=UTF-8 -cp %SC_ALL_JARS% -Djava.library.path=%SC_ALL_JAVA_LIB_PATHS% org.codehaus.groovy.tools.GroovyStarter --main groovy.ui.GroovyMain %*

ENDLOCAL
