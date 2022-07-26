unit View.Projeto.Historico;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid,
  FMX.Layouts, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, FMX.StdCtrls;

type
  TfrmViewHistorico = class(TForm)
    lytBotoes: TLayout;
    lytPrincipal: TLayout;
    grdHistorico: TGrid;
    BindingsList1: TBindingsList;
    LinkGridToDataSource1: TLinkGridToDataSource;
    btnSair: TButton;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewHistorico: TfrmViewHistorico;

implementation

{$R *.fmx}

uses Controller.Projeto.Download;

procedure TfrmViewHistorico.btnSairClick(Sender: TObject);
begin
  frmViewHistorico.Close;
end;

procedure TfrmViewHistorico.FormShow(Sender: TObject);
begin
  ControllerDownload.ExibirHistorico;
  {if vMSG<>'' then
    Alerta(vMSG)
  else
    Alerta('Sem Histórico');}
end;

end.
