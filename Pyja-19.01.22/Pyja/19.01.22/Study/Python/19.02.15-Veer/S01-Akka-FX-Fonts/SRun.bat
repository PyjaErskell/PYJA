@ECHO OFF
SETLOCAL

SET PATH=%SystemRoot%\system32

SET SC_THIS_BN=%~NX0
SET SC_THIS_JN=%~N0

PUSHD "%~DP0"
CD "%~DP0"
SET SC_APP_PN=%CD%
CD %SC_APP_PN%\..
SET SC_MILO_PN=%CD%
CD "%SC_MILO_PN%\..\..\.."
SET SC_PYJA_HM=%CD%
FOR %%F IN (%SC_PYJA_HM%) DO SET SC_PYJA_VR=%%~NXF
CD "%SC_PYJA_HM%\.."
SET SC_PYJA_RT=%CD%
FOR %%F IN (%SC_PYJA_RT%) DO SET SC_PYJA_NM=%%~NXF
POPD

CALL "%SC_PYJA_HM%\Config\SSet-KAPA.bat"
CALL "%SC_PYJA_HM%\Config\OpenJDK\x64\SSet-JDK-11.0.2.bat"
CALL "%SC_PYJA_HM%\Config\OpenJFX\x64\SSet-JFX-11.bat"
CALL "%SC_PYJA_HM%\Config\Anaconda\x64\SSet-Anaconda-5.1.0.bat"
SET SC_JAVA_XMX=-Xmx9g

SET JAVA_HOME=%SC_J11_HM%

SET PYTHONHOME=%SC_PYTHON_HM%
SET QT_QPA_PLATFORM_PLUGIN_PATH=%SC_PYTHON_HM%\Library\plugins
SET QT_AUTO_SCREEN_SCALE_FACTOR=1

SET PATH=%SC_PYTHON_HM%;%PATH%
SET SC_PATH=%PATH%

ECHO PATH =^> %SC_PATH%

ECHO MILO path =^> %SC_MILO_PN%
ECHO KAPA home =^> %SC_KAPA_HM%
ECHO PYJA name =^> %SC_PYJA_NM%
ECHO PYJA version =^> %SC_PYJA_VR%
ECHO PYJA root =^> %SC_PYJA_RT%
ECHO PYJA home =^> %SC_PYJA_HM%

ECHO Java home =^> %JAVA_HOME%
ECHO Java maximum heap size option =^> %SC_JAVA_XMX%

ECHO Python home =^> %PYTHONHOME%
ECHO Jep jar file =^> %SC_JEP_JAR_FN%

SET SC_ALL_JARS="%SC_MILO_PN%\ecu\ORun.jar"
SET SC_ALL_JARS="%SC_JEP_JAR_FN%";%SC_ALL_JARS%

SET SC_ALL_JARS="%SC_KAPA_HM%\19.01.22\Cumuni\Akka\2.5.19\akka-actor_2.12-2.5.19.jar";%SC_ALL_JARS%
SET SC_ALL_JARS="%SC_KAPA_HM%\19.01.22\Cumuni\Groovy\2.5.5\indy\groovy-2.5.5-indy.jar";%SC_ALL_JARS%
SET SC_ALL_JARS="%SC_KAPA_HM%\19.01.22\Cumuni\Groovy\2.5.5\indy\groovy-jsr223-2.5.5-indy.jar";%SC_ALL_JARS%
SET SC_ALL_JARS="%SC_KAPA_HM%\19.01.22\Cumuni\JNA\5.1.0\jna-5.1.0.jar";%SC_ALL_JARS%
SET SC_ALL_JARS="%SC_KAPA_HM%\19.01.22\Cumuni\JNA\5.1.0\jna-platform-5.1.0.jar";%SC_ALL_JARS%
SET SC_ALL_JARS="%SC_KAPA_HM%\19.01.22\Cumuni\Logback\1.2.3\logback-classic-1.2.3.jar";%SC_ALL_JARS%
SET SC_ALL_JARS="%SC_KAPA_HM%\19.01.22\Cumuni\Logback\1.2.3\logback-core-1.2.3.jar";%SC_ALL_JARS%
SET SC_ALL_JARS="%SC_KAPA_HM%\19.01.22\Cumuni\Scala\2.12.8\lib\scala-library.jar";%SC_ALL_JARS%
SET SC_ALL_JARS="%SC_KAPA_HM%\19.01.22\Cumuni\SLF4J\1.7.25\slf4j-api-1.7.25.jar";%SC_ALL_JARS%
SET SC_ALL_JARS="%SC_KAPA_HM%\19.01.22\Cumuni\Typesafe\Config\1.3.3\config-1.3.3.jar";%SC_ALL_JARS%

SET SC_ALL_JAVA_LIB_PATHS="%SC_JEP_PN%"

SET SC_ALL_MODULE_PATHS="%SC_FX11_HM%\lib"

SET SC_ALL_MODULES=javafx.controls

"%SC_J11_X_FN%" "%SC_JAVA_XMX%" --module-path %SC_ALL_MODULE_PATHS% --add-modules=%SC_ALL_MODULES% -cp %SC_ALL_JARS% -Djava.library.path=%SC_ALL_JAVA_LIB_PATHS% ORun "%SC_APP_PN%\SToa.py" %*

ENDLOCAL
