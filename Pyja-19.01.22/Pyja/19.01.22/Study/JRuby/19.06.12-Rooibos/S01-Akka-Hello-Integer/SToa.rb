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

def gp_sr & x_block; javax.swing.SwingUtilities .invokeLater { x_block .call }; end # (S)wing (r)un
def gp_xr & x_block; javafx.application.Platform .runLater { x_block .call }; end # JavaF(X) (r)un
def gf_jr & x_block
  Class .new {
    include Java::JavaLang::Runnable
    def initialize x_block; @__cau_block = x_block; end
    def run; @__cau_block .call; end
  } .new x_block
end
def gf_jt & x_block
  Class .new(Java::JavaLang::Thread) {
    def initialize x_block; @__cau_block = x_block; end
    def run; @__cau_block .call; end
  } .new x_block
end

def gp_register_on_termination; GC_AS .register_on_termination gf_jr { yield if block_given? }; end

def __gaf_ua & x_block
  Class.new {
    include Java::AkkaJapiPf::FI::UnitApply
    def initialize x_block; @__cau_block = x_block; end
    def apply x_it
      @__cau_block .call x_it
    end
  }.new x_block
end

class CgAt < Java::AkkaActor::AbstractActor # (a)c(t)or
  def createReceive
    return ( receive_builder .match Java::JavaLang::Object .java_class, __gaf_ua { |it| receive it } ) .build
  end
end

$__CgAkCreator = Class .new {
  include Java::AkkaJapi::Creator
  def initialize x_cls, * x_args
    @__cau_cls = x_cls
    @__cau_args = * x_args
  end
  def create
    nu_at = @__cau_cls .new
    nu_at .create *@__cau_args if nu_at .respond_to? :create
    nu_at
  end
}
def gf_mk_atr ( x_arf = GC_AS, x_cls, x_args, x_at_nm )
  ff2_props = -> { ( Java::AkkaActor::Props .create x_cls.java_class, ( $__CgAkCreator .new x_cls, * x_args ) ) }
  fu_atr = case x_at_nm
  when :c then x_arf .actor_of ff2_props.(), x_cls.name   # same as (c)lass name
  when :a then x_arf .actor_of ff2_props.()               # (a)uto -> akka generated name
  when String then x_arf .actor_of ff2_props.(), x_at_nm
  else raise RuntimeError, "Invalid actor name : #{x_at_nm}"
  end
  fu_atr
end

#---------------------------------------------------------------
# Main Skeleton
#---------------------------------------------------------------

module DRun
  def self .dp_it
    __dap_begin
    DBody .dp_it
  rescue Exception => bu2_ex
    gp_request_exit GC_EC_ERROR, ( gf_exception_to_list bu2_ex )
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

class CAtInteger < CgAt
  def create
    @cv_value = CgInteger::MAX_VALUE - 20
  end
  def receive x_letter
    case x_letter
    when :LNext then
      cn_change_value
      get_sender .tell @cv_value, get_self
    end
  end
  def cn_change_value
    @cv_value = ( @cv_value >= CgInteger::MAX_VALUE ) ? 1 : @cv_value + 1
  end
end

class WAtMain < CgAt
  def create x_atr_integer
    @wu_atr_integer = x_atr_integer
    gp_xr { wn_init }
  end
  def receive x_letter
    gp_xr { wn_set_pb_text x_letter }
  end
  def wn_init
    @wu_root = javafx.scene.layout.VBox .new
    @wu_scene = javafx.scene.Scene .new @wu_root
    @wu_bn = javafx.scene.control.Button .new .tap { |it|
      it .set_on_action { |bx_ev| @wu_atr_integer .tell :LNext, get_self }
    }
    @wu_root .tap { |it|
      it.alignment = javafx.geometry.Pos::CENTER
      it.spacing = 10
      it.children .add_all [@wu_bn]
    }
    GC_PS .tap { |it|
      it .set_on_shown { |bx_ev| wn_shown bx_ev }
      it .set_on_close_request { |bx_ev| wn_close_request bx_ev }
      it.title = GC_TONO_NM
      it.width = 350
      it.height = 150
      it.scene = @wu_scene
      wn_move_center
      it .show
      it .to_front
    }
  end
  def wn_shown x_ev
    GC_LOG .info gf_wai
    get_context.system.scheduler .schedule CgDuration::Zero(), CgDuration.create( 10, CgTimeUnit::MILLISECONDS ), @wu_atr_integer, :LNext, get_context.system.dispatcher, get_self
  end
  def wn_set_pb_text x_letter
    @wu_bn.text = gf_sf 'Ciao, %,d', x_letter
    GC_LOG .info @wu_bn.text
  end
  def wn_close_request x_ev
    GC_LOG .info gf_wai
    gp_request_exit GC_EC_SUCCESS
  end
  def wn_move_center
    nu_vb = javafx.stage.Screen.primary.visual_bounds
    nu_cx, nu_cy = (nu_vb.width/2).to_i, (nu_vb.height/2).to_i
    GC_PS.x = nu_cx - GC_PS.width / 2
    GC_PS.y = nu_cy - GC_PS.height / 2
  end
end

module DBody
  def self .dp_it
    gp_register_on_termination { # Code to run after termination of GC_AS, in this block you can't use GC_LOG
    }
    # 1 / 0
    pu_atr_integer = gf_mk_atr CAtInteger, [], :c
    gf_mk_atr WAtMain, [pu_atr_integer], :c
  end
end

def sp_main
  DRun .dp_it
end

sp_main
