table 50137 "SSD Update Sales Invoice Heade"
{
    Caption = 'Update Sales Invoice Heade';
    DataClassification = ToBeClassified;

    fields
    {
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "Sales Invoice Header";
        }
        field(6; "Firm Freight"; Code[5])
        {
            Caption = 'Firm Freight';
        }
        field(7; "Calculated Freight Amount"; Decimal)
        {
            Caption = 'Calculated Freight Amount';
        }
        field(8; "Fright Amount"; Decimal)
        {
            Caption = 'Fright Amount';
        }
        field(9; "Sales Person Code"; Code[20])
        {
            Caption = 'Sales Person Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(10; "Shipping Agent Code"; Code[20])
        {
            Caption = 'Shipping Agent Code';
        }
        field(11; "LR/RR No."; Code[20])
        {
            Caption = 'LR/RR No.';
        }
        field(12; "LR/RR Date"; Date)
        {
            Caption = 'LR/RR Date';
        }
        field(13; "Dispatch Mail Send"; Code[5])
        {
            Caption = 'Dispatch Mail Send';
        }
        field(14; "Mail Send Dispatch Detail"; Code[5])
        {
            Caption = 'Mail Send Dispatch Detail';
        }
        field(15; "Send Mail with COA"; Code[5])
        {
            Caption = 'Send Mail with COA';
        }
        field(16; "Send Mail Again without COA"; Code[5])
        {
            Caption = 'Send Mail Again without COA';
        }
        field(17; "Send Mail Again with COA"; Code[5])
        {
            Caption = 'Send Mail Again with COA';
        }
        field(18; "Actual Delivery Date"; Date)
        {
            Description = 'Alle-MS';
            DataClassification = CustomerContent;
            Caption = 'Actual Delivery Date';
            Editable = true;

            trigger OnValidate()
            begin
                if not ("Actual Delivery Date" >= "LR/RR Date") then Error('Actual Delivery date always greater than LR/RR date');
            end;
        }
        field(19; "Remarks1"; Text[50])
        {
            Caption = 'Remarks';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        CheckUser();
    end;

    trigger OnModify()
    begin
        CheckUser();
    end;

    trigger OnDelete()
    begin
        CheckUser();
    end;

    procedure CheckUser()
    var
        UserSetup: Record "User Setup";
        TextError: Label 'You do not have a permission.';
    begin
        UserSetup.Get(UserId);
        If not UserSetup."Sepecial Permission" then Error(TextError);
    end;
}
