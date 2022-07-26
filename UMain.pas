unit UMain;

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
  FMX.Menus, View.Projeto.Download;

type
  TfrmMain = class(TForm)
    MenuBar1: TMenuBar;
    MenuItem: TMenuItem;
    procedure MenuItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}


procedure TfrmMain.MenuItemClick(Sender: TObject);
begin
  if not Assigned(frmViewDownload) then
  begin
    frmViewDownload := frmViewDownload.Create(Self);
  end;
  frmViewDownload.ShowModal;
end;

end.
