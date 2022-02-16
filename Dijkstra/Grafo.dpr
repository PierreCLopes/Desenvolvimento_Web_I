program Grafo;

uses
  Forms,
  uForm in 'uForm.pas' {Formulario},
  uTipo in 'uTipo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormulario, Formulario);
  Application.Run;
end.
