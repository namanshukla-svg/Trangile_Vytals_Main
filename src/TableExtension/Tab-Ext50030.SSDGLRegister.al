TableExtension 50030 "SSD G/L Register" extends "G/L Register"
{
    fields
    {
        field(50000; "Document No."; Code[20])
        {
            CalcFormula = lookup("G/L Entry"."Document No." where("Entry No."=field("From Entry No.")));
            Description = 'ALLEMSI';
            FieldClass = FlowField;
            Caption = 'Document No.';
        }
    }
}
