unit U_Pessoa;
interface

uses
   U_Endereco;

type

  TPessoa = class
  private
    FTipoPessoa: string;
    FNome: string;
    FDataNascimento: TDate;
    FCPF: string;
    FRG: string;
    FEmail: string;
    FTelefone: string;
    FEndereco: TEndereco;

  public
    property TipoPessoa: string     read FTipoPessoa     write FTipoPessoa;
    property Nome: string           read FNome           write FNome;
    property DataNascimento: TDate  read FDataNascimento write FDataNascimento;
    property CPF: string            read FCPF            write FCPF;
    property RG: string             read FRG             write FRG;
    property Email: string          read FEmail          write FEmail;
    property Telefone: string       read FTelefone       write FTelefone;
    property Endereco: TEndereco    read FEndereco       write FEndereco;

end;


implementation





end.
