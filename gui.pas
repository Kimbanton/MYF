{  # < > | + - * / \ = ≠ √ π ← → ↑ ↓ ↖ ↗ ↘ ↙ ↔ ↕ ~ ^ °  }

unit Gui;

  {$mode OBJFPC}
  {$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Menus, LCLType, NewNutrient, Profile; //, GrocList;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1 : TButton;
    Button2 : TButton;
    Button3 : TButton;
    Button4 : TButton;
    Button5 : TButton;
    Button6 : TButton;
    Button7 : TButton;
    Button8 : TButton;
    ListView1 : TListView;
    Panel1 : TPanel;
    Panel2 : TPanel;
    procedure Button1Click(Sender : TObject);
    procedure Button2Click(Sender : TObject);
    procedure Button3Click(Sender : TObject);
    procedure Button4Click(Sender : TObject);
    procedure Button5Click(Sender : TObject);
    procedure Button6Click(Sender : TObject);
    procedure Button7Click(Sender : TObject);
    procedure Button8Click(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure MenuItem1Click(Sender : TObject);
    procedure MenuItem2Click(Sender : TObject);
    procedure Panel1Click(Sender : TObject);
  private

  public

  end;

var
  Form1 : TForm1;

implementation

  {$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender : TObject);
  begin

  end;

procedure TForm1.MenuItem1Click(Sender : TObject);
begin

end;

procedure TForm1.MenuItem2Click(Sender : TObject);
begin

end;

procedure TForm1.Button1Click(Sender : TObject);
begin

end;

procedure TForm1.Button2Click(Sender : TObject);
begin

end;

procedure TForm1.Button3Click(Sender : TObject);
begin

end;

{ Button: "+ Nahrung"}
procedure TForm1.Button4Click(Sender : TObject);
begin
  GrocEntry.Show;
end;

procedure TForm1.Button5Click(Sender : TObject);
begin

end;

procedure TForm1.Button6Click(Sender : TObject);
begin

end;

procedure TForm1.Button7Click(Sender : TObject);
begin

end;

procedure TForm1.Button8Click(Sender : TObject);
begin

end;


procedure TForm1.Panel1Click(Sender : TObject);
begin

end;



END.

