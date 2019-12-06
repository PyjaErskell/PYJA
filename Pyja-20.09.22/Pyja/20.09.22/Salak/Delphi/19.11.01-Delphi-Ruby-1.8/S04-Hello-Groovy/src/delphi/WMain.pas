unit WMain;

interface

uses
  Global,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

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

implementation

{$R *.dfm}

procedure Twu_main.FormCreate(Sender: TObject);
begin
  with wu_lbx .Items do begin
    wu_main.Caption := Format ( '%s : %s', [ gf_re ('$GC_OLIM_NM'), gf_re ('$GC_TONO_NM') ] );
    Add ( Format ( 'RTL Version => %f', [RTLVersion] ) );
    Add ( Format ( 'Ruby version => %s', [ gf_re ('RUBY_VERSION') ] ) );
    Add ( Format ( 'Java version => %s', [ gf_re ('$CjSystem') .getProperty ('java.version') ] ) );
    Add ( Format ( 'Groovy version => %s', [ gf_re ( '$CjString .valueOf $jf_ge .call "GroovySystem.version"' ) ] ) );
    Add ( Format ( 'Groovy hello (English) => %s', [ gf_re ('$sf_hello') .call ( 'english-', 10 ) ] ) );
    Add ( Format ( 'Groovy hello (Koean) => %s', [ gf_re ('$sf_hello') .call ( 'ÇÑ±Û-', 10 ) ] ) );
    Add ( Format ( 'Groovy sum of numbers => %s', [ gf_re ('$sf_sum') .call ( 700000000, 12, 49, 15, 51, 94, 21, 63 ) ] ) );
  end;
end;

end.
