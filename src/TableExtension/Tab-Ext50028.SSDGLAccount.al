TableExtension 50028 "SSD G/L Account" extends "G/L Account"
{
    fields
    {
        modify(Blocked)
        {
            trigger OnBeforeValidate()
            begin
                IF Blocked = FALSE THEN BEGIN
                    UserSetup.GET(USERID);
                    IF NOT UserSetup."G/L UnBlock Rights" THEN ERROR(BlockErr);
                END;
            end;
        }
        field(50000; "Manufacturing Expenses"; Boolean)
        {
            Description = 'ALLE-AT 250121';
            DataClassification = CustomerContent;
            Caption = 'Manufacturing Expenses';
        }
        field(50001; "Budget Grouping"; Text[80])
        {
            TableRelation = "SSD Budget Grouping"."Budget Group Code" where("G/L Group Code" = field("G/L Group Code"));
            DataClassification = CustomerContent;
            Caption = 'Budget Grouping';
        }
        field(50002; "BS Grouping"; Code[50])
        {
            TableRelation = "SSD Budget Grouping"."BS Grouping Code" where("Budget Group Code" = field("Budget Grouping"));
            DataClassification = CustomerContent;
            Caption = 'BS Grouping';
        }
        field(50003; "Fixed/Var."; Option)
        {
            OptionMembers = " ","FIXED",VARIABLE;
            DataClassification = CustomerContent;
            Caption = 'Fixed/Var.';
        }
        field(50004; "G/L Group Code"; Code[50])
        {
            TableRelation = "SSD G/L Group Code"."G/L Group Code";
            DataClassification = CustomerContent;
            Caption = 'G/L Group Code';
        }
        field(50005; "Ignore Budget"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnAfterInsert()
    begin
        Blocked := true;
    end;

    var
        UserSetup: Record "User Setup";
        BlockErr: Label 'You cannot block/unblock G/L Account, Contact Administrator';
}
