TableExtension 50053 "SSD Prod. Order Component" extends "Prod. Order Component"
{
    fields
    {
        field(50000; "Completely Issued"; Boolean)
        {
            Description = '5.51';
            DataClassification = CustomerContent;
            Caption = 'Completely Issued';
        }
        field(50001; "Actual Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Line No.';
        }
        field(60009; "Inventory Posting Group"; Code[10])
        {
            Description = 'ALLE3.26';
            TableRelation = "Inventory Posting Group".Code;
            DataClassification = CustomerContent;
            Caption = 'Inventory Posting Group';
        }
        field(60010; "Source No."; Code[20])
        {
            Description = 'ALLE3.26';
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Source No.';
        }
        field(75000; "Replensihment System";Enum "Replenishment System")
        {
            CalcFormula = lookup(Item."Replenishment System" where("No."=field("Item No.")));
            FieldClass = FlowField;
        }
    }
}
