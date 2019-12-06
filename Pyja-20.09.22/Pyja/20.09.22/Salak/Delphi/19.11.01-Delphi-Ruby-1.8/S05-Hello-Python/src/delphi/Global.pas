unit Global;

interface

uses
  ComObj, System.SysUtils, Vcl.Forms;

var
  gu_r: Variant;

function gf_re ( x_str: String ) : Variant;

implementation

function gf_re ( x_str: String ) : Variant;
begin
  result := gu_r .Eval (x_str);
end;

initialization
  gu_r := CreateOleObject ('ScriptControl');
  gu_r.Language := 'RubyScript';
  gf_re (
    'lambda { |x_milo_pn|' + Chr(10) +
    '  pu_src_pn = [ x_milo_pn, "src", "ruby" ] .join "\\"' + Chr(10) +
    '  $LOAD_PATH .unshift pu_src_pn unless $LOAD_PATH .include? pu_src_pn' + Chr(10) +
    '  $GC_MILO_PN = x_milo_pn' + Chr(10) +
    '  require "SToa"' + Chr(10) +
    '}'
  ) .call ( ExtractFileDir ( ExtractFileDir (Application.ExeName) ) );

finalization

end.
