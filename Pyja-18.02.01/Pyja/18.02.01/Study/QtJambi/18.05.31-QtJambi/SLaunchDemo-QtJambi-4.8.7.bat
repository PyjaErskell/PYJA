@ECHO OFF
SETLOCAL

SET PATH=%SystemRoot%\system32

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

CALL "%SC_PYJA_HM%\Config\SSet-JDK-8.bat"
CALL "%SC_PYJA_HM%\Config\SSet-QtJambi-4.8.7.bat"

SET JAVA_HOME=%SC_J8_HM%
SET SC_JAVA_XMX=-Xmx9g

SET SC_PATH=%PATH%

ECHO PATH =^> %SC_PATH%"

ECHO MILO path =^> %SC_MILO_PN%
ECHO PYJA name =^> %SC_PYJA_NM%
ECHO PYJA version =^> %SC_PYJA_VR%
ECHO PYJA root =^> %SC_PYJA_RT%
ECHO PYJA home =^> %SC_PYJA_HM%

ECHO Java home =^> %JAVA_HOME%
ECHO Java maximum heap size option =^> %SC_JAVA_XMX%

ECHO Qt Jambi home =^> %SC_QTJ_HM%

SET QT_PLUGIN_PATH=%SC_QTJ_PLUGIN_PN%

"%SC_J8_X_FN%" "%SC_JAVA_XMX%" -cp "%SC_QTJ_ALL_JARS%" -Djava.library.path="%SC_QTJ_LIB_PN%" com.trolltech.launcher.Launcher

ENDLOCAL


