class CFxApp extends javafx.application.Application {
  private static def __casl_args
  static void csn_launch ( final x_args ) {
    __casl_args = x_args
    launch this
  }
  void start ( final javafx.stage.Stage x_stage ) {
    final nu_jr = new javax.script.ScriptEngineManager () .getEngineByName ('jruby')
    nu_jr .put ( '__gau_fx_stage', x_stage )
    nu_jr .invokeFunction ( 'require', __casl_args [0] )
  }
}

CFxApp .csn_launch (args)
