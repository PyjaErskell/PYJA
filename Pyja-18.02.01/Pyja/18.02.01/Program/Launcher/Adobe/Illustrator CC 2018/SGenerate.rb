#
# Ruby (Global)
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

def gf_f2bs x_it; x_it .gsub '/', '\\' ;end

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

GC_PYJA_RT  = gf_ap gf_os_env(:SC_PYJA_RT)
GC_PYJA_HM  = gf_ap gf_os_env(:SC_PYJA_HM)
GC_MILO_PN  = gf_ap gf_os_env(:SC_MILO_PN)

def gf_banner x_leading_space = 0, x_margin_inside = 2
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

GC_RUBY_HM = gf_os_env(:SC_RUBY_HM)

GC_THIS_START_UP_PN = gf_ap Dir.getwd

GC_SCRIPT_FN = gf_fn $0
GC_SCRIPT_PN = gf_pn GC_SCRIPT_FN
GC_APP_NM = gf_jn GC_SCRIPT_FN

def gf_replace_with_px_symbol x_pn, x_px_path, x_px_symbol
  fu_pn = gf_ap x_pn
  return x_px_symbol if fu_pn == x_px_path
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
    GC_LOG .info  "Ruby home => #{GC_RUBY_HM}"
    GC_LOG .debug "Ruby version => #{GC_RUBY_VR}"
    GC_LOG .debug "Total CPU => #{GC_TOTAL_CPU}"
    GC_LOG .debug "Computer name => #{GC_HOST_NM}"
    GC_LOG .debug "Current user => #{GC_CUSR}"
    GC_LOG .debug "Process ID => #{GC_THIS_PID}"
    GC_LOG .info  "Start up path => #{ gf_to_phs GC_THIS_START_UP_PN }"
    GC_LOG .info  "Script file => #{ gf_to_phs GC_SCRIPT_FN }"
    gp_log_array  ( GC_LOG .method :debug ), 'Paths', GC_OS_ENV_PATHS
    gp_log_array  'Arguments', GC_ARGV if GC_ARGV.count > 0
  end
end

#
# Your Source
#

require 'os'
require 'tmpdir'

module DBody
  def self.dp_it
    __dap_common
    if OS.mac?
      __dap_gen_4_mac
    elsif OS.windows?
      __dap_gen_4_win
    else
      raise RuntimeError, "#{GC_PYJA_NM} #{GC_APP_NM} has not been tested on this OS !!!"
    end
  end
