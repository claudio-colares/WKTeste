unit uConstantesController;

interface

uses  Vcl.Graphics,  System.SysUtils, Vcl.Forms,  Winapi.Windows, Winapi.IpTypes,
      System.UITypes,  System.Classes, FireDAC.Comp.Client;
var
  _PATH_SISTEMA  : String;
Const
  //--------------------------------------------------------------------
  // Estrutua Arquivo .INI
  //--------------------------------------------------------------------

  _ARQUIVO_INI        =  'db_config.ini';

  _SECAO_SERVIDOR     = 'servidor';
  _CHAVE_BASEDADOS    = 'basedados';
  _CHAVE_IP           = 'ip';
  _CHAVE_PORTA        = 'porta';
  _CHAVE_USUARIO      = 'usuario';
  _CHAVE_SENHA        = 'senha';


  _DB_BASEDADOS       = 'db_wkteste';
  _DB_SERVIDOR        = '127.0.0.1';
  _DB_PORTA           = 3306;
  _DB_USUARIO         = 'root';
  _DB_SENHA           = 'masterkey';
  _DB_VENDORLIB       = 'libmariadb.dll';
  _DB_DRIVER          = 'MYSQL';

implementation


end.
