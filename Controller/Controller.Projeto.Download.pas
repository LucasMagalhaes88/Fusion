unit Controller.Projeto.Download;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  FMX.Types,
  FMX.Dialogs,
  Data.Bind.GenData,
  Fmx.Bind.GenData,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  Model.Projeto.Historico;

type
  TControllerDownload = class(TDataModule)
    pbsHistorico: TPrototypeBindSource;
    procedure pbsHistoricoCreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
  private
    FLista: TObjectList<THistorico>;
  public
    function ExibirHistorico: string;
    function Salvar(arquivo: string): string;
    procedure Atualizar;
  end;

var
  ControllerDownload: TControllerDownload;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses View.Projeto.Download, UDataModule;

{$R *.dfm}

{ TContollerDownload }

procedure TControllerDownload.Atualizar;
begin
  pbsHistorico.Active := False;
  pbsHistorico.Active := True;
  pbsHistorico.Refresh;
end;

function TControllerDownload.ExibirHistorico: string;
var vSQL, vMSG: string;
    item: THistorico;
begin
  vMSG := '';
  DMProjeto.ConectarBanco;
  vSQL := ' SELECT CODIGO, URL, DATAINICIO, DATAFIM FROM LOGDOWNLOAD ';
  DMProjeto.querySQL(vSQL);
  FLista.Clear;
  while not DMProjeto.FDQuery.Eof do
  begin
    //vMSG := vMSG + ' ' + DMProjeto.FDQuery['URL'];
    item := THistorico.Create;
    item.Codigo := DMProjeto.FDQuery['Codigo'];
    item.URL := DMProjeto.FDQuery['URL'];
    item.DataInicio := DMProjeto.FDQuery['DataInicio'];
    item.DataFim := DMProjeto.FDQuery['DataFim'];
    FLista.Add(item);
    DMProjeto.FDQuery.Next;
  end;
  DMProjeto.FecharBanco;
  Atualizar;
  Result := vMSG;
end;

procedure TControllerDownload.pbsHistoricoCreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  if not Assigned(FLista) then
  begin
    FLista := TObjectList<THistorico>.Create;
  end;

  ABindSourceAdapter := TListBindSourceAdapter<THistorico>.Create(nil,FLista,False);
  ABindSourceAdapter.Active := True;
  ABindSourceAdapter.AutoEdit := True;
end;

function TControllerDownload.Salvar(arquivo: string): string;
var vSQL: string;
begin
  vSQL := ' INSERT INTO logdownload (url, datainicio, datafim) VALUES('''+arquivo+''', '''+FormatDateTime('dd/MM/yyyy',Date)+''', '''+FormatDateTime('dd/MM/yyyy',Date)+'''); ';
  DMProjeto.ConectarBanco;
  DMProjeto.ExecutaSQL(vSQL);
  DMProjeto.FecharBanco;
end;

end.
