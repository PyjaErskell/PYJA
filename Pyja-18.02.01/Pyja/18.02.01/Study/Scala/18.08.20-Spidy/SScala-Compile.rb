#
# Ruby (Global)
#

GC_ST = Time.now

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

GC_RUBY_VR = RUBY_VERSION

require 'date'
require 'etc'
require 'fileutils'
require 'hash_dot'
require 'heredoc_unindent'
require 'logger'
require 'socket'

Hash.use_dot_syntax = true

GC_TOTAL_CPU = Etc.nprocessors
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

GC_LOG = ->() {
  fu_it = Logger.new STDOUT
  fu_it.level = Logger::DEBUG  # Logger::INFO
  fu_it.formatter = proc do | bx2_severity, bx2_datetime, bx2_progname, bx2_msg |
    bu2_datetime = bx2_datetime.strftime '%y%m%d-%H%M%S'
    "[#{ '%06d' % GC_THIS_PID },#{bx2_severity.chars.first},#{bu2_datetime}] #{bx2_msg}\n"
  end
  fu_it
}.()

def gp_set_log_level_to_info; GC_LOG .level = Logger::INFO; end
def gp_set_log_level_to_debug; GC_LOG .level = Logger::DEBUG; end

GC_ARGV = ARGV

GC_KAPA_HM  = gf_ap gf_os_env(:SC_KAPA_HM)
GC_PYJA_RT  = gf_ap gf_os_env(:SC_PYJA_RT)
GC_PYJA_HM  = gf_ap gf_os_env(:SC_PYJA_HM)
GC_MILO_PN  = gf_ap gf_os_env(:SC_MILO_PN)

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

GC_JAVA_HM  = gf_ap gf_os_env(:SC_J8_HM)
GC_RUBY_HM = gf_os_env(:SC_RUBY_HM)

GC_THIS_START_UP_PN = gf_ap Dir.getwd

GC_SCRIPT_FN = gf_fn $0
GC_SCRIPT_PN = gf_pn GC_SCRIPT_FN
GC_APP_NM = gf_jn GC_SCRIPT_FN

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

def gp_request_exit x_ec, x_ex = nil
  gp_log_array ( GC_LOG.method :debug ), '$LOAD_PATH', $: .sort
  gp_log_exception 'Following error occurs !!!', x_ex unless x_ex .nil?
  GC_LOG.info "Exit code => #{x_ec}"
  GC_LOG.info "Elpased #{ ( Time.at Time.now - GC_ST ) .utc .strftime ('%H:%M:%S.%L') } ..."
  exit x_ec
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
    GC_LOG .info  "KAPA home => #{GC_KAPA_HM}"
    GC_LOG .info  "Java home => #{GC_JAVA_HM}"
    GC_LOG .info  "Ruby home => #{GC_RUBY_HM}"
    GC_LOG .debug "Ruby version => #{GC_RUBY_VR}"
    GC_LOG .debug "Total CPU => #{GC_TOTAL_CPU}"
    GC_LOG .debug "Computer name => #{GC_HOST_NM}"
    GC_LOG .debug "Current user => #{GC_CUSR}"
    GC_LOG .debug "Process ID => #{GC_THIS_PID}"
    GC_LOG .info  "Start up path => #{ gf_to_mps GC_THIS_START_UP_PN }"
    GC_LOG .info  "Script file => #{ gf_to_mps GC_SCRIPT_FN }"
    gp_log_array  ( GC_LOG .method :debug ), 'Paths', GC_OS_ENV_PATHS
    gp_log_array  'Arguments', GC_ARGV if GC_ARGV.count > 0
  end
end

#
# Your Source
#

require 'tmpdir'

module DBody
  def self.dp_it
    @__dau_tmp_pn = Dir.mktmpdir
    GC_LOG .info "Temporary path for compiling => #{@__dau_tmp_pn}"
    @__dau_cls_o_pn = gf_pj @__dau_tmp_pn, 'cls'
    gp_mp @__dau_cls_o_pn
    GC_LOG .info "Output path for generated class files => #{@__dau_cls_o_pn}"
    raise RuntimeError, 'You must specify scala source file name !!!' unless GC_ARGV.count > 0
    @__dau_scala_src_fn = GC_ARGV[0]
    GC_LOG .info "Scala source file => #{ gf_to_mps @__dau_scala_src_fn }"
    raise RuntimeError, 'Scala source file not exist !!!' unless gf_xi @__dau_scala_src_fn
    @__dau_src_jn = gf_jn @__dau_scala_src_fn
    __dap_compile_scala
    __dap_make_jar
  ensure
    gp_rp @__dau_tmp_pn
  end
