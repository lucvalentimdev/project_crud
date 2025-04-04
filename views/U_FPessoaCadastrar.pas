unit U_FPessoaCadastrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCalendars, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.Mask, U_Endereco, U_Pessoa, U_GeralController, JPEG;

type
  TF_PessoaCadastrar = class(TForm)
    grp_Profile: TGroupBox;
    Label7: TLabel;
    img_Perfil: TImage;
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
    Lb_1: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label13: TLabel;
    Ed_Numero: TEdit;
    Ed_RG: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    procedure Bbtn_UpImgPerfilClick(Sender: TObject);
    procedure Cbo_TipoPessoaSelect(Sender: TObject);
    procedure Bbtn_Fechar1Click(Sender: TObject);
    procedure Bbtn_NovoClick(Sender: TObject);
    procedure Bbtn_BuscarClick(Sender: TObject);
    procedure Ed_CEPExit(Sender: TObject);
    procedure LimparCampos();
    procedure Bbtn_LimparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function PreenchimentoCampos : Boolean;
    procedure Bbtn_ConcluirClick(Sender: TObject);
    procedure ControlarCorDosCampos(CorFundo: TColor);
    procedure Bbtn_CancelarClick(Sender: TObject);

  private
    { Private declarations }
    var
    Controller: TGeralController;
  public
    { Public declarations }
  end;

var
  F_PessoaCadastrar: TF_PessoaCadastrar;

implementation

uses
    U_FPessoaBuscar, DM_Principal;

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

procedure TF_PessoaCadastrar.Bbtn_CancelarClick(Sender: TObject);
begin
   Bbtn_Novo.Enabled       := True;
   Bbtn_Cancelar.Enabled   := False;
   Bbtn_Concluir.Visible   := False;
   Bbtn_Buscar.Visible     := True;
   grp_Dados.Enabled       := False;

   LimparCampos;
   ControlarCorDosCampos(clBtnFace);
end;

procedure TF_PessoaCadastrar.Bbtn_ConcluirClick(Sender: TObject);
var
 NovaPessoa : TPessoa;
 Endereco   : TEndereco;
begin
   if not PreenchimentoCampos  then
      Exit;

   Endereco := TEndereco.Create;

   try
    // Alimenta os dados do endere�o//
      Endereco.Logradouro  := Trim(Ed_Logradouro.Text);
      Endereco.CEP         := Trim(Ed_CEP.Text);
      Endereco.Cidade      := Trim(Ed_Cidade.Text);
      Endereco.Estado      := Trim(Ed_UF.Text);
      Endereco.Numero      := Trim(Ed_Numero.Text);

    // Chamada do Controller para salvar a pessoa //

      Controller.SalvarPessoa(
         Cbo_TipoPessoa.ItemIndex,             // Tipo de Pessoa     //
         Trim(Ed_Nome.Text),                   // Nome               //
         Calendar_DataNasc.Date,               // Data de Nascimento //
         Trim(Ed_CPF.Text),                    // CPF                //
         Trim(Ed_CNPJ.Text),
         Trim(Ed_RG.Text),                     // RG                 //
         Trim(Ed_Email.Text),                  // E-mail             //
         Trim(Ed_Telefone.Text),               // Telefone           //
         Endereco                              // Objeto Endere�o    //
                                 );

      MessageDlg('Pessoa cadastrada com sucesso!', mtInformation, [mbOK], 0);
      Bbtn_Cancelar.Click;

   except on E: Exception do
      MessageDlg('Erro ao salvar a pessoa: ' + E.Message, mtError, [mbOK], 0);
   end;
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
   Bbtn_Cancelar.Enabled   := True;
   grp_Dados.Enabled       := True;
   Ed_Nome.SetFocus;

   ControlarCorDosCampos(clInfoBk);

end;

procedure TF_PessoaCadastrar.Bbtn_UpImgPerfilClick(Sender: TObject);
 var
  EnderecoImg : string;
begin
   if OpenDialog1.Execute then
   begin
      EnderecoImg := OpenDialog1.FileName;
      try
        Img_Perfil.Picture.LoadFromFile(EnderecoImg);
      except on E: Exception do
          ShowMessage('Erro ao carregar a imagem: ' + E.Message);
      end;
   end
   else
     ShowMessage('Nenhuma imagem foi selecionada.');  // Carrega temporariamente a imagem no TImagem //
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

procedure TF_PessoaCadastrar.ControlarCorDosCampos(CorFundo: TColor);
begin
   Ed_Nome.Color           := CorFundo;
   Ed_CPF.Color            := CorFundo;
   Ed_RG.Color             := CorFundo;
   Cbo_TipoPessoa.Color    := CorFundo;
   Ed_Logradouro.Color     := CorFundo;
   Ed_CNPJ.Color           := CorFundo;
   Ed_Telefone.Color       := CorFundo;
   Ed_Cidade.Color         := CorFundo;
   Ed_UF.Color             := CorFundo;
   Ed_CEP.Color            := CorFundo;
   Ed_Numero.Color         := CorFundo;
   Ed_Email.Color          := CorFundo;
   Calendar_DataNasc.Color := CorFundo;
end;

