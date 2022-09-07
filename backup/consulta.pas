unit consulta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,SQLDB, SQLite3Conn,SQLite3Dyn, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls;

type

  { TConsutaForm }

  TConsutaForm = class(TForm)
    CbbNome: TComboBox;
    DBCnn: TSQLite3Connection;
    DBTr: TSQLTransaction;
    ESexo: TEdit;
    EIdade: TEdit;
    ENascimento: TEdit;
    LSexo: TLabel;
    LIdade: TLabel;
    LNascimento: TLabel;
    LConsultar: TLabel;
    LNome: TLabel;
    Panel1: TPanel;
    procedure CbbNomeChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject);
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
       begin
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
end;

procedure TConsutaForm.FormClose(Sender: TObject);
begin
     ENascimento.Clear();
     EIdade.Clear();
     ESexo.Clear();
     CbbNome.Clear();
end;

procedure TConsutaForm.CbbNomeChange(Sender: TObject);
var
  database:string;
  query:TSQLQuery;
begin
     CbbNome.ReadOnly:=True;
     InitializeSqlite('sqlite3.dll');
     database := 'database.db';
     if not FileExists(database) then
        ShowMessage('A base de dados não foi encontrada!')
     else
       begin
         DBCnn.DatabaseName:=database;
         DBCnn.Connected:=True;

         query := TSQLQuery.Create(nil);
         query.SQL.Text:='SELECT dtNascimento,idade,sexo From usuario where nome ='+QuotedStr(CbbNome.Text)+';';
         query.DataBase := DBCnn;
         query.Open;

         ENascimento.Text:= query.FieldByName('dtNascimento');
         EIdade.Text:= query.FieldByName('idade').AsString;
         ESexo.Text:= query.FieldByName('sexo').AsString;

         query.Close();
         DBCnn.Close();
         CbbNome.ReadOnly:=False;
       end;
end;

end.

