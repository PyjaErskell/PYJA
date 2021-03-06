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
CALL "%SC_PYJA_HM%\Config\CitrusPerl\x64\SSet-CitrusPerl-5.24.1.bat"
CALL "%SC_PYJA_HM%\Config\OpenJDK\x64\SSet-JDK-11.0.2.bat"
CALL "%SC_PYJA_HM%\Config\OpenJFX\x64\SSet-JFX-11.bat"
CALL "%SC_PYJA_HM%\Config\Anaconda\x64\SSet-Anaconda-5.1.0.bat"

SET QT_QPA_PLATFORM_PLUGIN_PATH=%SC_PYTHON_HM%\Library\plugins
SET QT_AUTO_SCREEN_SCALE_FACTOR=1

SET PATH=%SC_PYTHON_HM%;%PATH%

SET SC_PATH=%PATH%

"%SC_PERL_EXE_FN%" "%SC_TONO_HM%\%SC_THIS_JN%.pl" %*

ENDLOCAL
