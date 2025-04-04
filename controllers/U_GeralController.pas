unit U_GeralController;

interface
   uses
   U_Pessoa, U_Endereco;

type
  TGeralController = class

  private


  public
    constructor Create();


    procedure SalvarPessoa(const TipoPessoa: Integer; const Nome: string; const DataNascimento: TDate;
                           const CPF: string; const RG: string; const Email: string; const Telefone: string;
                           const Endereco: TEndereco);
    procedure ConsultarCEP(const ACep: string; var AEndereco: TEndereco);
    function ValidarCEP(const ACep: string): Boolean;

  end;

implementation

uses
  System.SysUtils;

constructor TGeralController.Create();
begin

end;

procedure TGeralController.SalvarPessoa(const TipoPessoa: Integer; const Nome: string; const DataNascimento: TDate;
          const CPF: string; const RG: string; const Email: string; const Telefone: string;const Endereco: TEndereco);
var
 FPessoa: TPessoa;
begin
   if not FPessoa.ValidarEmail(Email) then                  // Valida��o do e-mail //
      raise Exception.Create('E-mail inv�lido!');

   //if FPessoa.CPFouCNPJCadastrado(FPessoa.CPF) then         // Valida��o de Pessoa j� cadastrada (CPF ou CNPJ) //
   //   raise Exception.Create('CPF j� cadastrado!');

   try
      FPessoa := TPessoa.Create(TipoPessoa, Nome, DataNascimento, CPF, RG, Email, Telefone, Endereco);
      FPessoa.Salvar;                                     // Chamada do metodo salvar no modelo Pessoa //
   finally
      FPessoa.Free;
   end;
end;

function TGeralController.ValidarCEP(const ACep: string): Boolean;
var
  Endereco: TEndereco;
begin
  Endereco := TEndereco.Create;
  try
    Result := Endereco.ValidarCEP(ACep); // M�todo do TEndereco para validar o CEP //
  finally
    Endereco.Free;                        // Libera da memoria //
  end;

end;

procedure TGeralController.ConsultarCEP(const ACep: string; var AEndereco: TEndereco);
begin
  try
    AEndereco.ConsultarViaCEP(ACep);
  except on E: Exception do
      raise Exception.Create('Erro ao consultar o CEP: ' + E.Message);
  end;
end;

end.
