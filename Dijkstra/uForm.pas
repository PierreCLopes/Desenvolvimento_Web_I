unit uForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uTipo, Generics.Collections, dblookup;

type
  TFormulario = class(TForm)
    FCalcular: TButton;
    EstadoInicio: TComboBox;
    EstadoFim: TComboBox;
    LabelEstadoFim: TLabel;
    LabelEstadoInicio: TLabel;
    MemoMelhorCaminho: TMemo;
    LabelMelhorCaminho: TLabel;
    MemoMelhorCaminhoMinutos: TMemo;
    LabelMelhorCaminhoMinutos: TLabel;

    procedure EstadoInicioCriar;
    procedure FormularioCriar(Sender: TObject);
    procedure FCalcularClick(Sender: TObject);
    procedure BuscarAresta(var prAresta: TDictionary<integer,TAresta>; prVertice: TVertice);
    procedure VerificaCaminhoDireto(prInicio, prFim: TVertice);
    procedure ConverteMelhorCaminho(prValor: integer; prString: string);
    function VerticeVisitada(var prVerticeVisitada: TDictionary<string,TVertice>; prVertice: TVertice): boolean;
    function ArestaVisitada(prArestaVisitada: TDictionary<integer,TAresta>; prKey: integer): boolean;
    procedure EncontrarMelhorCaminho(prValor:integer;prCaminho:string;prVertice, prFim: TVertice);
  private
    { Private declarations }
  public
    FVertice: TDictionary<string,TVertice>;
    FAresta: TDictionary<integer,TAresta>;
    FMelhorCaminho: string;
    FMelhorCaminhoValor: integer;
  end;

var
  Formulario: TFormulario;


implementation

{$R *.dfm}

{ TFormulario }

procedure TFormulario.FCalcularClick(Sender: TObject);
var
  vInicio: TVertice;
  vFim: TVertice;
  Aguarde: TForm;
  Mensagem: TLabel;
begin
  Aguarde:=  TForm.Create(Application);
  Aguarde.BorderStyle := bsNone;
  Aguarde.Position:= poDesktopCenter;
  Aguarde.Width:= 200;
  Aguarde.Height:= 40; //at� aqui criamos o form
  Aguarde.Color := clSilver;

  Mensagem :=  TLabel.Create(Application);
  Mensagem.Parent := Aguarde;
  Mensagem.Transparent := true;
  Mensagem.AutoSize := false;
  Mensagem.Width := 200;
  Mensagem.Height := 40;
  Mensagem.Caption :='Aguarde...';
  Mensagem.Font.Size := 20;
  Mensagem.Alignment := taCenter;//label com a mensagem "Aguarde"

  Aguarde.Show;
  Aguarde.Update;//Atualiza o form

  FMelhorCaminho := '';
  FMelhorCaminhoValor := 2000;
  if (not FVertice.ContainsKey(EstadoInicio.Text)) or (not FVertice.ContainsKey(EstadoFim.Text)) then
  begin
    raise Exception.Create('Estado inv�lido! ' + sLineBreak + 'Selecione uma das op��es dispon�veis!');
  end
  else
  begin
    vInicio := FVertice.Items[EstadoInicio.Text];
    vFim := FVertice.Items[EstadoFim.Text];

    if vFim.FSigla = vInicio.FSigla then
    begin
      FMelhorCaminho := vInicio.FEstado + ' > ' + vFim.FEstado;
      FMelhorCaminhoValor := 0;
    end;

    VerificaCaminhoDireto(vInicio,vFim);

    if FMelhorCaminho <> '' then
    begin
      MemoMelhorCaminho.Text := FMelhorCaminho;
      MemoMelhorCaminhoMinutos.Text := IntToStr(FMelhorCaminhoValor);
    end
    else
    begin
      EncontrarMelhorCaminho(0,vInicio.FEstado,vInicio, vFim);
    end;
  end;
  Aguarde.Free;//Fecha o aguarde
end;

procedure TFormulario.FormularioCriar(Sender: TObject);
var
  vVertice: TVertice;
  vAresta: TAresta;
