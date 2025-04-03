object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 32
    Top = 96
  end
  object Con_1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 32
    Top = 40
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 40
    Top = 168
  end
  object FQry_Op: TFDQuery
    Connection = Con_1
    Left = 256
    Top = 88
  end
  object FQry_Pessoas: TFDQuery
    Connection = Con_1
    Left = 352
    Top = 88
  end
  object FQry_TipoPessoa: TFDQuery
    Connection = Con_1
    Left = 448
    Top = 88
  end
end
