//  # < > | + - * / \ = ≠ √ π ← → ↑ ↓ ↖ ↗ ↘ ↙ ↔ ↕ ~ ^ °

program CalorieTracker;

  {$mode OBJFPC}
  {$H+}

uses
  {$IFDEF UNIX}
    cthreads,
  {$ENDIF}

  {$IFDEF HASAMIGA}
    athreads,
  {$ENDIF}

  Interfaces, Forms, Gui, NewNutrient, Profile, GrocList;


  {$R *.res}

BEGIN
  RequireDerivedFormResource := True;
  Application. Title :='CalorieTracker';
  Application. Scaled := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TGrocEntry, GrocEntry);
  Application.Run;
END.

