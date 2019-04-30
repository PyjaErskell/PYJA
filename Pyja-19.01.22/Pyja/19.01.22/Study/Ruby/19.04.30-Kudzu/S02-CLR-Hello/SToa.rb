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

GC_KAPA_HM_SYM = '@^'
GC_PYJA_RT_SYM = '@`'
GC_PYJA_HM_SYM = '@~'
GC_MILO_PN_SYM = '@!'
GC_TONO_HM_SYM = '@*'

GC_EC_NONE     = -200
GC_EC_SHUTDOWN = -199
GC_EC_SUCCESS  = 0
GC_EC_ERROR    = 1

GC_FOSA = File::SEPARATOR      # (fo)lder (s)ep(a)rator
GC_PASA = File::PATH_SEPARATOR # (pa)th (s)ep(a)rator

def gf_os_env x_it; ENV .fetch x_it.to_s; end
def gf_os_env_has x_it;  ENV .has_key? x_it.to_s; end
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

$gu_jar_fn_list = []
def gf_jar_fn x_jar_fn; $gu_jar_fn_list << x_jar_fn; x_jar_fn; end
def gf_jar_pj *x_args; gf_jar_fn File .join x_args; end

GC_KAPA_HM   = gf_ap gf_os_env(:SC_KAPA_HM)
GC_PYJA_RT   = gf_ap gf_os_env(:SC_PYJA_RT)
GC_PYJA_HM   = gf_ap gf_os_env(:SC_PYJA_HM)
GC_MILO_PN   = gf_ap gf_os_env(:SC_MILO_PN)
GC_TONO_HM   = gf_ap gf_os_env(:SC_TONO_HM)

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
def gf_to_khs x_pn; gf_replace_with_px_symbol x_pn, GC_KAPA_HM, GC_KAPA_HM_SYM; end # to (k)apa (h)ome (s)ymbol
def gf_to_prs x_pn; gf_replace_with_px_symbol x_pn, GC_PYJA_RT, GC_PYJA_RT_SYM; end # to (p)yja (r)oot (s)ymbol
def gf_to_phs x_pn; gf_replace_with_px_symbol x_pn, GC_PYJA_HM, GC_PYJA_HM_SYM; end # to (p)yja (h)ome (s)ymbol
def gf_to_mps x_pn; gf_replace_with_px_symbol x_pn, GC_MILO_PN, GC_MILO_PN_SYM; end # to (m)ilo (p)ath (s)ymbol
def gf_to_ths x_pn; gf_replace_with_px_symbol x_pn, GC_TONO_HM, GC_TONO_HM_SYM; end # to (t)ono (h)ome (s)ymbol
def gf_to_kms x_pn; fu_khs = gf_to_khs x_pn; ( x_pn == fu_khs ) ?  ( gf_to_mps x_pn ) : fu_khs; end # to khs or mps

# ri => (r)uby (i)d, ro => (r)uby (o)bject, ry = (r)uby (y)ethod
def gf_ri x_ro; x_ro.object_id; end
def gf_ro x_ri; ObjectSpace._id2ref x_ri; end
def gy_ry x_ri, x_yethod_nm, *x_args
  yu_ro = gf_ro x_ri
  yu_ro .send x_yethod_nm, *x_args if yu_ro .respond_to? x_yethod_nm, true
end

#---------------------------------------------------------------
# Java (Global)
#---------------------------------------------------------------

require 'rjb'

