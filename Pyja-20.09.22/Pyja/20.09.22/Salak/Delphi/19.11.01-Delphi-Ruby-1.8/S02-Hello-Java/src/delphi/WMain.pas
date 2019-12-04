unit WMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ComObj, Vcl.StdCtrls;

type
  Twu_main = class(TForm)
    wu_lbx: TListBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wu_main: Twu_main;
  wu_r: Variant;

implementation

{$R *.dfm}

procedure Twu_main.FormCreate(Sender: TObject);
begin
  wu_r := CreateOleObject ('ScriptControl');
  wu_r.Language := 'RubyScript';
  with wu_lbx .Items do begin
    Add ( Format ( 'Delphi Community Edition RTL Version => %f', [RTLVersion] ) );
    Add ( Format ( '$0 => %s', [ wu_r .Eval ('$0') ] ) );
    Add ( Format ( '$$ => %s', [ wu_r .Eval ('$$') ] ) );
    Add ( Format ( 'RUBY_VERSION => %s', [ wu_r .Eval ('RUBY_VERSION') ] ) );
    Add ( Format ( 'RUBY_PLATFORM => %s', [ wu_r .Eval ('RUBY_PLATFORM') ] ) );
    Add ( Format ( 'RUBY_RELEASE_DATE => %s', [ wu_r .Eval ('RUBY_RELEASE_DATE') ] ) );
    wu_r .Eval (
      'lambda { |x_milo_pn|' + Chr(10) +
      '  pu_src_pn = [ x_milo_pn, "src", "ruby" ] .join "\\"' + Chr(10) +
      '  $LOAD_PATH .unshift pu_src_pn unless $LOAD_PATH .include? pu_src_pn' + Chr(10) +
      '  $GC_MILO_PN = x_milo_pn' + Chr(10) +
      '  require "SToa"' + Chr(10) +
      '}'
    ) .call ( ExtractFileDir ( ExtractFileDir (Application.ExeName) ) );
    wu_main.Caption := Format ( '%s : %s', [ wu_r .Eval ('$GC_OLIM_NM'), wu_r .Eval ('$GC_TONO_NM') ] );
    Add ( Format ( 'Java version => %s', [ wu_r .Eval ('$CjSystem') .getProperty ('java.version') ] ) );
    Add ( Format ( 'Ruby sprintf "%%1$*2$s %%2$d %%1$s", "Hello", 8 => %s', [ wu_r .Eval ('$gf_sf') .call ( '%1$*2$s %2$d %1$s', 'Hello', 8 ) ] ) );
    Add ( Format ( 'Ruby sprintf "%%1$*2$s %%2$d %%1$s", "Korean (한글)", 30 => %s', [ wu_r .Eval ('$gf_sf') .call ( '%1$*2$s %2$d %1$s', 'Korean (한글)', 30 ) ] ) );
    Add ( Format ( 'Java string format "Hello %%s (%%,d) !!!", "World", 3141592 => %s', [ wu_r .Eval ('$jf_sf') .call ( 'Hello %s (%,d) !!!', 'World', 3141592 ) ] ) );
    Add ( Format ( 'Java string format "Hello %%s (%%,d) !!!", "Korean (한글)", 3141592 => %s', [ wu_r .Eval ('$jf_sf') .call ( 'Hello %s (%,d) !!!', 'Korean (한글)', 3141592 ) ] ) );
  end;
end;

end.
