unit U_Pessoa;
interface

uses
   U_Endereco, DM_Principal, System.RegularExpressions;

type

  TPessoa = class
  private
    FIdPessoa : Integer;
    FTipoPessoa: Integer;
    FNome: string;
    FDataNascimento: TDate;
    FCPF: string;
    FRG: string;
    FEmail: string;
    FTelefone: string;
    FEndereco: TEndereco;

  public

    property IdPessoa : Integer     read FIdPessoa       write FIdPessoa;
    property TipoPessoa: Integer    read FTipoPessoa     write FTipoPessoa;
    property Nome: string           read FNome           write FNome;
    property DataNascimento: TDate  read FDataNascimento write FDataNascimento;
    property CPF: string            read FCPF            write FCPF;
    property RG: string             read FRG             write FRG;
    property Email: string          read FEmail          write FEmail;
    property Telefone: string       read FTelefone       write FTelefone;
    property Endereco: TEndereco    read FEndereco       write FEndereco;

    constructor Create(ATipoPessoa: Integer; ANome: string; ADataNascimento: TDate; ACPF: string; ARG: string;
    AEmail: string ; ATelefone: string; AEndereco: TEndereco); overload;

    procedure Salvar;
    function ValidarEmail(const Email: string): Boolean;
    function CPFouCNPJCadastrado(const Documento: string): Boolean;

end;


implementation

function TPessoa.CPFouCNPJCadastrado(const Documento: string): Boolean;
begin
   Result := False;
   try
      try
        Data_Module.FQry_Op.SQL.Text := 'SELECT COUNT(1) FROM pessoa WHERE (CPF = :Documento OR CNPJ = :Documento)';
        Data_Module.FQry_Op.ParamByName('Documento').AsString := Documento;
        Data_Module.FQry_Op.Open;

        // Verifica se existe algum registro com o CPF ou CNPJ informado  //
        if Data_Module.FQry_Op.RecordCount >= 1 then
          Result := True;
      finally
        Data_Module.FQry_Op.Free;
      end;
   except
      raise ;
   end;

end;

constructor TPessoa.Create(ATipoPessoa: Integer; ANome: string; ADataNascimento: TDate; ACPF, ARG, AEmail, ATelefone: string; AEndereco: TEndereco);
begin
   FTipoPessoa     := ATipoPessoa;
   FNome           := ANome;
   FDataNascimento := ADataNascimento;
   FCPF            := ACPF;
   FRG             := ARG;
   FEmail          := AEmail;
   FTelefone       := ATelefone;
   FEndereco       := AEndereco;
end;

procedure TPessoa.Salvar;           // Procedure para salvar uma nova pessoa  //
var
 Script : string;
begin
  Script := 'INSERT INTO Pessoa (nome, data_nascimento, cpf, rg, email, telefone, cep, endereco,  cidade, estado,  end_numero) ' +
                        'VALUES (:nome, :data_nascimento, :cpf, :rg, :email, :telefone, :cep, :endereco, :cidade, :estado, :numero)';
   try
      try
         Data_Module.FQry_Op.SQL.Text := '';

         Data_Module.FQry_Op.SQL.Text                                := Script;
         Data_Module.FQry_Op.ParamByName('nome').AsString            := Self.Nome;
         Data_Module.FQry_Op.ParamByName('data_nascimento').AsDate   := Self.DataNascimento;
         Data_Module.FQry_Op.ParamByName('cpf').AsString             := Self.CPF;
         Data_Module.FQry_Op.ParamByName('rg').AsString              := Self.RG;
         Data_Module.FQry_Op.ParamByName('email').AsString           := Self.Email;
         Data_Module.FQry_Op.ParamByName('telefone').AsString        := Self.Telefone;
         Data_Module.FQry_Op.ParamByName('cep').AsString             := Self.Endereco.CEP;
         Data_Module.FQry_Op.ParamByName('endereco').AsString        := Self.Endereco.Logradouro;
         Data_Module.FQry_Op.ParamByName('cidade').AsString          := Self.Endereco.Cidade;
         Data_Module.FQry_Op.ParamByName('estado').AsString          := Self.Endereco.Estado;
         Data_Module.FQry_Op.ParamByName('numero').AsString          := Self.Endereco.Numero;
         Data_Module.FQry_Op.ExecSQL;
      except
         raise;
      end;
   finally
      Data_Module.FQry_Op.Close;
   end;
end;

function TPessoa.ValidarEmail(const Email: string): Boolean;  // Fun��o que usa RegEx para ver se o formato de e-mail � v�lido //
var
  Regex: TRegEx;
begin
  Regex := TRegEx.Create('^[\w._%+-]+@[\w.-]+\.[a-zA-Z]{2,}$');
  Result := Regex.IsMatch(Email);
end;

end.
