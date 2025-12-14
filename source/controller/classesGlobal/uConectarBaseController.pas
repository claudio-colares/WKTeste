unit uConectarBaseController;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IniFiles,
  Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.MSSQL,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.FB;

Type

  TConectarBaseController = Record
    BaseDados: String;
    IP: String;
    Porta: Integer;
    Usuario: String;
    Senha: String;
  private

    procedure GetAcesso();
  Public
    procedure Limpar;
    procedure VerificarINI;
    procedure GravarINI;
    procedure LerINI;
    procedure GetDriverLinkMySQL(var aDriverLink: TFDPhysMySQLDriverLink);
    procedure AcessarBase(var aFDConnection: TFDConnection);
    function Conectar(var aConnection: TFDConnection): Boolean;
  end;

Var
  oConectarBase: TConectarBaseController;

implementation

{ TConectarBase }

uses FuncoesController, uConstantesController;

procedure TConectarBaseController.Limpar;
begin
  BaseDados := '';
  IP        := '';
  Porta     := 0;
  Usuario   := '';
  Senha     := '';
end;

procedure TConectarBaseController.VerificarINI;
begin
  if not FileExists(_PATH_SISTEMA + _ARQUIVO_INI) then
  begin
    Limpar;
    GetAcesso();
    GravarINI;
  end;
end;

function TConectarBaseController.Conectar(var aConnection: TFDConnection): Boolean;
begin
  Result := False;
  AcessarBase(aConnection);

  if not aConnection.Connected then
  begin
    aConnection.Open;
    if aConnection.Connected then
      Result := True;
  end;
end;

procedure TConectarBaseController.GetAcesso();
begin
  Limpar;
  BaseDados := _DB_BASEDADOS;
  IP        := _DB_SERVIDOR;
  Porta     := _DB_PORTA;
  Usuario   := _DB_USUARIO;
  Senha     := _DB_SENHA;
end;

procedure TConectarBaseController.LerINI;
var
  oArqINI: TIniFile;
begin
  Limpar;
  oArqINI := TIniFile.create(_PATH_SISTEMA + _ARQUIVO_INI);
  try
    BaseDados := oArqINI.ReadString(_SECAO_SERVIDOR, _CHAVE_BASEDADOS, _DB_BASEDADOS);
    IP        := oArqINI.ReadString(_SECAO_SERVIDOR, _CHAVE_IP, _DB_SERVIDOR);
    Porta     := oArqINI.ReadInteger(_SECAO_SERVIDOR, _CHAVE_PORTA, _DB_PORTA);
    Usuario   := oArqINI.ReadString(_SECAO_SERVIDOR, _CHAVE_USUARIO, _DB_USUARIO);
    Senha     := oArqINI.ReadString(_SECAO_SERVIDOR, _CHAVE_SENHA, _DB_SENHA);
  finally
    oArqINI.Free;
  end;
end;

procedure TConectarBaseController.GravarINI;
var
  oArqINI: TIniFile;
begin
  oArqINI := TIniFile.create(_PATH_SISTEMA + _ARQUIVO_INI);
  try
    oArqINI.WriteString(_SECAO_SERVIDOR, _CHAVE_BASEDADOS, BaseDados);
    oArqINI.WriteString(_SECAO_SERVIDOR, _CHAVE_IP, IP);
    oArqINI.WriteInteger(_SECAO_SERVIDOR, _CHAVE_PORTA, Porta);
    oArqINI.WriteString(_SECAO_SERVIDOR, _CHAVE_USUARIO, Usuario);
    oArqINI.WriteString(_SECAO_SERVIDOR, _CHAVE_SENHA, Senha);
  finally
    oArqINI.Free;
  end;
end;

procedure TConectarBaseController.AcessarBase(var aFDConnection: TFDConnection);
begin
  if (aFDConnection = nil) then
  begin
    raise Exception.create('Objeto TFDConnection não instanciado.');
  end;

  VerificarINI();
  LerINI();
  aFDConnection.Params.Values['Server']    := IP;
  aFDConnection.Params.Values['Database']  := BaseDados;
  aFDConnection.Params.Values['User_Name'] := Usuario;
  aFDConnection.Params.Values['Password']  := Senha;
  aFDConnection.Params.Values['Port']      := Porta.ToString;
  aFDConnection.Params.Values['Compress']  := 'True';
  aFDConnection.Params.Values['DriverID']  := 'MySQL';
  aFDConnection.Params.Values['VendorLib'] := 'libmariadb.dll';
end;

procedure TConectarBaseController.GetDriverLinkMySQL(var aDriverLink: TFDPhysMySQLDriverLink);
begin
  if aDriverLink = nil then
    raise Exception.create('Objeto TFDPhysMySQLDriverLink não instanciado.');

  aDriverLink.DriverID  := _DB_DRIVER;
  aDriverLink.VendorLib := _DB_VENDORLIB;
end;

end.
