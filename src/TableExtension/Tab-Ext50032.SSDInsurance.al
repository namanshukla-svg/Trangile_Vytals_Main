TableExtension 50032 "SSD Insurance" extends Insurance
{
    fields
    {
        field(50000; "Responsibility Center"; Code[20])
        {
            Description = 'MSI.RC';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
    }
}