->() {
  pu_jar_fn_lst = ( ( gf_os_env_has :SC_JAVA_JARS ) ? ( ( gf_os_env :SC_JAVA_JARS ) .split GC_PASA ) : [] ) .each { |bx2_it| gf_jar_fn bx2_it } + [
    ( gf_jar_pj GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.5', 'indy', 'groovy-2.5.5-indy.jar' ),
    ( gf_jar_pj GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.5', 'indy', 'groovy-jsr223-2.5.5-indy.jar' ),
  ]
  pu_jar_fn_lst .each { |bx2_it| raise RuntimeError, "JAR file not found => #{bx2_it}" unless gf_if bx2_it }

  pu_opts = [ ( gf_os_env :SC_JAVA_XMX ) ]
  if gf_os_env_has :SC_JAVA_LPS
    bu2_lps = ( gf_os_env :SC_JAVA_LPS ) .split GC_PASA
    bu2_lps .each { |bx3_it| raise RuntimeError, "Java library path not found => #{bx3_it}" unless gf_id bx3_it }
    pu_opts << "-Djava.library.path=#{ bu2_lps .join GC_PASA }"
  end
  Rjb::load ( pu_jar_fn_lst .join GC_PASA ), pu_opts
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

# yo = p(y)thon (o)bject
def yf_ga x_yo, x_nm; PyCall.builtins .getattr x_yo, x_nm .to_s; end
def yp_sa x_yo, x_nm, x_val; PyCall.builtins .setattr x_yo, x_nm .to_s, x_val; end
def yf_e x_expr, x_globals: nil, x_locals: nil; PyCall::eval x_expr .to_s, globals: x_globals, locals: x_locals; end
def yp_e x_code, x_globals: nil, x_locals: nil; PyCall::exec x_code .to_s, globals: x_globals, locals: x_locals; end
def yp_gco x_yo, x_signal, xy_slot; ( yf_ga x_yo, x_signal.to_s ) .connect xy_slot; end # gco = si(g)nal (c)onnect sl(o)t

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
  def gp_pe ( x_yo, x_it ) : x_yo += x_it # pe = (p)lus (e)qual
  def gp_me ( x_yo, x_it ) : x_yo -= x_it # me = (m)inus (e)qual
__YASH_EOS

pyfrom :'PyQt5', import: :QtCore
pyfrom :'PyQt5', import: :QtGui
pyfrom :'PyQt5.QtCore', import: :QModelIndex
pyfrom :'PyQt5.QtCore', import: :Qt
pyfrom :'PyQt5.QtCore', import: :QTimer
pyfrom :'PyQt5.QtCore', import: :QVariant
pyfrom :'PyQt5.QtGui', import: :QFontDatabase
pyfrom :'PyQt5.QtWidgets', import: :QAbstractItemView
pyfrom :'PyQt5.QtWidgets', import: :QApplication
pyfrom :'PyQt5.QtWidgets', import: :QDesktopWidget
pyfrom :'PyQt5.QtWidgets', import: :QMainWindow
pyfrom :'PyQt5.QtWidgets', import: :QTableView
pyfrom :'PyQt5.QtWidgets', import: :QVBoxLayout
pyfrom :'PyQt5.QtWidgets', import: :QWidget

$yu_sys = yf_e :sys
$yu_os = yf_e :os
$yu_psutil = yf_e :psutil
$yu_platform = yf_e :platform
$yu_datetime = yf_e :datetime

$yp_pe = yf_e :gp_pe
$yp_me = yf_e :gp_me

->() {
  if gf_os_env_has :SC_PYTHON_SPS
    bu2_sps = ( gf_os_env :SC_PYTHON_SPS ) .split GC_PASA
    bu2_sps .each { |bx3_it|
      raise RuntimeError, "Python system path not found => #{bx3_it}" unless gf_id bx3_it
      $yu_sys .path .append bx3_it
    }
  end
}.()

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

GC_MILO_NM = gf_bn GC_MILO_PN

GC_TONO_ARGV = ARGV
GC_TONO_CMD = $yu_psutil.Process .new .cmdline .to_a
GC_TONO_EXE_FN = gf_ap $yu_sys.executable
GC_TONO_OS_ENV_PATHS = ( gf_os_env :SC_PATH ) .split GC_PASA
GC_TONO_PID = Process.pid
GC_TONO_SCRIPT_FN = gf_ap $0
GC_TONO_ST = $yu_datetime .strptime ( $__gau_app_st .strftime '%F %T' ), '%Y-%m-%d %H:%M:%S'
GC_TONO_START_UP_PN = gf_ap Dir .getwd
GC_TONO_NM = gf_on GC_TONO_HM, true

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
CjScriptEngineManager = jf_cls 'javax.script.ScriptEngineManager'
CjPlatform = jf_cls 'com.sun.jna.Platform'

GC_RUBY_VR   = RUBY_VERSION
GC_JAVA_VR   = CjSystem .getProperty 'java.version'
GC_GROOVY_VR = CjGroovySystem.version
GC_PYTHON_VR = $yu_platform .python_version
GC_PYQT_VR = QtCore .qVersion

GC_TOTAL_CPU = Etc.nprocessors
GC_TOTAL_MEMORY = $yu_psutil .virtual_memory .total
GC_HOST_NM = Socket .gethostname
GC_CUSR = Etc .getlogin  # current user

def gp_qapp_initialize; $gu_qapp = QApplication.new []; end

def gf_process x_pid; $yu_psutil.Process .new x_pid; end
def gf_os_available_memory; $yu_psutil .virtual_memory .available; end

GC_LOG = ->() {
  fu_it = Logger .new STDOUT
  fu_it.level = Logger::DEBUG  # Logger::INFO
  fu_it.formatter = proc do | bx2_severity, bx2_datetime, bx2_progname, bx2_msg |
    bu2_datetime = bx2_datetime.strftime '%y%m%d-%H%M%S'
    "[#{ '%06d' % GC_TONO_PID },#{bx2_severity.chars.first},#{bu2_datetime}] #{bx2_msg}\n"
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
    GC_TONO_NM,
    '',
    "made by #{GC_PYJA_AU}",
    "ran on #{ GC_TONO_ST .strftime ('%Y-%m-%d %H:%M:%S') }",
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
  gp_log_array ( GC_LOG.method :debug ), '$LOAD_PATH', $: .map { |x2_pn| gf_to_kms x2_pn } .sort
  gp_log_exception 'Following error occurs !!!', x_ex unless x_ex .nil?
  GC_LOG.info "Exit code => #{x_ec}"
  GC_LOG.info "Elpased #{ $yu_datetime.now - GC_TONO_ST } ..."
  $yu_os ._exit x_ec
end

def gy_rr &xy_block # (r)uby (r)un
  xy_block .call
rescue Exception => bu2_ex
  gp_request_exit GC_EC_ERROR, bu2_ex
end

class CgRi
  def initialize
    @cu_ri = gf_ri self
  end
end

module TjUtil
  def tn_fx_start x_yethod_nm
    jy_gf 'gp_fx_start', [ ( CjLong .new @cu_ri ), x_yethod_nm ]
  end
  def tn_fx_set_eh x_xo, x_xo_eh_nm, x_yethod_nm # xo -> F(x) (o)bject, eh -> fx (e)vent (h)andler
    jy_gc """{ x_xo ->
      x_xo.#{x_xo_eh_nm} = { x2_ev -> gy_ry #{@cu_ri}, '#{x_yethod_nm}', x2_ev }
    }""", [x_xo]
  end
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
    GC_LOG .info  "Kapa home (#{GC_KAPA_HM_SYM}) => #{GC_KAPA_HM}"
    GC_LOG .info  "Pyja root (#{GC_PYJA_RT_SYM}) => #{GC_PYJA_RT}"
    GC_LOG .info  "Pyja home (#{GC_PYJA_HM_SYM}) => #{ gf_to_prs GC_PYJA_HM }"
    GC_LOG .info  "Milo path (#{GC_MILO_PN_SYM}) => #{ gf_to_phs GC_MILO_PN }"
    GC_LOG .info  "Tono home (#{GC_TONO_HM_SYM}) => #{ gf_to_mps GC_TONO_HM }"
    GC_LOG .info  "Is 64 bit? => #{ CjPlatform .is64Bit }"
    GC_LOG .info  "Ruby version => #{GC_RUBY_VR}"
    GC_LOG .info  "Java version => #{GC_JAVA_VR}"
    GC_LOG .info  "Groovy version => #{GC_GROOVY_VR}"
    GC_LOG .info  "Python version => #{GC_PYTHON_VR}"
    GC_LOG .info  "PyQt version => #{GC_PYQT_VR}"
    GC_LOG .debug "Java home => #{ gf_to_kms GC_JAVA_HM }"
    GC_LOG .debug "Python home => #{ gf_to_kms GC_PYTHON_HM }"
    GC_LOG .debug "Total CPU => #{GC_TOTAL_CPU}"
    GC_LOG .debug "Total memory => #{ CjString .format '%,d', [GC_TOTAL_MEMORY] }"
    GC_LOG .debug "Available memory => #{ CjString .format '%,d', [gf_os_available_memory] }"
    GC_LOG .debug "Computer name => #{GC_HOST_NM}"
    GC_LOG .debug "Current user => #{GC_CUSR}"
    GC_LOG .debug "Process ID => #{GC_TONO_PID}"
    gp_log_array  ( GC_LOG .method :debug ), 'Early jar files', $gu_jar_fn_list .map { |x2_jar_fn| gf_to_kms x2_jar_fn } .sort
    GC_LOG .debug "Executable file => #{ gf_to_kms GC_TONO_EXE_FN }"
    GC_LOG .info  "Start up path => #{ gf_to_mps GC_TONO_START_UP_PN }"
    GC_LOG .info  "Script file => #{ gf_to_ths GC_TONO_SCRIPT_FN }"
    gp_log_array  ( GC_LOG .method :debug ), 'Paths', GC_TONO_OS_ENV_PATHS
    gp_log_array  ( GC_LOG .method :debug ), 'Command', GC_TONO_CMD
    gp_log_array  'Arguments', GC_TONO_ARGV if GC_TONO_ARGV.count > 0
  end
end

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

require 'gtk3'
Gtk .init

yp_e <<-__SASH_EOS.unindent
  import clr
  import System.Windows.Forms as swf
  import System.Drawing as sd
__SASH_EOS

$yu_clr = yf_e :clr
$yu_swf = yf_e :swf
$yu_sd = yf_e :sd

class WMain < CgRi
  def initialize; __wan_init; end
  def __wan_init
    def nf2_it
      $yu_swf.Form .new .tap { |x_it|
        x_it.Text = GC_TONO_NM
        x_it.AutoScaleBaseSize = $yu_sd.Size .new 5, 13
        x_it.ClientSize = $yu_sd.Size .new 392, 117
        x_it.MinimumSize = $yu_sd.Size .new 392, 117 + $yu_swf.SystemInformation.CaptionHeight
        @wu_bn, @wu_tb = nf2_bn, nf2_tb
        x_it.AcceptButton = @wu_bn
        ( yf_ga x_it, :Controls ) .AddRange [ @wu_bn, @wu_tb ]
        $yp_pe .call x_it.FormClosing, ->( x_sender, x_e ) { gy_rr {__wan_quit} } 
        x_it .CenterToScreen
      }
    end
    def nf2_bn
      $yu_swf.Button .new .tap { |x_bn|
        x_bn.Location = $yu_sd.Point .new 35, 25
        x_bn.Size = $yu_sd.Size .new 320, 20
        x_bn.TabIndex = 2
        x_bn.Text = 'Click Me!'
        $yp_pe .call x_bn.Click, ->( x_sender, x_e ) { gy_rr {
          $yu_swf.MessageBox .Show 'Please do not press this button again.'
        }}
      }
    end
    def nf2_tb
      $yu_swf.TextBox .new .tap { |x_tb|
        x_tb.Location = $yu_sd.Point .new 35, 70
        x_tb.Size = $yu_sd.Size .new 320, 20
        x_tb.TabIndex = 1
        x_tb.Text = 'Hello World'
      }
    end
    @wu_it = nf2_it
    $yu_swf.Application .Run @wu_it
  end
  def __wan_quit
    QTimer .singleShot 0, ->() {
      GC_LOG .info  'About to quit ...'
      gp_request_exit GC_EC_SUCCESS
    }
  end
end

module DBody
  def self.dp_it
    gp_qapp_initialize
    $gu_qapp .setStyle 'fusion'
    pu_o = WMain .new
    $gu_qapp .exec
  end
end

module OStart
  def self.main
    # gp_set_log_level_to_info
    DRun .dp_it
  end
end

if $0 == __FILE__
  OStart .main
end
