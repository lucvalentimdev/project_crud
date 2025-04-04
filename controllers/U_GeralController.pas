unit U_GeralController;

interface
   uses
   U_Pessoa, U_Endereco,  Datasnap.DBClient;

type
  TGeralController = class

  private


  public


    procedure SalvarPessoa(const TipoPessoa: Integer; const Nome: string; const DataNascimento: TDate;
                           const CPF: string;  const CNPJ : string; const RG: string; const Email: string;
                           const Telefone: string; const Endereco: TEndereco);
    procedure ConsultarCEP(const ACep: string; var AEndereco: TEndereco);
    procedure CarregarCDSPessoas(CDS_Pessoas : TClientDataSet);
    function ValidarCEP(const ACep: string): Boolean;


  end;

implementation

uses
  System.SysUtils;

procedure TGeralController.SalvarPessoa(const TipoPessoa: Integer; const Nome: string; const DataNascimento: TDate;
          const CPF: string; const CNPJ : string; const RG: string;  const Email: string; const Telefone: string;
          const Endereco: TEndereco);
var
 FPessoa: TPessoa;
begin

   try
      FPessoa := TPessoa.Create(TipoPessoa, Nome, DataNascimento, CPF, CNPJ, RG, Email, Telefone, Endereco);

      if not FPessoa.ValidarEmail(Email) then                  // Valida��o do e-mail //
         raise Exception.Create('E-mail inv�lido!');

      {if FPessoa.CPF = '' then
      begin
         if FPessoa.CPFouCNPJCadastrado(FPessoa.CNPJ) then         // Valida��o de Pessoa j� cadastrada (CPF ou CNPJ) //
            raise Exception.Create('CNPJ j� cadastrado!')            ** Erro de mem�ria identificado nesse trecho **
      end
      else if FPessoa.CPFouCNPJCadastrado(FPessoa.CPF) then
         raise Exception.Create('CPF j� cadastrado!');       }

      FPessoa.Salvar;                                     //<-- Chamada do metodo salvar no modelo Pessoa //
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

procedure TGeralController.CarregarCDSPessoas(CDS_Pessoas: TClientDataSet);
var
   ListaPessoas: TArray<TPessoa>;
   Pessoa: TPessoa;
begin
   // Configur��es do CDS //
   CDS_Pessoas.CreateDataSet;
   CDS_Pessoas.Open;
   CDS_Pessoas.DisableControls;

   try
      Pessoa := TPessoa.Create;
      ListaPessoas := Pessoa.BuscarPessoas;
      CDS_Pessoas.EmptyDataSet;

               // Carrega atrav�s da lista de objetos Pessoa para preencher o CDS //
      for Pessoa in ListaPessoas do
      begin
         CDS_Pessoas.Append;
         //CDS_Pessoas.FieldByName('id_pessoa').AsInteger           := 0;
         //CDS_Pessoas.FieldByName('tipo_pessoa').AsInteger         := Pessoa.TipoPessoa;
         CDS_Pessoas.FieldByName('nome').AsString                 := Pessoa.Nome;
         //CDS_Pessoas.FieldByName('data_nascimento').AsDateTime    := Pessoa.DataNascimento;
         CDS_Pessoas.FieldByName('cpf').AsString                  := Pessoa.CPF;
         CDS_Pessoas.FieldByName('rg').AsString                   := Pessoa.RG;
         CDS_Pessoas.FieldByName('email').AsString                := Pessoa.Email;
         CDS_Pessoas.FieldByName('telefone').AsString             := Pessoa.Telefone;

         // Campos relacionados ao endere�o //
         CDS_Pessoas.FieldByName('cep').AsString                  := Pessoa.Endereco.Cep;
         CDS_Pessoas.FieldByName('endereco').AsString             := Pessoa.Endereco.Logradouro;
         CDS_Pessoas.FieldByName('cidade').AsString               := Pessoa.Endereco.Cidade;
         CDS_Pessoas.FieldByName('estado').AsString               := Pessoa.Endereco.Estado;
         CDS_Pessoas.FieldByName('end_numero').AsString           := Pessoa.Endereco.Numero;
         CDS_Pessoas.Post;
      end;
   finally
     CDS_Pessoas.EnableControls;
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
