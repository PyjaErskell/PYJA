@ECHO OFF

SET SC_KAPA_HM=%ProgramData%\Bichon Frise\Kapa

SET SC_QT_HM=C:\Qt\Qt5.14.0\5.14.0\mingw73_64
SET SC_QM_X_FN=%SC_QT_HM%\bin\qmake.exe
SET QT_PLUGIN_PATH=%SC_QT_HM%\plugins
SET PATH=%SC_QT_HM%\bin;%PATH%

SET SC_PERL_HM=%SC_KAPA_HM%\19.01.22\Vindue\x64\Strawberry\5.28.1\perl
SET SC_PERL_X_FN=%SC_PERL_HM%\bin\perl5.28.1.exe

SET SC_MINGW_HM=C:\Qt\Qt5.14.0\Tools\mingw730_64
SET SC_MAKE_X_FN=%SC_MINGW_HM%\bin\mingw32-make.exe
SET PATH=%SC_MINGW_HM%\bin;%PATH%

PUSHD "%~DP0"
CD "%~DP0"

SET SC_MILO_PN=%CD%
CD "%SC_MILO_PN%\.."
SET SC_OLIM_PN=%CD%

CD "%SC_MILO_PN%\..\..\..\.."
SET SC_PYJA_HM=%CD%
FOR %%F IN (%SC_PYJA_HM%\..) DO SET SC_PYJA_NM=%%~NXF
FOR %%F IN (%SC_PYJA_HM%) DO SET SC_PYJA_VR=%%~NXF

SET SC_ECU_PN=%SC_MILO_PN%\ecu

POPD
