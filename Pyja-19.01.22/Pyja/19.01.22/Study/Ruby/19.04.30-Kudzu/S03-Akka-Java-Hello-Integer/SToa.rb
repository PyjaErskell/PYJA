#---------------------------------------------------------------
# Ruby (Global)
#---------------------------------------------------------------
GC_EC_NONE     = -200
GC_EC_SHUTDOWN = -199
GC_EC_SUCCESS  = 0
GC_EC_ERROR    = 1

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

def gf_jar_pj *x_args; File .join x_args; end

# ri => (r)uby (i)d, ro => (r)uby (o)bject, ry = (r)uby (y)ethod
def gf_ri x_ro; x_ro.object_id; end
def gf_ro x_ri; ObjectSpace._id2ref x_ri; end
def gy_call_if_exist x_ro, x_yethod_nm, *x_args
  x_ro .send x_yethod_nm, *x_args if x_ro .respond_to? x_yethod_nm, true
rescue Exception => bu2_ex
  jp_request_exit GC_EC_ERROR, * (bu2_ex.backtrace)
end

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
def yp_gco x_yo, x_signal, xy_slot; ( yf_ga x_yo, x_signal .to_s ) .connect xy_slot; end # gco = si(g)nal (c)onnect sl(o)t

yp_e 'import sys'
yp_e 'sys.dont_write_bytecode = True'

YG = yf_e 'sys.modules [__name__]'

yp_e File.read gf_pj ( gf_pn __FILE__ ), 'SToa.py'

def yp_os_exit x_ec; YG.os ._exit x_ec; end

#---------------------------------------------------------------
# Java (Global)
#---------------------------------------------------------------

require 'rjb'

->() {
  pu_pasa = File::PATH_SEPARATOR # (pa)th (s)ep(a)rator
  pu_kapa_hm = gf_os_env(:SC_KAPA_HM)
  pu_jar_fn_lst = ( ( gf_os_env_has :SC_JAVA_JARS ) ? ( ( gf_os_env :SC_JAVA_JARS ) .split pu_pasa ) : [] ) .each { |bx2_it| gf_jar_fn bx2_it } + [
    ( gf_jar_pj pu_kapa_hm, '19.01.22', 'Cumuni', 'Groovy', '2.5.5', 'indy', 'groovy-2.5.5-indy.jar' ),
    ( gf_jar_pj pu_kapa_hm, '19.01.22', 'Cumuni', 'Groovy', '2.5.5', 'indy', 'groovy-jsr223-2.5.5-indy.jar' ),
  ]
  pu_jar_fn_lst .each { |bx2_it| raise RuntimeError, "JAR file not found => #{bx2_it}" unless gf_if bx2_it }

  pu_opts = [ ( gf_os_env :SC_JAVA_XMX ) ]
  if gf_os_env_has :SC_JAVA_LPS
    bu2_lps = ( gf_os_env :SC_JAVA_LPS ) .split pu_pasa
    bu2_lps .each { |bx3_it| raise RuntimeError, "Java library path not found => #{bx3_it}" unless gf_id bx3_it }
    pu_opts << "-Djava.library.path=#{ bu2_lps .join pu_pasa }"
  end
  Rjb::load ( pu_jar_fn_lst .join pu_pasa ), pu_opts
}.()

$__jau_gr = ( Rjb::import 'javax.script.ScriptEngineManager' ) .new .getEngineByName ('Groovy')

def jy_ge x_str; $__jau_gr .eval x_str .to_s; end # ge = (g)roovy (e)val
def jy_gf x_nm, * x_args; $__jau_gr .invokeFunction x_nm .to_s, x_args; end # gf = (g)roovy (f)unction

def jp_println x_it; jy_gf :gp_println, x_it; end
def jf_sf x_format, * x_args; ( jy_gf :gf_sf, x_format, x_args ) .toString; end

jy_ge """
GC_ST = new Date ()

GC_EC_NONE     = #{GC_EC_NONE}
GC_EC_SHUTDOWN = #{GC_EC_SHUTDOWN}
GC_EC_SUCCESS  = #{GC_EC_SUCCESS}
GC_EC_ERROR    = #{GC_EC_ERROR}
"""

jy_ge File.read gf_pj ( gf_pn __FILE__ ), 'SToa.groovy'

