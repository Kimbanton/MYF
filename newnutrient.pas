{  # < > | + - * / \ = ≠ √ π ← → ↑ ↓ ↖ ↗ ↘ ↙ ↔ ↕ ~ ^ °  }

unit NewNutrient;

  {$mode OBJFPC}
  {$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Profile, GrocList, fpjson, jsonparser;

type

  { TGrocEntry }

  TGrocEntry = class(TForm)

    PANEL_Groc : TPanel;
      LABEL_Barcode : TLabel;
      LABEL_GrocTitle : TLabel;
      LABEL_CropName : TLabel;
      LABEL_CropType : TLabel;
      LABEL_Brand : TLabel;
      LABEL_PortionType : TLabel;
      LABEL_PortionSize : TLabel;

      LABEL_MacroTitle : TLabel;
      LABEL_Protein : TLabel;
      LABEL_Fat : TLabel;
      LABEL_Carb : TLabel;
      LABEL_Cal : TLabel;
      LABEL_Sugar : TLabel;
      LABEL_Fibre : TLabel;
      LABEL_Salt : TLabel;
      LABEL_SatFat : TLabel;


    PANEL_Macro : TPanel;
      EDIT_Barcode : TEdit;
      EDIT_CropName : TEdit;
      EDIT_CropType : TEdit;
      EDIT_Brand : TEdit;
      EDIT_PortionType : TEdit;
      EDIT_PortionSize : TEdit;

      EDIT_Protein : TEdit;
      EDIT_Fat : TEdit;
      EDIT_Carb : TEdit;
      EDIT_Cal : TEdit;
      EDIT_Sugar : TEdit;
      EDIT_Salt : TEdit;
      EDIT_SatFat : TEdit;
      EDIT_Fibre : TEdit;

      PANEL_WhiteLine : TPanel;

    BUTTON_Add : TButton;

    {### PROCEDURES ###}
    procedure BUTTON_AddClick(Sender : TObject);
    procedure EDIT_ProteinChange(Sender : TObject);
    procedure EDIT_FatChange(Sender : TObject);
    procedure EDIT_CarbChange(Sender : TObject);
    procedure EDIT_CalChange(Sender : TObject);
    procedure EDIT_SugarChange(Sender : TObject);
    procedure EDIT_SaltChange(Sender : TObject);
    procedure EDIT_SatFatChange(Sender : TObject);
    procedure EDIT_FibreChange(Sender : TObject);
    procedure LABEL_BarcodeClick(Sender : TObject);
    procedure LABEL_FatClick(Sender : TObject);
    procedure LABEL_CarbClick(Sender : TObject);
    procedure LABEL_CalClick(Sender : TObject);
    procedure LABEL_MacroTitleClick( Sender : TObject);
    procedure LABEL_SugarClick(Sender : TObject);
    procedure LABEL_FibreClick(Sender : TObject);
    procedure LABEL_SaltClick(Sender : TObject);
    procedure LABEL_SatFatClick(Sender : TObject);
    procedure PANEL_WhiteLineClick(Sender : TObject);
    procedure PANEL_MacroClick(Sender : TObject);
    procedure PANEL_GrocClick(Sender : TObject);
    procedure EDIT_BarcodeChange(Sender : TObject);
    procedure EDIT_CropNameChange(Sender : TObject);
    procedure EDIT_CropTypeChange(Sender : TObject);
    procedure EDIT_BrandChange(Sender : TObject);
    procedure EDIT_PortionTypeChange(Sender : TObject);
    procedure EDIT_PortionSizeChange( Sender : TObject);
    procedure LABEL_CropNameClick(Sender : TObject);
    procedure LABEL_CropTypeClick(Sender : TObject);
    procedure LABEL_BrandClick(Sender : TObject);
    procedure LABEL_PortionTypeClick(Sender : TObject);
    procedure LABEL_PortionSizeClick(Sender : TObject);
    procedure LABEL_ProteinClick(Sender : TObject);

  private

  public

  end;

var
  GrocEntry : TGrocEntry;


implementation

  {$R *.lfm}


/////////////////////////////////////////////////////////////////////////////////////////
//#####################################################################################//
//#####################################################################################//
//#####################################################################################//
//###########################                               ###########################//
//###########################                               ###########################//
//###########################       SAVING PROCEDURES       ###########################//
//###########################                               ###########################//
//###########################                               ###########################//
//#####################################################################################//
//#####################################################################################//
//#####################################################################################//
/////////////////////////////////////////////////////////////////////////////////////////


{### reads input in the "Neue Nahrung" Window ###}
procedure readGrocEntry;
  begin
    groc.barcode := StrToIntDef(GrocEntry.EDIT_Barcode.Text, 0);
    groc.cropName := GrocEntry.EDIT_CropName.Text;
    groc.cropType := GrocEntry.EDIT_CropType.Text;
    groc.brand := GrocEntry.EDIT_Brand.Text;
    groc.portionType := GrocEntry.EDIT_PortionType.Text;
    groc.portionSize := StrToFloatDef(GrocEntry.EDIT_PortionSize.Text, 0.0);
    groc.protein := StrToFloatDef(GrocEntry.EDIT_Protein.Text, 0.0);
    groc.fat := StrToFloatDef(GrocEntry.EDIT_Fat.Text, 0.0);
    groc.carb := StrToFloatDef(GrocEntry.EDIT_Carb.Text, 0.0);
    groc.sugar := StrToFloatDef(GrocEntry.EDIT_Sugar.Text, 0.0);
    groc.salt := StrToFloatDef(GrocEntry.EDIT_Salt.Text, 0.0);
    groc.satFat := StrToFloatDef(GrocEntry.EDIT_SatFat.Text, 0.0);
    groc.fibre := StrToFloatDef(GrocEntry.EDIT_Fibre.Text, 0.0);
    groc.cal := StrToFloatDef(GrocEntry.EDIT_Cal.Text, 0.0);
  end;


{### adds grocery to JSON file ###}
procedure saveGroc;
  begin
    {### sets name of JSON file ###}
    jsonFileName := 'groclist.json';

    {### sets JSON file location to current directory ###}
    currentDir := extractfilepath(ParamStr(0));

    {### constructs full path to JSON file ###}
    fullPath := currentDir + jsonFileName;

    {### creates new JSON object, if file doesn't exist ###}
    jsonGroc := TJSONObject.create;

    {### adds new input data to JSON object ###}
    jsonGroc.add('barcode', groc.barcode);
    jsonGroc.add('cropName', groc.cropName);
    jsonGroc.add('cropType', groc.cropType);
    jsonGroc.add('brand', groc.brand);
    jsonGroc.add('portionType', groc.portionType);
    jsonGroc.add('portionSize', groc.portionSize);
    jsonGroc.add('protein', groc.protein);
    jsonGroc.add('fat', groc.fat);
    jsonGroc.add('carb', groc.carb);
    jsonGroc.add('sugar', groc.sugar);
    jsonGroc.add('salt', groc.salt);
    jsonGroc.add('satFat', groc.satFat);
    jsonGroc.add('fibre', groc.fibre);
    jsonGroc.add('cal', groc.cal);

    {### converts JSON object to string ###}
    jsonString := jsonGroc.FormatJSON;

    if fileexists(fullPath) //checks if 'profiles.json' already exists
      then
        begin
          {### saves input to existing JSON file ###}
          assign(jsonFile, fullPath);
          append(jsonFile); //starts writing at last line of JSON file
          write(jsonFile, jsonString); //writes all data to JSON file
          append(jsonFile);
          writeln(jsonFile, ''); //adds an empty line at end
          close(jsonFile);
        end
      else
        begin
          {### creates new JSON file ###}
          assign(jsonFile, fullPath);
          rewrite(jsonFile); //creates empty 'profiles.json' file
          append(jsonFile);
          write(jsonFile, jsonString);
          append(jsonFile);
          writeln(jsonFile, '');
          close(jsonFile);
        end;

    {### frees memory to prevent unnecessary memory leak ###}
    jsonGroc.free;
  end;

{### deletes the input of the EDIT-wigdets from "GrocEntry"}
procedure emptyGrocEntry;
  begin
    GrocEntry.EDIT_Barcode.Text := '';
    GrocEntry.EDIT_CropName.Text := '';
    GrocEntry.EDIT_CropType.Text := '';
    GrocEntry.EDIT_Brand.Text := '';
    GrocEntry.EDIT_PortionType.Text := '';
    GrocEntry.EDIT_PortionSize.Text := '';
    GrocEntry.EDIT_Protein.Text := '';
    GrocEntry.EDIT_Fat.Text := '';
    GrocEntry.EDIT_Carb.Text := '';
    GrocEntry.EDIT_Sugar.Text := '';
    GrocEntry.EDIT_Salt.Text := '';
    GrocEntry.EDIT_SatFat.Text := '';
    GrocEntry.EDIT_Fibre.Text := '';
    GrocEntry.EDIT_Cal.Text := '';
  end;

//////////////////////////////////////////////////////////////////////////
//######################################################################//
//######################################################################//
//####################                              ####################//
//####################     GRAPHICAL PROCEDURES     ####################//
//####################                              ####################//
//######################################################################//
//######################################################################//
//////////////////////////////////////////////////////////////////////////

{##### TGrocEntry #####}

//////////////////////////////////////////////////////////////////////
/////////////////////////////   PANELS   /////////////////////////////
//////////////////////////////////////////////////////////////////////


procedure TGrocEntry.PANEL_GrocClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.PANEL_MacroClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_FatClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.BUTTON_AddClick(Sender : TObject);
  begin
    readGrocEntry;
    saveGroc;
    GrocEntry.close; //closes the "GrocEntry" window
    emptyGrocEntry;
  end;


procedure TGrocEntry.LABEL_MacroTitleClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_ProteinChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_FatChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_CarbChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_CalChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_SugarChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_SaltChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_SatFatChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_FibreChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_CarbClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_CalClick(Sender : TObject);
  begin

  end;



procedure TGrocEntry.PANEL_WhiteLineClick(Sender : TObject);
  begin

  end;


//////////////////////////////////////////////////////////////////////
/////////////////////////////   LABELS   /////////////////////////////
//////////////////////////////////////////////////////////////////////


procedure TGrocEntry.LABEL_BarcodeClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_CropNameClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_CropTypeClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_BrandClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_PortionTypeClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_PortionSizeClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_ProteinClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_SugarClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_SaltClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_SatFatClick(Sender : TObject);
  begin

  end;


procedure TGrocEntry.LABEL_FibreClick(Sender : TObject);
  begin

  end;


/////////////////////////////////////////////////////////////////////
/////////////////////////////   EDITS   /////////////////////////////
/////////////////////////////////////////////////////////////////////

procedure TGrocEntry.EDIT_BarcodeChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_CropNameChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_CropTypeChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_BrandChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_PortionTypeChange(Sender : TObject);
  begin

  end;


procedure TGrocEntry.EDIT_PortionSizeChange(Sender : TObject);
  begin

  end;


END.

