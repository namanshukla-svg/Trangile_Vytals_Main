Table 50077 "SSD Amazon Staging"
{
    // Alle-[Amazon-HG]-Created a new table for Amazon SI Integration
    DrillDownPageID = "Amazon Staging List";
    LookupPageID = "Amazon Staging List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Guid)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Amazon OrderId"; Code[35])
        {
            Caption = 'Amazon OrderId';
            DataClassification = CustomerContent;
        }
        field(3; "Amazon Posted Invoice No."; Code[20])
        {
            Editable = true;
            Caption = 'Amazon Posted Invoice No.';
            DataClassification = CustomerContent;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(5; "ZD Customer Code"; Code[20])
        {
            Caption = 'ZD Customer Code';
            DataClassification = CustomerContent;
        }
        field(6; "End Customer Name"; Text[250])
        {
            Caption = 'End Customer Name';
            DataClassification = CustomerContent;
        }
        field(7; "End Customer Name Address"; Text[250])
        {
            Caption = 'End Customer Name Address';
            DataClassification = CustomerContent;
        }
        field(8; "ZD FG Code"; Code[20])
        {
            Caption = 'ZD FG Code';
            DataClassification = CustomerContent;
        }
        field(9; SKU; Code[10])
        {
            Caption = 'SKU';
            DataClassification = CustomerContent;
        }
        field(10; "Quantity Shipped"; Decimal)
        {
            Caption = 'Quantity Shipped';
            DataClassification = CustomerContent;
        }
        field(11; "Item Price"; Decimal)
        {
            Caption = 'Item Price';
            DataClassification = CustomerContent;
        }
        field(12; "Shipping Price"; Decimal)
        {
            Caption = 'Shipping Price';
            DataClassification = CustomerContent;
        }
        field(13; "Ship Promotion Discount"; Decimal)
        {
            Caption = 'Ship Promotion Discount';
            DataClassification = CustomerContent;
        }
        field(14; "Invoice/Credit Memo Created"; Boolean)
        {
            Editable = true;
            Caption = 'Invoice/Credit Memo Created';
            DataClassification = CustomerContent;
        }
        field(15; "Invoice Created DateTime"; DateTime)
        {
            Editable = false;
            Caption = 'Invoice Created DateTime';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //"NAV SI Created No.":=CURRENTDATETIME;
            end;
        }
        field(16; "NAV SI Created No."; Code[20])
        {
            Editable = true;
            Caption = 'NAV SI Created No.';
            DataClassification = CustomerContent;
        }
        field(17; "Customer Ship-to-Code"; Code[10])
        {
            Caption = 'Customer Ship-to-Code';
            DataClassification = CustomerContent;
        }
        field(18; "Entry Type"; Option)
        {
            OptionMembers = " ",Invoice,"Credit Memo";
            Caption = 'Entry Type';
            DataClassification = CustomerContent;
        }
        field(19; "Original Invoice No."; Code[20])
        {
            Caption = 'Original Invoice No.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry Type", "Amazon OrderId")
        {
        }
        key(Key3; "Entry Type")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        "Entry No." := CreateGuid;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
    // NoSeriesManagement: Codeunit NoSeriesManagement;
}
