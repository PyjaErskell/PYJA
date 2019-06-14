@ECHO OFF
SETLOCAL

SET PATH=%SystemRoot%\system32

SET SC_THIS_BN=%~NX0
SET SC_THIS_JN=%~N0

PUSHD "%~DP0"
CD "%~DP0"
SET SC_TONO_HM=%CD%
CD %SC_TONO_HM%\..
SET SC_MILO_PN=%CD%
CD "%SC_MILO_PN%\..\..\.."
SET SC_PYJA_HM=%CD%
CD "%SC_PYJA_HM%\.."
SET SC_PYJA_RT=%CD%
FOR %%F IN (%SC_PYJA_RT%) DO SET SC_PYJA_NM=%%~NXF
FOR %%F IN (%SC_PYJA_HM%) DO SET SC_PYJA_VR=%%~NXF
POPD

CALL "%SC_PYJA_HM%\Config\SSet-KAPA.bat"
CALL "%SC_PYJA_HM%\Config\JDK\x64\SSet-JDK-8-212.bat"
CALL "%SC_PYJA_HM%\Config\JRuby\SSet-JRuby-9.2.5.0.bat"

SET SC_JAVA_XMX=-Xmx9g

SET JAVA_HOME=%SC_J8_HM%

SET JRUBY_HOME=%SC_JRUBY_HM%
SET RUBYLIB=%SC_MILO_PN%

SET SC_PATH=%PATH%

ECHO PYJA name =^> %SC_PYJA_NM%
ECHO PYJA version =^> %SC_PYJA_VR%
ECHO PYJA root =^> %SC_PYJA_RT%
ECHO PYJA home =^> %SC_PYJA_HM%
ECHO MILO path =^> %SC_MILO_PN%
ECHO TONO home =^> %SC_TONO_HM%
ECHO KAPA home =^> %SC_KAPA_HM%

SET SC_JARS=%SC_TONO_HM%\ecu\ORun.jar
SET SC_JARS=%SC_KAPA_HM%\19.01.22\Cumuni\Groovy\2.5.5\indy\groovy-2.5.5-indy.jar;%SC_JARS%
SET SC_JARS=%SC_KAPA_HM%\19.01.22\Cumuni\Groovy\2.5.5\indy\groovy-jsr223-2.5.5-indy.jar;%SC_JARS%
SET SC_JARS=%SC_JRUBY_JAR_FN%;%SC_JARS%

SET SC_JAVA_LPS=%SC_TONO_HM%\ecu

ECHO PATH =^> %SC_PATH%

ECHO Java home =^> %JAVA_HOME%
ECHO Java maximum heap size option =^> %SC_JAVA_XMX%

"%SC_J8_X_FN%" "%SC_JAVA_XMX%" -Dfile.encoding=UTF-8 -cp "%SC_JARS%" -Djava.library.path="%SC_JAVA_LPS%" ORun %*

ENDLOCAL
