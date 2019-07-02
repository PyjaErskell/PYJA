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

def gf_qg x_n; gy_gf "gf_qg_#{x_n}"; end # x_n <- 0 to 9

def gp_gco x_signal, x_nethod # gco = si(g)nal (c)onnect sl(o)t
  pu_slot = gy_gf "gf_qo_#{x_signal.class.name[-1]}", x_nethod .to_proc
  x_signal .connect *pu_slot
end

def gp_gcb x_signal, & x_blk # gco = si(g)nal (c)onnect ruby (b)lock
  pu_slot = gy_gf "gf_qo_#{x_signal.class.name[-1]}", x_blk
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

# The following url is referred for this sample.
# https://github.com/callicoder/javafx-examples/blob/master/javafx-registration-form-application/src/RegistrationFormApplication.java

import javafx.geometry.HPos
import javafx.geometry.Insets
import javafx.geometry.Pos
import javafx.scene.control.Alert
import javafx.scene.control.Button
import javafx.scene.control.Label
import javafx.scene.control.PasswordField
import javafx.scene.control.TextField
import javafx.scene.layout.ColumnConstraints
import javafx.scene.layout.GridPane
import javafx.scene.layout.Priority
import javafx.scene.Scene
import javafx.scene.text.Font
import javafx.scene.text.FontWeight

class WAtFxMain
  def create
    gp_xr { wn_create }
  end
  def wn_create
    nu_root = GridPane .new .tap { |it|
      it.alignment = Pos::CENTER # position the pane at the center of the screen, both vertically and horizontally
      it.padding = Insets .new 40, 40, 40, 40 # set a padding of 20px on each side
      it.hgap = 10 # set the horizontal gap between columns
      it.vgap = 10 # set the vertical gap between rows
      it.column_constraints .add_all ( ColumnConstraints .new 100, 100, CgDouble::MAX_VALUE ) .tap { |it| it.halignment = HPos::RIGHT },
        ( ColumnConstraints .new 200, 200, CgDouble::MAX_VALUE ) .tap { |it| it.hgrow = Priority::ALWAYS }
    }
    Label .new('Registration Form') .tap { |it| # add header
      it.font = Font .font 'Arial', FontWeight::BOLD, 24
      nu_root .add it, 0, 0, 2, 1
      GridPane .set_halignment it, HPos::CENTER
      GridPane .set_margin it, ( Insets .new 20, 0, 20 ,0 )
    }
    nu_root .add ( Label .new 'Full Name : ' ), 0, 1 # add name label
    nu_tf_nm = TextField .new .tap { |it| # add name text field
      it.pref_height = 40
      nu_root .add it, 1, 1
    }
    nu_root .add ( Label .new 'Email ID : ' ), 0, 2 # add email label
    nu_tf_email = TextField .new .tap { |it| # # add email text field
      it.pref_height = 40
      nu_root .add it, 1, 2
    }
    nu_root .add ( Label .new 'Password : ' ), 0, 3 # add password label
    nu_pf_nm = PasswordField .new .tap { |it| # # add password field
      it.pref_height = 40
      nu_root .add it, 1, 3
    }
    Button .new('Submit') .tap { |it| # add submit button
      it.pref_height = 40
      it.default_button = true
      it.pref_width = 100
      nu_root .add it, 0, 4, 2, 1
      GridPane .set_halignment it, HPos::CENTER
      GridPane .set_margin it, ( Insets .new 20, 0, 20, 0 )
      it .set_on_action { |bx_ev| gy_br {
        bu_w = nu_root.scene.window
        if nu_tf_nm.text .empty?
          wn_show_alert Alert::AlertType::ERROR, bu_w, 'Form Error!', 'Please enter your name'
        elsif nu_tf_email.text .empty?
          wn_show_alert Alert::AlertType::ERROR, bu_w, 'Form Error!', 'Please enter your email id'
        elsif nu_pf_nm.text .empty?
          wn_show_alert Alert::AlertType::ERROR, bu_w, 'Form Error!', 'Please enter a password'
        else
          wn_show_alert Alert::AlertType::CONFIRMATION, bu_w, 'Registration Successful!', "Welcome #{nu_tf_nm.text}"
        end
      } }
    }
    GC_PS .tap { |it|
      it .set_on_shown { |bx_ev| wn_shown bx_ev }
      it .set_on_close_request { |bx_ev| gy_br { wn_close_request bx_ev } }
      it.title = GC_TONO_NM
      it.width = 800
      it.height = 500
      it.scene = Scene .new nu_root
      it .show
      it .to_front
    }
  end
  def wn_show_alert x_type, x_owner, x_title, x_msg
    Alert .new(x_type) .tap { |it|
      it.title = x_title
      it.header_text = nil
      it.content_text = x_msg
      it.init_owner x_owner
      it.show
    }
  end
  def wn_shown x_ev
    GC_LOG .info gf_wai
  end
  def wn_close_request x_ev
    GC_LOG .info gf_wai 'About to quit ...'
    gp_request_exit GC_EC_SUCCESS
  end
end

module DBody
  def self .dp_it
    gp_register_on_termination {
      # Code to run after termination of GC_AS, in this block you can't use GC_LOG
    }
    # 1 / 0
    gf_mk_atr_ro WAtFxMain .new, [], :c
  end
end

def sp_main
  DRun .dp_it
end

sp_main
