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
rem CALL "%SC_TONO_HM%\SSet-x32.bat"
CALL "%SC_TONO_HM%\SSet-x64.bat"


SET JAVA_HOME=%SC_J8_HM%
SET PYTHONHOME=%SC_PYTHON_HM%
SET PYTHON=%SC_PYTHON_EXE_FN%

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

ECHO Qt Jambi home =^> %SC_QTJ_HM%

SET QT_PLUGIN_PATH=%SC_QTJ_PLUGIN_PN%

SET SC_JAVA_JARS=%SC_QTJ_JAR_FN%
SET SC_JAVA_LPS=%SC_QTJ_LIB_PN%

"%SC_RUBY_X_FN%" "%SC_TONO_HM%\SToa.rb" %*

ENDLOCAL