begin
  EstadoInicioCriar;

  FVertice := TDictionary<string,TVertice>.Create;
  FAresta := TDictionary<integer,TAresta>.Create;

  vVertice.FSigla := 'RS';
  vVertice.FEstado := 'Rio Grande do Sul';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'SC';
  vVertice.FEstado := 'Santa Catarina';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'PR';
  vVertice.FEstado := 'Paran�';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'SP';
  vVertice.FEstado := 'S�o Paulo';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'MS';
  vVertice.FEstado := 'Mato Grosso do Sul';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'RJ';
  vVertice.FEstado := 'Rio de Janeiro';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'MG';
  vVertice.FEstado := 'Minas Gerais';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'ES';
  vVertice.FEstado := 'Espirito Santo';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'GO';
  vVertice.FEstado := 'Goias';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'DF';
  vVertice.FEstado := 'Distrito Federal';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'MT';
  vVertice.FEstado := 'Mato Grosso';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'BA';
  vVertice.FEstado := 'Bahia';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'TO';
  vVertice.FEstado := 'Tocantis';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'RO';
  vVertice.FEstado := 'Rondonia';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'AC';
  vVertice.FEstado := 'Acre';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'AM';
  vVertice.FEstado := 'Amazonas';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'RR';
  vVertice.FEstado := 'Roraima';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'AP';
  vVertice.FEstado := 'Amap�';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'MA';
  vVertice.FEstado := 'Maranh�o';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'PI';
  vVertice.FEstado := 'Piau�';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'SE';
  vVertice.FEstado := 'Sergipe';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'AL';
  vVertice.FEstado := 'Alagoas';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'PE';
  vVertice.FEstado := 'Pernambuco';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'PB';
  vVertice.FEstado := 'Para�ba';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'RN';
  vVertice.FEstado := 'Rio Grande do Norte';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'CE';
  vVertice.FEstado := 'Cear�';
  FVertice.Add(vVertice.FSigla,vVertice);

  vVertice.FSigla := 'PA';
  vVertice.FEstado := 'Par�';
  FVertice.Add(vVertice.FSigla,vVertice);

    vAresta.FVertice1 := FVertice.Items['RS'];
  vAresta.FVertice2 := FVertice.Items['RO'];
  vAresta.FValor := 380;
  FAresta.Add(1,vAresta);

  vAresta.FVertice1 := FVertice.Items['RS'];
  vAresta.FVertice2 := FVertice.Items['PR'];
  vAresta.FValor := 60;
  FAresta.Add(2,vAresta);

  vAresta.FVertice1 := FVertice.Items['RS'];
  vAresta.FVertice2 := FVertice.Items['SP'];
  vAresta.FValor := 95;
  FAresta.Add(3,vAresta);

  vAresta.FVertice1 := FVertice.Items['SC'];
  vAresta.FVertice2 := FVertice.Items['PR'];
  vAresta.FValor := 40;
  FAresta.Add(4,vAresta);

  vAresta.FVertice1 := FVertice.Items['SC'];
  vAresta.FVertice2 := FVertice.Items['SP'];
  vAresta.FValor := 60;
  FAresta.Add(5,vAresta);

  vAresta.FVertice1 := FVertice.Items['SC'];
  vAresta.FVertice2 := FVertice.Items['RJ'];
  vAresta.FValor := 80;
  FAresta.Add(6,vAresta);

  vAresta.FVertice1 := FVertice.Items['PR'];
  vAresta.FVertice2 := FVertice.Items['SP'];
  vAresta.FValor := 55;
  FAresta.Add(7,vAresta);

  vAresta.FVertice1 := FVertice.Items['PR'];
  vAresta.FVertice2 := FVertice.Items['MS'];
  vAresta.FValor := 90;
  FAresta.Add(8,vAresta);

  vAresta.FVertice1 := FVertice.Items['SP'];
  vAresta.FVertice2 := FVertice.Items['MS'];
  vAresta.FValor := 95;
  FAresta.Add(9,vAresta);

  vAresta.FVertice1 := FVertice.Items['SP'];
  vAresta.FVertice2 := FVertice.Items['GO'];
  vAresta.FValor := 95;
  FAresta.Add(10,vAresta);

  vAresta.FVertice1 := FVertice.Items['SP'];
  vAresta.FVertice2 := FVertice.Items['DF'];
  vAresta.FValor := 95;
  FAresta.Add(11,vAresta);

  vAresta.FVertice1 := FVertice.Items['SP'];
  vAresta.FVertice2 := FVertice.Items['MG'];
  vAresta.FValor := 75;
  FAresta.Add(12,vAresta);

  vAresta.FVertice1 := FVertice.Items['SP'];
  vAresta.FVertice2 := FVertice.Items['RJ'];
  vAresta.FValor := 80;
  FAresta.Add(13,vAresta);

  vAresta.FVertice1 := FVertice.Items['MG'];
  vAresta.FVertice2 := FVertice.Items['GO'];
  vAresta.FValor := 80;
  FAresta.Add(14,vAresta);

  vAresta.FVertice1 := FVertice.Items['MG'];
  vAresta.FVertice2 := FVertice.Items['DF'];
  vAresta.FValor := 70;
  FAresta.Add(15,vAresta);

  vAresta.FVertice1 := FVertice.Items['GO'];
  vAresta.FVertice2 := FVertice.Items['DF'];
  vAresta.FValor := 30;
  FAresta.Add(16,vAresta);

  vAresta.FVertice1 := FVertice.Items['GO'];
  vAresta.FVertice2 := FVertice.Items['TO'];
  vAresta.FValor := 95;
  FAresta.Add(17,vAresta);

  vAresta.FVertice1 := FVertice.Items['DF'];
  vAresta.FVertice2 := FVertice.Items['TO'];
  vAresta.FValor := 90;
  FAresta.Add(18,vAresta);

  vAresta.FVertice1 := FVertice.Items['RJ'];
  vAresta.FVertice2 := FVertice.Items['TO'];
  vAresta.FValor := 190;
  FAresta.Add(19,vAresta);

  vAresta.FVertice1 := FVertice.Items['MG'];
  vAresta.FVertice2 := FVertice.Items['ES'];
  vAresta.FValor := 90;
  FAresta.Add(20,vAresta);

  vAresta.FVertice1 := FVertice.Items['RJ'];
  vAresta.FVertice2 := FVertice.Items['AL'];
  vAresta.FValor := 190;
  FAresta.Add(21,vAresta);

  vAresta.FVertice1 := FVertice.Items['ES'];
  vAresta.FVertice2 := FVertice.Items['PI'];
  vAresta.FValor := 180;
  FAresta.Add(22,vAresta);

  vAresta.FVertice1 := FVertice.Items['ES'];
  vAresta.FVertice2 := FVertice.Items['BA'];
  vAresta.FValor := 95;
  FAresta.Add(23,vAresta);

  vAresta.FVertice1 := FVertice.Items['ES'];
  vAresta.FVertice2 := FVertice.Items['SE'];
  vAresta.FValor := 105;
  FAresta.Add(24,vAresta);

  vAresta.FVertice1 := FVertice.Items['BA'];
  vAresta.FVertice2 := FVertice.Items['SE'];
  vAresta.FValor := 40;
  FAresta.Add(25,vAresta);

  vAresta.FVertice1 := FVertice.Items['SE'];
  vAresta.FVertice2 := FVertice.Items['AL'];
  vAresta.FValor := 35;
  FAresta.Add(26,vAresta);

  vAresta.FVertice1 := FVertice.Items['SE'];
  vAresta.FVertice2 := FVertice.Items['PB'];
  vAresta.FValor := 75;
  FAresta.Add(27,vAresta);

  vAresta.FVertice1 := FVertice.Items['AL'];
  vAresta.FVertice2 := FVertice.Items['PB'];
  vAresta.FValor := 40;
  FAresta.Add(28,vAresta);

  vAresta.FVertice1 := FVertice.Items['AL'];
  vAresta.FVertice2 := FVertice.Items['PE'];
  vAresta.FValor := 40;
  FAresta.Add(29,vAresta);

  vAresta.FVertice1 := FVertice.Items['BA'];
  vAresta.FVertice2 := FVertice.Items['PE'];
  vAresta.FValor := 65;
  FAresta.Add(30,vAresta);

  vAresta.FVertice1 := FVertice.Items['BA'];
  vAresta.FVertice2 := FVertice.Items['PI'];
  vAresta.FValor := 75;
  FAresta.Add(31,vAresta);

  vAresta.FVertice1 := FVertice.Items['PI'];
  vAresta.FVertice2 := FVertice.Items['PE'];
  vAresta.FValor := 60;
  FAresta.Add(32,vAresta);

  vAresta.FVertice1 := FVertice.Items['PI'];
  vAresta.FVertice2 := FVertice.Items['RN'];
  vAresta.FValor := 80;
  FAresta.Add(33,vAresta);

  vAresta.FVertice1 := FVertice.Items['PE'];
  vAresta.FVertice2 := FVertice.Items['RN'];
  vAresta.FValor := 65;
  FAresta.Add(34,vAresta);

  vAresta.FVertice1 := FVertice.Items['PE'];
  vAresta.FVertice2 := FVertice.Items['PB'];
  vAresta.FValor := 40;
  FAresta.Add(35,vAresta);

  vAresta.FVertice1 := FVertice.Items['PB'];
  vAresta.FVertice2 := FVertice.Items['RN'];
  vAresta.FValor := 35;
  FAresta.Add(36,vAresta);

  vAresta.FVertice1 := FVertice.Items['RN'];
  vAresta.FVertice2 := FVertice.Items['CE'];
  vAresta.FValor := 75;
  FAresta.Add(37,vAresta);

  vAresta.FVertice1 := FVertice.Items['PI'];
  vAresta.FVertice2 := FVertice.Items['CE'];
  vAresta.FValor := 75;
  FAresta.Add(38,vAresta);

  vAresta.FVertice1 := FVertice.Items['MA'];
  vAresta.FVertice2 := FVertice.Items['CE'];
  vAresta.FValor := 75;
  FAresta.Add(39,vAresta);

  vAresta.FVertice1 := FVertice.Items['AP'];
  vAresta.FVertice2 := FVertice.Items['CE'];
  vAresta.FValor := 255;
  FAresta.Add(40,vAresta);

  vAresta.FVertice1 := FVertice.Items['MA'];
  vAresta.FVertice2 := FVertice.Items['PI'];
  vAresta.FValor := 70;
  FAresta.Add(41,vAresta);

  vAresta.FVertice1 := FVertice.Items['AP'];
  vAresta.FVertice2 := FVertice.Items['MA'];
  vAresta.FValor := 210;
  FAresta.Add(42,vAresta);

  vAresta.FVertice1:= FVertice.Items['MA'];
  vAresta.FVertice2 := FVertice.Items['PA'];
  vAresta.FValor := 100;
  FAresta.Add(43,vAresta);

  vAresta.FVertice1 := FVertice.Items['PI'];
  vAresta.FVertice2 := FVertice.Items['PA'];
  vAresta.FValor := 210;
  FAresta.Add(44,vAresta);

  vAresta.FVertice1 := FVertice.Items['TO'];
  vAresta.FVertice2 := FVertice.Items['PI'];
  vAresta.FValor := 90;
  FAresta.Add(45,vAresta);

  vAresta.FVertice1 := FVertice.Items['BA'];
  vAresta.FVertice2 := FVertice.Items['TO'];
  vAresta.FValor := 200;
  FAresta.Add(46,vAresta);

  vAresta.FVertice1 := FVertice.Items['MT'];
  vAresta.FVertice2 := FVertice.Items['TO'];
  vAresta.FValor := 85;
  FAresta.Add(47,vAresta);

  vAresta.FVertice1 := FVertice.Items['TO'];
  vAresta.FVertice2 := FVertice.Items['RO'];
  vAresta.FValor := 320;
  FAresta.Add(48,vAresta);

  vAresta.FVertice1 := FVertice.Items['MT'];
  vAresta.FVertice2 := FVertice.Items['PA'];
  vAresta.FValor := 100;
  FAresta.Add(49,vAresta);

  vAresta.FVertice1 := FVertice.Items['MS'];
  vAresta.FVertice2 := FVertice.Items['MT'];
  vAresta.FValor := 100;
  FAresta.Add(50,vAresta);

  vAresta.FVertice1 := FVertice.Items['MS'];
  vAresta.FVertice2 := FVertice.Items['TO'];
  vAresta.FValor := 260;
  FAresta.Add(51,vAresta);

  vAresta.FVertice1 := FVertice.Items['MT'];
  vAresta.FVertice2 := FVertice.Items['RO'];
  vAresta.FValor := 95;
  FAresta.Add(52,vAresta);

  vAresta.FVertice1 := FVertice.Items['RO'];
  vAresta.FVertice2 := FVertice.Items['PA'];
  vAresta.FValor := 250;
  FAresta.Add(53,vAresta);

  vAresta.FVertice1 := FVertice.Items['RO'];
  vAresta.FVertice2 := FVertice.Items['AC'];
  vAresta.FValor := 95;
  FAresta.Add(54,vAresta);

  vAresta.FVertice1 := FVertice.Items['AC'];
  vAresta.FVertice2 := FVertice.Items['PA'];
  vAresta.FValor := 280;
  FAresta.Add(55,vAresta);

  vAresta.FVertice1 := FVertice.Items['AM'];
  vAresta.FVertice2 := FVertice.Items['PA'];
  vAresta.FValor := 200;
  FAresta.Add(56,vAresta);

  vAresta.FVertice1 := FVertice.Items['RR'];
  vAresta.FVertice2 := FVertice.Items['PA'];
  vAresta.FValor := 230;
  FAresta.Add(57,vAresta);

  vAresta.FVertice1 := FVertice.Items['AP'];
  vAresta.FVertice2 := FVertice.Items['PA'];
  vAresta.FValor := 210;
  FAresta.Add(58,vAresta);

  vAresta.FVertice1 := FVertice.Items['AM'];
  vAresta.FVertice2 := FVertice.Items['AP'];
  vAresta.FValor := 230;
  FAresta.Add(59,vAresta);

  vAresta.FVertice1 := FVertice.Items['RR'];
  vAresta.FVertice2 := FVertice.Items['AP'];
  vAresta.FValor := 190;
  FAresta.Add(60,vAresta);

  vAresta.FVertice1 := FVertice.Items['AM'];
  vAresta.FVertice2 := FVertice.Items['RR'];
  vAresta.FValor := 90;
  FAresta.Add(61,vAresta);

  vAresta.FVertice1 := FVertice.Items['AC'];
  vAresta.FVertice2 := FVertice.Items['AM'];
  vAresta.FValor := 250;
  FAresta.Add(62,vAresta);

  vAresta.FVertice1 := FVertice.Items['AC'];
  vAresta.FVertice2 := FVertice.Items['RR'];
  vAresta.FValor := 270;
  FAresta.Add(63,vAresta);

  vAresta.FVertice1 := FVertice.Items['TO'];
  vAresta.FVertice2 := FVertice.Items['PA'];
  vAresta.FValor := 75;
  FAresta.Add(64,vAresta);

  vAresta.FVertice1 := FVertice.Items['RS'];
  vAresta.FVertice2 := FVertice.Items['SC'];
  vAresta.FValor := 60;
  FAresta.Add(65,vAresta);
