codeunit 50033 "SSD Single Instance"
{
    SingleInstance = true;

    procedure SetValues(Vraince: Enum "SSD Variance Cause"; RMKS: Text[100])
    begin
        NewVariance:=Vraince;
        NewRemarks:=RMKS;
    end;
    procedure GetValues(var Vraince: Enum "SSD Variance Cause"; Var RMKS: Text[100])
    begin
        Vraince:=NewVariance;
        RMKS:=NewRemarks;
    end;
    procedure SetCode(Vraince: Enum "SSD Variance Cause")
    begin
        NewVariance:=Vraince;
    end;
    procedure SetCode(Var RMKS: Text[100])
    begin
        NewRemarks:=RMKS;
    end;
    var NewVariance: Enum "SSD Variance Cause";
    NewRemarks: text[100];
}
