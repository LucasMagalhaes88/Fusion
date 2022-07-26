unit UDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL;

type
  TDMProjeto = class(TDataModule)
    FDConnection: TFDConnection;
    FDQuery: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  private
    { Private declarations }
  public
    function ConectarBanco: String;
    function FecharBanco: String;
    function QuerySQL(vSQL: string): String;
    function ExecutaSQL(vSQL: string): String;
  end;

var
  DMProjeto: TDMProjeto;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TDMProjeto.ConectarBanco: String;
var caminho: string;
begin
  caminho := System.SysUtils.GetCurrentDir + '\Database\BANCO.DB';
  if FDConnection.Connected = False then
  begin
    try
      FDConnection.Params.Database := caminho;
      FDConnection.Connected := True;
      Result := '';
    except
    on E: Exception do
      Result := 'Erro: '+ e.Message;
    end;
  end;
end;

function TDMProjeto.ExecutaSQL(vSQL: string): String;
begin
  try
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Add(vSQL);
    FDQuery.Prepare;
    FDQuery.Execute;
    Result := '';
  except
    on E: Exception do
      Result := 'Erro: '+ e.Message;
  end;
end;

function TDMProjeto.FecharBanco: String;
begin
  if FDConnection.Connected = True then
  begin
    try
      FDConnection.Connected := false;
      Result := '';
    except
    on E: Exception do
      Result := 'Erro: '+ e.Message;
    end;
  end;
end;

function TDMProjeto.QuerySQL(vSQL: string): String;
var i: integer;
begin
  try
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Add(vSQL);
    FDQuery.Open;
    Result := '';
  except
    on E: Exception do
      Result := 'Erro: '+ e.Message;
  end;
end;

end.
