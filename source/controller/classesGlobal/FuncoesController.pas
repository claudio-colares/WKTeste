unit FuncoesController;

interface

uses System.SysUtils, System.Classes, vcl.ComStrs, vcl.ExtCtrls, vcl.Buttons, vcl.Controls, uConstantesController,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Param, FPredidoVenda;

procedure ExibirBotaoPesquisa(ButtonedEdit: TButtonedEdit);
procedure SetConstantes;
procedure QueryCriar(var aQuery: TFDQuery; aConexao: TFDConnection = nil);
procedure QueryLiberar(var aQuery: TFDQuery);

implementation

procedure ExibirBotaoPesquisa(ButtonedEdit: TButtonedEdit);
begin
  if ButtonedEdit.Text = '' then
    ButtonedEdit.RightButton.Visible := True
  else
    ButtonedEdit.RightButton.Visible := False;
end;

procedure SetConstantes;
begin
  _PATH_SISTEMA := ExtractFilePath(ParamStr(0));
end;

procedure QueryCriar(var aQuery: TFDQuery; aConexao: TFDConnection = nil);
begin
  try
    aQuery      := TFDQuery.Create(nil);
    aQuery.Name := '_FDQuery_' + (aQuery.GetHashCode).ToString;
    aQuery.DisableControls;
    aQuery.SQL.Clear;
    aQuery.Connection := FrmPedidoVenda.DBConexao;
    if aConexao <> Nil then
      aQuery.Connection := aConexao;
  except
    raise;
  end;
end;

procedure QueryLiberar(var aQuery: TFDQuery);
begin
  if aQuery = nil then
    Exit;

  aQuery.Close;
  FreeAndNil(aQuery);
end;

end.
