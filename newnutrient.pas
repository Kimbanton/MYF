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
      LABEL_GrocTitle : TLabel;
      LABEL_CropName : TLabel;
      LABEL_CropType : TLabel;
      LABEL_Brand : TLabel;
      LABEL_PortionType : TLabel;
      LABEL_PortionSize : TLabel;
      EDIT_CropName : TEdit;
      EDIT_CropType : TEdit;
      EDIT_Brand : TEdit;
      EDIT_PortionType : TEdit;
      EDIT_PortionSize : TEdit;
    PANEL_Macro : TPanel;
      LABEL_MacroTitle : TLabel;
      LABEL_Protein : TLabel;
      LABEL_Fat : TLabel;
      LABEL_Carb : TLabel;
      LABEL_Cal : TLabel;
      LABEL_Sugar : TLabel;
      LABEL_Fibre : TLabel;
      LABEL_Salt : TLabel;
      LABEL_SatFat : TLabel;
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
    cropName := GrocEntry.EDIT_CropName.Text;
    cropType := GrocEntry.EDIT_CropType.Text;
    brand := GrocEntry.EDIT_Brand.Text;
    portionType := GrocEntry.EDIT_PortionType.Text;
    portionSize := StrToFloatDef(GrocEntry.EDIT_PortionSize.Text, 0.0);
    protein := StrToFloatDef(GrocEntry.EDIT_Protein.Text, 0.0);
    fat := StrToFloatDef(GrocEntry.EDIT_Fat.Text, 0.0);
    carb := StrToFloatDef(GrocEntry.EDIT_Carb.Text, 0.0);
    sugar := StrToFloatDef(GrocEntry.EDIT_Sugar.Text, 0.0);
    salt := StrToFloatDef(GrocEntry.EDIT_Salt.Text, 0.0);
    satFat := StrToFloatDef(GrocEntry.EDIT_SatFat.Text, 0.0);
    fibre := StrToFloatDef(GrocEntry.EDIT_Fibre.Text, 0.0);
    cal := StrToFloatDef(GrocEntry.EDIT_Cal.Text, 0.0);
  end;


{### adds grocery to JSON file ###}
procedure saveGroc;
  begin
    {sets JSON file location to current directory}
    outputPath := ExtractFilePath(ParamStr(0));

    {appends "groclist" folder as source code's directory path}
    outputPath := IncludeTrailingPathDelimiter(outputPath) + 'groclist' + PathDelim;

    {ensures the 'groclist' folder exists, creates it if it doesn't}
    if not DirectoryExists(outputPath)
      then CreateDir(outputPath);

    {checks if the JSON file already exists}
    if FileExists(outputPath + 'groclist.json')
      then
        begin
          {reads existing JSON data}
          assign(existingJsonFile, outputPath + 'groclist.json');
          reset(existingJsonFile);
          while not Eof(existingJsonFile) do
            readln(existingJsonFile, existingJsonLine);
            existingJsonString := existingJsonString + existingJsonLine;
          close(existingJsonFile);

          {parses existing JSON data}
          jsonGroc := TJSONObject(GetJSON(existingJsonString));
        end
      else
        begin
          {creates new JSON object, if file doesn't exist}
          jsonGroc := TJSONObject.create;
        end;

    {adds new input data to existing JSON object}
    jsonGroc.Add('cropName', cropName);
    jsonGroc.Add('cropType', cropType);
    jsonGroc.Add('brand', brand);
    jsonGroc.Add('portionType', portionType);
    jsonGroc.Add('portionSize', portionSize);
    jsonGroc.Add('protein', protein);
    jsonGroc.Add('fat', fat);
    jsonGroc.Add('carb', carb);
    jsonGroc.Add('sugar', sugar);
    jsonGroc.Add('salt', salt);
    jsonGroc.Add('satFat', satFat);
    jsonGroc.Add('fibre', fibre);
    jsonGroc.Add('cal', cal);

    {converts JSON object to string}
    jsonString := jsonGroc.FormatJSON;

    {saves JSON string to file}
    assign(jsonFile, outputPath + 'groclist.json');
    rewrite(jsonFile);
    write(jsonFile, jsonString);
    close(jsonFile);

    {frees memory}
    jsonGroc.Free;
  end;


//////////////////////////////////////////////////////////////////////
//##################################################################//
//##################################################################//
//####################                          ####################//
//####################   GRAPHICAL PROCEDURES   ####################//
//####################                          ####################//
//##################################################################//
//##################################################################//
//////////////////////////////////////////////////////////////////////

{##### TGrocEntry #####}

//////////////////////////////////////////////////
////////////////////  PANELS  ////////////////////
//////////////////////////////////////////////////



procedure TGrocEntry.PANEL_GrocClick(Sender : TObject);
begin

end;


procedure TGrocEntry.PANEL_MacroClick(Sender : TObject);
begin

end;

procedure TGrocEntry.LABEL_FatClick(Sender : TObject);
begin

end;

procedure TGrocEntry.EDIT_ProteinChange(Sender : TObject);
begin

end;

procedure TGrocEntry.BUTTON_AddClick(Sender : TObject);
begin
  readGrocEntry;
  saveGroc;
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

procedure TGrocEntry.LABEL_MacroTitleClick(Sender : TObject);
begin

end;

procedure TGrocEntry.LABEL_SugarClick(Sender : TObject);
begin

end;

procedure TGrocEntry.LABEL_FibreClick(Sender : TObject);
begin

end;

procedure TGrocEntry.LABEL_SaltClick(Sender : TObject);
begin

end;

procedure TGrocEntry.LABEL_SatFatClick(Sender : TObject);
begin

end;

procedure TGrocEntry.PANEL_WhiteLineClick(Sender : TObject);
begin

end;


//////////////////////////////////////////////////
///////////((///////  LABELS  ////////////////////
//////////////////////////////////////////////////


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


///////////////////////////////////////////////////
/////////////////////  EDITS  /////////////////////
///////////////////////////////////////////////////


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



end.