procedure TF_PessoaCadastrar.Ed_CEPExit(Sender: TObject);
var
  Endereco: TEndereco;
begin
   Endereco    := TEndereco.Create;
   Controller  := TGeralController.Create();
   try
      try
         if not Controller.ValidarCEP(Trim(Ed_CEP.Text)) then      // Validando CEP //
         begin
            MessageDlg('CEP inv�lido, favor verificar!', mtInformation, [mbOk, mbCancel], 0);
            Exit;
         end;
         Controller.ConsultarCEP(Trim(Ed_CEP.Text), Endereco);    // Consultando CEP //
      except on E: Exception do
         begin
            MessageDlg('Erro ao consultar o CEP: ' + E.Message, mtError, [mbOk], 0);
            Exit;
         end;
      end;
      // Atualiza os campos //
      Ed_Logradouro.Text   := Endereco.Logradouro;
      Ed_Cidade.Text       := Endereco.Cidade;
      Ed_UF.Text           := Endereco.Estado;
   finally
     Endereco.Free;      // Libera da memoria //
     Controller.Free;
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
   Cbo_TipoPessoa.ItemIndex := 1;

   Bbtn_Concluir.Top       := 23;
   Bbtn_Concluir.Visible   := False;
   ControlarCorDosCampos(clBtnFace);

end;

procedure TF_PessoaCadastrar.LimparCampos;
begin
    Ed_Nome.Clear;
    Ed_CPF.Clear;
    Ed_RG.Clear;
    Cbo_TipoPessoa.ItemIndex := 0;
    Ed_Logradouro.Clear;
    Ed_CNPJ.Clear;
    Ed_Telefone.Clear;
    Ed_Cidade.Clear;
    Ed_UF.Clear;
    Ed_CEP.Clear;
    Ed_Email.Clear;
    Ed_Nome.Clear;
    Ed_Numero.Clear;
    Calendar_DataNasc.Date := Date;
end;

function TF_PessoaCadastrar.PreenchimentoCampos: Boolean;
begin
   // Valida o campo Nome //
   if Trim(Ed_Nome.Text) = '' then
   begin
      MessageDlg('O campo Nome � obrigat�rio!', mtWarning, [mbOK], 0);
      Ed_Nome.SetFocus;
      Result := False;
      Exit;
   end;

   // Valida o campo Logradouro //
   if Trim(Ed_Logradouro.Text) = '' then
   begin
      MessageDlg('O campo Logradouro � obrigat�rio!', mtWarning, [mbOK], 0);
      Ed_Logradouro.SetFocus;
      Result := False;
      Exit;
   end;

   if Trim(Cbo_TipoPessoa.Text) = 'CLIENTE' then   //<-- Verifica o tipo de pessoa selecionado //
   begin
      if Trim(Ed_CPF.Text) = '' then      // CPF � obrigat�rio para CLIENTE //
      begin
        MessageDlg('O campo CPF � obrigat�rio para Cliente!', mtWarning, [mbOK], 0);
        Ed_CPF.SetFocus;
        Result := False;
        Exit;
      end;

      if Trim(Ed_RG.Text) = '' then        // Campo RG � obrigat�rio para Cliente //
      begin
        MessageDlg('O campo RG � obrigat�rio!', mtWarning, [mbOK], 0);
        Ed_RG.SetFocus;
        Result := False;
        Exit;
      end;
   end
   else
   begin
      // CNPJ � obrigat�rio para outros tipos de pessoa //
      if Trim(Ed_CNPJ.Text) = '' then
      begin
        MessageDlg('O campo CNPJ � obrigat�rio para este tipo de pessoa!', mtWarning, [mbOK], 0);
        Ed_CNPJ.SetFocus;
        Result := False;
        Exit;
      end;
   end;

   // Valida o campo Telefone//
   if Trim(Ed_Telefone.Text) = '' then
   begin
     MessageDlg('O campo Telefone � obrigat�rio!', mtWarning, [mbOK], 0);
     Ed_Telefone.SetFocus;
     Result := False;
     Exit;
   end;

   // Valida o campo E-mail//
   if Trim(Ed_Email.Text) = '' then
   begin
      MessageDlg('O campo E-mail � obrigat�rio!', mtWarning, [mbOK], 0);
      Ed_Email.SetFocus;
      Result := False;
      Exit;
   end;

   // Valida o campo Cidade//
   if Trim(Ed_Cidade.Text) = '' then
   begin
      MessageDlg('O campo Cidade � obrigat�rio!', mtWarning, [mbOK], 0);
      Ed_Cidade.SetFocus;
      Result := False;
      Exit;
   end;

   // Valida o campo UF//
   if Trim(Ed_UF.Text) = '' then
   begin
      MessageDlg('O campo UF � obrigat�rio!', mtWarning, [mbOK], 0);
      Ed_UF.SetFocus;
      Result := False;
      Exit;
   end;

   // Valida o campo CEP//
   if Trim(Ed_CEP.Text) = '' then
   begin
      MessageDlg('O campo CEP � obrigat�rio!', mtWarning, [mbOK], 0);
      Ed_CEP.SetFocus;
      Result := False;
      Exit;
   end;

Result := True;
end;

end.
