Codeunit 50015 "Single CU"
{
    SingleInstance = true;

    trigger OnRun()
    begin
        if not StoreToTemp then begin
            StoreToTemp:=true;
        end
        else
            Page.RunModal(0, TempGLEntry);
    end;
    var TempGLEntry: Record "G/L Entry" temporary;
    StoreToTemp: Boolean;
    procedure InsertGL(GLEntry: Record "G/L Entry")
    begin
        if StoreToTemp then begin
            TempGLEntry:=GLEntry;
            if not TempGLEntry.Insert then begin
                TempGLEntry.DeleteAll;
                TempGLEntry.Insert;
            end;
        end;
    end;
}
