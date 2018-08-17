import java.util.Date;
import javafx.application.Application;
import javafx.stage.Stage;
import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import jep.Jep;

public class ORun extends Application {
  private static String [] __oal_args;
  public static void main ( final String [] x_args ) {
    __oal_args = x_args;
    launch (ORun.class);
  }
  @Override
  public void start ( final Stage x_stage ) throws Exception {
    final ScriptEngine nu_jr = new ScriptEngineManager () .getEngineByName ("jruby");
    if ( nu_jr == null ) {
      System.out.println ( "Can't find JRuby engine !!!" );
      System .exit (1);
    }
    if ( __oal_args.length < 1 ) {
      System.out.println ( "Must specify a JRuby file name !!!" );
      System .exit (1);
    }
    final Jep nu_jep = new Jep ( false, "." );
    nu_jep .set ( "JC_JR", nu_jr );
    final String nu_jr_fn = __oal_args [0];
    nu_jr .put ( "__gau_st", new Date () );
    nu_jr .put ( "__gau_jep", nu_jep );
    nu_jr .put ( "__gau_fx_stage", x_stage );
    ( (Invocable) nu_jr ) .invokeFunction ( "require", nu_jr_fn );
  }
}