end;

procedure TFormulario.ConverteMelhorCaminho(prValor: integer; prString: string);
begin
  MemoMelhorCaminho.Text := '';
  FMelhorCaminhoValor :=  prValor;
  FMelhorCaminho := prString;
  MemoMelhorCaminho.Text := FMelhorCaminho;
  MemoMelhorCaminhoMinutos.Text := IntToStr(FMelhorCaminhoValor);
end;

procedure TFormulario.VerificaCaminhoDireto(prInicio, prFim: TVertice);
var
  vKey: integer;
begin
  for vKey in FAresta.Keys do
  begin
    if ((FAresta.Items[vKey].FVertice1.FSigla = prInicio.FSigla) and
       (FAresta.Items[vKey].FVertice2.FSigla = prFim.FSigla)) then
    begin
      FMelhorCaminho := FAresta.Items[vKey].FVertice1.FEstado + ' > ' + FAresta.Items[vKey].FVertice2.FEstado;
      FMelhorCaminhoValor := FAresta.Items[vKey].FValor;
    end
    else
    if((FAresta.Items[vKey].FVertice1.FSigla = prFim.FSigla) and
       (FAresta.Items[vKey].FVertice2.FSigla = prInicio.FSigla)) then
    begin
      FMelhorCaminho := FAresta.Items[vKey].FVertice2.FEstado + ' > ' + FAresta.Items[vKey].FVertice1.FEstado;
      FMelhorCaminhoValor := FAresta.Items[vKey].FValor;
    end;
  end;
