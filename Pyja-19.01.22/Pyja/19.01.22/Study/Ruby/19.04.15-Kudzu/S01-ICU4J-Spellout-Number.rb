#---------------------------------------------------------------
# Ruby (Global)
#---------------------------------------------------------------

$__gau_app_st = Time.now

require 'date'
require 'etc'
require 'fileutils'
require 'hash_dot'
require 'heredoc_unindent'
require 'logger'
require 'socket'

Hash.use_dot_syntax = true

GC_PYJA_NM = 'Pyja'
GC_PYJA_AU = 'Erskell' # (au)thor

GC_PJYA_CEN = 20
GC_PYJA_YEA = 19
GC_PYJA_MON =  1
GC_PYJA_DAY = 22

GC_PYJA_CD = '%02d%02d.%02d.%02d' % [ GC_PJYA_CEN, GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY ] # Pyja creation date
GC_PYJA_VR = '%02d.%02d.%02d' % [ GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY ]                  # Pyja version with fixed length 8
GC_PYJA_V2 = '%d.%d.%d' % [ GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY ]                        # Pyja version without leading zero

GC_PYJA_VER_MAJ = GC_PYJA_YEA # Major
GC_PYJA_VER_MIN = GC_PYJA_MON # Minor
GC_PYJA_VER_PAT = GC_PYJA_DAY # Patch

GC_PYJA_RT_SYM = '@`'
GC_PYJA_HM_SYM = '@~'
GC_MILO_PN_SYM = '@!'

GC_EC_NONE     = -200
GC_EC_SHUTDOWN = -199
GC_EC_SUCCESS  = 0
GC_EC_ERROR    = 1

GC_FOSA = File::SEPARATOR      # (fo)lder (s)ep(a)rator
GC_PASA = File::PATH_SEPARATOR # (pa)th (s)ep(a)rator

def gf_os_env x_it; ENV .fetch x_it.to_s; end
def gp_set_const x_sym, x_val; Object .const_set x_sym, x_val; end
def gf_str_is_valid_date x_str, x_format; Date .strptime x_str, x_format; end
def gf_rm_px x_str, x_px # px : prefix
  ( x_str .start_with? x_px ) ? x_str [ x_px.size .. -1 ] : x_str
end

def gf_bn x_fn; File .basename x_fn; end
def gf_ap x_it; File .expand_path x_it; end
def gf_jn x_fn; File .basename x_fn, ( File .extname x_fn ); end
def gf_xn x_fn
  fu_list = ( File .basename x_fn ) .split ('.')
  return ( fu_list.size < 2 ) ? '' : fu_list [-1]
end
def gf_xi x_it; File .exist? x_it; end 
def gf_id x_it; File .directory? x_it; end
def gf_if x_it; File .file? x_it; end
def gf_pj *x_args; File .join x_args; end
Object .alias_method :gf_jar_pj, :gf_pj
def gp_mp x_pn; FileUtils .mkdir_p x_pn if not gf_id x_pn; end
def gp_rp x_pn # (r)emove (p)ath
  FileUtils .remove_dir x_pn if gf_id x_pn
end
def gp_ep x_pn  # (e)mpty out (p)ath
  return unless gf_id x_pn
  ( Dir .glob gf_pj x_pn, '*' ) .each { |it|
    if gf_id x_pn
      FileUtils .remove_dir it
    else
      FileUtils .rm it
    end
  }
end
def gf_pn x_it, x_chedk_id = false; ( x_chedk_id and gf_id x_it ) ? (x_it) : ( File .dirname x_it ); end # (p)ath (n)ame
def gf_on x_it, x_chedk_id = false; gf_bn ( gf_pn x_it, x_chedk_id ); end # f(o)lder (n)ame

GC_KAPA_HM   = gf_ap gf_os_env(:SC_KAPA_HM)
GC_PYJA_RT   = gf_ap gf_os_env(:SC_PYJA_RT)
GC_PYJA_HM   = gf_ap gf_os_env(:SC_PYJA_HM)
GC_MILO_PN   = gf_ap gf_os_env(:SC_MILO_PN)
GC_MILO_NM   = gf_bn GC_MILO_PN

