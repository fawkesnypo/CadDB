unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, cadastro,
  consulta, SQLite3Conn, SQLDB,SQLite3Dyn;

type

  { TMainForm }

  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
  private

  public
    DBCnn: TSQLite3Connection;
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

procedure TMainForm.MenuItem3Click(Sender: TObject);
begin
     if consulta.ConsutaForm.Showing then
        consulta.ConsutaForm.SetFocus
     else consulta.ConsutaForm.Show();
end;

end.

