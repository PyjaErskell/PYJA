#
# Global
#

GC_ST = Time.now

GC_PYJA_NM = 'Pyja'

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

require 'date'
require 'etc'
require 'fileutils'
require 'hash_dot'
require 'heredoc_unindent'
require 'logger'
require 'socket'

Hash.use_dot_syntax = true

GC_TOTAL_CPU = Etc.nprocessors
GC_TOTAL_MEMORY = Java::JavaLangManagement::ManagementFactory .operating_system_mx_bean .total_physical_memory_size
GC_HOST_NM = Socket.gethostname
GC_CUSR = Etc.getlogin  # current user
GC_THIS_PID = Process.pid

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
def gp_cp x_i_fn, x_o_pn; FileUtils .cp x_i_fn, x_o_pn; end

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

GC_ARGV = ARGV

GC_PYJA_RT  = gf_ap gf_os_env(:SC_PYJA_RT)
GC_PYJA_HM  = gf_ap gf_os_env(:SC_PYJA_HM)
GC_JAVA_HM  = gf_ap gf_os_env(:SC_J8_HM)
GC_JRUBY_HM = gf_ap gf_os_env(:SC_JRUBY_HM)
GC_MILO_PN  = gf_ap gf_os_env(:SC_MILO_PN)

GC_THIS_START_UP_PN = gf_ap Dir.getwd

GC_SCRIPT_FN = gf_fn $0
GC_APP_NM = gf_jn GC_SCRIPT_FN

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

def gp_add_jar x_jar_fn
  raise RuntimeError, "Can't find jar file => #{x_jar_fn}" unless gf_if x_jar_fn
  $CLASSPATH << x_jar_fn
