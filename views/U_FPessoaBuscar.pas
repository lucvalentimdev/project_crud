unit U_FPessoaBuscar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, FireDAC.Comp.DataSet;

type
  TF_PessoaBuscar = class(TForm)
    Pn_Top: TPanel;
    Pn_Botton: TPanel;
    DS_1: TDataSource;
    CDS_Pessoas: TClientDataSet;
    Grid_Principal: TDBGrid;
    Bbtn_Limpar: TBitBtn;
    Bbtn_Fechar1: TBitBtn;
    Bbtn_Editar: TBitBtn;
    Bt_Consultar: TSpeedButton;
    Label24: TLabel;
    Label5: TLabel;
    Ed_CPF: TEdit;
    Ed_Nome: TEdit;
    Label1: TLabel;
    Ed_CNPJ: TEdit;
    Label2: TLabel;
    CDS_Pessoasid_pessoa: TFDAutoIncField;
    CDS_Pessoasnome: TWideStringField;
    CDS_Pessoastelefone: TWideStringField;
    CDS_Pessoasdata_nascimento: TWideMemoField;
    CDS_Pessoascpf: TWideStringField;
    CDS_Pessoasrg: TWideStringField;
    CDS_Pessoasemail: TWideStringField;
    CDS_Pessoasendereco: TWideStringField;
    CDS_Pessoascidade: TWideStringField;
    CDS_Pessoasestado: TWideStringField;
    CDS_PessoasCEP: TWideStringField;
    CDS_Pessoasend_numero: TWideMemoField;
    CDS_Pessoastipo_pessoa: TStringField;
    CDS_Pessoascnpj: TStringField;
    procedure Bt_ConsultarClick(Sender: TObject);
    procedure Bbtn_Fechar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Bbtn_LimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_PessoaBuscar: TF_PessoaBuscar;

implementation

uses
   U_GeralController;

{$R *.dfm}

procedure TF_PessoaBuscar.Bbtn_Fechar1Click(Sender: TObject);
begin
   Close;
end;

procedure TF_PessoaBuscar.Bbtn_LimparClick(Sender: TObject);
begin
   Ed_Nome.Clear;
   Ed_CPF.Clear;
   Ed_CNPJ.Clear;
   CDS_Pessoas.EmptyDataSet;
end;

procedure TF_PessoaBuscar.Bt_ConsultarClick(Sender: TObject);
var
   Controller : TGeralController;
begin
   controller.CarregarCDSPessoas(CDS_Pessoas);            // Aciona o controlador para fazer tratar la busca//
end;

procedure TF_PessoaBuscar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CDS_Pessoas.EmptyDataSet;
   CDS_Pessoas.Close;
end;

end.
