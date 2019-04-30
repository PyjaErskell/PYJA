IF 1==0 ( 
  CALL "%SC_PYJA_HM%\Config\Anaconda\x64\SSet-Anaconda-5.1.0.bat"
  CALL "%SC_PYJA_HM%\Config\RubyInstaller\x64\SSet-Ruby-2.3.3.bat"
) ELSE (
  CALL "%SC_PYJA_HM%\Config\MSYS2\x64\SSet-MSYS2.bat"
  CALL "%SC_PYJA_HM%\Config\MSYS2\x64\SSet-Python-3.7.2.bat"
  CALL "%SC_PYJA_HM%\Config\MSYS2\x64\SSet-Ruby-2.6.0.bat"
)
CALL "%SC_PYJA_HM%\Config\JDK\x64\SSet-JDK-8-212.bat"

SET SC_JAVA_XMX=-Xmx9g
