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

ENV['Path'] = [ ( $gf_pj .call $GC_RUBY_HM, 'bin' ), ENV['Path'] ] .join $GC_PASA
ENV['JAVA_HOME'] = $GC_JAVA_HM

require 'iconv'
require 'rjb'

Rjb::load nil, ['-Dfile.encoding=UTF-8']

$CjSystem = Rjb::import 'java.lang.System'
$CjString = Rjb::import 'java.lang.String'
$CjLocale = Rjb::import 'java.util.Locale'

$GC_CONV_2_UTF8 = Iconv.new 'UTF-8//IGNORE', $GC_ENCODING
$GC_CONV_2_BACK = Iconv.new $GC_ENCODING, 'UTF-8//IGNORE'

$gf_2_utf8 = lambda { |x_it|
  if x_it .kind_of? Array
    return x_it .map { |bx2_item| ( bx2_item .kind_of? String ) ? ( $GC_CONV_2_UTF8 .iconv bx2_item ) : bx2_item }
  elsif x_it .kind_of? String
    $GC_CONV_2_UTF8 .iconv x_it
  else
    x_it
  end
}

$gf_2_back = lambda { |x_it|
  if x_it .kind_of? Array
    return x_it .map { |bx2_item| ( bx2_item .kind_of? String ) ? ( $GC_CONV_2_BACK .iconv bx2_item ) : bx2_item }
  elsif x_it .kind_of? String
    $GC_CONV_2_BACK .iconv x_it
  else
    x_it
  end
}

$jf_sf = lambda { | x_format, * x_args |
  fu_r = $CjString .format x_format, ( $gf_2_utf8 .call x_args )
  $gf_2_back .call fu_r
}

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

[
  ( $gf_pj .call $GC_KAPA_HM, '19.01.22', 'Cumuni', 'ICU4J', '63.1', 'icu4j-63_1.jar' ),
  ( $gf_pj .call $GC_KAPA_HM, '19.01.22', 'Cumuni', 'ICU4J', '63.1', 'icu4j-charset-63_1.jar' ),
  ( $gf_pj .call $GC_KAPA_HM, '19.01.22', 'Cumuni', 'ICU4J', '63.1', 'icu4j-localespi-63_1.jar' ),
] .each { |bx2_jar_fn| Rjb::add_jar bx2_jar_fn }

$CjRuleBasedNumberFormat = Rjb::import 'com.ibm.icu.text.RuleBasedNumberFormat'

su_spellout_eng = $CjRuleBasedNumberFormat .new $CjLocale.ENGLISH, $CjRuleBasedNumberFormat.SPELLOUT
su_spellout_kor = $CjRuleBasedNumberFormat .new $CjLocale.KOREA, $CjRuleBasedNumberFormat.SPELLOUT

$sf_spellout_eng = lambda { |x_number|
  $gf_2_back .call su_spellout_eng .format x_number
}

$sf_spellout_kor = lambda { |x_number|
  $gf_2_back .call su_spellout_kor .format x_number
}
