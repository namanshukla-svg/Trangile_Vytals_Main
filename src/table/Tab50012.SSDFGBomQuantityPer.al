Table 50012 "SSD FG Bom Quantity Per"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Guid)
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Parent Item No."; Code[20])
        {
            Caption = 'Parent Item No.';
            DataClassification = CustomerContent;
        }
        field(4; "Raw Material Item No."; Code[20])
        {
            Caption = 'Raw Material Item No.';
            DataClassification = CustomerContent;
        }
        field(5; "Quantity Per"; Decimal)
        {
            Caption = 'Quantity Per';
            DataClassification = CustomerContent;
        }
        field(6; "Production Forecast No."; Code[10])
        {
            Caption = 'Production Forecast No.';
            DataClassification = CustomerContent;
        }
        field(7; "Raw Material Description"; Text[50])
        {
            Caption = 'Raw Material Description';
            DataClassification = CustomerContent;
        }
        field(8; "Parent Description"; Text[50])
        {
            Caption = 'Parent Description';
            DataClassification = CustomerContent;
        }
        field(9; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(10; "Prod. Forecast M1"; Decimal)
        {
            Caption = 'Prod. Forecast M1';
            DataClassification = CustomerContent;
        }
        field(11; "Prod. Forecast M2"; Decimal)
        {
            Caption = 'Prod. Forecast M2';
            DataClassification = CustomerContent;
        }
        field(12; "Prod. Forecast M3"; Decimal)
        {
            Caption = 'Prod. Forecast M3';
            DataClassification = CustomerContent;
        }
        field(13; "Prod. Forecast M4"; Decimal)
        {
            Caption = 'Prod. Forecast M4';
            DataClassification = CustomerContent;
        }
        field(14; "PF M1 Name"; Text[30])
        {
            Caption = 'PF M1 Name';
            DataClassification = CustomerContent;
        }
        field(15; "PF M2 Name"; Text[30])
        {
            Caption = 'PF M2 Name';
            DataClassification = CustomerContent;
        }
        field(16; "PF M3 Name"; Text[30])
        {
            Caption = 'PF M3 Name';
            DataClassification = CustomerContent;
        }
        field(17; "PF M4 Name"; Text[30])
        {
            Caption = 'PF M4 Name';
            DataClassification = CustomerContent;
        }
        field(18; "Item Category Code"; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Category Code';
        }
        field(19; "BOM Qty"; Decimal)
        {
            Caption = 'BOM Qty';
            DataClassification = CustomerContent;
        }
        field(20; "Prod. Forecast M5"; Decimal)
        {
            Caption = 'Prod. Forecast M5';
            DataClassification = CustomerContent;
        }
        field(21; "Prod. Forecast M6"; Decimal)
        {
            Caption = 'Prod. Forecast M6';
            DataClassification = CustomerContent;
        }
        field(22; "Prod. Forecast M7"; Decimal)
        {
            Caption = 'Prod. Forecast M7';
            DataClassification = CustomerContent;
        }
        field(23; "Prod. Forecast M8"; Decimal)
        {
            Caption = 'Prod. Forecast M8';
            DataClassification = CustomerContent;
        }
        field(24; "Prod. Forecast M9"; Decimal)
        {
            Caption = 'Prod. Forecast M9';
            DataClassification = CustomerContent;
        }
        field(25; "Prod. Forecast M10"; Decimal)
        {
            Caption = 'Prod. Forecast M10';
            DataClassification = CustomerContent;
        }
        field(26; "Prod. Forecast M11"; Decimal)
        {
            Caption = 'Prod. Forecast M11';
            DataClassification = CustomerContent;
        }
        field(27; "Prod. Forecast M12"; Decimal)
        {
            Caption = 'Prod. Forecast M12';
            DataClassification = CustomerContent;
        }
        field(30; "PF M5 Name"; Text[30])
        {
            Caption = 'PF M5 Name';
            DataClassification = CustomerContent;
        }
        field(31; "PF M6 Name"; Text[30])
        {
            Caption = 'PF M6 Name';
            DataClassification = CustomerContent;
        }
        field(32; "PF M7 Name"; Text[30])
        {
            Caption = 'PF M7 Name';
            DataClassification = CustomerContent;
        }
        field(33; "PF M8 Name"; Text[30])
        {
            Caption = 'PF M8 Name';
            DataClassification = CustomerContent;
        }
        field(34; "PF M9 Name"; Text[30])
        {
            Caption = 'PF M9 Name';
            DataClassification = CustomerContent;
        }
        field(35; "PF M10 Name"; Text[30])
        {
            Caption = 'PF M10 Name';
            DataClassification = CustomerContent;
        }
        field(36; "PF M11 Name"; Text[30])
        {
            Caption = 'PF M11 Name';
            DataClassification = CustomerContent;
        }
        field(37; "PF M12 Name"; Text[30])
        {
            Caption = 'PF M12 Name';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Parent Item No.")
        {
        }
    }
    fieldgroups
    {
    }
}
