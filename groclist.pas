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
  jsonFile: Text;
  jsonString: String;
  jsonFileName : String;
  currentDir, fullPath : String;

implementation

BEGIN

END.

