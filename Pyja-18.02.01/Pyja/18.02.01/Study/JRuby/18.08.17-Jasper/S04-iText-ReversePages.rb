#
# JRuby (Global
#

require 'jruby/core_ext'

GC_ST = Time .at $__gau_st.time / 1000
GC_JEP = $__gau_jep
GC_FX_STAGE = $__gau_fx_stage

GC_PYJA_NM = 'Pyja'
GC_PYJA_AU = 'Erskell' # (au)thor

GC_PJYA_CEN = 20
GC_PYJA_YEA = 18
GC_PYJA_MON =  2
GC_PYJA_DAY =  1

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

CgBigInteger = java.math.BigInteger
CgFile = java.io.File
CgString = Java::JavaLang::String
CgSystem = Java::JavaLang::System
CgTimeUnit = java.util.concurrent.TimeUnit

GC_JAVA_VR = CgSystem .get_property 'java.version'
GC_GROOVY_VR = Java::GroovyLang::GroovySystem .version
GC_JRUBY_VR = JRUBY_VERSION
GC_RUBY_VR = RUBY_VERSION

require 'date'
require 'fileutils'
require 'hash_dot'
require 'heredoc_unindent'

Hash.use_dot_syntax = true

def gf_os_env x_it; ENV .fetch x_it.to_s; end
def gp_set_const x_sym, x_val; Object .const_set x_sym, x_val; end
def gf_str_is_valid_date x_str, x_format; Date .strptime x_str, x_format; end
def gf_rm_px x_str, x_px # px : prefix
  ( x_str .start_with? x_px ) ? x_str [ x_px.size .. -1 ] : x_str
end

GC_OS_ENV_PATHS = ( gf_os_env :SC_PATH ) .split GC_PASA

def gf_bn x_fn; File .basename x_fn; end
def gf_ap x_it; File .expand_path x_it; end
def gf_fn x_it; File .expand_path x_it; end
def gf_jn x_fn; File .basename x_fn, File .extname(x_fn); end
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
def gf_pn x_fn; fu_ap = gf_ap x_fn; File .dirname x_fn; end
def gf_on x_pn; fu_ap = gf_ap x_pn; gf_bn fu_ap; end
def gf_on_list x_it
  fu_pn = if gf_if (x_it); gf_pn (x_it); else; gf_ap (x_it); end
  fu_pn .split File::SEPARATOR
end

GC_THIS_START_UP_PN = gf_ap Dir.getwd

GC_PYJA_RT  = gf_ap gf_os_env(:SC_PYJA_RT)
GC_PYJA_HM  = gf_ap gf_os_env(:SC_PYJA_HM)
GC_JAVA_HM  = gf_ap gf_os_env(:SC_J8_HM)
GC_JRUBY_HM = gf_ap gf_os_env(:SC_JRUBY_HM)
GC_PYTHON_HM = gf_ap gf_os_env(:SC_PYTHON_HM)
GC_MILO_PN  = gf_ap gf_os_env(:SC_MILO_PN)

GC_SCRIPT_FN = gf_fn __FILE__
GC_SCRIPT_PN = gf_pn GC_SCRIPT_FN
GC_APP_NM = gf_jn GC_SCRIPT_FN

