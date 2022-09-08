unit editar;

{$mode ObjFPC}{$H+}

interface

uses
    Classes, SysUtils, SQLDB, SQLite3Conn,SQLite3Dyn, IBConnection, Forms, Controls,
    Graphics, Dialogs, Menus, ExtCtrls, StdCtrls, EditBtn, DBCtrls,dateutils;

type

  { TEditarRegistros }

  TEditarRegistros = class(TForm)
    BtnEditar: TButton;
    BtnDeletar: TButton;
    BtnSalvar: TButton;
    BtnCancelar: TButton;
    CbbNome: TComboBox;
    DateEdit1: TDateEdit;
    DBCnn: TSQLite3Connection;
    DBTr: TSQLTransaction;
    EIdade: TEdit;
    LEditar: TLabel;
    LIdade: TLabel;
    LNascimento: TLabel;
    LNome1: TLabel;
    Panel1: TPanel;
    RadioButtonF: TRadioButton;
    RadioButtonM: TRadioButton;
    RadioGroup1: TRadioGroup;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnDeletarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure CbbNomeChange(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject);
    procedure ActivateFields();
    procedure DeactivateFields();
  private

  public

  end;

var
  EditarRegistros: TEditarRegistros;

implementation

{$R *.lfm}

{ TEditarRegistros }

procedure TEditarRegistros.FormActivate(Sender: TObject);
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

procedure TEditarRegistros.FormClose(Sender: TObject);
begin
     DateEdit1.Clear();
     EIdade.Clear();
     CbbNome.Clear();
     BtnEditar.Enabled:=False;
     BtnSalvar.Enabled:=False;
     BtnDeletar.Enabled:=False;
end;

procedure TEditarRegistros.ActivateFields;
begin
     BtnSalvar.Enabled:=True;
     BtnEditar.Enabled:=False;
     BtnDeletar.Enabled:=False;
     BtnCancelar.Visible:=True;
     BtnCancelar.Enabled:=True;
     RadioGroup1.Enabled:=True;
     DateEdit1.ReadOnly:=False;
end;

procedure TEditarRegistros.DeactivateFields;
begin
     BtnSalvar.Enabled:=False;
     BtnEditar.Enabled:=True;
     BtnDeletar.Enabled:=True;
     BtnCancelar.Visible:=False;
     BtnCancelar.Enabled:=False;
     RadioGroup1.Enabled:=False;
     DateEdit1.ReadOnly:=True;
end;

procedure TEditarRegistros.CbbNomeChange(Sender: TObject);
var
  database,sexo:string;
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
         query.SQL.Text:='SELECT dtNascimento,idade,sexo FROM usuario WHERE nome ='+QuotedStr(CbbNome.Text)+';';
         query.DataBase := DBCnn;
         query.Open;

         DateEdit1.Text:= query.FieldByName('dtNascimento').AsString;
         EIdade.Text:= query.FieldByName('idade').AsString;
         sexo:= query.FieldByName('sexo').AsString;

         if sexo.Contains('F') then
            RadioButtonF.Checked:=True
         else
           RadioButtonM.Checked:=True;

         query.Close();
         DBCnn.Close();
         CbbNome.ReadOnly:=False;
         BtnEditar.Enabled:=True;
         BtnDeletar.Enabled:=True;
       end;
end;

procedure TEditarRegistros.DateEdit1Change(Sender: TObject);
begin
     if Now < DateEdit1.Date then
        begin
          DateEdit1.Clear();
          ShowMessage('A data de nascimento não pode ser uma data futura!');
        end
     else
         EIdade.Text:=Trunc(dateutils.YearsBetween(Now,DateEdit1.Date)).toString;
end;

procedure TEditarRegistros.BtnEditarClick(Sender: TObject);
begin
     ActivateFields();
end;

procedure TEditarRegistros.BtnCancelarClick(Sender: TObject);
begin
     DeactivateFields();
end;

procedure TEditarRegistros.BtnDeletarClick(Sender: TObject);
var
   database,nome:string;
begin
   CbbNome.ReadOnly:=True;
   InitializeSqlite('sqlite3.dll');
   database := 'database.db';
   if not FileExists(database) then
      ShowMessage('A base de dados não foi encontrada!')
   else
     begin
       nome := CbbNome.Text;

       DBCnn.DatabaseName:=database;
       DBCnn.Connected:=True;
       DBTr.DataBase:= DBCnn;
       DBTr.Active:=True;
       DBCnn.ExecuteDirect('DELETE FROM usuario WHERE nome ='+QuotedStr(nome)+';');
       DBTr.CommitRetaining;

       ShowMessage('Registro Deletado!');
       DBCnn.Close();

       CbbNome.ReadOnly:=False;
       CbbNome.Item.Delete(CbbNome.Items.IndexOf(nome));
       CbbNome.Text:='';
       DateEdit1.Clear();
       EIdade.Clear();
       BtnDeletar.Enabled:=False;
       BtnEditar.Enabled:=False;
     end;
end;

procedure TEditarRegistros.BtnSalvarClick(Sender: TObject);
var
  database,sexo:string;
begin
     EditarRegistros.Deactivate();
     InitializeSqlite('sqlite3.dll');
     database := 'database.db';
     if not FileExists(database) then
        ShowMessage('A base de dados não foi encontrada!')
     else
       DBCnn.DatabaseName:=database;
       DBCnn.Connected:=True;

       if (Length(DateEdit1.Text) > 6) and (Length(EIdade.Text) > 0) then
          begin
            if RadioButtonF.Checked then
               sexo := 'F'
            else
                sexo := 'M';

            DBTr.DataBase:= DBCnn;
            DBTr.Active:=True;
            DBCnn.ExecuteDirect('UPDATE usuario '+'SET dtNascimento='+QuotedStr(DateEdit1.Text)+','+'idade='+EIdade.Text+','+'sexo='+QuotedStr(sexo)+' WHERE nome = '+QuotedStr(CbbNome.Text)+';');

            DBTr.CommitRetaining;

            ShowMessage('Atualização realizada!')
          end
       else
         ShowMessage('É necessário preencher todos os campos');

     EditarRegistros.Activate();
     DeactivateFields();
     DBCnn.Close();
end;

end.

