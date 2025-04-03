unit U_FPessoas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCalendars, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TF_Pessoas = class(TForm)
    grp_Profile: TGroupBox;
    Label7: TLabel;
    img_Perfil: TImage;
    Label10: TLabel;
    Lb_DataCadastro: TLabel;
    Lb_2: TLabel;
    Label14: TLabel;
    Bbtn_UpImgPerfil: TBitBtn;
    grp_Dados: TGroupBox;
    Label24: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Lb_DataNascFund: TLabel;
    Label26: TLabel;
    Label37: TLabel;
    Ed_NomeAluno: TEdit;
    Cbo_TipoPessoa: TComboBox;
    Ed_CPFAluno: TEdit;
    Ed_Email: TEdit;
    Calendar_DataNascAluno: TCalendarPicker;
    Cbo_UF: TComboBox;
    Ed_EnderecoAluno: TEdit;
    Ed_CEPAluno: TEdit;
    Pn_rodape: TPanel;
    Bbtn_Limpar: TBitBtn;
    Bbtn_Fechar1: TBitBtn;
    Bbtn_Concluir: TBitBtn;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    Ed_CNPJ: TEdit;
    Label3: TLabel;
    Ed_Telefone: TEdit;
    Ed_Cidade: TEdit;
    Label4: TLabel;
    Label6: TLabel;
    Bbtn_Novo: TBitBtn;
    Bbtn_Buscar: TBitBtn;
    Bbtn_Cancelar: TBitBtn;
    procedure Bbtn_UpImgPerfilClick(Sender: TObject);
    procedure Cbo_TipoPessoaSelect(Sender: TObject);
    procedure Bbtn_Fechar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Bbtn_NovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Pessoas: TF_Pessoas;

implementation

{$R *.dfm}

procedure TF_Pessoas.Bbtn_Fechar1Click(Sender: TObject);
begin
   Close;
end;

procedure TF_Pessoas.Bbtn_NovoClick(Sender: TObject);
begin
   Bbtn_Concluir.Visible   := True;
   Bbtn_Novo.Enabled       := False;
   Bbtn_Cancelar.Enabled   := False;
end;

procedure TF_Pessoas.Bbtn_UpImgPerfilClick(Sender: TObject);
 var
  EnderecoImg : string;
begin
   if OpenDialog1.Execute then
      EnderecoImg  := OpenDialog1.FileName;

   Img_Perfil.Picture.LoadFromFile(EnderecoImg);   // Carrega temporariamente a imagem no TImagem //

end;

procedure TF_Pessoas.Cbo_TipoPessoaSelect(Sender: TObject);
begin
   if (Cbo_TipoPessoa.Text = 'FORNECEDOR') OR (Cbo_TipoPessoa.Text = 'TRANSPORTADOR') then
   begin
      Ed_CNPJ.Enabled         := True;
      Ed_CNPJ.Color           := clInfoBk;
      Lb_DataNascFund.Caption := 'Data Funda��o:'
   end;

end;

procedure TF_Pessoas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   F_Pessoas := Nil;
end;

end.
