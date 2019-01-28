import javafx.application.Application;
import javafx.stage.Stage;
import jep.Jep;

public class ORun extends Application {
  private static String [] __oal_args; 
  public static void main ( final String [] x_args ) {
    __oal_args = x_args;
    if ( __oal_args.length < 1 ) {
      System.out.println ( "Must specify a Python file name !!!" );
      System .exit (1);
    }
    launch (ORun.class);
  }
  @Override
  public void start ( final Stage x_stage ) throws Exception {
    final Jep nu_jep = new Jep ( false, "." );
    nu_jep .set ( "JC_JEP", nu_jep );
    nu_jep .set ( "JC_FX_STAGE", x_stage );
    nu_jep .runScript ( __oal_args [0] );
  }
}