def jf_cls x_cls_nm; jy_gf :gf_cls, x_cls_nm; end
def jf_to_ths x_pn; ( jy_gf :gf_to_ths, x_pn ) .toString; end
def jf_to_kms x_pn; ( jy_gf :gf_to_kms, x_pn ) .toString; end

def jp_request_exit x_ec, * x_ex
  jy_gf :gp_before_exit, x_ec, x_ex
  case x_ec
  when GC_EC_NONE
    yp_os_exit GC_EC_ERROR
  when GC_EC_SHUTDOWN
    exit
  when proc { |it| it < 0 }
    yp_os_exit GC_EC_ERROR
  else
    yp_os_exit x_ec
  end
end

def jf_wai x_start = 1, x_msg = nil
  fu_cl = ( caller_locations x_start, 1 ) [0]
  fu_msg = "#{fu_cl.label} [#{ jf_to_ths fu_cl.path }:#{ '%04d' % fu_cl.lineno }]"
  return fu_msg if x_msg.nil?
  "#{fu_msg} #{x_msg}"
end

def jf_gg x_key
  fu_it = $__jau_gr .get x_key .to_s
  jp_request_exit GC_EC_ERROR, ( jf_wai "Can't find key => #{x_key}" ) if fu_it .nil?
  return fu_it
end
def jp_gp x_key, x_jo; $__jau_gr .put x_key .to_s, x_jo; end

def jf_method x_jo, x_yethod_nm; jy_gf :gf_method, x_jo, x_yethod_nm .to_s, jf_wai(2); end
def JOY x_jo, x_yethod_nm, * x_args; jy_gf :gy_oy, x_jo, x_yethod_nm, x_args; end
def jf_new x_cls, * x_args; JOY x_cls, 'newInstance', * x_args; end

JC_AS = jf_gg :GC_AS
JC_LOG = jf_gg :GC_LOG

def jf_mk_atr_jo x_at_jo, x_at_nm, x_arf = JC_AS
  jy_gf :gf_mk_atr_jo, x_at_jo, x_at_nm, x_arf
end
def jf_mk_atr_ro x_at_ro, x_at_nm, x_arf = JC_AS
  fu_at_nm = ( x_at_nm == ':c' ) ? x_at_ro.class.name  : x_at_nm
  jy_gf :gf_mk_atr_ro, ( gf_ri x_at_ro ), fu_at_nm, x_arf
end

#---------------------------------------------------------------
# Ruby (Global)
#---------------------------------------------------------------

GC_TONO_ARGV = ARGV
GC_TONO_CMD = YG.psutil.Process .new .cmdline .to_a
GC_TONO_EXE_FN = gf_ap YG.sys.executable
GC_TONO_SCRIPT_FN = gf_ap $0

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

CjPlatform = jf_cls 'com.sun.jna.Platform'

GC_RUBY_VR   = RUBY_VERSION
GC_PYTHON_VR = YG.platform .python_version
GC_PYQT_VR = YG.QtCore .qVersion

$gu_qapp = YG.QApplication.new []

if CjPlatform .isMac
  Signal .trap ('INT') { 
    jp_request_exit GC_EC_SHUTDOWN, [ 'SIGINT occurred !!!' ]
  }
end

def gf_process x_pid; YG.psutil.Process .new x_pid; end
def gf_os_available_memory; YG.psutil .virtual_memory .available; end

def gp_log_array xp_out = ( jf_method JC_LOG, :info ), x_title, x_array
  return if x_array.empty?
  xp_out .call "#{x_title} =>"
  x_array .each .with_index (1) { | bx2_it, bx2_idx | xp_out .call "  #{'%2d' % bx2_idx} : #{bx2_it}" }
end
def gp_log_header xp_out = ( jf_method JC_LOG, :info ), x_header, x_line_width
  xp_out .call '+' + '-' * x_line_width
  xp_out .call ": #{x_header}"
  xp_out .call '+' + '-' * x_line_width
end

