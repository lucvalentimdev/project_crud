unit DM_Principal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TData_Module = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Con_1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FQry_Op: TFDQuery;
    FQry_Pessoas: TFDQuery;
    FQry_TipoPessoa: TFDQuery;
    FQry_TipoPessoaid: TFDAutoIncField;
    FQry_TipoPessoatipo_descricao: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Data_Module: TData_Module;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TData_Module.DataModuleCreate(Sender: TObject);    // Aqui incio criando os parametros de conex�o //
begin
   try
      Con_1.Params.Clear;
      Con_1.DriverName := 'SQLite';
      Con_1.Params.Add('Database=C:\project_crud\_database\db_projCrud');
      Con_1.Connected := True;
   except
      raise Exception.Create('Ocorreu um erro ao conectar-se a base de dados');
   end;

end;

end.
