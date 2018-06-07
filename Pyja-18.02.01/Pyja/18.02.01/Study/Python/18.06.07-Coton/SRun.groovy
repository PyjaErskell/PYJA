class CFxApp extends javafx.application.Application {
  private static def __casl_args
  static void csn_launch ( final x_args ) {
    __casl_args = x_args
    launch this
  }
  void start ( final javafx.stage.Stage x_stage ) { 
    final nu_jep = new jep.Jep ( false, '.' )
    nu_jep .set 'JC_JEP', nu_jep
    nu_jep .set 'JC_FX_STAGE', x_stage
    nu_jep .runScript __casl_args
  }
}

CFxApp .csn_launch ( args [0] )
