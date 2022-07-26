unit Model.Projeto.Historico;

interface

type
  THistorico = class
  private
    FCodigo: Integer;
    FURL: String;
    FDataInicio: String;
    FDataFim: String;
    procedure SetCodigo(const Value: Integer);
    procedure SetURL(const Value: String);
    procedure SetDataInicio(const Value: String);
    procedure SetDataFim(const Value: String);
  public
    property Codigo: Integer read FCodigo write SetCodigo;
    property URL: String read FURL write SetURL;
    property DataInicio: String read FDataInicio write SetDataInicio;
    property DataFim: String read FDataFim write SetDataFim;
  end;

implementation

{ THistorico }

procedure THistorico.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure THistorico.SetDataFim(const Value: String);
begin
  FDataFim := Value;
end;

procedure THistorico.SetDataInicio(const Value: String);
begin
  FDataInicio := Value;
end;

procedure THistorico.SetURL(const Value: String);
begin
  FURL := Value;
end;

end.
