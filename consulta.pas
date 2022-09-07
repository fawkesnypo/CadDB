unit consulta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,SQLDB, SQLite3Conn,SQLite3Dyn, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls;

type

  { TConsutaForm }

  TConsutaForm = class(TForm)
    BtnConsultar: TButton;
    CbbNome: TComboBox;
    DBCnn: TSQLite3Connection;
    DBTr: TSQLTransaction;
    EIdade: TEdit;
    ENascimento: TEdit;
    LIdade: TLabel;
    LNascimento: TLabel;
    LConsultar: TLabel;
    LNome: TLabel;
    Panel1: TPanel;
    procedure FormActivate(Sender: TObject);
  private

  public

  end;

var
  ConsutaForm: TConsutaForm;

implementation

{$R *.lfm}

{ TConsutaForm }

procedure TConsutaForm.FormActivate(Sender: TObject);
var
  database:string;
  query:TSQLQuery;
begin
     InitializeSqlite('sqlite3.dll');
     database := 'database.db';
     if not FileExists(database) then
        ShowMessage('A base de dados não foi encontrada!')
     else
       DBCnn.DatabaseName:=database;
       DBCnn.Connected:=True;

     query := TSQLQuery.Create(nil);
     query.SQL.Text:='SELECT nome From usuario;';
     query.DataBase := DBCnn;
     query.Open;

     while not query.EOF do
     begin
       if CbbNome.Items.IndexOf(query.FieldByName('nome').AsString) = -1 then
          CbbNome.Items.Add(query.FieldByName('nome').AsString);
       query.Next();
     end;
     query.Close();
     DBCnn.Close();
end;

end.

