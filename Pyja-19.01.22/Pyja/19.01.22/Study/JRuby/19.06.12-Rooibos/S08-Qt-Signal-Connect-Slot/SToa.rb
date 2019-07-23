#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

require 'fileutils'
require 'hash_dot'
require 'heredoc_unindent'

Hash.use_dot_syntax = true

CgInteger = Java::JavaLang::Integer
CgDouble = Java::JavaLang::Double
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
def gf_to_kms x_pn; gy_gf :gf_to_kms, x_pn; end

def gp_request_exit x_ec, x_ex_list = []; gy_gf :gp_request_exit, x_ec, x_ex_list; end

def gf_exception_to_list x_ex
  fu_list = [ x_ex.message ]
  x_ex .backtrace .each { |bx2_it| fu_list << ( gf_to_kms bx2_it ) } unless x_ex .backtrace .nil?
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

def gy_call_if_exist x_ro, x_yethod_nm, * x_args
  ( x_ro .method x_yethod_nm ) .call *x_args if x_ro .respond_to? x_yethod_nm
end

def __gaf_ua & x_blk
  Class .new {
    include Java::AkkaJapiPf::FI::UnitApply
    def initialize x_blk; @__cau_blk = x_blk; end
    def apply x_it; @__cau_blk .call x_it; end
  } .new x_blk
end

$__CgAt = Class.new(Java::AkkaActor::AbstractActor) { # (a)c(t)or
  attr_writer :cu_at_ro
  def preStart; gy_br { gy_call_if_exist @cu_at_ro, :preStart } end
  def createReceive; ( receive_builder .match Java::JavaLang::Object.java_class, __gaf_ua { |x_letter| gy_br { gy_call_if_exist @cu_at_ro, :receive, x_letter } } ) .build; end
  def postStop; gy_br { gy_call_if_exist @cu_at_ro, :postStop } end
}

