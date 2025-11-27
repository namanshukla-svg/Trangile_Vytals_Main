Table 50127 "SSD Claims Staging"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; SeqID; Guid)
        {
            DataClassification = CustomerContent;
            Caption = 'SeqID';
        }
        field(3; "Company Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Company Name';
        }
        field(4; "Claims No."; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Claims No.';
        }
        field(5; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(6; "Claim Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Claim Date';
        }
        field(7; "Employee Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Code';
        }
        field(8; "Employee Dimension Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Dimension Code';
        }
        field(9; "Employee Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Name';
        }
        field(10; Department; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Department';
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(12; "Expense Type"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Expense Type';
        }
        field(13; "Expense Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Expense Amount';
        }
        field(14; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Success,Fail';
            OptionMembers = Open, Success, Fail;
            Caption = 'Status';
        }
        field(15; "Expense Category"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Expense Category';
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    var
        ClaimsStaging: Record "SSD Claims Staging";
    begin
        ClaimsStaging.Reset;
        if ClaimsStaging.FindLast then LastEntryNo:=ClaimsStaging."Entry No." + 1
        else
            LastEntryNo:=1;
        "Entry No.":=LastEntryNo;
        SeqID:=CreateGuid;
    end;
    var DimMgt: Codeunit DimensionManagement;
    LastEntryNo: Integer;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    end;
}
