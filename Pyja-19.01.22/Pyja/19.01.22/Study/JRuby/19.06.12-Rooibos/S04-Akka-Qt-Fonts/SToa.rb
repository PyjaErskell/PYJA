#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

require 'fileutils'
require 'hash_dot'
require 'heredoc_unindent'

Hash.use_dot_syntax = true

CgInteger = Java::JavaLang::Integer
CgString = Java::JavaLang::String
CgSystem = Java::JavaLang::System

CgActorRef = Java::AkkaActor::ActorRef
CgAwait = Java::ScalaConcurrent::Await
CgDuration = Java::ScalaConcurrentDuration::Duration
CgFile = java.io.File
CgTimeUnit = java.util.concurrent.TimeUnit

GC_PS = Java::ORun.ol_ps
GC_GR = Java::ORun.ol_gr

def gf_gg x_it; GC_GR .get x_it .to_s; end
def gy_ge x_str; GC_GR .eval x_str; end
def gy_gf x_fn_nm, * x_args; GC_GR .invoke_function x_fn_nm .to_s, * x_args; end

GC_EC_NONE = gf_gg :GC_EC_NONE
GC_EC_SHUTDOWN = gf_gg :GC_EC_SHUTDOWN
GC_EC_SUCCESS = gf_gg :GC_EC_SUCCESS
GC_EC_ERROR = gf_gg :GC_EC_ERROR

GC_TONO_NM = gf_gg :GC_TONO_NM
GC_TONO_ARGV = gf_gg :GC_TONO_ARGV

GC_AS = gf_gg :GC_AS
GC_LOG = gf_gg :GC_LOG

def gp_log_array xp_out = ( GC_LOG .method :info ), x_title, x_array
  return if x_array .empty?
  xp_out .call "#{x_title} =>"
  x_array .each .with_index (1) { | bx2_it, bx2_idx | xp_out .call "  #{'%2d' % bx2_idx} : #{bx2_it}" }
end
def gp_log_header xp_out = ( GC_LOG .method :info ), x_header, x_line_width
  xp_out .call '+' + '-' * x_line_width
  xp_out .call ": #{x_header}"
  xp_out .call '+' + '-' * x_line_width
end

def gf_sf x_format, * x_args; gy_gf :gf_sf, x_format, * x_args; end

def gf_to_ths x_pn; gy_gf :gf_to_ths, x_pn; end

def gp_request_exit x_ec, x_ex_list = []; gy_gf :gp_request_exit, x_ec, x_ex_list; end

def gf_exception_to_list x_ex
  fu_list = [ x_ex.message ]
  x_ex .backtrace .each { |bx2_it| fu_list << bx2_it } unless x_ex .backtrace .nil?
  fu_list
end

def gf_wai x_msg = nil
  fu_cl = ( caller_locations 1, 1 ) [0]
  fu_msg = "#{fu_cl.label} [#{ gf_to_ths fu_cl.path }:#{ '%04d' % fu_cl.lineno }]"
  return fu_msg if x_msg .nil?
  "#{fu_msg} #{x_msg}"
end

def gf_jr & x_blk # (j)ava (r)unnable
  Class .new {
    include Java::JavaLang::Runnable
    def initialize x_blk; @__cau_blk = x_blk; end
    def run; @__cau_blk .call; end
  } .new x_blk
end

def gp_register_on_termination; GC_AS .register_on_termination gf_jr { yield if block_given? }; end

def gy_br & x_blk # (b)egin (r)escue
  x_blk .call
rescue Exception => bu2_ex
  gp_request_exit GC_EC_ERROR, ( gf_exception_to_list bu2_ex )
end

def __gaf_ua & x_blk
  Class.new {
    include Java::AkkaJapiPf::FI::UnitApply
    def initialize x_blk; @__cau_blk = x_blk; end
    def apply x_it; gy_br { @__cau_blk .call x_it }; end
  } .new x_blk
end

$__CgAt = Class.new(Java::AkkaActor::AbstractActor) { # (a)c(t)or
  attr_writer :cu_at_ro
  def preStart; @cu_at_ro .preStart if @cu_at_ro .respond_to? :preStart; end
  def createReceive; ( receive_builder .match Java::JavaLang::Object.java_class, __gaf_ua { |x_letter| @cu_at_ro .receive x_letter if @cu_at_ro .respond_to? :receive } ) .build; end
  def postStop; @cu_at_ro .postStop if @cu_at_ro .respond_to? :postStop; end
}

$__CgAkCreator = Class .new {
  include Java::AkkaJapi::Creator
  def initialize x_at_ro, x_args
    @cu_at_ro = x_at_ro
    @cu_args = x_args
  end
  def create
    mu_at = $__CgAt.new
    @cu_at_ro .tap { |it|
      it .define_singleton_method :getSelf do; mu_at .getSelf; end
      it .define_singleton_method :getContext do; mu_at .getContext; end
      it .define_singleton_method :getSender do; mu_at .getSender; end
      it .create *@cu_args if it .respond_to? :create
      mu_at.cu_at_ro = it
    }
    mu_at
  end
}