end;

function TFormulario.VerticeVisitada(var prVerticeVisitada: TDictionary<string, TVertice>; prVertice: TVertice): boolean;
begin
  Result := prVerticeVisitada.ContainsKey(prVertice.FSigla);
end;

function TFormulario.ArestaVisitada(prArestaVisitada: TDictionary<integer, TAresta>; prKey: integer): boolean;
begin
  Result := prArestaVisitada.ContainsKey(prKey);
end;

procedure TFormulario.BuscarAresta(var prAresta: TDictionary<integer,TAresta>; prVertice: TVertice);
var
  vKey: integer;
begin
  for vKey in FAresta.Keys do
  begin
    if (FAresta.Items[vKey].FVertice1.FSigla = prVertice.FSigla) or
       (FAresta.Items[vKey].FVertice2.FSigla = prVertice.FSigla) then
    begin
      prAresta.AddOrSetValue(vKey,FAresta.Items[vKey]);
    end;
  end;
end;

procedure TFormulario.EncontrarMelhorCaminho(prValor: integer; prCaminho: string; prVertice, prFim: TVertice);
var
  vArestaAux: TAresta;
  vAresta, vArestaVisitada: TDictionary<integer,TAresta>;
  vVerticeFinal: TVertice;
  vValor: integer;
  vCaminho: string;
  vKey: integer;
