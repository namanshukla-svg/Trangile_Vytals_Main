TableExtension 50108 "SSD Value Entry" extends "Value Entry"
{
    fields
    {
        field(50057; "Suplementary Invoice"; Boolean)
        {
            Description = 'CF001.02 ->';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Suplementary Invoice';
        }
        field(50058; "Rework Qty"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Rework Qty';
        }
        field(50059; "Rejected Qty"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty';
        }
    }
}
