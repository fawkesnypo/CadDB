unit consulta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TConsutaForm }

  TConsutaForm = class(TForm)
    BtnConsultar: TButton;
    CbbNome: TComboBox;
    EIdade: TEdit;
    ENascimento: TEdit;
    LIdade: TLabel;
    LNascimento: TLabel;
    LConsultar: TLabel;
    LNome: TLabel;
    Panel1: TPanel;
  private

  public

  end;

var
  ConsutaForm: TConsutaForm;

implementation

{$R *.lfm}

end.

