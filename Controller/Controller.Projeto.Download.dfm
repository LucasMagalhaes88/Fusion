object ControllerDownload: TControllerDownload
  OldCreateOrder = False
  Height = 225
  Width = 326
  object pbsHistorico: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Codigo'
        FieldType = ftInteger
        Generator = 'Integers'
        ReadOnly = False
      end
      item
        Name = 'Url'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'DataInicio'
        Generator = 'Date'
        ReadOnly = False
      end
      item
        Name = 'DataFim'
        Generator = 'Date'
        ReadOnly = False
      end>
    ScopeMappings = <>
    OnCreateAdapter = pbsHistoricoCreateAdapter
    Left = 32
    Top = 40
  end
end
