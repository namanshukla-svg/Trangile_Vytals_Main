TableExtension 50073 "SSD Res. Journal Template" extends "Res. Journal Template"
{
    fields
    {
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
    }
}