begin
  vValor := prValor;
  vCaminho := prCaminho;

  vAresta := TDictionary<integer,TAresta>.Create;
  vArestaVisitada := TDictionary<integer,TAresta>.Create;

  BuscarAresta(vAresta,prVertice);

  for vKey in vAresta.Keys do
  begin
    if not(vArestaVisitada.ContainsKey(vKey)) then
    begin
       vArestaAux := vAresta.Items[vKey];
       vArestaVisitada.Add(vKey,vArestaAux);

       if vArestaAux.FVertice1.FSigla = prVertice.FSigla then
         vVerticeFinal := vArestaAux.FVertice2
       else
         vVerticeFinal := vArestaAux.FVertice1;

       if (vValor + vArestaAux.FValor)<= FMelhorCaminhoValor then
       begin
           if vVerticeFinal.FSigla = prFim.FSigla then
           begin
             vValor := prValor + vArestaAux.FValor;
             vCaminho := prCaminho + ' > '+ vVerticeFinal.FEstado;
             ConverteMelhorCaminho(vValor,vCaminho);
           end
           else
           begin
             vValor := vValor + vArestaAux.FValor;
             vCaminho := vCaminho + ' > '+ vVerticeFinal.FEstado;
             EncontrarMelhorCaminho(vValor,vCaminho,vVerticeFinal,prFim);
             vValor := prValor;
             vCaminho := prCaminho;
           end;
       end;
      end;
    end;
  vAresta.Free;
  vArestaVisitada.Free;