def gf_replace_with_px_symbol x_pn, x_px_path, x_px_symbol
  fu_pn = gf_ap x_pn
  if fu_pn.start_with? x_px_path
    bu2_tail = fu_pn [ x_px_path.size + 1 .. -1 ]
    if bu2_tail.nil?
      x_px_symbol
    else
      gf_pj x_px_symbol, bu2_tail
    end
  else
    fu_pn
  end
end
def gf_to_prs x_pn # to (p)yja (r)oot (s)ymbol
  gf_replace_with_px_symbol x_pn, GC_PYJA_RT, GC_PYJA_RT_SYM
end
def gf_to_phs x_pn # to (p)yja (h)ome (s)ymbol
  gf_replace_with_px_symbol x_pn, GC_PYJA_HM, GC_PYJA_HM_SYM
end
def gf_to_mps x_pn # to (m)ilo (p)ath (s)ymbol
  gf_replace_with_px_symbol x_pn, GC_MILO_PN, GC_MILO_PN_SYM
end

#---------------------------------------------------------------
# Java (Global)
#---------------------------------------------------------------

require 'rjb'

->() {
  pu_jar_fn_lst = [
    ( gf_jar_pj GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.5', 'indy', 'groovy-2.5.5-indy.jar' ),
    ( gf_jar_pj GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.5', 'indy', 'groovy-jsr223-2.5.5-indy.jar' ),
  ]
  Rjb::load ( pu_jar_fn_lst .join GC_PASA ), [ gf_os_env(:SC_JAVA_XMX) ]
}.()

$__jau_gr = ( Rjb::import 'javax.script.ScriptEngineManager' ) .new .getEngineByName ('Groovy')

def jy_ge x_gr = $__jau_gr, x_str; x_gr .eval x_str; end # ge = (g)roovy (e)val
def jy_gf x_gr = $__jau_gr, x_nm, x_args; x_gr .invokeFunction x_nm, x_args; end # gf = (g)roovy (f)unction
def jy_gm x_gr = $__jau_gr, x_jo, x_nm, x_args; x_gr .invokeMethod x_jo, x_nm, x_args; end # gm = (g)roovy (m)ethod, jo = (j)ava (o)bject
def jy_gc x_gr = $__jau_gr, x_closure, x_args # gc = (g)roovy (c)losure
  yu_closure = ( x_closure .kind_of? String ) ? ( jy_ge x_gr, x_closure ) : x_closure
  jy_gm x_gr, yu_closure, 'call', x_args
end

jy_ge <<-__JASH_EOS.unindent
  gf_cls = { final x_cls_nm -> Class .forName x_cls_nm }
  gf_is_instance = { final x_cls, final x_jo -> x_cls .isInstance x_jo } // jo = (j)ava (o)bject
  gp_add_jar = { final x_jar_fn ->
    final pu_jar_fl = new File (x_jar_fn)
    if ( ! pu_jar_fl .exists () ) { throw new FileNotFoundException ( "JAR file not found => ${x_jar_fn}" ) }
    URLClassLoader.class .getDeclaredMethod ( 'addURL', URL.class ) .with {
      accessible = true
      invoke ClassLoader.systemClassLoader, pu_jar_fl .toURI () .toURL ()
    }
  }
__JASH_EOS

def jf_cls x_cls_nm; jy_gf 'gf_cls', [x_cls_nm]; end
def jf_is_instance x_cls, x_jo; jf_gf 'gf_is_instance', x_cls, x_jo; end # jo = (j)ava (o)bject
def jp_add_jar x_jar_fn; jy_gf 'gp_add_jar', [x_jar_fn]; end

[
  ( gf_jar_pj GC_KAPA_HM, '19.01.22', 'Cumuni', 'JNA', '5.1.0', 'jna-5.1.0.jar' ),
  ( gf_jar_pj GC_KAPA_HM, '19.01.22', 'Cumuni', 'JNA', '5.1.0', 'jna-platform-5.1.0.jar' ),
] .each { |bx2_jar_fn| jp_add_jar bx2_jar_fn }

#---------------------------------------------------------------
# Python (Global)
#---------------------------------------------------------------

require 'pycall/import'
include PyCall::Import

def yp_sa x_yo, x_nm, x_val; PyCall.builtins .setattr x_yo, x_nm, x_val; end # yo = p(y)thon (o)bject
def yf_e x_expr, x_globals: nil, x_locals: nil; PyCall::eval x_expr, globals: x_globals, locals: x_locals; end
def yp_e x_code, x_globals: nil, x_locals: nil; PyCall::exec x_code, globals: x_globals, locals: x_locals; end

yp_e <<-__YASH_EOS.unindent
  import sys
  sys.dont_write_bytecode = True
  import os
  import psutil
  import platform
  from datetime import datetime
  
  # yo = p(y)thon (o)bject
  
  def gp_yn ( x_yo, x_nethod_nm, *x_args ) : # from yo, call (n)ethod
    if hasattr ( x_yo, x_nethod_nm ) : getattr ( x_yo, x_nethod_nm ) (*x_args)
  def gf_ym ( x_yo, x_method_nm, *x_args ) : # from yo, call (m)ethod
    if hasattr ( x_yo, x_method_nm ) : return getattr ( x_yo, x_method_nm ) (*x_args)
__YASH_EOS

pyfrom :'PyQt5', import: :QtCore
pyfrom :'PyQt5', import: :QtGui
pyfrom :'PyQt5.QtCore', import: :QModelIndex
pyfrom :'PyQt5.QtCore', import: :Qt
pyfrom :'PyQt5.QtCore', import: :QVariant
pyfrom :'PyQt5.QtGui', import: :QFontDatabase
pyfrom :'PyQt5.QtWidgets', import: :QAbstractItemView
pyfrom :'PyQt5.QtWidgets', import: :QApplication
pyfrom :'PyQt5.QtWidgets', import: :QDesktopWidget
pyfrom :'PyQt5.QtWidgets', import: :QMainWindow
pyfrom :'PyQt5.QtWidgets', import: :QTableView
pyfrom :'PyQt5.QtWidgets', import: :QVBoxLayout
pyfrom :'PyQt5.QtWidgets', import: :QWidget

$yu_sys = yf_e 'sys'
$yu_os = yf_e 'os'
$yu_psutil = yf_e 'psutil'
$yu_platform = yf_e 'platform'
$yu_datetime = yf_e 'datetime'

yp_e <<-__YASH_EOS.unindent
  # ro = (r)uby (o)bject
  
  from PyQt5.QtCore import QAbstractTableModel
  from PyQt5.QtCore import QModelIndex
  class HQAbstractTableModel (QAbstractTableModel) :
    def __init__ ( self, x_ro ) : super () .__init__ (); self.hu_ro = x_ro
    def rowCount ( self, x_parent = QModelIndex () ) : return gf_ym ( self.hu_ro, 'rowCount', x_parent )
    def columnCount ( self, x_parent = QModelIndex () ) : return gf_ym ( self.hu_ro, 'columnCount', x_parent )
    def headerData ( self, x_column, x_orientation, x_role ) : return gf_ym ( self.hu_ro, 'headerData', x_column, x_orientation, x_role )
    def data ( self, x_index, x_role ) : return gf_ym ( self.hu_ro, 'data', x_index, x_role )
__YASH_EOS

HyQAbstractTableModel = yf_e 'HQAbstractTableModel'

#---------------------------------------------------------------
# Ruby (Global)
#---------------------------------------------------------------

GC_JAVA_HM  = gf_ap gf_os_env(:SC_J8_HM)
GC_PYTHON_HM = gf_ap gf_os_env(:SC_PYTHON_HM)

GC_APP_ARGV = ARGV
GC_APP_CMD = $yu_psutil.Process .new .cmdline .to_a
GC_APP_EXE_FN = gf_ap $yu_sys.executable
GC_APP_OS_ENV_PATHS = ( gf_os_env :SC_PATH ) .split GC_PASA
GC_APP_PID = Process.pid
GC_APP_SCRIPT_FN = gf_ap $0
GC_APP_ST = $yu_datetime .strptime ( $__gau_app_st .strftime '%F %T' ), '%Y-%m-%d %H:%M:%S'
GC_APP_START_UP_PN = gf_ap Dir .getwd

GC_APP_NM = gf_jn GC_APP_SCRIPT_FN

CjBigInteger = jf_cls 'java.math.BigInteger'
CjBoolean    = jf_cls 'java.lang.Boolean'
CjByte       = jf_cls 'java.lang.Byte'
CjChar       = jf_cls 'java.lang.Character'
CjDouble     = jf_cls 'java.lang.Double'
CjFloat      = jf_cls 'java.lang.Float'
CjInteger    = jf_cls 'java.lang.Integer'
CjLong       = jf_cls 'java.lang.Long'
CjShort      = jf_cls 'java.lang.Short'
CjString     = jf_cls 'java.lang.String'
CjSystem     = jf_cls 'java.lang.System'

CjGroovySystem = jf_cls 'groovy.lang.GroovySystem'
CjPlatform = jf_cls 'com.sun.jna.Platform'
CjScriptEngineManager = jf_cls 'javax.script.ScriptEngineManager'

GC_RUBY_VR   = RUBY_VERSION
GC_JAVA_VR   = CjSystem .getProperty 'java.version'
GC_GROOVY_VR = CjGroovySystem.version
GC_PYTHON_VR = $yu_platform .python_version
GC_PYQT_VR = QtCore .qVersion

GC_TOTAL_CPU = Etc.nprocessors
GC_TOTAL_MEMORY = $yu_psutil .virtual_memory .total
GC_HOST_NM = Socket .gethostname
GC_CUSR = Etc .getlogin  # current user

GC_QAPP = QApplication.new []

def gf_process x_pid; $yu_psutil.Process .new x_pid; end
def gf_os_available_memory; $yu_psutil .virtual_memory .available; end

GC_LOG = ->() {
  fu_it = Logger .new STDOUT
  fu_it.level = Logger::DEBUG  # Logger::INFO
  fu_it.formatter = proc do | bx2_severity, bx2_datetime, bx2_progname, bx2_msg |
    bu2_datetime = bx2_datetime.strftime '%y%m%d-%H%M%S'
    "[#{ '%06d' % GC_APP_PID },#{bx2_severity.chars.first},#{bu2_datetime}] #{bx2_msg}\n"
  end
  fu_it
}.()
def gp_set_log_level_to_info; GC_LOG .level = Logger::INFO; end
def gp_set_log_level_to_debug; GC_LOG .level = Logger::DEBUG; end
def gp_log_array xp_out = ( GC_LOG.method :info ), x_title, x_array
  return if x_array.empty?
  xp_out .call "#{x_title} =>"
  x_array .each .with_index (1) { | bx2_it, bx2_idx | xp_out .call "  #{'%2d' % bx2_idx} : #{bx2_it}" }
end
def gp_log_header xp_out = ( GC_LOG.method :info ), x_header, x_line_width
  xp_out .call '+' + '-' * x_line_width
  xp_out .call ": #{x_header}"
  xp_out .call '+' + '-' * x_line_width
end
def gp_log_exception xp_out = ( GC_LOG.method :error ), x_title, x_ex
  gp_log_header xp_out, x_title, 60
  xp_out .call x_ex.message
  x_ex .backtrace .each { |bx2_it| xp_out .call "  #{bx2_it}" } unless x_ex .backtrace .nil?
end

def gf_banner x_leading_space = 0, x_margin_inside = 2
  fu_msgs = [
    "#{GC_PYJA_NM} #{GC_PYJA_V2}",
    GC_MILO_NM,
    GC_APP_NM,
    '',
    "made by #{GC_PYJA_AU}",
    "ran on #{ GC_APP_ST .strftime ('%F %T') }",
    'released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.',
  ]
  fu_msl = fu_msgs .map { |bx2_it| bx2_it.size } .max # max string length
  fu_ls = x_leading_space # leading space before box
  fu_mg = x_margin_inside # margin inside box
  fu_ll = fu_mg + fu_msl + fu_mg # line length inside box

  ff2_get_line = ->() { return ' ' * fu_ls + '+' + '-' * fu_ll + '+' }
  ff2_get_string = ->(x2_str) {
    fu2_sl = x2_str.size # string lentgh
    fu2_lm = ( ( fu_ll - fu2_sl ) / 2.0 ) .to_i # left margin inside box
    fu2_rm = fu_ll - ( fu2_sl + fu2_lm ) # right margin inside box
    return ' ' * fu_ls + ':' + ' ' * fu2_lm + x2_str + ' ' * fu2_rm + ':' 
  }
  fu_r = [ff2_get_line.()] + fu_msgs .map { |bx2_msg| ff2_get_string.(bx2_msg) } + [ff2_get_line.()]
  return fu_r
end

def gp_request_exit x_ec, x_ex = nil
  gp_log_array ( GC_LOG.method :debug ), '$LOAD_PATH', $: .sort
  gp_log_exception 'Following error occurs !!!', x_ex unless x_ex .nil?
  GC_LOG.info "Exit code => #{x_ec}"
  GC_LOG.info "Elpased #{ $yu_datetime.now - GC_APP_ST } ..."
  exit x_ec
end

#---------------------------------------------------------------
# Main Skeleton
#---------------------------------------------------------------

module DRun
  @__dav_ec = GC_EC_NONE
  @__dav_ex = nil
  def self.dp_it
    __dap_begin
    DBody .dp_it
    @__dav_ec = GC_EC_SUCCESS
  rescue Exception => bu2_ex
    @__dav_ec = GC_EC_ERROR
    @__dav_ex = bu2_ex
  ensure
    gp_request_exit @__dav_ec, @__dav_ex
  end
private
  def self.__dap_begin
    puts gf_banner .join "\n"
    GC_LOG .debug "Pyja name => #{GC_PYJA_NM}"
    raise RuntimeError, 'Invalid Pyja name !!!' if GC_PYJA_NM != ( gf_os_env :SC_PYJA_NM )
    GC_LOG .debug "Pyja creation date => #{GC_PYJA_CD}"
    raise RuntimeError, 'Pyja create date is not invalid !!!' unless gf_str_is_valid_date GC_PYJA_CD, '%Y.%m.%d'
    GC_LOG .debug "Pyja version => #{GC_PYJA_V2}"
    raise RuntimeError, 'Invalid Pyja version !!!' if GC_PYJA_VR != ( gf_os_env :SC_PYJA_VR )
    GC_LOG .info  "Pyja root (#{GC_PYJA_RT_SYM}) => #{GC_PYJA_RT}"
    GC_LOG .info  "Pyja home (#{GC_PYJA_HM_SYM}) => #{ gf_to_prs GC_PYJA_HM }"
    GC_LOG .info  "Milo path (#{GC_MILO_PN_SYM}) => #{ gf_to_phs GC_MILO_PN }"
    GC_LOG .info  "Ruby version => #{GC_RUBY_VR}"
    GC_LOG .info  "Java version => #{GC_JAVA_VR}"
    GC_LOG .info  "Groovy version => #{GC_GROOVY_VR}"
    GC_LOG .info  "Python version => #{GC_PYTHON_VR}"
    GC_LOG .info  "PyQt version => #{GC_PYQT_VR}"
    GC_LOG .debug "Java home => #{GC_JAVA_HM}"
    GC_LOG .debug "Python home => #{GC_PYTHON_HM}"
    GC_LOG .debug "Total CPU => #{GC_TOTAL_CPU}"
    GC_LOG .debug "Total memory => #{ CjString .format '%,d', [GC_TOTAL_MEMORY] }"
    GC_LOG .debug "Available memory => #{ CjString .format '%,d', [gf_os_available_memory] }"
    GC_LOG .debug "Computer name => #{GC_HOST_NM}"
    GC_LOG .debug "Current user => #{GC_CUSR}"
    GC_LOG .debug "Process ID => #{GC_APP_PID}"
    GC_LOG .debug "Executable file => #{GC_APP_EXE_FN}"
    GC_LOG .info  "Start up path => #{ gf_to_mps GC_APP_START_UP_PN }"
    GC_LOG .info  "Script file => #{ gf_to_mps GC_APP_SCRIPT_FN }"
    gp_log_array  ( GC_LOG .method :debug ), 'Paths', GC_APP_OS_ENV_PATHS
    gp_log_array  ( GC_LOG .method :debug ), 'Command', GC_APP_CMD
    gp_log_array  'Arguments', GC_APP_ARGV if GC_APP_ARGV.count > 0
  end
end

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

[
  ( gf_jar_pj GC_KAPA_HM, '19.01.22', 'Cumuni', 'ICU4J', '63.1', 'icu4j-63_1.jar' ),
  ( gf_jar_pj GC_KAPA_HM, '19.01.22', 'Cumuni', 'ICU4J', '63.1', 'icu4j-charset-63_1.jar' ),
  ( gf_jar_pj GC_KAPA_HM, '19.01.22', 'Cumuni', 'ICU4J', '63.1', 'icu4j-localespi-63_1.jar' ),
] .each { |bx2_jar_fn| jp_add_jar bx2_jar_fn }

class HSpellout
  attr_reader :hu_it
  def initialize x_total; @hu_total = x_total; __han_init; end
  def __han_init
    nu_cls_rbnf = jf_cls 'com.ibm.icu.text.RuleBasedNumberFormat'
    @hu_rbnf = nu_cls_rbnf .new nu_cls_rbnf.SPELLOUT
    @hu_fixed_fnt = QFontDatabase.systemFont QFontDatabase.FixedFont
    @hu_it = HyQAbstractTableModel .new self
  end
  def rowCount x_parent = QModelIndex .new; @hu_total; end
  def columnCount x_parent = QModelIndex .new; 2; end
  def headerData x_column, x_orientation, x_role
    if x_role == Qt.DisplayRole and x_orientation == Qt.Horizontal
      return QVariant .new 'Number' if x_column == 0
      return QVariant .new 'Spell out' if x_column == 1
    end
    QVariant .new
  end
  def data x_index, x_role
    return QVariant .new unless x_index .isValid
    case x_role
    when Qt.DisplayRole
      bu2_col = x_index .column
      bu2_row = x_index .row
      return QVariant .new CjString .format '%,d', [bu2_row] if bu2_col == 0
      return QVariant .new @hu_rbnf .format bu2_row if bu2_col == 1
    when Qt.TextAlignmentRole
      bu2_col = x_index .column
      return Qt.AlignRight | Qt.AlignVCenter if bu2_col == 0
      return Qt.AlignLeft | Qt.AlignVCenter if bu2_col == 1
    when Qt.FontRole
      bu2_col = x_index .column
      return @hu_fixed_fnt if bu2_col == 0
    end
    QVariant .new
  end
end

class WMain
  def initialize; __wan_init; end
  def __wan_init
    def nf2_it
      QMainWindow .new .tap { |x_it|
        x_it .setWindowTitle GC_APP_NM
        yp_sa x_it, 'closeEvent', ->(x_ev_close) {__wan_quit}
        x_it .setCentralWidget QWidget .new .tap { |x_cw|
          x_cw .setLayout QVBoxLayout .new .tap { |x_lo|
            @wu_tv = nf2_tv
            x_lo .addWidget @wu_tv
          }
        }
        x_it .resize 777, 333
        x_it .show
        x_it .raise_
        __wan_move_center x_it
      }
    end
    def nf2_tv
      QTableView .new .tap { |x_tv|
        x_tv .verticalHeader .hide
        x_tv .horizontalHeader .setStretchLastSection true
        x_tv .setSelectionBehavior QAbstractItemView.SelectRows
        x_tv .setSelectionMode QAbstractItemView.SingleSelection
        yp_sa x_tv, 'keyboardSearch', ->(x_search) {}
        x_tv .setModel ( HSpellout .new 32345678 ) .hu_it
        x_tv .scrollToBottom
      }
    end
    @wu_it = nf2_it
  end
  def __wan_quit
    GC_LOG .info  'About to quit ...'
    GC_QAPP .quit
  end
  def __wan_move_center x_it
    nu_cp = QDesktopWidget .new .availableGeometry .center # center point
    nu_fg = x_it .frameGeometry
    nu_fg .moveCenter nu_cp
    x_it .move nu_fg .topLeft
  end
end

module DBody
  def self.dp_it
    GC_QAPP .setStyle 'fusion'
    WMain .new
    GC_QAPP .exec_
  end
end

module OStart
  def self.main
    gp_set_log_level_to_info
    DRun .dp_it
  end
end

if $0 == __FILE__
  OStart .main
end