end
->() {
  [
    ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'akka-actor_2.12-2.5.9.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'akka-slf4j_2.12-2.5.9.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'config-1.3.2.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-library.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'Groovy', '2.4.13', 'embeddable', 'groovy-all-2.4.13-indy.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'JNA', '4.5.1', 'jna-4.5.1.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'JNA', '4.5.1', 'jna-platform-4.5.1.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-classic-1.2.3.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-core-1.2.3.jar' ),
    ( gf_pj GC_PYJA_HM, 'Library', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
  ] .each { |bx2_jar_fn|
    gp_add_jar bx2_jar_fn
  }
}.()

GC_GR = Java::JavaxScript::ScriptEngineManager.new .get_engine_by_name ('groovy')
GC_GR .eval """
  Object.metaClass.GC_EC_ERROR = #{GC_EC_ERROR}
  Object.metaClass.GC_THIS_PID = #{GC_THIS_PID}
"""
def gy_gr_call x_fun_nm, *x_args; GC_GR .invoke_function x_fun_nm, *x_args; end

GC_GR .eval <<-__GASH_EOS.unindent
  Object.metaClass.__gau_jr = org.jruby.Ruby .getGlobalRuntime ()
  Object.metaClass.__gaf_java_to_jr = { final Object... x_java_oj_arr ->
    final fu_jr_oj_arr = new org.jruby.runtime.builtin.IRubyObject [x_java_oj_arr.length]
    x_java_oj_arr .eachWithIndex { final bx2_java_oj, final bx2_idx -> fu_jr_oj_arr [bx2_idx] = org.jruby.javasupport.JavaEmbedUtils.javaToRuby __gau_jr, bx2_java_oj }
    return fu_jr_oj_arr
  }
  Object.metaClass.__gaf_jr_ctx = { return __gau_jr .getGlobalRuntime () .getThreadService () .getCurrentContext () }
  class __CgFxApp extends javafx.application.Application {
    private static org.jruby.RubyProc __casp_start = null
    def static csn_launch ( final org.jruby.RubyProc xp_start ) { __casp_start = xp_start; launch this }
    void start ( final javafx.stage.Stage x_stage ) { __casp_start .call __gaf_jr_ctx (), __gaf_java_to_jr ( this, x_stage ) }
  }
  def gp_fx_start ( final org.jruby.RubyProc x_block ) { Thread .start { __CgFxApp .csn_launch x_block } }
__GASH_EOS
def gp_fx_start &x_block; gy_gr_call 'gp_fx_start', x_block; end
def gp_xr &x_block; javafx.application.Platform.runLater { x_block .call }; end

CgActorRef = Java::AkkaActor::ActorRef
CgAwait = Java::ScalaConcurrent::Await
CgDuration = Java::ScalaConcurrentDuration::Duration
CgJnaPlatform = Java::ComSunJna::Platform
CgString = Java::JavaLang::String

GC_GR .eval <<-__GASH_EOS.unindent
  def __gaf_default_as ( final String x_as_nm ) {
    fu_lc = org.slf4j.LoggerFactory .getILoggerFactory ()
    final fu_jc = new ch.qos.logback.classic.joran.JoranConfigurator ()
    fu_jc .setContext (fu_lc)
    fu_lc .reset ()
    final fu_cfg_xml_str = """
      <configuration>
        <statusListener class="ch.qos.logback.core.status.NopStatusListener" />
        <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
          <layout class="ch.qos.logback.classic.PatternLayout">
            <Pattern>
              [${ String.format ( '%04d', GC_THIS_PID ) },%.-1level,%date{yyMMdd-HHmmss}] %msg%n
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
    return akka.actor.ActorSystem .create ( x_as_nm, fu_cfg )
  }
  Object.metaClass.GC_AS = __gaf_default_as ('GC_AS')
  def gf_as () { return GC_AS }
  def gp_set_log_level_to_info () { GC_AS .eventStream () .setLogLevel ( akka.event.Logging .InfoLevel () ) }
  def gp_set_log_level_to_debug () { GC_AS .eventStream () .setLogLevel ( akka.event.Logging .DebugLevel () ) }
__GASH_EOS

GC_AS = gy_gr_call 'gf_as'
GC_LOG = GC_AS.log
def gp_set_log_level_to_info; gy_gr_call 'gp_set_log_level_to_info'; end
def gp_set_log_level_to_debug; gy_gr_call 'gp_set_log_level_to_debug'; end

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
  when :c then x_arf .actor_of ff2_props.(), x_cls.name   # same as (c)lass name
  when :a then x_arf .actor_of ff2_props.()               # (a)uto -> akka generated name
  when String then x_arf .actor_of ff2_props.(), x_at_nm
  else raise RuntimeError, "Invalid actor name : #{x_at_nm}"
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
    gp_log_array 'CLASSPATH', Java::JavaLang::ClassLoader .system_class_loader .uRLs .map { |it| it.to_s } .sort unless pu_ec == GC_EC_SUCCESS
    pu_ex = @__dav_cx.lu_ex
    gp_log_exception 'Following error occurs !!!', pu_ex unless pu_ex .nil?
    gp_log_header ( GC_LOG .method :error ), 'Unknown error occurs !!!', 60 if pu_ec != GC_EC_SUCCESS and pu_ex .nil?
    case
    when pu_ec == GC_EC_NONE then GC_LOG .error 'Undefined exit code (GC_EC_NONE), check your logic !!!'
    when pu_ec == GC_EC_SHUTDOWN then GC_LOG .info 'Exit code from shutdown like ctrl+c, ...'
    when pu_ec < 0 then GC_LOG .error "Negative exit code (#{pu_ec}), should consider using a positive value !!!"
    else GC_LOG .info "Exit code => #{pu_ec}"
    end
    GC_LOG.info "Elpased #{ ( Time.at Time.now - GC_ST ) .utc .strftime ('%H:%M:%S.%L') } ..."
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

class CgAt < Java::AkkaActor::AbstractActor # (a)c(t)or
  def createReceive
    return ( receive_builder .match Java::JavaLang::Object .java_class, __gaf_ua { |it| receive it } ) .build
  end
  def tell x_target_atr, x_letter, x_sender_atr = nil
    nu_sender_atr = if x_sender_atr.nil? then get_self else x_sender_atr end
    x_target_atr .tell x_letter, nu_sender_atr
  end
end

#
# Main Skeleton
#

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
    puts __daf_banner.join "\n"
    GC_LOG .debug "Pyja name => #{GC_PYJA_NM}"
    raise RuntimeError, 'Invalid Pyja name !!!' if GC_PYJA_NM != ( gf_os_env :SC_PYJA_NM )
    GC_LOG .debug "Pyja creation date => #{GC_PYJA_CD}"
    raise RuntimeError, 'Pyja create date is not invalid !!!' unless gf_str_is_valid_date GC_PYJA_CD, '%Y.%m.%d'
    GC_LOG .debug "Pyja version => #{GC_PYJA_V2}"
    raise RuntimeError, 'Invalid Pyja version !!!' if GC_PYJA_VR != ( gf_os_env :SC_PYJA_VR )
    GC_LOG .info  "Pyja root (#{GC_PYJA_RT_SYM}) => #{GC_PYJA_RT}"
    GC_LOG .info  "Pyja home (#{GC_PYJA_HM_SYM}) => #{ gf_to_prs GC_PYJA_HM }"
    GC_LOG .info  "Milo path (#{GC_MILO_PN_SYM}) => #{ gf_to_phs GC_MILO_PN }"
    GC_LOG .info  "Java home => #{GC_JAVA_HM}"
    GC_LOG .info  "JRuby home => #{GC_JRUBY_HM}"
    GC_LOG .debug "Ruby description => #{RUBY_DESCRIPTION}"
    GC_LOG .debug "Total CPU => #{GC_TOTAL_CPU}"
    GC_LOG .debug "Total memory => #{ CgString .format '%,d', GC_TOTAL_MEMORY } bytes"
    GC_LOG .debug "Computer name => #{GC_HOST_NM}"
    GC_LOG .debug "Current user => #{GC_CUSR}"
    GC_LOG .debug "Process ID => #{GC_THIS_PID}"
    GC_LOG .info  "Start up path => #{ gf_to_phs GC_THIS_START_UP_PN }"
    GC_LOG .info  "Script file => #{ gf_to_phs GC_SCRIPT_FN }"
    gp_log_array  ( GC_LOG .method :debug ), 'Paths', GC_OS_ENV_PATHS
    gp_log_array  'Arguments', GC_ARGV if GC_ARGV.count > 0
  end
  def self.__daf_banner x_leading_space = 0, x_margin_inside = 2
    fu_msgs = [
      "#{GC_PYJA_NM} #{GC_APP_NM}",
      '',
      "ran on #{ Time .now .strftime ('%F %T') }",
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
end

#
# Your Source
#

require 'tmpdir'

module DBody
  def self.dp_it
    gp_register_on_termination {
      # Code to run after termination of GC_AS, in this block you can't use GC_LOG
    }
    if CgJnaPlatform .is_windows then GC_LOG .info 'Operating system => Windows'
    elsif CgJnaPlatform .is_mac then GC_LOG .info 'Operating system => macOS'
    else raise RuntimeError, 'Untested OS !!!'
    end
    @__dau_tmp_pn = Dir.mktmpdir
    GC_LOG .info "Temporary path for compiling => #{@__dau_tmp_pn}"
    @__dau_cls_o_pn = gf_pj @__dau_tmp_pn, 'cls'
    gp_mp @__dau_cls_o_pn
    GC_LOG .info "Output path for generated class files => #{@__dau_cls_o_pn}"
    @__dau_java_src_fn = gf_pj GC_MILO_PN, 'DgQt.java'
    GC_LOG .info "Java source file => #{@__dau_java_src_fn}"
    raise RuntimeError, 'Java source file not exist !!!' unless gf_xi @__dau_java_src_fn
    @__dau_src_jn = gf_jn @__dau_java_src_fn
    __dap_compile_java
    __dap_make_jar
    __dap_generate_header
    __dap_make_shared
  ensure
    gp_rp @__dau_tmp_pn
  end
private
  def self.__dap_compile_java
    gp_log_header 'Compiling java source file ...', 40
    pu_javac_x_fn = gf_os_env :SC_J8C_X_FN
    GC_LOG .info "Java compiler executable file => #{pu_javac_x_fn}"
    Thread.new do
      system pu_javac_x_fn, '-d', @__dau_cls_o_pn, @__dau_java_src_fn
      raise RuntimeError, 'Error during compiling !!!' unless $?.exitstatus == 0
    end .join
  end
  def self.__dap_make_jar
    gp_log_header 'Making jar file ...', 40
    @__dau_x_pn = gf_pj GC_MILO_PN, 'exe'
    gp_mp @__dau_x_pn
    @__dau_out_jar_fn = gf_pj @__dau_x_pn, "#{@__dau_src_jn}.jar"
    GC_LOG .info "Output JAR file => #{ gf_to_mps @__dau_out_jar_fn }"
    pu_jar_x_fn = gf_os_env :SC_J8R_X_FN
    GC_LOG .info "Jar executable file => #{pu_jar_x_fn}"
    Thread.new do
      system pu_jar_x_fn, '-cvf', @__dau_out_jar_fn, '-C', @__dau_cls_o_pn, '.'
      raise RuntimeError, 'Error during making jar !!!' unless $?.exitstatus == 0
    end .join
  end
  def self.__dap_generate_header
    gp_log_header 'Generating header file from jar ...', 40
    @__dau_out_header_fn = gf_pj GC_MILO_PN, "#{@__dau_src_jn}.h"
    GC_LOG .info "Output header file => #{ gf_to_mps @__dau_out_header_fn }"
    pu_javah_x_fn = gf_os_env :SC_J8H_X_FN
    GC_LOG .info "Java class file disassembler executable file => #{pu_javah_x_fn}"
    Thread.new do
      system pu_javah_x_fn, '-o', @__dau_out_header_fn, '-cp', @__dau_out_jar_fn, @__dau_src_jn
      raise RuntimeError, 'Error during generating header !!!' unless $?.exitstatus == 0
    end .join
  end
  def self.__dap_make_shared
    gp_log_header 'Making shared object from c++ source ...', 40
    pu_src_jn = @__dau_src_jn
    pu_pro_fn = gf_pj @__dau_tmp_pn, "#{pu_src_jn}.pro"
    GC_LOG .info "Generating file #{ gf_bn pu_pro_fn } in temporary path"
    pu_inc_paths = ( gf_os_env :SC_INC_PATH ) .split GC_PASA
    pu_libs = ( gf_os_env :SC_LIB ) .split GC_PASA
    File .write pu_pro_fn, <<-__PASH_EOS.unindent
      TARGET = #{pu_src_jn}
      TEMPLATE = lib
      CONFIG += c++14
      CONFIG += shared
      CONFIG += release
      QT += core
      #{ pu_inc_paths .map { |bx2_pn| "INCLUDEPATH += #{bx2_pn.inspect}" } .join "\n      " }
      #{ pu_libs .map { |bx2_fn| "LIBS += #{bx2_fn.inspect}" } .join "\n      " }
      DEFINES += QT_DEPRECATED_WARNINGS
      VPATH += $$(SC_MILO_PN)
      SOURCES += #{pu_src_jn}.cpp
      win32 {
        QMAKE_CXXFLAGS += /utf-8
      }
    __PASH_EOS
    puts File .read pu_pro_fn
    pu_qm_x_fn = gf_os_env :SC_QM_X_FN
    GC_LOG .info "qmake executable file => #{pu_qm_x_fn}"
    pu_mk_fn = gf_pj @__dau_tmp_pn, 'Makefile'
    GC_LOG .info "Generating Makefile #{ gf_bn pu_mk_fn } in temporary path ..."
    pu_x_pn = @__dau_x_pn
    Thread.new do
      system pu_qm_x_fn, '-o', pu_mk_fn, pu_pro_fn
      raise RuntimeError, 'Error during generating Makefile !!!' unless $?.exitstatus == 0
    end .join
    GC_LOG .info "Compiling #{pu_src_jn}.cpp ..."
    if CgJnaPlatform .is_windows
      Dir.chdir(@__dau_tmp_pn)
      Thread.new do
        system 'nmake', '/f', 'Makefile'
        raise RuntimeError, 'Error during compiling c++ source !!!' unless $?.exitstatus == 0
      end .join
      bu2_x_fn = gf_pj @__dau_tmp_pn, 'release', "#{pu_src_jn}.dll"
      GC_LOG .info "Copying generated dll #{bu2_x_fn} to #{ gf_to_phs pu_x_pn } ..."
      gp_cp bu2_x_fn, pu_x_pn
    elsif CgJnaPlatform .is_mac
      Thread.new do
        system 'make', '-C', @__dau_tmp_pn
        raise RuntimeError, 'Error during compiling c++ source !!!' unless $?.exitstatus == 0
      end .join
      bu2_x_fn = gf_pj @__dau_tmp_pn, "lib#{pu_src_jn}.dylib"
      GC_LOG .info "Copying generated executable #{bu2_x_fn} to #{ gf_to_phs pu_x_pn } ..."
      gp_cp bu2_x_fn, pu_x_pn
    end
  end
end

module OStart
  def self.main
    gp_set_log_level_to_info
    DRun .dp_it #false
  end
end

if $0 == __FILE__
  OStart.main
end
