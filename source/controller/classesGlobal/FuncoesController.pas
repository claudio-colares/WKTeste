unit FuncoesController;

interface

uses System.SysUtils, System.Classes, vcl.ComStrs, vcl.ExtCtrls, vcl.Buttons, vcl.Controls;

procedure ExibirBotaoPesquisa(ButtonedEdit: TButtonedEdit);

implementation

procedure ExibirBotaoPesquisa(ButtonedEdit: TButtonedEdit);
begin
  if ButtonedEdit.Text = '' then
    ButtonedEdit.RightButton.Visible := True
  else
    ButtonedEdit.RightButton.Visible := False;
end;

end.
