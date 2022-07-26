object DMProjeto: TDMProjeto
  OldCreateOrder = False
  Height = 282
  Width = 347
  object FDConnection: TFDConnection
    Params.Strings = (
      'OpenMode=ReadWrite'
      'DriverID=SQLite'
      
        'Database=D:\Documentos\Embarcadero\Studio\Projects\Fusion\Win32\' +
        'Debug\Database\BANCO.DB')
    LoginPrompt = False
    Left = 88
    Top = 48
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT *'
      'FROM LOGDOWNLOAD')
    Left = 88
    Top = 112
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 136
    Top = 48
  end
end
