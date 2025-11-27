Table 50116 "SSD QR Code Str"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
        }
        field(2; "QR No Integer"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'QR No Integer';
        }
        field(3; "Qty."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty.';
        }
        field(4; Location; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Location';
        }
        field(5; QRCode; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'QRCode';
        }
        field(6; "Bin No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Bin No.';
        }
        field(7; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(8; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';
        }
        field(9; "QR Code No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'QR Code No.';
        }
        field(10; "Expiration Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiration Date';
        }
    }
    keys
    {
        key(Key1; "Item No.", "QR No Integer")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