end;


procedure TFormulario.EstadoInicioCriar;
begin

  EstadoInicio.Items.Add('RS');
  EstadoInicio.Items.Add('SC');
  EstadoInicio.Items.Add('PR');
  EstadoInicio.Items.Add('SP');
  EstadoInicio.Items.Add('MS');
  EstadoInicio.Items.Add('RJ');
  EstadoInicio.Items.Add('MG');
  EstadoInicio.Items.Add('ES');
  EstadoInicio.Items.Add('GO');
  EstadoInicio.Items.Add('DF');
  EstadoInicio.Items.Add('MT');
  EstadoInicio.Items.Add('BA');
  EstadoInicio.Items.Add('TO');
  EstadoInicio.Items.Add('RO');
  EstadoInicio.Items.Add('AC');
  EstadoInicio.Items.Add('AM');
  EstadoInicio.Items.Add('RR');
  EstadoInicio.Items.Add('AP');
  EstadoInicio.Items.Add('MA');
  EstadoInicio.Items.Add('PI');
  EstadoInicio.Items.Add('SE');
  EstadoInicio.Items.Add('AL');
  EstadoInicio.Items.Add('PE');
  EstadoInicio.Items.Add('PB');
  EstadoInicio.Items.Add('RN');
  EstadoInicio.Items.Add('CE');
  EstadoInicio.Items.Add('PA');

  EstadoFim.Items.Add('RS');
  EstadoFim.Items.Add('SC');
  EstadoFim.Items.Add('PR');
  EstadoFim.Items.Add('SP');
  EstadoFim.Items.Add('MS');
  EstadoFim.Items.Add('RJ');
  EstadoFim.Items.Add('MG');
  EstadoFim.Items.Add('ES');
  EstadoFim.Items.Add('GO');
  EstadoFim.Items.Add('DF');
  EstadoFim.Items.Add('MT');
  EstadoFim.Items.Add('BA');
  EstadoFim.Items.Add('TO');
  EstadoFim.Items.Add('RO');
  EstadoFim.Items.Add('AC');
  EstadoFim.Items.Add('AM');
  EstadoFim.Items.Add('RR');
  EstadoFim.Items.Add('AP');
  EstadoFim.Items.Add('MA');
  EstadoFim.Items.Add('PI');
  EstadoFim.Items.Add('SE');
  EstadoFim.Items.Add('AL');
  EstadoFim.Items.Add('PE');
  EstadoFim.Items.Add('PB');
  EstadoFim.Items.Add('RN');
  EstadoFim.Items.Add('CE');
  EstadoFim.Items.Add('PA');

end;

end.

