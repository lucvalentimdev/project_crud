program ProjectCrud;

uses
  Vcl.Forms,
  U_FMenu in 'views\U_FMenu.pas' {F_Menu},
  DM_Principal in 'dataModules\DM_Principal.pas' {DataModule1: TDataModule},
  U_FPessoas in 'views\U_FPessoas.pas' {F_Pessoas},
  U_Pessoa in 'models\U_Pessoa.pas',
  U_Endereco in 'models\U_Endereco.pas',
  U_CadastroController in 'controllers\U_CadastroController.pas',
  U_FPessoaBuscar in 'views\U_FPessoaBuscar.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Menu, F_Menu);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
