unit FuncoesController;

interface

uses System.SysUtils, System.Classes, vcl.ComStrs, vcl.ExtCtrls, vcl.Buttons, vcl.Controls, uConstantesController;

procedure ExibirBotaoPesquisa(ButtonedEdit: TButtonedEdit);
procedure SetConstantes;

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
 _PATH_SISTEMA :=  ExtractFilePath(ParamStr(0));
end;

end.
