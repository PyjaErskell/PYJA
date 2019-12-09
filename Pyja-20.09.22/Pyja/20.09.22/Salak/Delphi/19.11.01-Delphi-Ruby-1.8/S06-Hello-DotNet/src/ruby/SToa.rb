#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

$GC_ENCODING = 'EUC-KR'

$GC_FOSA = File::ALT_SEPARATOR || File::SEPARATOR # (fo)lder (s)ep(a)rator
$GC_PASA = File::PATH_SEPARATOR # (pa)th (s)ep(a)rator

$gf_pj = lambda { | * x_args | x_args .join $GC_FOSA } # (p)ath (j)oin
$gf_bn = lambda { |x_fn| File .basename x_fn } # (b)ase (n)ame
$gf_id = lambda { |x_it| File .directory? x_it } # (i)s (d)irectory
def gf_pn x_it, x_chedk_id = false; ( x_chedk_id and ( $gf_id .call x_it ) ) ? (x_it) : ( File .dirname x_it ); end # (p)ath (n)ame
$gf_pn = method :gf_pn
def gf_on x_it, x_chedk_id = false; $gf_bn .call $gf_pn .call x_it, x_chedk_id; end # f(o)lder (n)ame
$gf_on = method :gf_on

$GC_OLIM_PN = $gf_pn .call $GC_MILO_PN
$GC_OLIM_NM = $gf_on .call $GC_OLIM_PN, true

$GC_TONO_HM = $GC_MILO_PN
$GC_TONO_NM = $gf_on .call $GC_TONO_HM, true

$gf_sf = lambda { | * x_args | sprintf *x_args }

$GC_KAPA_HM = $gf_pj .call 'C:', 'ProgramData', 'Bichon Frise', 'Kapa'
$GC_JAVA_HM = $gf_pj .call 'C:', 'Program Files (x86)', 'Java', 'jdk1.8.0_66'
$GC_RUBY_HM = $gf_pj .call $GC_KAPA_HM, '19.11.01', 'Vindue', 'x32', 'ActiveScriptRuby', '1.8.7-p330'

ENV['JAVA_HOME'] = $GC_JAVA_HM

ENV['Path'] = [ ( $gf_pj .call $GC_RUBY_HM, 'bin' ), ENV['Path'] ] .join $GC_PASA

$GC_PYTHON_HM = $gf_pj .call $GC_KAPA_HM, '19.01.22', 'Vindue', 'x32', 'Anaconda', '2.3.0'
$GC_JEP_PN = $gf_pj .call $GC_PYTHON_HM, 'Lib', 'site-packages', 'jep'
$GC_JEP_JAR_FN = $gf_pj .call $GC_JEP_PN, 'jep-3.8.2.jar'
$GC_QT_PLUGIN_PATH = $gf_pj .call $GC_PYTHON_HM, 'Lib', 'site-packages', 'PyQt5', 'plugins'

ENV['Path'] = [ $GC_PYTHON_HM, ENV['Path'] ] .join $GC_PASA
ENV['PYTHONPATH'] = $gf_pj .call $GC_PYTHON_HM, 'Lib'

require 'iconv'
require 'rjb'

$GC_CONV_2_UTF8 = Iconv.new 'UTF-8//IGNORE', $GC_ENCODING
$GC_CONV_2_BACK = Iconv.new $GC_ENCODING, 'UTF-8//IGNORE'

def gf_2u x_it
  if x_it .kind_of? Array
    return x_it .map { |bx2_item| ( bx2_item .kind_of? String ) ? ( $GC_CONV_2_UTF8 .iconv bx2_item ) : bx2_item }
  elsif x_it .kind_of? String
    $GC_CONV_2_UTF8 .iconv x_it
  else
    x_it
  end
end

def gf_2b x_it
  if x_it .kind_of? Array
    return x_it .map { |bx2_item| ( bx2_item .kind_of? String ) ? ( $GC_CONV_2_BACK .iconv bx2_item ) : bx2_item }
  elsif x_it .kind_of? String
    $GC_CONV_2_BACK .iconv x_it
  else
    x_it
  end
end

lambda {
  pu_jars = [
    ( $gf_pj .call $GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.8', 'indy', 'groovy-2.5.8-indy.jar' ),
    ( $gf_pj .call $GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.8', 'indy', 'groovy-jsr223-2.5.8-indy.jar' ),
    $GC_JEP_JAR_FN,
  ] .join $GC_PASA
  Rjb::load pu_jars, [ '-Dfile.encoding=UTF-8', "-Djava.library.path=#{$GC_JEP_PN}" ]
} .call

$ju_g = ( Rjb::import 'javax.script.ScriptEngineManager' ) .new .getEngineByName ('Groovy')
$jf_ge = lambda { |x_str| $ju_g .eval x_str } # ge = (g)roovy (e)val
$jf_gf = lambda { | x_nm, * x_args | $ju_g .invokeFunction x_nm.to_s, x_args } # gf = (g)roovy (f)unction

$jf_ge .call '''
  gf_cls = { x_cls_nm -> Class .forName (x_cls_nm) } // find class from string
'''

$jf_cls = lambda { |x_cls_nm| $jf_gf .call 'gf_cls', x_cls_nm }

lambda {
  pu_src_pn = $gf_pj .call $GC_MILO_PN, 'src', 'python'
  $ju_t = ( Rjb::import 'jep.Jep' ).new false, pu_src_pn
  $ju_t .set 'GC_QT_PLUGIN_PATH', $GC_QT_PLUGIN_PATH
  $ju_t .runScript $gf_pj .call pu_src_pn, 'SToa.py'
} .call
$jf_tf = lambda { | x_nm, * x_args | $ju_t .invoke x_nm.to_s, x_args } # tf = py(t)hon (f)unction

$CjSystem = $jf_cls .call 'java.lang.System'
$CjString = $jf_cls .call 'java.lang.String'
$CjLong = $jf_cls .call 'java.lang.Long'

$jf_sf = lambda { | x_format, * x_args |
  fu_r = $CjString .format x_format, ( gf_2u x_args )
  gf_2b fu_r
}

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

$jf_ge .call '''
  sf_hello = { x_str, x_no -> "Hello ${ x_str * x_no } !!!" }
  sf_sum = { long ... x_args -> x_args*.value .sum () }
'''
$sf_g_hello = lambda { | x_str, x_no | gf_2b $CjString .valueOf $jf_gf .call 'sf_hello', ( gf_2u x_str ), x_no  }
$sf_g_sum = lambda { | * x_args | ( $jf_gf .call 'sf_sum', *x_args ) .longValue }

$sf_t_hello = lambda { | x_str, x_no | gf_2b $CjString .valueOf $jf_tf .call 'sf_hello', ( gf_2u x_str ), x_no  }
$sf_t_sum = lambda { | * x_args | ( $jf_tf .call 'sf_sum', *x_args ) .longValue }

$sf_n_format = lambda { | x_format, * x_args | 
  fu_args = gf_2u x_args
  gf_2b $CjString .valueOf $jf_tf .call 'sf_n_format', x_format, *fu_args
}
