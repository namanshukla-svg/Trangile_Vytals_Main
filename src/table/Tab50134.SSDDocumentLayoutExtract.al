Table 50134 "SSD Document Layout Extract"
{
    Caption = 'Document Extract';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = ' ,Sales Invoice,Sales Cr Memo,Purchase Order,Sales Order';
            OptionMembers = " ", "Sales Invoice", "Sales Cr Memo", "Purchase Order", "Sales Order";
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; Type, "Document No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
