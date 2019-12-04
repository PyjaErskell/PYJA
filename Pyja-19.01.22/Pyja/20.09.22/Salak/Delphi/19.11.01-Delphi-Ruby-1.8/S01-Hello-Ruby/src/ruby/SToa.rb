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
