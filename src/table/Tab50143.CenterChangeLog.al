table 50143 "Center Change Log"
{
    Caption = 'Machine Center/Work Center Change Log List';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Center Change Log List";
    LookupPageId = "Center Change Log List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Center Type"; Enum "Center Type Enum")
        {
            Caption = 'Center Type';
            DataClassification = ToBeClassified;
        }
        field(3; "Center No."; Code[20])
        {
            Caption = 'Center No.';
            TableRelation = if ("Center Type" = const("Work Center")) "Work Center"
            else
            if ("Center Type" = const("Machine Center")) "Machine Center";
            DataClassification = ToBeClassified;
        }
        field(4; "Center Name"; Text[100])
        {
            Caption = 'Center Name';
            DataClassification = ToBeClassified;
        }
        field(5; Action; Enum "Center Block Action Enum")
        {
            Caption = 'Action';
            DataClassification = ToBeClassified;
        }
        field(6; "Effective Date-Time"; DateTime)
        {
            Caption = 'Effective Date-Time';
            DataClassification = ToBeClassified;
        }
        field(7; "Changed By"; Code[50])
        {
            Caption = 'Changed By';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(PK2; "Center Type", "Center No.")
        {
        }
    }
    trigger OnInsert()
    var
        LastLog: Record "Center Change Log";
    begin
        if "Entry No." = 0 then begin
            if LastLog.FindLast() then
                "Entry No." := LastLog."Entry No." + 1
            else
                "Entry No." := 1;
        end;
    end;
}

