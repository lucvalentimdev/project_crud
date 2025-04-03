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

  public
    property Logradouro: string read FLogradouro write FLogradouro;
    property Bairro: string read FBairro write FBairro;
    property Cidade: string read FCidade write FCidade;
    property Estado: string read FEstado write FEstado;
    property CEP: string read FCEP write FCEP;
    property Complemento: string read FComplemento write FComplemento;
    property Numero: string read FNumero write FNumero;

    procedure ConsultarViaCEP(const ACep: string);
  end;

implementation

procedure TEndereco.ConsultarViaCEP(const ACep: string);
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  JsonObj: TJSONObject;
begin
  HttpClient := THTTPClient.Create;
  try
    // Faz a requisição ao ViaCEP
    Response := HttpClient.Get('https://viacep.com.br/ws/' + ACep + '/json/');
    if Response.StatusCode = 200 then
    begin
      // Parseia o JSON retornado
      JsonObj := TJSONObject.ParseJSONValue(Response.ContentAsString) as TJSONObject;

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
      raise Exception.Create('Erro ao consultar o CEP: ' + Response.StatusCode.ToString);
  finally
    HttpClient.Free;
  end;
end;

end.
