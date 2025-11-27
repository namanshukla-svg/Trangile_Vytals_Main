tableextension 50038 "SSD Item Charge Assign (Purch)" extends "Item Charge Assignment (Purch)"
{
    fields
    {
        field(50000; "Applies-to Doc. Line Qty"; Decimal)
        {
            Description = 'ALLE 2.25';
            DataClassification = CustomerContent;
            Caption = 'Applies-to Doc. Line Qty';
        }
    }
}
