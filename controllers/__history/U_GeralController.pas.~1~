unit U_CadastroController;

interface
{   uses
   U_Pessoa;
type
  TCadastroController = class
  private
    FPessoa: TPessoa; // Referência ao modelo de Pessoa
  public
    constructor Create(APessoa: TPessoa);

    // Métodos relacionados à Pessoa
    procedure SalvarPessoa(
      const TipoPessoa: TTipoPessoa; const Nome: string; const DataNascimento: TDate;
      const CPF: string; const RG: string; const Email: string; const Telefone: string;
      const Endereco: TEndereco
    );
    procedure ConsultarCEP(const ACep: string; var AEndereco: TEndereco);
  end;    }

implementation

uses
  System.SysUtils;

{constructor TCadastroController.Create(APessoa: TPessoa);
begin
  FPessoa := APessoa;
end;

procedure TCadastroController.SalvarPessoa(
  const TipoPessoa: TTipoPessoa; const Nome: string; const DataNascimento: TDate;
  const CPF: string; const RG: string; const Email: string; const Telefone: string;
  const Endereco: TEndereco);
begin
  // Atualiza os dados da pessoa no modelo
  FPessoa.TipoPessoa := TipoPessoa;
  FPessoa.Nome := Nome;
  FPessoa.DataNascimento := DataNascimento;
  FPessoa.CPF := CPF;
  FPessoa.RG := RG;
  FPessoa.Email := Email;
  FPessoa.Telefone := Telefone;
  FPessoa.Endereco := Endereco;

  // Chama o método Salvar do modelo
  FPessoa.Salvar;
end;

procedure TCadastroController.ConsultarCEP(const ACep: string; var AEndereco: TEndereco);
begin
  // Utiliza o método ConsultarViaCEP do Endereco para buscar os dados
  try
    AEndereco.ConsultarViaCEP(ACep);
  except
    on E: Exception do
      raise Exception.Create('Erro ao consultar o CEP: ' + E.Message);
  end;
end;}

end.
