TableExtension 50118 "SSD Work Center" extends "Work Center"
{
    fields
    {
        field(50002; "Process / Operation"; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Process / Operation';
        }
        field(50050; "Responsibility Center"; Code[20])
        {
            Description = '5.51';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
    }
}
