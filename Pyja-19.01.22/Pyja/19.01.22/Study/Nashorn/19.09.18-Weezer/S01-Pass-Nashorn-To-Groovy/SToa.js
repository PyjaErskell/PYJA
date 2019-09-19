var GC_GR = new Packages.javax.script.ScriptEngineManager () .getEngineByName("Groovy");
GC_GR .put ( "GC_GR", GC_GR );
GC_GR .put ( "GC_NA", this );
gu_string = "Hello, this is Nashorn string";
function gf_hello (x_name) {
  return "Hello " + x_name + " !!!";
}
function gf_sum ( x_1, x_2, x_3 ) { return new java.lang.Long ( x_1 + x_2 + x_3 ); }
GC_GR .eval ( new java.io.FileReader ( ( java.lang.System ) .getenv ("SC_TONO_HM") + java.io.File.separator + "SToa.groovy" ) );
