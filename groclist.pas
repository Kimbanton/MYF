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
  outputPath : String;

implementation

BEGIN

END.

