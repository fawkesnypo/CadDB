unit cadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  StdCtrls, EditBtn;

type

  { TCadastroForm }

  TCadastroForm = class(TForm)
    DateEdit1: TDateEdit;
    EIdade: TEdit;
    ENome: TEdit;
    LIdade: TLabel;
    LNascimento: TLabel;
    LNome: TLabel;
    LCadastro: TLabel;
    Panel1: TPanel;
    RadioButtonF: TRadioButton;
    RadioButtonM: TRadioButton;
    RadioGroup1: TRadioGroup;
  private

  public

  end;

var
  CadastroForm: TCadastroForm;

implementation

{$R *.lfm}

end.