def gf_banner x_leading_space = 0, x_margin_inside = 2
  fu_msgs = [
    "#{GC_PYJA_NM} #{GC_APP_NM}",
    "made by #{GC_PYJA_AU}",
    '',
    "ran on #{ GC_ST .strftime ('%F %T') }",
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

def gf_replace_with_px_symbol x_pn, x_px_path, x_px_symbol
  fu_pn = gf_ap x_pn
  if fu_pn.start_with? x_px_path
    gf_pj x_px_symbol, fu_pn [ x_px_path.size + 1 .. -1 ]
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

def gf_wai x_msg = nil
  fu_cl = ( caller_locations 1, 1 ) [0]
  fu_msg = "#{ gf_to_mps (fu_cl.path) } [#{ '%03d' % fu_cl.lineno }]"
  return fu_msg if x_msg.nil?
  "#{fu_msg} #{x_msg}"
end

def gp_sr &x_block; javax.swing.SwingUtilities.invokeLater { x_block .call }; end # (S)wing (r)un
def gp_xr &x_block; javafx.application.Platform.runLater { x_block .call }; end # JavaF(X) (r)un
def gf_jr &x_block
  Class.new {
    include Java::JavaLang::Runnable
    def initialize x2_block; @__cau_block = x2_block; end
    def run; @__cau_block .call; end
  }.new x_block
end
def gf_jt &x_block
  Class.new(Java::JavaLang::Thread) {
    def initialize x2_block; @__cau_block = x2_block; end
    def run; @__cau_block .call; end
  }.new x_block
end

GC_GR = Java::JavaxScript::ScriptEngineManager.new .get_engine_by_name ('groovy')
GC_GR .put 'GC_JEP', GC_JEP
def gy_ge x_str; GC_GR .eval x_str; end
def gy_gf x_nm, *x_args; GC_GR. invoke_function x_nm, *x_args; end
def gy_gm x_oj, x_nm, *x_args; GC_GR .invoke_method x_oj, x_nm, *x_args; end
def gy_gc x_closure, *x_args
  yu_closure = x_closure.kind_of?(String) ? gy_ge(x_closure) : x_closure
  gy_gm yu_closure, 'call', *x_args
end

def gf_gi (x_cls); gy_ge "@groovy.transform.Immutable ( knownImmutableClasses = [Object] ) #{x_cls}" end # gi -> (g)roovy (i)mmutable class
gy_ge 'gf_gn = { final Class x_cls, final Object... x_args -> return x_cls .newInstance (x_args) }' # gn -> (g)roovy (n)ew with groovy class from JRuby
def gf_gn x_cls, *x_args; gy_gf 'gf_gn', x_cls, *x_args end

gy_ge <<-__GASH_EOS.unindent
  gp_add_jar = { final String x_jar_fn ->
    if ( ! new File (x_jar_fn) .exists () ) { throw new FileNotFoundException ( "JAR file not found => ${x_jar_fn}" ) }
    final URL pu_url = new File (x_jar_fn) .toURI () .toURL ()
    final URLClassLoader pu_cl = ClassLoader .getSystemClassLoader ()
    final fu_m = URLClassLoader.class .getDeclaredMethod 'addURL', URL.class
    fu_m.setAccessible true
    fu_m.invoke pu_cl, pu_url
  }
__GASH_EOS
def gp_add_jar (x_jar_fn); gy_gf 'gp_add_jar', x_jar_fn; end
->() {
  [
    ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'akka-actor_2.12-2.5.9.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'akka-slf4j_2.12-2.5.9.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'config-1.3.2.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-library.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-classic-1.2.3.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-core-1.2.3.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
  ] .each { |bx2_jar_fn|
    gp_add_jar bx2_jar_fn
  }
}.()

CgActorRef = Java::AkkaActor::ActorRef
CgAwait = Java::ScalaConcurrent::Await
CgDuration = Java::ScalaConcurrentDuration::Duration
CgPatterns = Java::AkkaPattern::Patterns
CgTimeout = Java::AkkaUtil::Timeout

GC_THIS_PID = Process.pid

gy_ge <<-__GASH_EOS.unindent
  GC_AS = { ->
    final fu_lc = org.slf4j.LoggerFactory .getILoggerFactory ()
    final fu_jc = new ch.qos.logback.classic.joran.JoranConfigurator ()
    fu_jc .setContext (fu_lc)
    fu_lc .reset ()
    final fu_cfg_xml_str = """
      <configuration>
        <statusListener class="ch.qos.logback.core.status.NopStatusListener" />
        <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
          <layout class="ch.qos.logback.classic.PatternLayout">
            <Pattern>
              [${ String.format ( '%06d', #{GC_THIS_PID} ) },%.-1level,%date{yyMMdd-HHmmss}] %msg%n
            </Pattern>
          </layout>
          <target>System.out</target>
        </appender>
        <appender name="ASYNC" class="ch.qos.logback.classic.AsyncAppender">
          <appender-ref ref="STDOUT" />
        </appender>
        <root level="DEBUG">
          <appender-ref ref="ASYNC" />
        </root>
        <logger name="akka.event.slf4j.Slf4jLogger" level="OFF" additivity="false" />
        <logger name="akka.event.EventStream" level="OFF" additivity="false" />
        <logger name="slick" level="INFO" />
      </configuration>
    """
    fu_jc .doConfigure ( new java.io.ByteArrayInputStream ( fu_cfg_xml_str .getBytes () ) )
    final fu_cfg = com.typesafe.config.ConfigFactory .parseString """
      akka {
        loggers = ["akka.event.slf4j.Slf4jLogger"]
        loglevel = "DEBUG"
        logging-filter = "akka.event.slf4j.Slf4jLoggingFilter"
      }
    """
    return akka.actor.ActorSystem .create ( 'GC_AS', fu_cfg )
  } ()
  gp_set_log_level_to_error  = { -> GC_AS .eventStream () .setLogLevel ( akka.event.Logging .ErrorLevel () ) }
  gp_set_log_level_to_warn   = { -> GC_AS .eventStream () .setLogLevel ( akka.event.Logging .WarningLevel () ) }
  gp_set_log_level_to_info   = { -> GC_AS .eventStream () .setLogLevel ( akka.event.Logging .InfoLevel () ) }
  gp_set_log_level_to_debug  = { -> GC_AS .eventStream () .setLogLevel ( akka.event.Logging .DebugLevel () ) }
__GASH_EOS
GC_AS = gy_ge 'GC_AS'
GC_LOG = GC_AS.log
def gp_set_log_level_to_error;  gy_gf 'gp_set_log_level_to_error'; end
def gp_set_log_level_to_warn;   gy_gf 'gp_set_log_level_to_warn'; end
def gp_set_log_level_to_info;   gy_gf 'gp_set_log_level_to_info'; end
def gp_set_log_level_to_debug;  gy_gf 'gp_set_log_level_to_debug'; end

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
  if x_ex.class == Java::JavaUtil::ArrayList
    xp_out .call x_ex .join "\n"
  else
    xp_out .call x_ex.message
    x_ex .backtrace .each { |bx2_it| xp_out .call "  #{bx2_it}" } unless x_ex .backtrace .nil?
  end
end

$__CgAkCreator = Class.new {
  include Java::AkkaJapi::Creator
  def initialize x_cls, *x_args
    @__cau_cls = x_cls
    @__cau_args = *x_args
  end
  def create
    nu_at = @__cau_cls.new
    nu_at .create *@__cau_args if nu_at .respond_to? :create
    nu_at
  end
}
def gf_mk_atr ( x_arf = GC_AS, x_cls, x_args, x_at_nm )
  ff2_props = -> { ( Java::AkkaActor::Props .create x_cls.java_class, ( $__CgAkCreator.new x_cls, *x_args ) ) }
  fu_atr = case x_at_nm
  when ':c' then x_arf .actor_of ff2_props.(), x_cls.name   # same as (c)lass name
  when ':a' then x_arf .actor_of ff2_props.()               # (a)uto -> akka generated name
  else x_arf .actor_of ff2_props.(), x_at_nm
  end
  fu_atr
end
def __gaf_ua &x_block
  Class.new {
    include Java::AkkaJapiPf::FI::UnitApply
    def initialize x2_block; @__cau_block = x2_block; end
    def apply x_it
      @__cau_block .call x_it
    end
  }.new x_block
end
class CgAt < Java::AkkaActor::AbstractActor # (a)c(t)or
  def createReceive
    return ( receive_builder .match Java::JavaLang::Object .java_class, __gaf_ua { |it| receive it } ) .build
  end
  def tell x_target_atr, x_letter, x_sender_atr = nil
    nu_sender_atr = if x_sender_atr.nil? then get_self else x_sender_atr end
    x_target_atr .tell x_letter, nu_sender_atr
  end
end
def gf_ak_foc &x_block # ak -> (ak)ka, foc -> (f)uture (o)n(C)omplete
  Class.new(Java::AkkaDispatch::OnComplete) {
    def initialize x2_block
      super()
      @__cau_block = x2_block
    end
    def onComplete x2_throwable, x2_result
      @__cau_block .call x2_throwable, x2_result
    end
  }.new x_block
end

LgCx = ( Struct.new :lu_ec, :lu_ex )
$__DgExit = Module.new {
  @__dav_cx = LgCx.new GC_EC_NONE, nil
  @__dav_was_lgcx_processed = false
  def self.dp_it x_cx
    GC_LOG .debug "Received LgCx #{x_cx.lu_ec}"
    unless @__dav_was_lgcx_processed
      @__dav_was_lgcx_processed = true
      @__dav_cx = x_cx
      GC_LOG .debug 'Terminating GC_AS ...'
      __dap_before_exit
      __dap_exit
    end
  end
private
  def self.__dap_before_exit
    pu_ec = @__dav_cx.lu_ec
    gp_log_array ( GC_LOG .method :debug ), 'CLASSPATH', Java::JavaLang::ClassLoader .system_class_loader .uRLs .map { |it| it.to_s } .sort unless pu_ec == GC_EC_SUCCESS
    pu_ex = @__dav_cx.lu_ex
    gp_log_exception 'Following error occurs !!!', pu_ex unless pu_ex .nil?
    gp_log_header ( GC_LOG .method :error ), 'Unknown error occurs !!!', 60 if pu_ec != GC_EC_SUCCESS and pu_ex .nil?
    case
    when pu_ec == GC_EC_NONE then GC_LOG .error 'Undefined exit code (GC_EC_NONE), check your logic !!!'
    when pu_ec == GC_EC_SHUTDOWN then GC_LOG .info 'Exit code from shutdown like ctrl+c, ...'
    when pu_ec < 0 then GC_LOG .error "Negative exit code (#{pu_ec}), should consider using a positive value !!!"
    else GC_LOG .info "Exit code => #{pu_ec}"
    end
    GC_LOG.info "Elpased #{ gy_cy 'jf_elapsed', GC_ST } ..."
    GC_AS .terminate
    CgAwait .ready GC_AS .when_terminated, CgDuration.Inf
  end
  def self.__dap_exit
    pu_ec = @__dav_cx.lu_ec
    case
    when pu_ec == GC_EC_NONE then Java::JavaLang::System .exit GC_EC_ERROR
    when pu_ec == GC_EC_SHUTDOWN
    when pu_ec < 0 then Java::JavaLang::System .exit GC_EC_ERROR
    else Java::JavaLang::System .exit pu_ec
    end
  end
}
def gp_request_exit x_ec, x_ex = nil
  $__DgExit .dp_it LgCx.new x_ec, x_ex
end
def gp_register_on_termination
  GC_AS .register_on_termination gf_jr { yield if block_given? }
end
Java::JavaLang::Runtime .runtime .add_shutdown_hook gf_jt { gp_request_exit GC_EC_SHUTDOWN, ( Exception.new 'Shutdown occurred !!!' ) }

GC_JEP .set 'GC_PYJA_NM', GC_PYJA_NM
GC_JEP .set 'GC_PYJA_AU', GC_PYJA_AU

GC_JEP .set 'GC_PJYA_CEN', GC_PJYA_CEN
GC_JEP .set 'GC_PYJA_YEA', GC_PYJA_YEA
GC_JEP .set 'GC_PYJA_MON', GC_PYJA_MON
GC_JEP .set 'GC_PYJA_DAY', GC_PYJA_DAY

GC_JEP .set 'GC_PYJA_CD', GC_PYJA_CD
GC_JEP .set 'GC_PYJA_VR', GC_PYJA_VR
GC_JEP .set 'GC_PYJA_V2', GC_PYJA_V2

GC_JEP .set 'GC_PYJA_VER_MAJ', GC_PYJA_VER_MAJ
GC_JEP .set 'GC_PYJA_VER_MIN', GC_PYJA_VER_MIN
GC_JEP .set 'GC_PYJA_VER_PAT', GC_PYJA_VER_PAT

GC_JEP .set 'GC_EC_NONE', GC_EC_NONE
GC_JEP .set 'GC_EC_SHUTDOWN', GC_EC_SHUTDOWN
GC_JEP .set 'GC_EC_SUCCESS', GC_EC_SUCCESS
GC_JEP .set 'GC_EC_ERROR', GC_EC_ERROR

GC_JEP .set 'GC_FOSA', GC_FOSA
GC_JEP .set 'GC_PASA', GC_PASA

GC_JEP .set 'GC_THIS_PID', GC_THIS_PID
GC_JEP .set 'GC_OS_ENV_PATHS', GC_OS_ENV_PATHS

GC_JEP .set 'GC_MILO_PN', GC_MILO_PN

GC_JEP .set 'GC_PYJA_RT', GC_PYJA_RT
GC_JEP .set 'GC_PYJA_HM', GC_PYJA_HM

GC_JEP .set 'GC_PYJA_RT_SYM', GC_PYJA_RT_SYM
GC_JEP .set 'GC_PYJA_HM_SYM', GC_PYJA_HM_SYM
GC_JEP .set 'GC_MILO_PN_SYM', GC_MILO_PN_SYM

GC_JEP .set 'GC_JAVA_HM', GC_JAVA_HM
GC_JEP .set 'GC_JRUBY_HM', GC_JRUBY_HM
GC_JEP .set 'GC_PYTHON_HM', GC_PYTHON_HM

GC_JEP .set 'JC_FX_STAGE', GC_FX_STAGE

GC_JEP .set 'JC_GR', GC_GR
def gy_cy x_fun_nm, *x_args; GC_JEP .invoke x_fun_nm, * x_args; end
def gp_run_python x_fn; GC_JEP .run_script x_fn end

def gp_begin
  puts gf_banner.join "\n"
  GC_LOG .debug "Pyja name => #{GC_PYJA_NM}"
  raise RuntimeError, 'Invalid Pyja name !!!' if GC_PYJA_NM != ( gf_os_env :SC_PYJA_NM )
  GC_LOG .debug "Pyja creation date => #{GC_PYJA_CD}"
  raise RuntimeError, 'Pyja create date is not invalid !!!' unless gf_str_is_valid_date GC_PYJA_CD, '%Y.%m.%d'
  GC_LOG .debug "Pyja version => #{GC_PYJA_V2}"
  raise RuntimeError, 'Invalid Pyja version !!!' if GC_PYJA_VR != ( gf_os_env :SC_PYJA_VR )
  GC_LOG .info  "Pyja root (#{GC_PYJA_RT_SYM}) => #{GC_PYJA_RT}"
  GC_LOG .info  "Pyja home (#{GC_PYJA_HM_SYM}) => #{ gf_to_prs GC_PYJA_HM }"
  GC_LOG .info  "Milo path (#{GC_MILO_PN_SYM}) => #{ gf_to_phs GC_MILO_PN }"
  GC_LOG .debug "Process ID => #{GC_THIS_PID}"
  GC_LOG .info  "Java version => #{GC_JAVA_VR}"
  GC_LOG .info  "JRuby version => #{GC_JRUBY_VR}"
  GC_LOG .info  "Ruby version => #{GC_RUBY_VR}"
  GC_LOG .info  "Groovy version => #{GC_GROOVY_VR}"
  GC_LOG .info  "Python version => #{GC_PYTHON_VR}"
  GC_LOG .info  "Tcl version => #{GC_TCL_VR}"
  GC_LOG .info  "PyQt version => #{GC_PYQT_VR}"
  GC_LOG .info  "Total CPU => #{GC_TOTAL_CPU}"
  GC_LOG .info  "Total memory => #{ CgString .format '%,d', GC_TOTAL_MEMORY } bytes"
  GC_LOG .debug "Computer name => #{GC_HOST_NM}"
  GC_LOG .debug "Current user => #{GC_CUSR}"
  GC_LOG .debug "Executable file => #{GC_THIS_EXE_FN}"
  GC_LOG .info  "Start up path => #{ gf_to_phs GC_THIS_START_UP_PN }"
  GC_LOG .info  "Script file => #{ gf_to_mps GC_SCRIPT_FN }"
  gp_log_array  ( GC_LOG .method :debug ), 'Paths', GC_OS_ENV_PATHS
  gp_log_array  ( GC_LOG .method :debug ),'Command', GC_THIS_CMD
  gp_log_array  'Arguments', GC_ARGV if GC_ARGV.count > 0
end

#
# Your Source
#

[
  ( gf_pj GC_PYJA_HM, 'Library', 'iText', '7.1.0', 'io-7.1.0.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'iText', '7.1.0', 'kernel-7.1.0.jar' ),
] .each { |bx2_jar_fn|
  gp_add_jar bx2_jar_fn
}

PageSize = Java::ComItextpdfKernelGeom::PageSize
PdfCanvas = Java::ComItextpdfKernelPdfCanvas::PdfCanvas
PdfDocument = Java::ComItextpdfKernelPdf::PdfDocument
PdfReader = Java::ComItextpdfKernelPdf::PdfReader
PdfWriter = Java::ComItextpdfKernelPdf::PdfWriter

class CAtReversePages < CgAt
  LInputFileNumberOfPages = gf_gi 'class LInputFileNumberOfPages { int lu_it }'
  LDone = gf_gi 'class LDone {}'
  LSoFar = gf_gi 'class LSoFar { int lu_it }'
  def receive x_letter
    GC_LOG .debug "Received #{x_letter.get_class.get_name}"
    case x_letter
    when Java::Default::LInputFileName
      @wv_i_doc .close unless @wv_i_doc.nil?
      @wv_i_doc = PdfDocument.new PdfReader.new x_letter.lu_it
      tell sender, ( gf_gn LInputFileNumberOfPages, @wv_i_doc.number_of_pages .to_java(:int) )
    when Java::Default::LDo then wn_do x_letter.lu_o_fn
    end
  end
  def wn_do x_o_fn
    nu_w = PdfWriter.new x_o_fn
    nu_w .setSmartMode true
    nu_o_doc = PdfDocument.new nu_w
    nv_o_nop_so_far = 0
    @wv_i_doc.number_of_pages.step(1, -1) { |bx2_i_pg_no|
      bu2_i_pg = @wv_i_doc .get_page bx2_i_pg_no
      bu2_i_pg_sz = bu2_i_pg.crop_box
      bu2_o_pg_cp = bu2_i_pg .copy_as_form_xobject nu_o_doc
      bu2_o_pg = nu_o_doc .add_new_page ( PageSize.new bu2_i_pg_sz )
      ( PdfCanvas.new bu2_o_pg ) .add_xobject bu2_o_pg_cp, 0, 0
      nv_o_nop_so_far += 1
      tell sender, ( gf_gn LSoFar, nv_o_nop_so_far .to_java(:int) )
    }
  ensure
    nu_o_doc .close 
    tell sender, ( gf_gn LDone )
  end
end

module OStart
  def self.main
    gp_register_on_termination {
      # Code to run after termination of GC_AS, in this block you can't use GC_LOG
    }
    gp_run_python gf_pj GC_MILO_PN, "#{GC_APP_NM}.py"
  end
end

OStart.main