def gf_mk_atr_ro x_at_ro, x_args, x_at_nm, x_arf = GC_AS
  ff2_props = -> { Java::AkkaActor::Props .create $__CgAt.java_class, ( $__CgAkCreator .new x_at_ro, x_args ) }
  case x_at_nm
  when :a then x_arf .actor_of ff2_props . ()                     # (a)uto -> akka generated name
  when :c then x_arf .actor_of ff2_props . (), x_at_ro.class.name # same as (c)lass name
  else x_arf .actor_of ff2_props . (), x_at_nm
  end
end

def gp_xr & x_blk; javafx.application.Platform .runLater { gy_br { x_blk .call } }; end # JavaF(X) (r)un
def gp_qr & x_blk; com.trolltech.qt.core.QCoreApplication .invokeLater { gy_br { x_blk .call } }; end

def gp_gco x_signal, & x_blk # gco = si(g)nal (c)onnect sl(o)t
  pu_slot = gy_gf "gf_qs#{x_blk.arity}", x_blk
  x_signal .connect *pu_slot
end

#---------------------------------------------------------------
# Main Skeleton
#---------------------------------------------------------------

module DRun
  def self .dp_it
    gy_br {
      __dap_begin
      DBody .dp_it
    }
  end
private
  def self .__dap_begin
    GC_LOG .info  "JRuby version => #{JRUBY_VERSION}"
    GC_LOG .info  "Ruby version => #{RUBY_VERSION}"
    gp_log_array  'Arguments', GC_TONO_ARGV if GC_TONO_ARGV.count > 0
  end
end

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

import com.trolltech.qt.core.Qt
import com.trolltech.qt.gui.QApplication
import com.trolltech.qt.gui.QDesktopWidget
import com.trolltech.qt.gui.QFont
import com.trolltech.qt.gui.QFontDatabase
import com.trolltech.qt.gui.QLabel
import com.trolltech.qt.gui.QMainWindow
import com.trolltech.qt.gui.QPushButton
import com.trolltech.qt.gui.QSizePolicy
import com.trolltech.qt.gui.QVBoxLayout
import com.trolltech.qt.gui.QWidget

class WAtQtMain < QMainWindow
  def initialize
    super
    @wu_fnt_families = QFontDatabase .new .families
    GC_LOG .info gf_wai "Total fonts => #{@wu_fnt_families.size}"
    @wv_fnt_idx = @wu_fnt_families.size - 1
  end
  def create
    gp_qr { cn_create }
  end
  def receive x_letter
    gp_qr { wn_change_font }
  end
  def cn_create
    set_window_title GC_TONO_NM
    nu_cw = QWidget .new
    nu_lo = QVBoxLayout .new
    @wu_pb = QPushButton .new .tap { |it|
      it .set_size_policy QSizePolicy::Policy::Expanding, QSizePolicy::Policy::Fixed
      gp_gco it.pressed do
        wn_change_font
      end
    }
    @wu_lb = QLabel .new .tap { |it| it.alignment = Qt::AlignmentFlag::AlignCenter }
    [ QWidget .new, @wu_pb, @wu_lb ] .each { |it| nu_lo .add_widget it }
    wn_change_font
    nu_cw.layout = nu_lo
    set_central_widget nu_cw
    wn_move_position
    showMaximized
    raise
    QApplication .exec_static
  end
  def showEvent x_ev
    GC_LOG .info gf_wai
    getContext.system.scheduler .schedule CgDuration::Zero(), CgDuration .create( 100, CgTimeUnit::MILLISECONDS ), getSelf, :LNext, getContext.system.dispatcher, nil
  end
  def closeEvent x_ev
    GC_LOG .info gf_wai 'About to quit ...'
    gp_request_exit GC_EC_SUCCESS
  end
  def wn_change_font
    @wv_fnt_idx = 0 if @wv_fnt_idx >= @wu_fnt_families.size
    nu_fnt_nm = @wu_fnt_families [@wv_fnt_idx]
    GC_LOG .info "#{@wv_msg}" unless @wv_msg.nil?
    nu_nt = "(#{@wv_fnt_idx+1}/#{@wu_fnt_families.size})"
    @wv_msg = "0^0 #{nu_nt} (#{nu_fnt_nm})"
    @wu_pb .tap { |it|
      it.text = "Say '#{@wv_msg}'"
      it.font = QFont .new nu_fnt_nm, 18
    }
    @wu_lb.text = "#{nu_nt} Font name : #{nu_fnt_nm}"
    @wv_fnt_idx += 1
  end
  def wn_move_position
    nu_cp = QDesktopWidget .new .available_geometry.center # center point
    move nu_cp.x - width/2, nu_cp.y - height/2
  end
end

module DBody
  def self .dp_it
    gp_register_on_termination {
      # Code to run after termination of GC_AS, in this block you can't use GC_LOG
    }
    QApplication .initialize [] .to_java :string
    gf_mk_atr_ro WAtQtMain .new, [], :c
  end
end

def sp_main
  DRun .dp_it
end

sp_main
