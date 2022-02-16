unit uTipo;

interface

uses
  Generics.Collections;

type

  TVertice = record
    FSigla: string;
    FEstado: string;
  end;

  TAresta = record
    FVertice1: TVertice;
    FVertice2: TVertice;
    FValor: Integer;
  end;

  TCaminho = record
    Vertices: array of string;
    Valor: integer;
  end;

implementation

end.
