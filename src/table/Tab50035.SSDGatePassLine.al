Table 50035 "SSD Gate Pass Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = CustomerContent;
        }
        field(4; "Invoice Date"; Date)
        {
            Editable = false;
            Caption = 'Invoice Date';
            DataClassification = CustomerContent;
        }
        field(5; "Customer No."; Code[20])
        {
            TableRelation = Vendor."No." where(Transporter=filter(true));
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(6; "Customer Name"; Text[50])
        {
            Editable = false;
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(7; "Invoice Amount"; Decimal)
        {
            Editable = false;
            Caption = 'Invoice Amount';
            DataClassification = CustomerContent;
        }
        field(8; "Net Wt."; Decimal)
        {
            Editable = false;
            Caption = 'Net Wt.';
            DataClassification = CustomerContent;
        }
        field(9; "Gross Wt."; Decimal)
        {
            Editable = false;
            Caption = 'Gross Wt.';
            DataClassification = CustomerContent;
        }
        field(10; "No. Of Cartons"; Integer)
        {
            Editable = false;
            Caption = 'No. Of Cartons';
            DataClassification = CustomerContent;
        }
        field(11; Remark; Text[200])
        {
            Caption = 'Remark';
            DataClassification = CustomerContent;
        }
        field(12; "ILE Lot Scanned"; Boolean)
        {
            Caption = 'ILE Lot Scanned';
            DataClassification = CustomerContent;
        }
        field(13; "LR/RR No."; Code[20])
        {
            Caption = 'LR/RR No.';
            DataClassification = CustomerContent;
        }
        field(14; "LR/RR Date"; Date)
        {
            Caption = 'LR/RR Date';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
