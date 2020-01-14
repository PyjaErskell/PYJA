#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

use v5.26;
use strict;
use warnings;

use File::Basename;

BEGIN { $ENV {'SC_DUCK_PN'} = dirname __FILE__; }

use i191210::G010;

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

use File::Copy;
use File::Slurp;
use File::Temp;

my $su_tmp_pn = File::Temp -> newdir;

sub sp_body {
  GC_LOG -> info ( "Temporary path (${\ GC_TEMP_PN_SYM }) => $su_tmp_pn" );
  gp_mp GC_ECU_PN;
  gp_ep GC_ECU_PN;
  gp_log_header undef, 'Making executable from C++ source ...', undef;

  my $pu_src_pn = gf_pj GC_MILO_PN, 'src', 'k-00701-ya';
  my $pu_src_fn = gf_pj $pu_src_pn, 'SToa.cpp';
  GC_LOG -> info ( "C++ source file => ${\ gf_to_mps $pu_src_fn }" );
  my $pu_src_jn = gf_jn $pu_src_fn;
  my $pu_pro_fn = gf_pj $su_tmp_pn, "$pu_src_jn.pro";
  my @pu_inc_paths = (GC_ECU_PN);
  write_file $pu_pro_fn, <<~PASH_EOS;
    TARGET = $pu_src_jn
    TEMPLATE = app
    macx {
      CONFIG -= app_bundle
    }
    QMAKE_CXXFLAGS += -std=gnu++1z
    CONFIG += release
    QT += core gui widgets network
    ${\ join ( "\n  ", map { "INCLUDEPATH += \"$_\"" } @pu_inc_paths ) }
    DEFINES += QT_DEPRECATED_WARNINGS
    VPATH += "$pu_src_pn"
    SOURCES += ${\ gf_bn $pu_src_fn }
    PASH_EOS
  gp_log_array undef, "Generating Qt pro file => ${\ gf_to_tps $pu_pro_fn, $su_tmp_pn }", read_file $pu_pro_fn;

  my $pu_qm_x_fn = gf_os_env 'SC_QM_X_FN';
  GC_LOG -> info ( "Qt qmake executable file => ${\ gf_to_khs $pu_qm_x_fn }" );
  my $pu_mk_fn = gf_pj $su_tmp_pn, 'Makefile';
  GC_LOG -> info ( "Generating ${\ gf_to_tps $pu_mk_fn, $su_tmp_pn } ..." );
  my $pu_qm_rxc = gf_rxc [ $pu_qm_x_fn, '-o', $pu_mk_fn, $pu_pro_fn ];
  gp_log_array undef, undef, @{$pu_qm_rxc->ru_soe};
  die 'Cannot generate Makefile ... !!!' if $pu_qm_rxc->ru_ce >> 8;

  my $pu_make_x_fn = gf_os_env 'SC_MAKE_X_FN';
  GC_LOG -> info ( "Make executable file => ${\ gf_to_khs $pu_make_x_fn }" );
  GC_LOG -> info ( "Compiling C++ ${\ gf_to_mps $pu_src_fn } ..." );
  my $pu_mk_rxc = gf_rxc [ $pu_make_x_fn, '-C', $su_tmp_pn ];
  gp_log_array undef, undef, @{$pu_mk_rxc->ru_soe};
  die 'Cannot compile ... !!!' if $pu_mk_rxc->ru_ce >> 8;

  my $pv_x_bn = $pu_src_jn;
  $pv_x_bn .= '.exe' if $^O eq 'MSWin32';
  my $pu_x_fn = gf_pj $su_tmp_pn, $pv_x_bn;
  GC_LOG -> info ( "Moving generated executable ${\ gf_to_tps $pu_x_fn, $su_tmp_pn } to ${\ gf_to_mps GC_ECU_PN } ..." );
  die 'Cannot move ... !!!' unless move $pu_x_fn, GC_ECU_PN;
}

sub sp_main {
  gp_run \&sp_body;
}

sp_main;
