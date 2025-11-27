TableExtension 50111 "SSD Vendor Ledger Entry" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50001; "Responsibility Center"; Code[20])
        {
            Description = 'MSI.RC';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50002; Remarks; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(50007; "Hold Payment"; Boolean)
        {
            Description = 'HP1.0';
            DataClassification = CustomerContent;
            Caption = 'Hold Payment';
        }
        field(50008; "MSME Classification Year"; Code[10])
        {
            Caption = 'MSME Classification Year';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor."MSME Classification Year" where("No."=field("Vendor No.")));
        }
        field(50009; "MSME Category";Enum "MSME Category")
        {
            Caption = 'MSME Category';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor."MSME Category" where("No."=field("Vendor No.")));
        }
        field(75000; "PO No."; Code[20])
        {
            Description = 'ALLE 2.16';
            DataClassification = CustomerContent;
            Caption = 'PO No.';
        }
    }
}
