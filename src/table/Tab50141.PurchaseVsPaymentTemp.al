table 50141 "Purchase Vs Payment Temp"
{
    Caption = 'Purchase Vs Payment Temp';
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(8; "PI No."; Code[20])
        {
            Caption = 'PI No.';
        }
        field(9; "PI Date"; Date)
        {
            Caption = 'PI Date';
        }
        field(17; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(18; "Posting Date"; Date)
        {
        }
        field(19; "Document Type";Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
        }
        field(20; "Document No."; Code[20])
        {
        }
        field(21; "External Doc No."; Code[20])
        {
        }
        field(22; "Document Date"; Date)
        {
        }
        field(23; "Vendor No."; Code[20])
        {
        }
        field(24; "Vendor Name"; Code[20])
        {
        }
    }
    keys
    {
        key(PK; "PI No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
