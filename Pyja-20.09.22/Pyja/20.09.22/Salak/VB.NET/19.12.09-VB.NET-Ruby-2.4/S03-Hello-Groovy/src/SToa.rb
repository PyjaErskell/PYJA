#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

$GC_FOSA = File::ALT_SEPARATOR || File::SEPARATOR # (fo)lder (s)ep(a)rator
$GC_PASA = File::PATH_SEPARATOR # (pa)th (s)ep(a)rator

$gf_pj = -> ( * x_args ) { x_args .join $GC_FOSA } # (p)ath (j)oin
$gf_bn = -> (x_fn) { File .basename x_fn } # (b)ase (n)ame
$gf_id = -> (x_it) { File .directory? x_it } # (i)s (d)irectory
$gf_pn = -> ( x_it, x_chedk_id = false ) { ( x_chedk_id and ( $gf_id .(x_it) ) ) ? (x_it) : ( File .dirname x_it ) } # (p)ath (n)ame
$gf_on = -> ( x_it, x_chedk_id = false ) { $gf_bn .( $gf_pn .( x_it, x_chedk_id ) ) } # f(o)lder (n)ame

$GC_OLIM_PN = $gf_pn .($GC_MILO_PN)
$GC_OLIM_NM = $gf_on .( $GC_OLIM_PN, true )

$GC_TONO_HM = $GC_MILO_PN
$GC_TONO_NM = $gf_on .( $GC_TONO_HM, true )

$gf_sf = -> ( * x_args ) { sprintf *x_args } # (s)tring (f)ormat

$GC_KAPA_HM = $gf_pj .( 'C:', 'ProgramData', 'Bichon Frise', 'Kapa' )

$GC_JAVA_HM = $gf_pj .( $GC_KAPA_HM, '19.11.01', 'Vindue', 'x64', 'Amazon', 'Corretto', '8.232.09.1' )
ENV['JAVA_HOME'] = $GC_JAVA_HM

require 'rjb'

-> () {
  pu_jars = [
    $gf_pj .( $GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.8', 'indy', 'groovy-2.5.8-indy.jar' ),
    $gf_pj .( $GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.8', 'indy', 'groovy-jsr223-2.5.8-indy.jar' ),
  ] .join $GC_PASA
  Rjb::load pu_jars, ['-Dfile.encoding=UTF-8']
} .()

$ju_g = ( Rjb::import 'javax.script.ScriptEngineManager' ) .new .getEngineByName ('Groovy')
$jf_ge = -> (x_str) { $ju_g .eval x_str } # ge = (g)roovy (e)val
$jf_gf = -> ( x_nm, * x_args ) { $ju_g .invokeFunction x_nm.to_s, x_args } # gf = (g)roovy (f)unction

$jf_ge .( File .read $gf_pj .( $GC_MILO_PN, 'src', 'SToa.groovy' ) )

$jf_cls = -> (x_cls_nm) { $jf_gf .( 'gf_cls', x_cls_nm ) }

$CjSystem = $jf_cls .('java.lang.System')
$CjString = $jf_cls .('java.lang.String')

$jf_sf = -> ( x_format, * x_args ) { $CjString .format x_format, x_args }

$GC_JAVA_VR = $CjSystem .getProperty 'java.version'
$GC_GROOVY_VR = $jf_ge .('GroovySystem.version') .toString

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

$sf_hello = -> ( x_str, x_no ) { $jf_gf .( 'sf_hello', x_str, x_no ) .toString }
$sf_sum = -> ( * x_args ) { $jf_gf .( 'sf_sum', *x_args ) .longValue }
