unit View.Projeto.Download;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.Controls.Presentation,
  VCL.Dialogs,
  System.Threading,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdBaseComponent,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL;

type
  TfrmViewDownload = class(TForm)
    lytPrincipal: TLayout;
    lytBotoes: TLayout;
    lblLinkArquivo: TLabel;
    edtLinkArquivo: TEdit;
    ProgressBar: TProgressBar;
    lblInformacao: TLabel;
    btnDownload: TButton;
    btnPararDownload: TButton;
    btnExibirMensagem: TButton;
    btnFechar: TButton;
    btnExibirHistorico: TButton;
    SaveDialog: TSaveDialog;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTP: TIdHTTP;
    procedure btnDownloadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPararDownloadClick(Sender: TObject);
    procedure btnExibirMensagemClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdHTTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure btnExibirHistoricoClick(Sender: TObject);
  private
    function RetornaPorcentagem(ValorMaximo, ValorAtual: real): string;
    function RetornaKiloBytes(ValorAtual: real): string;
    procedure FazerDownload(caminho: string);
  public
    procedure Alerta(mensagem: string);
  end;

var
  frmViewDownload: TfrmViewDownload;

implementation

{$R *.fmx}

uses Controller.Projeto.Download, View.Projeto.Historico;

function TfrmViewDownload.RetornaKiloBytes(ValorAtual: real): string;
var resultado : real;
begin
  resultado := ((ValorAtual / 1024) / 1024);
  Result    := FormatFloat('0.000 KBs', resultado);
end;

function TfrmViewDownload.RetornaPorcentagem(ValorMaximo,
  ValorAtual: real): string;
var resultado: Real;
begin
  resultado := ((ValorAtual * 100) / ValorMaximo);
  Result    := FormatFloat('0%', resultado);
end;

procedure TfrmViewDownload.FazerDownload(caminho: string);
var
 Arquivo: TFileStream;
begin
  try
    Arquivo := TFileStream.Create(caminho, fmCreate);
    IdHTTP.Get(edtLinkArquivo.Text, Arquivo);
  finally
      Arquivo.Free;
    end;
end;

procedure TfrmViewDownload.Alerta(mensagem: string);
begin
    MessageDlg(mensagem, TMsgDlgType.mtInformation,[mbOk],0);
end;

procedure TfrmViewDownload.btnDownloadClick(Sender: TObject);
var Arquivo: TFileStream;
    Task: ITask;
begin
  if edtLinkArquivo.Text='' then
  begin
    MessageDlg('Digite o Link para Download Anteriormente!', TMsgDlgType.mtError,[mbOk],0);
    Exit;
  end;


  lblInformacao.Text := '';
  SaveDialog.Filter := ExtractFileExt(edtLinkArquivo.Text) + '|*' + ExtractFileExt(edtLinkArquivo.Text);
  SaveDialog.FileName := 'Arquivo.exe';
  if SaveDialog.Execute then
  begin
    TThread.CreateAnonymousThread(
    procedure
    begin
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
        FazerDownload(SaveDialog.FileName + ExtractFileExt(edtLinkArquivo.Text));
        end);
    end).Start;
  end;

end;

procedure TfrmViewDownload.btnExibirHistoricoClick(Sender: TObject);
var vMSG: string;
begin
  if not Assigned(frmViewHistorico) then
  begin
    frmViewHistorico := frmViewHistorico.Create(Self);
  end;
  frmViewHistorico.ShowModal;
end;

procedure TfrmViewDownload.btnExibirMensagemClick(Sender: TObject);
begin
  if ProgressBar.Value = 0 then
    MessageDlg('Faça o Download Anteriormente!', TMsgDlgType.mtInformation,[mbOk],0)
  else
  if ProgressBar.Value = ProgressBar.Max then
    MessageDlg('Download Finalizado!', TMsgDlgType.mtInformation,[mbOk],0)
  else
    MessageDlg(lblInformacao.Text, TMsgDlgType.mtInformation,[mbOk],0)
end;

procedure TfrmViewDownload.btnFecharClick(Sender: TObject);
begin
  if (ProgressBar.Value>0) and (ProgressBar.Value < ProgressBar.Max) and (MessageDlg('Existe um download em andamento, deseja interrompe-lo?',mtConfirmation,[mbyes,mbno],0) = mrNo)then
    Exit;
  btnPararDownloadClick(nil);
  Application.Terminate;
end;

procedure TfrmViewDownload.btnPararDownloadClick(Sender: TObject);
begin
  idHttp.Disconnect; //para o download
  lblInformacao.Text := 'Download Cancelado!';
end;

procedure TfrmViewDownload.FormCreate(Sender: TObject);
begin
  edtLinkArquivo.Text := 'https://az764295.vo.msecnd.net/stable/78a4c91400152c0f27ba4d363eb56d2835f9903a/VSCodeUserSetup-x64-1.43.0.exe';
  lblInformacao.Text := '';
end;

procedure TfrmViewDownload.IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  ProgressBar.Value := AWorkCount;
  Application.ProcessMessages;
  lblInformacao.Text := 'Download em ... ' + RetornaPorcentagem(ProgressBar.Max, AWorkCount) + ' ' +RetornaKiloBytes(AWorkCount);
end;

procedure TfrmViewDownload.IdHTTPWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  ProgressBar.Value := 0;
  ProgressBar.Max := AWorkCountMax; //tamanho total do arquivo
end;

procedure TfrmViewDownload.IdHTTPWorkEnd(ASender: TObject;
  AWorkMode: TWorkMode);
begin
  if ProgressBar.Value = ProgressBar.Max then
  begin
    lblInformacao.Text := 'Download Concluído!';
    ControllerDownload.Salvar(edtLinkArquivo.Text);
  end
  else
    lblInformacao.Text := 'Download Cancelado!';
  ProgressBar.Value := ProgressBar.Max;
end;

end.
