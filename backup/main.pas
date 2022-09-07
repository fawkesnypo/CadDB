unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, cadastro,
  consulta,SQLDB, SQLite3Conn,SQLite3Dyn;

type

  { TMainForm }

  TMainForm = class(TForm)
    DBTr: TSQLTransaction;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
  private

  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.MenuItem2Click(Sender: TObject);
begin
     if cadastro.CadastroForm.Showing then
        cadastro.CadastroForm.SetFocus
     else cadastro.CadastroForm.Show();
end;

procedure TMainForm.FormActivate(Sender: TObject);
var
  database:string;
begin
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
              '     dtNascimento  VARCHAR(30),'+
              '     idade INTEGER,'+
              '     sexo VARCHAR (1)'+
              ' ); '
            );

            DBTr.CommitRetaining;
          except
            ShowMessage('Não foi possível criar o database: '+ database);
          end
        end;
end;

procedure TMainForm.MenuItem3Click(Sender: TObject);
begin
     if consulta.ConsutaForm.Showing then
        consulta.ConsutaForm.SetFocus
     else consulta.ConsutaForm.Show();
end;

end.