private
  def self.__dap_compile_scala
    gp_log_header 'Compiling scala source file ...', 40
    pu_jar_fn_list_4_scala_boot_cp = __daf_jar_fn_list_4_scala_boot_cp
    gp_log_array  'JAR files for scala boot class path', pu_jar_fn_list_4_scala_boot_cp .map { |bx2_jar_fn| gf_to_prs bx2_jar_fn }
    pu_scala_boot_cp = pu_jar_fn_list_4_scala_boot_cp .join GC_PASA
    pu_jar_fn_list = __daf_jar_fn_list
    gp_log_array  'JAR files for compiling scala source', pu_jar_fn_list .map { |bx2_jar_fn| gf_to_prs bx2_jar_fn }
    pu_java_x_fn = gf_os_env :SC_J8_X_FN
    GC_LOG .info "Java executable file => #{pu_java_x_fn}"
    GC_LOG .info "Compiling #{ gf_to_mps @__dau_scala_src_fn } ..."
    system pu_java_x_fn, '-Xmx256M', '-Xms32M', "-Xbootclasspath/a:#{pu_scala_boot_cp}", '-classpath', '', "-Dscala.boot.class.path=#{pu_scala_boot_cp}", 'scala.tools.nsc.Main', '-feature', '-target:jvm-1.8', '-classpath', pu_jar_fn_list.join(GC_PASA), '-d', @__dau_cls_o_pn, @__dau_scala_src_fn
    raise RuntimeError, 'Error during compiling !!!' unless $?.exitstatus == 0
  end
  def self.__daf_jar_fn_list_4_scala_boot_cp
    fu_it = [
      ( gf_os_env :SC_JEP_JAR_FN ),
      ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'jline-2.14.5.jar' ),
      ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-compiler.jar' ),
      ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-library.jar' ),
      ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-parser-combinators_2.12-1.0.6.jar' ),
      ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-reflect.jar' ),
      ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-swing_2.12-2.0.0.jar' ),
      ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-xml_2.12-1.0.6.jar' ),
      ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scalap-2.12.4.jar' ),
    ]
    gp_log_array  ( GC_LOG .method :debug ), 'Scala boot class jar files', fu_it
    return fu_it .sort
  end
  def self.__daf_jar_fn_list
    fu_python_src_fn = gf_pj GC_MILO_PN, "#{@__dau_src_jn}.py" 
    GC_LOG .info "Companion python script file => #{ gf_to_mps fu_python_src_fn }"
    raise RuntimeError, 'Companion python script file not exist !!!' unless gf_xi fu_python_src_fn
    GC_LOG .info 'Extracting jar files from companion python script ...'
    fu_fns = [ ( gf_pj GC_MILO_PN, 'out', 'ORun.jar' ) ]
    File.readlines(fu_python_src_fn).each do |bx2_ln|
      unless bx2_ln =~ %r{^\s*#}
        %r{\s*gf_jar_pj\s*\(\s*(?<bu2_args>.+)\s*\)\s*,\s*$}i =~ bx2_ln
        fu_fns << ( eval "gf_pj #{bu2_args}" ) unless bu2_args.nil?
      end
    end
    raise RuntimeError, "Can't find any jar file !!!" unless fu_fns.count > 0
    gp_log_array  ( GC_LOG .method :debug ), 'Extracted jar files', fu_fns
    return fu_fns .sort
  end
  def self.__dap_make_jar
    gp_log_header 'Making jar file ...', 40
    @__dau_out_pn = gf_pj GC_MILO_PN, 'out'
    gp_mp @__dau_out_pn
    @__dau_out_jar_fn = gf_pj @__dau_out_pn, "#{@__dau_src_jn}.jar"
    GC_LOG .info "Output JAR file => #{ gf_to_mps @__dau_out_jar_fn }"
    pu_jar_x_fn = gf_os_env :SC_J8R_X_FN
    GC_LOG .info "Jar executable file => #{pu_jar_x_fn}"
    system pu_jar_x_fn, '-cvf', @__dau_out_jar_fn, '-C', @__dau_cls_o_pn, '.'
    raise RuntimeError, 'Error during making jar !!!' unless $?.exitstatus == 0
  end
end

module OStart
  def self.main
    gp_set_log_level_to_info
    DRun .dp_it
  end
end

if $0 == __FILE__
  OStart.main
end