$__CgAkCreator = Class .new {
  include Java::AkkaJapi::Creator
  def initialize x_at_ro, x_args
    @cu_at_ro = x_at_ro
    @cu_args = x_args
  end
  def create
    mu_at = $__CgAt .new
    @cu_at_ro .tap { |it|
      it .define_singleton_method :getSelf do; mu_at .getSelf; end
      it .define_singleton_method :getContext do; mu_at .getContext; end
      it .define_singleton_method :getSender do; mu_at .getSender; end
      gy_br { gy_call_if_exist it, :create, *@cu_args }
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

#---------------------------------------------------------------
# Global ( Qt Jambi )
#---------------------------------------------------------------

def gp_qr & x_blk; com.trolltech.qt.core.QCoreApplication .invokeLater { gy_br { x_blk .call } }; end # (Q)t (r)un

def gf_qg x_n; gy_gf "gf_qg_#{x_n}"; end # x_n <- 0 to 9

def gp_gco x_signal, x_slot # gco = si(g)nal (c)onnect sl(o)t
  pu_slot = gy_gf "gf_qo_#{x_signal.class.name[-1]}", ( x_slot.class == Method ) ? x_slot .to_proc : x_slot
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

class CMain
  def preStart
    @cg_0 = gf_qg 0
    gp_gco @cg_0, ( self .method :con_0 )

    @cg_1 = gf_qg 1
    gp_gco @cg_1, ( self .method :con_1 )

    @cg_2 = gf_qg 2
    gp_gco @cg_2, self.method(:con_2)

    @cg_3 = gf_qg 3
    gp_gco @cg_3, self.method(:con_3)

    @cg_4 = gf_qg 4
    gp_gco @cg_4, self.method(:con_4)

    @cg_5 = gf_qg 5
    gp_gco @cg_5, self.method(:con_5)

    @cg_6 = gf_qg 6
    gp_gco @cg_6, self.method(:con_6)

    @cg_7 = gf_qg 7
    gp_gco @cg_7, self.method(:con_7)

    @cg_8 = gf_qg 8
    gp_gco @cg_8, self.method(:con_8)

    @cg_9 = gf_qg 9
    gp_gco @cg_9, self.method(:con_9)

    @cg_0 .emit
    @cg_1 .emit 1
    @cg_2 .emit 1, 2
    @cg_3 .emit 1, 2, 3
    @cg_4 .emit 1, 2, 3, 4
    @cg_5 .emit 1, 2, 3, 4, 5
    @cg_6 .emit 1, 2, 3, 4, 5, 6
    @cg_7 .emit 1, 2, 3, 4, 5, 6, 7
    @cg_8 .emit 1, 2, 3, 4, 5, 6, 7, 8
    @cg_9 .emit 1, 2, 3, 4, 5, 6, 7, 8, 9
  end
  def con_0
    gp_log_header 'Test signal connect slot', 50
    GC_LOG .info gf_wai
  end
  def con_1 x_1
    GC_LOG .info gf_wai "#{x_1}"
  end
  def con_2 x_1, x_2
    GC_LOG .info gf_wai "#{x_1}, #{x_2}"
  end
  def con_3 x_1, x_2, x_3
    GC_LOG .info gf_wai "#{x_1}, #{x_2}, #{x_3}"
  end
  def con_4 x_1, x_2, x_3, x_4
    GC_LOG .info gf_wai "#{x_1}, #{x_2}, #{x_3}, #{x_4}"
  end
  def con_5 x_1, x_2, x_3, x_4, x_5
    GC_LOG .info gf_wai "#{x_1}, #{x_2}, #{x_3}, #{x_4}, #{x_5}"
  end
  def con_6 x_1, x_2, x_3, x_4, x_5, x_6
    GC_LOG .info gf_wai "#{x_1}, #{x_2}, #{x_3}, #{x_4}, #{x_5}, #{x_6}"
  end
  def con_7 x_1, x_2, x_3, x_4, x_5, x_6, x_7
    GC_LOG .info gf_wai "#{x_1}, #{x_2}, #{x_3}, #{x_4}, #{x_5}, #{x_6}, #{x_7}"
  end
  def con_8 x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8
    GC_LOG .info gf_wai "#{x_1}, #{x_2}, #{x_3}, #{x_4}, #{x_5}, #{x_6}, #{x_7}, #{x_8}"
  end
  def con_9 x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9
    GC_LOG .info gf_wai "#{x_1}, #{x_2}, #{x_3}, #{x_4}, #{x_5}, #{x_6}, #{x_7}, #{x_8}, #{x_9}"
  end
  def postStop
    ng_0 = gf_qg 0
    gp_gco ng_0, -> () {
      GC_LOG .info 'From custom Qt Signal 0'
      GC_LOG .info 'About to quit ...'
      gp_request_exit GC_EC_SUCCESS
    }

    ng_1 = gf_qg 1
    gp_gco ng_1, -> (bx_1) {
      gp_log_header 'Test signal connect lambda', 50
      GC_LOG .info "#{bx_1} from custom Qt Signal 1"
    }

    ng_2 = gf_qg 2
    gp_gco ng_2, -> ( bx_1, bx_2 ) { GC_LOG .info "#{ bx_1 + bx_2 } from custom Qt Signal 2" }

    ng_3 = gf_qg 3
    gp_gco ng_3, -> ( bx_1, bx_2, bx_3 ) { GC_LOG .info "#{bx_1}, #{bx_2}, #{bx_3} from custom Qt Signal 3" }

    ng_4 = gf_qg 4
    gp_gco ng_4, -> ( bx_1, bx_2, bx_3, bx_4 ) { GC_LOG .info "#{bx_1}, #{bx_2}, #{bx_3}, #{bx_4} from custom Qt Signal 4" }

    ng_5 = gf_qg 5
    gp_gco ng_5, -> ( bx_1, bx_2, bx_3, bx_4, bx_5 ) { GC_LOG .info "#{bx_1}, #{bx_2}, #{bx_3}, #{bx_4}, #{bx_5} from custom Qt Signal 5" }

    ng_6 = gf_qg 6
    gp_gco ng_6, -> ( bx_1, bx_2, bx_3, bx_4, bx_5, bx_6 ) { GC_LOG .info "#{bx_1}, #{bx_2}, #{bx_3}, #{bx_4}, #{bx_5}, #{bx_6} from custom Qt Signal 6" }

    ng_7 = gf_qg 7
    gp_gco ng_7, -> ( bx_1, bx_2, bx_3, bx_4, bx_5, bx_6, bx_7 ) { GC_LOG .info "#{bx_1}, #{bx_2}, #{bx_3}, #{bx_4}, #{bx_5}, #{bx_6}, #{bx_7} from custom Qt Signal 7" }

    ng_8 = gf_qg 8
    gp_gco ng_8, -> ( bx_1, bx_2, bx_3, bx_4, bx_5, bx_6, bx_7, bx_8 ) { GC_LOG .info "#{bx_1}, #{bx_2}, #{bx_3}, #{bx_4}, #{bx_5}, #{bx_6}, #{bx_7}, #{bx_8} from custom Qt Signal 8" }

    ng_9 = gf_qg 9
    gp_gco ng_9, -> ( bx_1, bx_2, bx_3, bx_4, bx_5, bx_6, bx_7, bx_8, bx_9 ) { GC_LOG .info "#{bx_1}, #{bx_2}, #{bx_3}, #{bx_4}, #{bx_5}, #{bx_6}, #{bx_7}, #{bx_8}, #{bx_9} from custom Qt Signal 9" }

    ng_1 .emit 'One'
    ng_2 .emit 1000, 24
    ng_3 .emit 1, 2, 3
    ng_4 .emit 1, 2, 3, 4
    ng_5 .emit 1, 2, 3, 4, 5
    ng_6 .emit 1, 2, 3, 4, 5, 6
    ng_7 .emit 1, 2, 3, 4, 5, 6, 7
    ng_8 .emit 1, 2, 3, 4, 5, 6, 7, 8
    ng_9 .emit 1, 2, 3, 4, 5, 6, 7, 8, 9

    ng_0 .emit
  end
end

module DBody
  def self .dp_it
    gp_register_on_termination {
      # Code to run after termination of GC_AS, in this block you can't use GC_LOG
    }
    # 1 / 0
    com.trolltech.qt.gui.QApplication .initialize [] .to_java :string

    pu_atr_m = gf_mk_atr_ro CMain .new, [], :c
    GC_AS .stop pu_atr_m
  end
end

def sp_main
  DRun .dp_it
end

sp_main