def gp_akka_receive_jo
  pu_q4atr = jf_gg :GC_Q4ATR
  pu_msec = 1
  YG.QTimer .new .tap { |it|
    it .setSingleShot true
    yp_gco it, :timeout, ->() {
      while true
        bu4_it = pu_q4atr .poll
        break if bu4_it.nil?
        bu4_ro = gf_ro bu4_it [0] .longValue
        bu4_nethod_nm = bu4_it [1] .toString
        bu4_args = bu4_it [2]
        gy_call_if_exist bu4_ro, bu4_nethod_nm, * bu4_args
        $gu_qapp .processEvents
      end
      it .start pu_msec
    }
    it .start 0
  }
end

#---------------------------------------------------------------
# Main Skeleton
#---------------------------------------------------------------

module DRun
  def self.dp_it
    __dap_begin
    DBody .dp_it
  rescue Exception => bu2_ex
    jp_request_exit GC_EC_ERROR, * (bu2_ex.backtrace)
  end
private
  def self.__dap_begin
    JC_LOG .info  "Ruby version => #{GC_RUBY_VR}"
    JC_LOG .info  "Python version => #{GC_PYTHON_VR}"
    JC_LOG .info  "PyQt version => #{GC_PYQT_VR}"
    JC_LOG .debug "Available memory => #{ CjString .format '%,d', [gf_os_available_memory] }"
    JC_LOG .debug "Executable file => #{ jf_to_kms GC_TONO_EXE_FN }"
    JC_LOG .info  "Script file => #{ jf_to_ths GC_TONO_SCRIPT_FN }"
    gp_log_array ( jf_method JC_LOG, :debug ), 'Paths', ( jf_gg :GC_TONO_OS_ENV_PATHS )
    gp_log_array ( jf_method JC_LOG, :debug ), 'Command', GC_TONO_CMD
    gp_log_array 'Arguments', GC_TONO_ARGV if GC_TONO_ARGV.count > 0
  end
end

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

class WAtMain
  def initialize x_atr_integer
    @wu_atr_integer = x_atr_integer
    wn_init
  end
  def wn_init
    @wu_mw = YG.QMainWindow .new
    nu_cw = YG.QWidget .new
    nu_lo = YG.QVBoxLayout .new
    @wu_pb = YG.QPushButton .new .tap { |it|
      yp_gco it, :clicked, ->(x_checked) { JOY @wu_atr_integer, 'tell', 'LNext', @wu_atr_self }
    }
    nu_lo .addWidget @wu_pb
    nu_cw .setLayout nu_lo
    @wu_mw .tap { |it|
      it .setWindowTitle ( jf_gg :GC_TONO_NM ) .toString
      yp_sa it, 'closeEvent', ->(x_ev_close) { wn_quit }
      it .setCentralWidget nu_cw
      it .resize 350, 150
    }
    @wu_timer = YG.QTimer .new .tap { |it| yp_gco it, :timeout, ->() { @wu_pb .click } }
  end
  def preStart x_atr_self, x_context
    @wu_atr_self = x_atr_self
    @wu_context = x_context
    JOY @wu_atr_integer, 'tell', 'LCurrent', @wu_atr_self
  end
  def receive x_letter, x_atr_sender
    wn_set_pb_text x_letter
    @wu_mw .tap { |it|
      unless it .isVisible
        it .show
        it .raise_
        wn_move_center
        @wu_timer .start 100
      end
    }
  end
  def postStop
  end
  def wn_set_pb_text x_cnt
    @wu_pb .setText jf_sf "Ciao, %,d !", x_cnt
    JC_LOG .info @wu_pb.text
  end
  def wn_move_center
    nu_cp = YG.QApplication.primaryScreen.geometry.center # center point
    @wu_mw .move nu_cp.x - @wu_mw.width / 2, nu_cp.y - @wu_mw.height / 2
  end
  def wn_quit
    JC_LOG .info  'About to quit ...'
    @wu_timer .stop
    jp_request_exit GC_EC_SUCCESS
  end
end

module DBody
  def self.dp_it
    # 1 / 0
    pu_atr_integer = jf_mk_atr_jo ( jf_new jf_cls 'CAtInteger' ), ':c'
    jf_mk_atr_ro ( WAtMain .new pu_atr_integer ), ':c'
    gp_akka_receive_jo
    $gu_qapp .exec
  end
end

module OStart
  def self.main
    DRun .dp_it
  end
end

if $0 == __FILE__
  OStart .main
end
