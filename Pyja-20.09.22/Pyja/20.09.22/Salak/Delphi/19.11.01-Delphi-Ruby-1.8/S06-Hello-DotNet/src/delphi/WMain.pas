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
    Add ( Format ( 'Python version => %s', [ gf_re ( '$CjString .valueOf $ju_t .getValue "GC_PYTHON_VR"' ) ] ) );
    Add ( Format ( 'PyQt version => %s', [ gf_re ( '$CjString .valueOf $ju_t .getValue "GC_PYQT_VR"' ) ] ) );
    Add ( Format ( '.NET version => %s', [ gf_re ( '$CjString .valueOf $ju_t .getValue "GC_DOTNET_VR"' ) ] ) );
    Add ( Format ( 'Groovy hello (English) => %s', [ gf_re ('$sf_g_hello') .call ( 'groovy-', 10 ) ] ) );
    Add ( Format ( 'Groovy hello (Koean) => %s', [ gf_re ('$sf_g_hello') .call ( '±×·çºñ-', 10 ) ] ) );
    Add ( Format ( 'Groovy sum of numbers => %s', [ gf_re ('$sf_g_sum') .call ( 700000000, 12, 49, 15, 51, 94, 21, 63 ) ] ) );
    Add ( Format ( 'Python hello (English) => %s', [ gf_re ('$sf_t_hello') .call ( 'python-', 10 ) ] ) );
    Add ( Format ( 'Python hello (Korea) => %s', [ gf_re ('$sf_t_hello') .call ( 'ÆÄÀÌ½ã-', 10 ) ] ) );
    Add ( Format ( 'Python sum of numbers => %s', [ gf_re ('$sf_t_sum') .call ( 700000000, 12, 49, 15, 51, 94, 21, 63 ) ] ) );
    Add ( Format ( 'System.String.Format (English) => %s', [ gf_re ('$sf_n_format') .call ( 'Hello {0} !!!', 'DotNet' ) ] ) );
    Add ( Format ( 'System.String.Format (Korea) => %s', [ gf_re ('$sf_n_format') .call ( 'Hello {0} !!!', '´å³Ý' ) ] ) );
  end;
end;

end.
