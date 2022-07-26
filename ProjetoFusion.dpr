program ProjetoFusion;

uses
  System.StartUpCopy,
  FMX.Forms,
  UMain in 'UMain.pas' {frmMain},
  UDataModule in 'UDataModule.pas' {DMProjeto: TDataModule},
  View.Projeto.Download in 'View\View.Projeto.Download.pas' {frmViewDownload},
  Controller.Projeto.Download in 'Controller\Controller.Projeto.Download.pas' {ControllerDownload: TDataModule},
  View.Projeto.Historico in 'View\View.Projeto.Historico.pas' {frmViewHistorico},
  Model.Projeto.Historico in 'Model\Model.Projeto.Historico.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDMProjeto, DMProjeto);
  Application.CreateForm(TfrmViewDownload, frmViewDownload);
  Application.CreateForm(TControllerDownload, ControllerDownload);
  Application.CreateForm(TfrmViewHistorico, frmViewHistorico);
  Application.Run;
end.
