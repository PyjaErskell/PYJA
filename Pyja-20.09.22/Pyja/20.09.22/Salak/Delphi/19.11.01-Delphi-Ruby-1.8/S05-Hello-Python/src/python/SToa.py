#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

import sys

sys.dont_write_bytecode = True

import os

os.environ['QT_PLUGIN_PATH'] = GC_QT_PLUGIN_PATH
os.environ['QT_AUTO_SCREEN_SCALE_FACTOR'] = '1' # High-DPI Support in Qt 5.6

import platform
from PyQt5 import QtCore

GC_PYTHON_VR = platform .python_version ()
GC_PYQT_VR = QtCore .qVersion ()

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

def sf_hello ( x_str, x_no ) : return 'Hello {} !!!' .format ( x_str * x_no )
def sf_sum ( * x_args ) : return sum (x_args)