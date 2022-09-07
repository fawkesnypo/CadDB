unit cadastro;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, SQLite3Conn,SQLite3Dyn, IBConnection, Forms, Controls,
  Graphics, Dialogs, Menus, ExtCtrls, StdCtrls, EditBtn, DBCtrls,dateutils;

type

  { TCadastroForm }

  TCadastroForm = class(TForm)
    BtnCadastrar: TButton;
    BtnLimpar: TButton;
    DateEdit1: TDateEdit;
    DBCnn: TSQLite3Connection;
    DBTr: TSQLTransaction;
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
    procedure BtnLimparClick(Sender: TObject);
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
  database:string;
begin
     CadastroForm.Deactivate();
     InitializeSqlite('sqlite3.dll');
     database := 'database.db';
     if not FileExists(database) then
        begin
          try
            DBCnn.DatabaseName:=database;
            DBCnn.Connected:=True;
            DBTr.DataBase:= DBCnn;
            DBTr.Active:=True;
            DBCnn.ExecuteDirect(
              'CREATE TABLE usuario (  '+
              '     id INTEGER PRIMARY KEY AUTOINCREMENT,'+
              '     nome VARCHAR (30),'+
              '     dtNascimento  DATE,'+
              '     idade INTEGER,'+
              '     sexo VARCHAR (1)'+
              ' ); '
            );

            DBTr.CommitRetaining;
          except
            ShowMessage('Não foi possível criar o database: '+ database);
          end
        end
     else
       DBCnn.DatabaseName:=database;
       DBCnn.Connected:=True;

     if (Length(ENome.Text) > 3) and (Length(DateEdit1.Text) > 6) and (Length(EIdade.Text) > 0) then
        begin
          if RadioButtonF.Checked then
             sexo := 'F'
          else
              sexo := 'M';

          DBTr.DataBase:= DBCnn;
          DBTr.Active:=True;
          DBCnn.ExecuteDirect(
          'INSERT INTO usuario(nome,dtNascimento,idade,sexo)'+
          'VALUES ('+QuotedStr(ENome.Text)+','+DateEdit1.Text+','+EIdade.Text+','+QuotedStr(sexo)+');'
          );

          DBTr.CommitRetaining;

          BtnLimparClick(Sender);
          ShowMessage('Cadastro realizado!')
        end
     else
         ShowMessage('É necessário preencher todos os campos');

     CadastroForm.Activate;
     DBCnn.Close();
end;

procedure TCadastroForm.BtnLimparClick(Sender: TObject);
begin
     ENome.Clear();
     DateEdit1.Clear();
     EIdade.Clear();
end;

end.

