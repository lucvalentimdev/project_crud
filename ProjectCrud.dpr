program ProjectCrud;

uses
  Vcl.Forms,
  U_FMenu in 'views\U_FMenu.pas' {F_Menu},
  DM_Principal in 'dataModules\DM_Principal.pas' {Data_Module: TDataModule},
  U_FPessoaCadastrar in 'views\U_FPessoaCadastrar.pas' {F_PessoaCadastrar},
  U_Pessoa in 'models\U_Pessoa.pas',
  U_Endereco in 'models\U_Endereco.pas',
  U_GeralController in 'controllers\U_GeralController.pas',
  U_FPessoaBuscar in 'views\U_FPessoaBuscar.pas' {F_PessoaBuscar};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Menu, F_Menu);
  Application.CreateForm(TData_Module, Data_Module);
  Application.CreateForm(TF_PessoaBuscar, F_PessoaBuscar);
  Application.Run;
end.
