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
    FCNPJ : string;
    FRG: string;
    FEmail: string;
    FTelefone: string;
    FEndereco: TEndereco;        // Objeto do tipo TEndereco //

  public
    property IdPessoa : Integer     read FIdPessoa       write FIdPessoa;
    property TipoPessoa: Integer    read FTipoPessoa     write FTipoPessoa;
    property Nome: string           read FNome           write FNome;
    property DataNascimento: TDate  read FDataNascimento write FDataNascimento;
    property CPF: string            read FCPF            write FCPF;
    property CNPJ: string           read FCNPJ           write FCNPJ;
    property RG: string             read FRG             write FRG;
    property Email: string          read FEmail          write FEmail;
    property Telefone: string       read FTelefone       write FTelefone;
    property Endereco: TEndereco    read FEndereco       write FEndereco;    // Objeto do tipo TEndereco //

    constructor Create() overload;
    constructor Create(ATipoPessoa: Integer; ANome: string; ADataNascimento: TDate; ACPF: string; ACNPJ : string; ARG: string;
    AEmail: string ; ATelefone: string; AEndereco: TEndereco); overload;

    procedure Salvar;
    function ValidarEmail(const Email: string): Boolean;
    function CPFouCNPJCadastrado(const Documento: string): Boolean;
    function BuscarPessoas : TArray<TPessoa>;

end;

implementation


constructor TPessoa.Create;
begin
end;

constructor TPessoa.Create(ATipoPessoa: Integer; ANome: string; ADataNascimento: TDate; ACPF, ACNPJ, ARG, AEmail, ATelefone: string;
            AEndereco: TEndereco);
begin
   FTipoPessoa     := ATipoPessoa;
   FNome           := ANome;
   FDataNascimento := ADataNascimento;
   FCPF            := ACPF;
   FCNPJ           := ACNPJ;
   FRG             := ARG;
   FEmail          := AEmail;
   FTelefone       := ATelefone;
   FEndereco       := AEndereco;
end;

procedure TPessoa.Salvar;           // Procedure para salvar uma nova pessoa  //
var
 Script : string;
begin
  Script := 'INSERT INTO Pessoa (nome, data_nascimento, id_tipopessoa, cpf, cnpj, rg, email, telefone, cep, endereco,  cidade, estado,  end_numero) ' +
                        'VALUES (:nome, :data_nascimento,:id_tipopessoa, :cpf, :cnpj, :rg, :email, :telefone, :cep, :endereco, :cidade, :estado, :numero)';
   try
      try
         Data_Module.FQry_Op.SQL.Text := '';
         Data_Module.FQry_Op.SQL.Text                                := Script;

         Data_Module.FQry_Op.ParamByName('nome').AsString            := Self.Nome;
         Data_Module.FQry_Op.ParamByName('data_nascimento').AsDate   := Self.DataNascimento;
         Data_Module.FQry_Op.ParamByName('id_tipopessoa').AsInteger  := Self.TipoPessoa;
         Data_Module.FQry_Op.ParamByName('cpf').AsString             := Self.CPF;
         Data_Module.FQry_Op.ParamByName('cnpj').AsString            := Self.CNPJ;
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

function TPessoa.BuscarPessoas: TArray<TPessoa>;
var
  Pessoa: TPessoa;
  Endereco : TEndereco;
  ListaPessoas: TArray<TPessoa>;
begin
   try
      try
         Data_Module.FQry_Pessoas.SQL.Text := 'SELECT  p.nome, p.data_nascimento, p.id_tipopessoa, p.cnpj,  tp.tipo_descricao AS descricao, '+
         ' p.cpf,  p.rg,  p.email, p.telefone, p.cep,  p.endereco,  p.cidade,  p.estado,  p.end_numero ' +
         ' FROM Pessoa p '+
         ' INNER JOIN TipoPessoa tp ON p.id_tipopessoa = tp.id ';

         Data_Module.FQry_Pessoas.Open;

         ListaPessoas := TArray<TPessoa>.Create(nil);
         SetLength(ListaPessoas, Data_Module.FQry_Pessoas.RecordCount);

         while not Data_Module.FQry_Pessoas.Eof do
         begin
           Pessoa := TPessoa.Create;
                     //Pessoa.IdPessoa            := Data_Module.FQry_Pessoas.FieldByName('id_pessoa').AsInteger;
                     //Pessoa.TipoPessoa          := Data_Module.FQry_Pessoas.FieldByName('id_tipopessoa').AsInteger;
                     Pessoa.Nome                := Data_Module.FQry_Pessoas.FieldByName('nome').AsString;
                     //Pessoa.DataNascimento      := Data_Module.FQry_Pessoas.FieldByName('data_nascimento').AsDateTime;
                     Pessoa.CPF                 := Data_Module.FQry_Pessoas.FieldByName('cpf').AsString;
                     Pessoa.CNPJ                := Data_Module.FQry_Pessoas.FieldByName('cnpj').AsString;
                     Pessoa.RG                  := Data_Module.FQry_Pessoas.FieldByName('rg').AsString;
                     Pessoa.Email               := Data_Module.FQry_Pessoas.FieldByName('email').AsString;
                     Pessoa.Telefone            := Data_Module.FQry_Pessoas.FieldByName('telefone').AsString;

                     Pessoa.Endereco := TEndereco.Create;
                     Pessoa.Endereco.Cep        := Data_Module.FQry_Pessoas.FieldByName('cep').AsString;
                     Pessoa.Endereco.Logradouro := Data_Module.FQry_Pessoas.FieldByName('endereco').AsString;
                     Pessoa.Endereco.Cidade     := Data_Module.FQry_Pessoas.FieldByName('cidade').AsString;
                     Pessoa.Endereco.Estado     := Data_Module.FQry_Pessoas.FieldByName('estado').AsString;
                     Pessoa.Endereco.Numero     := Data_Module.FQry_Pessoas.FieldByName('end_numero').Value;

            ListaPessoas[Data_Module.FQry_Pessoas.RecNo -1] := Pessoa;
            Data_Module.FQry_Pessoas.Next;
         end;
      except
         raise;
      end;

      Result := ListaPessoas;
   finally
      Data_Module.FQry_Pessoas.Free;
      Pessoa.Free;
   end;

end;

function TPessoa.CPFouCNPJCadastrado(const Documento: string): Boolean;
begin
   Result := False;
   try
      try
         Data_Module.FQry_Op.Close;
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

end.
