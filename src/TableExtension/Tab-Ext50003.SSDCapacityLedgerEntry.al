TableExtension 50003 "SSD Capacity Ledger Entry" extends "Capacity Ledger Entry"
{
    fields
    {
        field(50010; "SSD Quality Control Report No."; Code[20])
        {
            Caption = 'Quality Control Report No.';
            Description = 'QLT';
            DataClassification = CustomerContent;
        }
        field(50058; "SSD Rework Qty"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Rework Qty';
        }
        field(50059; "Rejected Qty"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty';
        }
        field(50060; "SSD No.2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("Item No.")));
            FieldClass = FlowField;
            Caption = 'No.2';
        }
    }
}
