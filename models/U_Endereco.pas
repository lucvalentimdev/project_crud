unit U_Endereco;

interface
      uses
         System.SysUtils, System.JSON, System.Net.HttpClient;
type
  TEndereco = class

  private
    FLogradouro: string;
    FBairro: string;
    FCidade: string;
    FEstado: string;
    FCEP: string;
    FComplemento: string;
    FNumero: string;
    FLog : string;

  public
    property Logradouro: string  read FLogradouro  write FLogradouro;
    property Bairro: string      read FBairro      write FBairro;
    property Cidade: string      read FCidade      write FCidade;
    property Estado: string      read FEstado      write FEstado;
    property CEP: string         read FCEP         write FCEP;
    property Complemento: string read FComplemento write FComplemento;
    property Numero: string      read FNumero      write FNumero;
    property Log : string        read FLog         write FLog;

    procedure ConsultarViaCEP(const CEP: string);
    function ValidarCEP(const CEP: string): Boolean;
  end;

implementation

procedure TEndereco.ConsultarViaCEP(const CEP: string);
var
  HttpClient:  THTTPClient;                                      // Documentação dessa API disponível em:*** https://viacep.com.br/ ***//
  Response:    IHTTPResponse;
  JsonObj:     TJSONObject;
begin
   HttpClient := THTTPClient.Create;
   try
      Response := HttpClient.Get('https://viacep.com.br/ws/' + CEP + '/json/');  //<--- Consulta a Api ViaCEP //

      if Response.StatusCode = 200 then
      begin
         JsonObj := TJSONObject.ParseJSONValue(Response.ContentAsString) as TJSONObject;     // Trata o arquivo JSON de retorno //

         try
            FLogradouro  := JsonObj.GetValue<string>('logradouro');
            FBairro      := JsonObj.GetValue<string>('bairro');
            FCidade      := JsonObj.GetValue<string>('localidade');
            FEstado      := JsonObj.GetValue<string>('uf');
         finally
            JsonObj.Free;
         end;
      end
      else
        FLog := 'Erro ao consultar o CEP: ' + Response.StatusCode.ToString;
   finally
      HttpClient.Free;
   end;
end;

function TEndereco.ValidarCEP(const CEP: string): Boolean;
var
  I: Integer;
begin
  Result := False;

  // Verificar se o CEP tem 9 caracteres incluindo o traço //
   if Length(CEP) <> 9 then
    Exit;

  // Verificar se todos os caracteres são numéricos
   for I := 1 to Length(CEP) do
   begin
      if (I = 6) and (CEP[I] <> '-') then                   // Verifica se o traço esta na posição correta//
         Exit
      else if (I <> 6) and not (CEP[I] in ['0'..'9']) then  // Verifica outros caracteres que devem ser números//
      Exit;
   end;
  Result := True;
end;

end.
