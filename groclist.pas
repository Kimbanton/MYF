{  # < > | + - * / \ = ≠ √ π ← → ↑ ↓ ↖ ↗ ↘ ↙ ↔ ↕ ~ ^ °  }

unit GrocList;

  {$mode OBJFPC}
  {$H+}


interface


uses
  Classes, SysUtils, fpjson, jsonparser; //, Forms


var
  cropName, cropType, brand, portionType : String;
  portionSize, protein, fat, carb, sugar, salt, satFat, fibre, cal : Real;
  jsonGroc: TJSONObject;
  jsonFile, existingJsonFile: Text;
  jsonString, existingJsonString : String;
  existingJsonLine : String;
  outputPath : String;

implementation

BEGIN

END.

