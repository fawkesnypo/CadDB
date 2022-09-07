unit utils;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,SQLite3Conn,SQLDB;

type
  {TUtils}

  TUtils = class(TProcedure)
    procedure CreateConn(DBCnn:TSQLite3Connection);

implementation

procedure CreateConn(DBCnn:TSQLite3Connection)
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
              '     dtNascimento  DATE,'+
              '     idade INTEGER '+
              '     sexo VARCHAR (1)'+
              ' ); '
            );

            DBTr.CommitRetaining;
          except
            ShowMessage('Não foi possível criar o database: '+ database);
          end;
        end;
end;

end.

