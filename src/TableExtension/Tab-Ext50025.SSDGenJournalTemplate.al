TableExtension 50025 "SSD Gen. Journal Template" extends "Gen. Journal Template"
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
        field(50002; "Attachment Mandatory"; Boolean)
        {
            Caption = 'Attachment Mandatory';
            DataClassification = SystemMetadata;
        }
    }
}
