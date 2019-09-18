var GC_GR = new Packages.javax.script.ScriptEngineManager () .getEngineByName("Groovy");
GC_GR .put ( "GC_NH", this );
gu_string = "Hello, this is Nashorn string";
function gf_hello (x_name) {
  return "Hello " + x_name + " !!!";
}
GC_GR .eval ( new Packages.java.io.FileReader ( ( Packages.java.lang.System ) .getenv ("SC_TONO_HM") + Packages.java.io.File.separator + "SToa.groovy" ) );
