{  # < > | + - * / \ = ≠ √ π ← → ↑ ↓ ↖ ↗ ↘ ↙ ↔ ↕ ~ ^ °  }

unit Profile;

  {$mode OBJFPC}
  {$H+}


interface


uses
  Classes, SysUtils, fpjson, jsonparser;


type
  TChar = array of Char;
  TString = array of String;
  TSingle = array of Single;
  TReal = array of Real;
  TDietGoal = (tKeep, tGain, tLoss);
  TRateOption = (tWeekRate, tMonthRate, tYearRate);
  TDurOption = (tDayDur, tWeekDur, tMonthDur, tYearDur);
  TWeekAct = (tLittle, tLight, tModerate, tHard, tExtreme);


const
  {### dropdown values ###}
  cWeekRate : TReal = (0.1, 0.2, 0.25, 0.3, 0.4, 0.5, 0.6, 0.7, 0.75, 0.8, 0.9, 1);
  cMonthRate : TReal = (0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4);
  cYearRate : TReal = (5, 10, 15, 20, 25, 30, 35, 40, 45);


var
  {### user-only ###}
  yourName : String;
  yourSex : String;
  yourAge : Integer;
  yourHeight, currentWeight, targetWeight, weightRate : Real;
  weekAct : TWeekAct;
  dietGoal : TDietGoal;
  rateOption : TRateOption;
  durOption : TDurOption;

  {### program-only ###}
  sex : Char;
  i : Integer;
  weightCondition, weekActOption, durUnit : String;
  bmi, initWeight, optWeight, weightDiff, bmr, cal, dailyCal : Real;
  weekLGDurFunction, monthLGDurFunction, yearLGDurFunction : Real;
  weekDurRaw, dayDur, weekDur, monthDur, yearDur, dur : Real;

  {### JSON-related ###}
  jsonString: String;
  jsonObject: TJSONObject; //creates JSON Object
  jsonFile: Text;
  jsonFileName : String;
  currentDir, fullPath : String;


implementation

{sets yourName}
procedure setYourName;
  begin
    write('Enter your name: ');
    readln(yourName);
  end;


{sets sex}
procedure setSex;
  begin
    write('Choose your sex (m/w): ');
    readln(yourSex);
    case yourSex of
      'm', 'M', 'male', 'Male', 'boy', 'Boy', 'man', 'Man': sex := 'm';
      'w', 'W', 'female', 'Female', 'girl', 'Girl', 'woman', 'Woman': sex := 'w';
      otherwise
        begin
          writeln('ERROR: Invalid sex!');
          setSex;
        end;
    end;
  end;


{sets yourAge}
procedure setYourAge;
  begin
    write('Enter your age: ');
    readln(yourAge);
    if yourAge <= 0
      then
        begin
          writeln('ERROR: Invalid age!');
          setYourAge;
        end;
  end;


{sets yourHeight}
procedure setYourHeight;
  begin
    write('Enter your height (cm): ');
    readln(yourHeight);
    if yourHeight <= 0
      then
        begin
          writeln('ERROR: Invalid height!');
          setYourHeight;
        end;
  end;


{sets currentWeight}
procedure setCurrentWeight;
  begin
    write('Enter your weight (kg): ');
    readln(currentWeight);
    if currentWeight <= 0
      then
        begin
          writeln('ERROR: Invalid weight!');
          setCurrentWeight;
        end;
  end;


{sets weekAct}
{procedure setWeekAct;
  begin
    //TWeekAct = (tLittle, tLight, tModerate, tHard, tExtreme);
    //('wenig (kaum beweglich)',
       'leicht (1-3 mal)',
       'mäßig (4-5 mal)',
       'stark (6-7 mal)',
       'extrem (täglich hart)')
    write('Select your weekly activity level: ');
    ...
    readln(weekAct);
    if weekAct ...
      then
        begin
          writeln('ERROR: Invalid activity!');
          setWeekAct;
        end;
  end;}


{sets targetWeight}
procedure setTargetWeight;
  begin
    write('Enter how much you wanna weigh (kg): ');
    readln(targetWeight);
    if targetWeight <= 0
      then
        begin
          writeln('ERROR: Invalid weight!');
          setTargetWeight;
  end;
  end;


{calculates bmi}
procedure CalcBmi;
  begin
    bmi := currentWeight / (yourHeight * yourHeight) * 10000;
  end;


{calculates optWeight}
procedure calcOptWeight;
  begin
    optWeight := 22 * yourHeight * yourHeight / 10000;
  end;


{calculates weightDiff}
procedure calcWeightDiff;
  begin
    if targetWeight = -1
      then weightDiff := currentWeight - optWeight
    else weightDiff := currentWeight - targetWeight;
    if weightDiff < 0
      then weightDiff := -weightDiff;
  end;


{sets weightCondition}
procedure setWeightCondition;
  begin
    if bmi >= 25
      then if bmi >= 40
        then weightCondition := 'fettleibig (Grad III)'
      else if bmi >= 35
        then weightCondition := 'fettleibig (Grad II)'
      else if bmi > 30
        then weightCondition := 'fettleibig (Grad I)'
      else weightCondition := 'übergewichtig'
    else if bmi < 18.5
      then if bmi < 16
        then weightCondition := 'stark untergewichtig'
      else if bmi < 17
        then weightCondition := 'mäßig untergewichtig'
      else weightCondition := 'leicht untergewichtig'
    else weightCondition := 'normalgewichtig';
  end;


{calculates weekLGDurFunction}
procedure calcWeekLGDurFunction(i : Integer);
  begin
    //readMenu(menu, i);
    weekLGDurFunction := weightDiff / cWeekRate[i]; //reads content from index of cWeekRate array
  end;


{calculates monthLGDurFunction}
procedure calcMonthLGDurFunction(i : Integer);
  begin
    //readMenu(menu, i);
    monthLGDurFunction := weightDiff / ((cWeekRate[i] / 7) * (365.25 / 12));
  end;


{calculates yearLGDurFunction}
procedure calcYearLGDurFunction(i : Integer);
  begin
    //readMenu(menu, i);
    yearLGDurFunction := weightDiff / ((cWeekRate[i] / 7) * 365.25);
  end;


{calculates weekDurRaw}
procedure calcWeekDurRaw;
  begin
    case rateOption of
      tWeekRate : weekDurRaw := weekLGDurFunction;
      tMonthRate : weekDurRaw := monthLGDurFunction;
      tYearRate : weekDurRaw := yearLGDurFunction;
      otherwise weekDurRaw := weekLGDurFunction;
    end;
  end;


{calculates duration in days}
procedure calcDayDur;
  begin
    dayDur := weekDurRaw * 7;
  end;


{calculates duration in weeks}
procedure calcWeekDur;
  begin
    weekDur := weekDurRaw;
  end;


{calculates duration in months}
procedure calcMonthDur;
  begin
    monthDur := weekDurRaw * (7 / (365.25 / 12));
  end;


{calculates duration in years}
procedure calcYearDur;
  begin
    yearDur := weekDurRaw * (7 / 365.25);
  end;


{calculates dur}
procedure calcDur;
  begin
    case durOption of
      tDayDur :
        begin
          calcDayDur;
          dur := round(dayDur);
          durUnit := 'day(s)'; //Tag(e)
        end;
      tWeekDur :
        begin
          calcWeekDur;
          dur := round(weekDur);
          durUnit := 'week(s)'; //Woche(n)
        end;
      tMonthDur :
        begin
          calcMonthDur;
          dur := round(monthDur);
          durUnit := 'month(s)'; //Monat(e)
        end;
      tYearDur :
        begin
          calcYearDur;
          dur := round(yearDur);
          durUnit := 'year(s)'; //Jahr(e)
        end;
      otherwise
        begin
          calcWeekDur;
          dur := round(weekDur);
          durUnit := 'week(s)';
        end;
    end;
  end;


{calculates bmr}
procedure calcBmr;
  begin
    case sex of
      'm' : bmr := 88.362 + (13.397 * currentWeight) + (4.799 * yourHeight) - (5.677 * yourAge);
      'w' : bmr := 447.593 + (9.247 * currentWeight) + (3.098 * yourHeight) - (4.33 * yourAge);
      otherwise bmr := 0;
    end;
  end;


{calculates cal}
procedure calcCal;
  begin
    case weekAct of
      tLittle : cal := bmr * 1.2;
      tLight : cal := bmr * 1.375;
      tModerate : cal := bmr * 1.55;
      tHard : cal := bmr * 1.725;
      tExtreme : cal := bmr * 1.9;
      otherwise cal := bmr * 1.2;
    end;
  end;


{calculates dailyCal}
procedure calcDailyCal;
  begin
    case rateOption of
      tWeekRate :  //(0.1, 0.2, 0.25, 0.3, 0.4, 0.5, 0.6, 0.7, 0.75, 0.8, 0.9, 1)
        begin
    case dietGoal of
      tKeep : dailyCal := cal;
      tLoss : dailyCal := cal - weightRate;
      tGain : dailyCal := cal + weightRate;
      otherwise dailyCal := cal;
    end;
  end;
      tMonthRate :  //(0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4)
        begin
    case dietGoal of
      tKeep : dailyCal := cal;
      tLoss : dailyCal := cal - ((weightRate / (365.25 / 12)) * 7);
      tGain : dailyCal := cal + ((weightRate / (365.25 / 12)) * 7);
      otherwise dailyCal := cal;
    end;
  end;
      tYearRate :  //(5, 10, 15, 20, 25, 30, 35, 40, 45)
  begin
    case dietGoal of
      tKeep : dailyCal := cal;
      tLoss : dailyCal := cal - ((weightRate / 365.25) * 7);
      tGain : dailyCal := cal + ((weightRate / 365.25) * 7);
      otherwise dailyCal := cal;
    end;
  end;
    end;
  end;

{### creates JSON with a user profile ###}
procedure createNewProfile;
begin
  {### sets name of JSON file ###}
  jsonFileName := 'profiles.json';

  {### sets JSON file location to current directory ###}
  currentDir := extractfilepath(ParamStr(0));

  {### constructs full path to JSON file ###}
  fullPath := currentDir + jsonFileName;

  {### creates JSON object ###}
  jsonObject := TJSONObject.create;

  {### adds new input data to JSON object ###}
  jsonObject.add('yourName', yourName);
  jsonObject.add('sex', sex);
  jsonObject.add('yourAge', yourAge);
  jsonObject.add('yourHeight', yourHeight);
  jsonObject.add('currentWeight', currentWeight);
  //jsonObject.add('weekAct', weekAct);
  //jsonObject.add('TDietGoal', TDietGoal);
  //jsonObject.add('TRateOption', TRateOption);
  jsonObject.add('targetWeight', targetWeight);
  jsonObject.add('weightCondition', weightCondition);
  jsonObject.add('bmi', bmi);
  jsonObject.add('optWeight', optWeight);
  jsonObject.add('dur', dur);
  jsonObject.add('durUnit', durUnit);
  jsonObject.add('cal', cal);
  jsonObject.add('dailyCal', dailyCal);

  {### converts JSON object to String ###}
  jsonString := jsonObject.FormatJSON;

  if fileexists(fullPath) //checks if 'profiles.json' already exists
    then
      begin
        {### saves input to existing JSON file ###}
        assign(jsonFile, fullPath);
        append(jsonFile); //starts writing at last line
        write(jsonFile, jsonString);
        append(jsonFile);
        writeln(jsonFile, ''); //empty extra line at end
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

  {### frees memory ###}
  jsonObject.free;
end;


/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
///////###########################################################################################///////
///////###########################################################################################///////
///////######################################               ######################################///////
///////######################################   EXECUTION   ######################################///////
///////######################################               ######################################///////
///////###########################################################################################///////
///////###########################################################################################///////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
  
{BEGIN
  {### gets user input ###}
  setYourName;
  setSex;
  setYourAge;
  setYourHeight;
  setCurrentWeight;
  //setWeekAct;
  setTargetWeight;
  setWeightCondition;

  {### calculates other profile results ###}
  CalcBmi;
  calcOptWeight;
  calcDur;
  calcBmr;
  calcCal;
  calcDailyCal;
  createNewProfile;

  {### outputs user profiles ###}
  writeln('.');
  writeln('.');
  writeln('.');
  writeln('||||==========================================================');
  writeln('||||==========================================================');
  writeln('||||==========================================================');
  writeln('||||==========================================================');
  writeln('|||| Name: ', yourName);
  writeln('|||| Geschlecht: ', sex);
  writeln('|||| Alter: ', formatfloat('0', yourAge));
  writeln('|||| Größe: ', formatfloat('0', yourHeight), ' cm');
  writeln('|||| Gewicht: ', formatfloat('0.0', currentWeight), ' kg');
  //writeln('|||| Wochenaktivität: ', weekActOption);
  //writeln('|||| Diätziel: ', dietGoal); #keep/gain/loss
  //writeln('|||| Diätrate in Wochen/Monaten/Jahren:', TRateOption);
  writeln('|||| Zielgewicht: ', formatfloat('0.0', targetWeight), ' kg');
  writeln('||||==========================================================');
  writeln('||||==========================================================');
  writeln('|||| Gewichtszustand: ', weightCondition);
  writeln('|||| Körper-Masse-Index: ', formatfloat('0.00', bmi));
  writeln('|||| Optimalgewicht: ', formatfloat('0.0', optWeight), ' kg');
  writeln('|||| Diätdauer: ', formatfloat('0.0', dur), ' ', durUnit);
  writeln('|||| Täglicher Kalorienbedarf: ', formatfloat('0', dailyCal), ' kcal');
  writeln('||||==========================================================');
  writeln('||||==========================================================');
  writeln('||||==========================================================');
  writeln('||||==========================================================');
  writeln('.');
  writeln('.');
  writeln('.');

END.}
END.
