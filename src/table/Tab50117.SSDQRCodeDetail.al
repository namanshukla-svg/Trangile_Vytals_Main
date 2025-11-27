Table 50117 "SSD QR Code Detail"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "QR Code No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'QR Code No.';
        }
        field(2; "MRN No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'MRN No.';
        }
        field(3; "MRN Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'MRN Date';
        }
        field(4; "Item Code"; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Item Code';
        }
        field(5; "Location Code"; Code[20])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Location Code';
        }
        field(6; UOM; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'UOM';
        }
        field(7; "Expiration Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiration Date';
        }
        field(8; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity';
        }
        field(9; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';
        }
        field(10; "Vendor Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Code';
        }
        field(11; "Vendor Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Name';
        }
        field(13; "Barcode No Integer"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Barcode No Integer';
        }
        field(14; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Date';
        }
        field(15; "BIN Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'BIN Code';
        }
        field(16; "Item Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Description';
        }
    }
    keys
    {
        key(Key1; "Barcode No Integer")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
