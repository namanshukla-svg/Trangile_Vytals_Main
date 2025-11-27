TableExtension 50042 "SSD Item Journal Template" extends "Item Journal Template"
{
    fields
    {
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'MSI.RC';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
    }
}
