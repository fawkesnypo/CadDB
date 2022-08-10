unit cadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, sqlite3conn, IBConnection, Forms, Controls,
  Graphics, Dialogs, Menus, ExtCtrls, StdCtrls, EditBtn, DBCtrls,dateutils;

type

  { TCadastroForm }

  TCadastroForm = class(TForm)
    BtnCadastrar: TButton;
    BtnLimpar: TButton;
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
    procedure BtnCadastrarClick(Sender: TObject);
    procedure DateEdit1Exit(Sender: TObject);
  private

  public

  end;

var
  CadastroForm: TCadastroForm;

implementation

{$R *.lfm}

{ TCadastroForm }

procedure TCadastroForm.DateEdit1Exit(Sender: TObject);
begin
       EIdade.Text:=Trunc(dateutils.YearsBetween(Now,DateEdit1.Date)).toString;
end;

procedure TCadastroForm.BtnCadastrarClick(Sender: TObject);
begin

     if (ENome.GetTextLen() > 3) and (DateEdit1.GetTextLen() > 6) and (EIdade.GetTextLen() > 0) and (RadioButtonF.IsEnabled or RadioButtonM.IsEnabled) then

        //main.TMainForm.DBCnn.ExecuteDirect(
        //'INSERT INTO usuario(nome,dtNascimento,idade,sexo)'+
        //'VALUES('+
        //);

        ShowMessage('Okay')
     else
         ShowMessage('É necessário preencher todos os campos');
end;


end.