private
  def self.__dap_common
    @__dau_app_nm = gf_on GC_MILO_PN
    GC_LOG .info "Application name to generate => #{@__dau_app_nm}"
    pu_now = Time .now
    @__dau_ver_maj = pu_now.year % 100
    @__dau_ver_min = pu_now.month
    @__dau_ver_pat = pu_now.day
    GC_LOG .info "Application version to generate => #{@__dau_ver_maj}.#{@__dau_ver_min}.#{@__dau_ver_pat}"
    @__dau_dest_pn = GC_MILO_PN
    GC_LOG .info "Destination for generating application => #{ gf_to_mps @__dau_dest_pn }"
  end
  def self.__dap_gen_4_mac
    pu_bundle_pn = gf_pj @__dau_dest_pn, "#{@__dau_app_nm}.app"
    GC_LOG .info "Bundle path => #{ gf_to_mps pu_bundle_pn }"
    gp_ep pu_bundle_pn
    pu_contents_pn = gf_pj pu_bundle_pn, 'Contents'
    gp_mp pu_contents_pn
    pp2_gen_exe = ->() {
      pu2_dest_pn = gf_pj pu_contents_pn, 'MacOS'
      gp_mp pu2_dest_pn
      pu2_x_fn = gf_pj pu2_dest_pn, 'SRun.sh'
      GC_LOG .info "Generating executable #{ gf_to_mps pu2_x_fn } ..."
      File .write pu2_x_fn, <<-PASH2_EOS.unindent
        #!/bin/bash
        __SAC_MILO_PN="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
        "$__SAC_MILO_PN/../../../SRun.sh" "$@"
      PASH2_EOS
      FileUtils::chmod 'ugo+rwx', pu2_x_fn
    }
    pp2_gen_icon = ->() {
      pu2_icon_fn = gf_pj GC_MILO_PN, 'it.icns'
      pu2_dest_pn = gf_pj pu_contents_pn, 'Resources'
      gp_mp pu2_dest_pn
      GC_LOG .info "Generating icon under #{ gf_to_mps pu2_dest_pn } from #{ gf_to_mps pu2_icon_fn } ..."
      gp_cp pu2_icon_fn, pu2_dest_pn
    }
    pp2_gen_plist = ->() {
      pu2_dest_pn = pu_contents_pn
      pu2_fn = gf_pj pu2_dest_pn, 'Info.plist'
      GC_LOG .info "Generating plist #{ gf_to_mps pu2_fn } ..."
      File .write pu2_fn, <<-PASH2_EOS.unindent
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist SYSTEM
        "file://localhost/System/Library/DTDs/PropertyList.dtd">
        <plist version="0.9">
        <dict>
           <key>CFBundleExecutable</key>
           <string>SRun.sh</string>
           <key>CFBundleName</key>
           <string>#{@__dau_app_nm}</string>
           <key>CFBundleDevelopmentRegion</key>
           <string>en</string>
           <key>CFBundlePackageType</key>
           <string>APPL</string>
           <key>CFBundleSignature</key>
           <string>????</string>
           <key>CFBundleShortVersionString</key>
           <string>#{@__dau_ver_maj}.#{@__dau_ver_min}.#{@__dau_ver_pat}</string>
           <key>CFBundleIconFile</key>
           <string>it.icns</string>
        </dict>
        </plist>
      PASH2_EOS
    }
    pp2_gen_exe .()
    pp2_gen_icon .()
    pp2_gen_plist .()
  end
  def self.__dap_gen_4_win
    pu_tmp_pn = Dir.mktmpdir
    GC_LOG .info "Temporary path for compiling => #{pu_tmp_pn}"
    pu_cs_fn = gf_pj pu_tmp_pn, "#{@__dau_app_nm}.cs"
    pu_cs_src = <<-PASH2_EOS.unindent
      using System;
      using System.IO;
      using System.Windows.Forms;
      using System.Reflection;
      using System.Diagnostics;
      [ assembly : AssemblyVersionAttribute ("#{@__dau_ver_maj}.#{@__dau_ver_min}.#{@__dau_ver_pat}") ]
      class DRun {
        static void Main () {
          var nl_cl = Environment.CommandLine;
          var nl_1st_arg = Environment .GetCommandLineArgs () [0];
          string nl_args;
          if ( nl_cl .StartsWith ("\\"") ) {
            nl_args = df_replace_first ( nl_cl, "\\"" + nl_1st_arg + "\\"", "" ) .TrimStart ();
          } else {
            nl_args = df_replace_first ( nl_cl, nl_1st_arg, "" ) .TrimStart ();
          }
          var nl_x_pn = Path .GetDirectoryName (Application.ExecutablePath);
          var nl_bat_fn = Path .Combine ( nl_x_pn, "SRun.bat" );
          var nl_proc = new Process ();
          nl_proc.StartInfo.WorkingDirectory = nl_x_pn;
          nl_proc.StartInfo.FileName = nl_bat_fn;
          nl_proc.StartInfo.Arguments = nl_args;
          nl_proc.StartInfo.CreateNoWindow = true;
          nl_proc.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
          nl_proc.Start();
        }
        static string df_replace_first ( string xl_src, string xl_find, string xl_replace ) {
          int fl_place = xl_src .IndexOf (xl_find);
          string fl_r = xl_src .Remove ( fl_place, xl_find .Length ) .Insert ( fl_place, xl_replace );
          return fl_r;
        }
      }
    PASH2_EOS
    GC_LOG .info "Generating C# source #{pu_cs_fn}:\n#{pu_cs_src}"
    File .write pu_cs_fn, pu_cs_src
    pu_csc_x_fn = gf_os_env :SC_CSHARP_X_FN
    GC_LOG .info "CSharp compiler executable file => #{pu_csc_x_fn}"
    pu_icon_fn = gf_pj GC_MILO_PN, 'it.ico'
    GC_LOG .info "Icon file => #{ gf_to_mps pu_icon_fn }"
    pu_exe_fn = gf_pj @__dau_dest_pn, "#{@__dau_app_nm}.exe"
    GC_LOG .info "Generating executable file => #{ gf_to_mps pu_exe_fn } from source ..."
    system pu_csc_x_fn, '/target:winexe', "/win32icon:#{ gf_f2bs pu_icon_fn }", "/out:#{ gf_f2bs pu_exe_fn }", gf_f2bs(pu_cs_fn)
    raise RuntimeError, 'Error during compiling C# source !!!' unless $?.exitstatus == 0
  ensure
    gp_rp pu_tmp_pn
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
