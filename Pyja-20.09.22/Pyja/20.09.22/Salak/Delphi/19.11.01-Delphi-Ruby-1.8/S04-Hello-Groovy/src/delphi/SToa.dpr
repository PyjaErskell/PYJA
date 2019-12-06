program SToa;

uses
  Vcl.Forms,
  WMain in 'WMain.pas' {wu_main},
  Global in 'Global.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Twu_main, wu_main);
  Application.Run;
end.
