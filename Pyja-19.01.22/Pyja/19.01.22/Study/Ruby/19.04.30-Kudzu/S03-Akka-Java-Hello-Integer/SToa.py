import os
import psutil
import platform
import time
from datetime import datetime

# yo = p(y)thon (o)bject

def gp_yn ( x_yo, x_nethod_nm, *x_args ) : # from yo, call (n)ethod
  if hasattr ( x_yo, x_nethod_nm ) : getattr ( x_yo, x_nethod_nm ) (*x_args)
def gf_ym ( x_yo, x_method_nm, *x_args ) : # from yo, call (m)ethod
  if hasattr ( x_yo, x_method_nm ) : return getattr ( x_yo, x_method_nm ) (*x_args)

from PyQt5 import QtCore
from PyQt5 import QtGui
from PyQt5.QtCore import QAbstractTableModel
from PyQt5.QtCore import QModelIndex
from PyQt5.QtCore import QObject
from PyQt5.QtCore import Qt
from PyQt5.QtCore import QThread
from PyQt5.QtCore import QTimer
from PyQt5.QtCore import QVariant
from PyQt5.QtGui import QFontDatabase
from PyQt5.QtWidgets import QAbstractItemView
from PyQt5.QtWidgets import QApplication
from PyQt5.QtWidgets import QDesktopWidget
from PyQt5.QtWidgets import QMainWindow
from PyQt5.QtWidgets import QPushButton
from PyQt5.QtWidgets import QTableView
from PyQt5.QtWidgets import QVBoxLayout
from PyQt5.QtWidgets import QWidget

class HQAbstractTableModel (QAbstractTableModel) :
  def __init__ ( self, x_ro ) : super () .__init__ (); self.hu_ro = x_ro
  def rowCount ( self, x_parent = QModelIndex () ) : return gf_ym ( self.hu_ro, 'rowCount', x_parent )
  def columnCount ( self, x_parent = QModelIndex () ) : return gf_ym ( self.hu_ro, 'columnCount', x_parent )
  def headerData ( self, x_column, x_orientation, x_role ) : return gf_ym ( self.hu_ro, 'headerData', x_column, x_orientation, x_role )
  def data ( self, x_index, x_role ) : return gf_ym ( self.hu_ro, 'data', x_index, x_role )
