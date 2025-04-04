unit U_FMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Buttons;

type
  TF_Menu = class(TForm)
    pn_Left: TPanel;
    Btn_Relatorio: TSpeedButton;
    Btn_Fechar: TSpeedButton;
    img_background: TImage;
    procedure Btn_RelatorioClick(Sender: TObject);
    procedure Btn_FecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Menu: TF_Menu;

implementation

uses
   U_FPessoaCadastrar;

{$R *.dfm}

procedure TF_Menu.Btn_FecharClick(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TF_Menu.Btn_RelatorioClick(Sender: TObject);
begin
   if F_PessoaCadastrar = nil then
   begin
      try
         F_PessoaCadastrar := TF_PessoaCadastrar.Create(Self);
         F_PessoaCadastrar.Show;
      finally
         F_PessoaCadastrar := nil;
      end;
   end
   else
      F_PessoaCadastrar.Show;

end;

end.
