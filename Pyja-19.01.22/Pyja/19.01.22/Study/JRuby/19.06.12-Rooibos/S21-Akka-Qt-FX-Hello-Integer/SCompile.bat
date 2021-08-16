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

SET JAVA_HOME=%SC_J8_HM%
SET SC_JAVA_XMX=-Xmx9g

CALL "%SC_PYJA_HM%\Config\MSYS2\x64\SSet-MSYS2.bat"
CALL "%SC_PYJA_HM%\Config\MSYS2\x64\SSet-Ruby-2.6.0.bat"

SET SC_PATH=%PATH%

"%SC_RUBY_X_FN%" "%SC_TONO_HM%\%SC_THIS_JN%.rb" %*

ENDLOCAL