TableExtension 50000 "SSD Applied Delivery Challan" extends "Applied Delivery Challan"
{
    fields
    {
        field(50000; "SSD SubCon Qty."; Decimal)
        {
            CalcFormula = lookup("Sub Order Comp. List Vend"."Qty. to Consume" where("Item No."=field("Item No."), "Document No."=field("Document No."), "Line No."=field("Line No.")));
            DecimalPlaces = 0: 5;
            FieldClass = FlowField;
            Caption = 'SubCon Qty.';
        }
    }
}
