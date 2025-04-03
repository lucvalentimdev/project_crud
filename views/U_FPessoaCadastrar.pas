unit U_FPessoaCadastrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCalendars, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.Mask;

type
  TF_PessoaCadastrar = class(TForm)
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
    Ed_Nome: TEdit;
    Cbo_TipoPessoa: TComboBox;
    Ed_CPF: TEdit;
    Ed_Email: TEdit;
    Calendar_DataNasc: TCalendarPicker;
    Ed_Logradouro: TEdit;
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
    Ed_UF: TEdit;
    Ed_CEP: TMaskEdit;
    Label11: TLabel;
    procedure Bbtn_UpImgPerfilClick(Sender: TObject);
    procedure Cbo_TipoPessoaSelect(Sender: TObject);
    procedure Bbtn_Fechar1Click(Sender: TObject);
    procedure Bbtn_NovoClick(Sender: TObject);
    procedure Bbtn_BuscarClick(Sender: TObject);
    procedure Ed_CEPExit(Sender: TObject);
    procedure LimparCampos();
    procedure Bbtn_LimparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_PessoaCadastrar: TF_PessoaCadastrar;

implementation

uses
   U_Endereco, U_Pessoa, U_FPessoaBuscar, DM_Principal;

{$R *.dfm}

procedure TF_PessoaCadastrar.Bbtn_BuscarClick(Sender: TObject);
begin
   if F_PessoaBuscar = nil then
   begin
      try
         F_PessoaBuscar    := TF_PessoaBuscar.Create(Self);
         F_PessoaBuscar.ShowModal;
      finally
         F_PessoaBuscar    := nil;
      end;
   end
   else
      F_PessoaBuscar.ShowModal;

end;

procedure TF_PessoaCadastrar.Bbtn_Fechar1Click(Sender: TObject);
begin
   Close;
end;

procedure TF_PessoaCadastrar.Bbtn_LimparClick(Sender: TObject);
begin
   LimparCampos;
end;

procedure TF_PessoaCadastrar.Bbtn_NovoClick(Sender: TObject);
begin
   Bbtn_Concluir.Visible   := True;
   Bbtn_Buscar.Visible     := False;
   Bbtn_Novo.Enabled       := False;
   Bbtn_Cancelar.Enabled   := False;
end;

procedure TF_PessoaCadastrar.Bbtn_UpImgPerfilClick(Sender: TObject);
 var
  EnderecoImg : string;
begin
   if OpenDialog1.Execute then
      EnderecoImg  := OpenDialog1.FileName;

   Img_Perfil.Picture.LoadFromFile(EnderecoImg);   // Carrega temporariamente a imagem no TImagem //
end;

procedure TF_PessoaCadastrar.Cbo_TipoPessoaSelect(Sender: TObject);
begin
   if (Cbo_TipoPessoa.Text = 'FORNECEDOR') OR (Cbo_TipoPessoa.Text = 'TRANSPORTADOR') then
   begin
      Ed_CNPJ.Enabled         := True;
      Ed_CNPJ.Color           := clInfoBk;
      Lb_DataNascFund.Caption := 'Data Funda��o:'
   end
   else
   begin
      Ed_CNPJ.Enabled         := False;
      Ed_CNPJ.Color           := clBtnFace;
      Lb_DataNascFund.Caption := 'Data Nascimento:'
   end;
end;

procedure TF_PessoaCadastrar.Ed_CEPExit(Sender: TObject);
var
   CEP : TEndereco;
begin
   try
      try
         CEP := TEndereco.Create;

         if not CEP.ValidarCEP(Trim(Ed_CEP.Text)) then       // Valida se o CEP esta dento do padr�o //
         begin
            MessageDlg('CEP inv�lido, favor verificar!', mtInformation, [mbOk, mbCancel], 0);
            Exit;
         end;

         CEP.ConsultarViaCEP(Trim(Ed_CEP.Text));
      except
         raise Exception.Create(CEP.Log);
      end;

      Ed_Logradouro.Text   := CEP.Logradouro;
      Ed_Cidade.Text       := CEP.Cidade;
      Ed_UF.Text           := CEP.Estado;

   finally
      CEP.Free;
   end;

end;

procedure TF_PessoaCadastrar.FormShow(Sender: TObject);
begin
   Data_Module.FQry_TipoPessoa.Open();                      // Carrega via Query de leitura os Tipos de Pessoa //
   Data_Module.FQry_TipoPessoa.First;

   while not Data_Module.FQry_TipoPessoa.Eof do
   begin
      Cbo_TipoPessoa.Items.Add(Data_Module.FQry_TipoPessoa.FieldByName('tipo_descricao').AsString);
      Data_Module.FQry_TipoPessoa.Next;
   end;

   Bbtn_Concluir.Top       := 23;
   Bbtn_Concluir.Visible   := False;

end;

procedure TF_PessoaCadastrar.LimparCampos;
begin
    Ed_Logradouro.Clear;
    Ed_CNPJ.Clear;
    Ed_Telefone.Clear;
    Ed_Cidade.Clear;
    Ed_UF.Clear;
    Ed_CEP.Clear;
end;

end.
