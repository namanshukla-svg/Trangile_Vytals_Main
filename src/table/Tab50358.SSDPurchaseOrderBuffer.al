table 50358 "SSD Purchase Order Buffer"
{
    Caption = 'SSD Purchase Order Buffer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
    }
    keys
    {
        key(PK; "Order No.")
        {
            Clustered = true;
        }
    }
}
