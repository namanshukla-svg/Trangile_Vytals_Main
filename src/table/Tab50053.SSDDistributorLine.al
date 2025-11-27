Table 50053 "SSD Distributor Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "MRP No"; Code[30])
        {
            Caption = 'MRP No';
            DataClassification = CustomerContent;
        }
        field(2; "Forecast Name"; Code[30])
        {
            Caption = 'Forecast Name';
            DataClassification = CustomerContent;
        }
        field(3; "SP Order No."; Code[30])
        {
            Caption = 'SP Order No.';
            DataClassification = CustomerContent;
        }
        field(4; "Suggested Quantity"; Decimal)
        {
            Caption = 'Suggested Quantity';
            DataClassification = CustomerContent;
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(6; Month; Date)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(7; "Item Code"; Code[10])
        {
            Caption = 'Item Code';
            DataClassification = CustomerContent;
        }
        field(8; "Required Receipt Date"; Date)
        {
            Caption = 'Required Receipt Date';
            DataClassification = CustomerContent;
        }
        field(9; "Suggested Receipt Date"; Date)
        {
            Caption = 'Suggested Receipt Date';
            DataClassification = CustomerContent;
        }
        field(10; "SP Price"; Decimal)
        {
            Caption = 'SP Price';
            DataClassification = CustomerContent;
        }
        field(11; Stock; Decimal)
        {
            Caption = 'Stock';
            DataClassification = CustomerContent;
        }
        field(12; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(14; "Create Sales Order"; Boolean)
        {
            Caption = 'Create Sales Order';
            DataClassification = CustomerContent;
        }
        field(15; "Sales Line No."; Code[30])
        {
            Description = 'ALLE-NM';
            Caption = 'Sales Line No.';
            DataClassification = CustomerContent;
        }
        field(16; "SP Remarks"; Text[80])
        {
            Description = 'ALLE-NM';
            NotBlank = false;
            Caption = 'SP Remarks';
            DataClassification = CustomerContent;
        }
        field(17; "Created Date Time"; DateTime)
        {
            Description = 'ALLE-NM';
            Caption = 'Created Date Time';
            DataClassification = CustomerContent;
        }
        field(18; "Mail Sent"; Boolean)
        {
            Description = 'ALLE-NM';
            Caption = 'Mail Sent';
            DataClassification = CustomerContent;
        }
        field(19; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "MRP No", Month, "Item Code", "Sales Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var AlleEvents: Codeunit "Alle Events";
}
