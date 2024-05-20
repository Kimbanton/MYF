{  # < > | + - * / \ = ≠ √ π ← → ↑ ↓ ↖ ↗ ↘ ↙ ↔ ↕ ~ ^ °  }

unit GrocList;

  {$mode OBJFPC}
  {$H+}


interface


uses
  Classes, SysUtils, fpjson, jsonparser; //, Forms

type
  RGrocery =
    record
      barcode : Integer;
      cropName, cropType, brand, portionType : String;
      portionSize : Real;
      protein, fat, carb, sugar, salt, satFat, fibre, cal : Real;
    end;


var
  groc : RGrocery;
  jsonGroc : TJSONObject;
  jsonFile : Text;
  jsonString : String;
  jsonFileName : String;
  currentDir, fullPath : String;

implementation

BEGIN

END.

