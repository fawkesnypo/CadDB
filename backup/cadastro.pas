unit cadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLite3Conn, IBConnection, Forms, Controls,
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
    procedure DateEdit1Change(Sender: TObject);

  private

  public

  end;

var
  CadastroForm: TCadastroForm;

implementation

{$R *.lfm}

{ TCadastroForm }

procedure TCadastroForm.DateEdit1Change(Sender: TObject);
begin
  EIdade.Text:=Trunc(dateutils.YearsBetween(Now,DateEdit1.Date)).toString;
end;

procedure TCadastroForm.BtnCadastrarClick(Sender: TObject);
var
  sexo:string;
begin

     if (Length(ENome.Text) > 3) and (Length(DateEdit1.Text) > 6) and (Length(EIdade.Text) > 0) then
        begin
          if RadioButtonF.IsEnabled then
             sexo := 'F'
          else
              sexo := 'M';
          //DBCnm.ExecuteDirect(
          //'INSERT INTO usuario(nome,dtNascimento,idade,sexo)'+
          //'VALUES('+ ENome.Text+','+DateEdit1.Text+','+EIdade.Text+','+ sexo
          //);

          ShowMessage('Okay')
        end
     else
         ShowMessage('É necessário preencher todos os campos');
end;


end.

