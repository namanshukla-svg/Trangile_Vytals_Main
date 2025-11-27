tableextension 50120 "SSD Sales Price" extends "Sales Price"
{
    fields
    {
        field(50000; Remarks; Text[200])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(50001; "Credit Note"; Decimal)
        {
            Caption = 'Credit Note';
            DataClassification = ToBeClassified;
        }
        field(50002; "Special Price"; Decimal)
        {
            Caption = 'Special Price';
            DataClassification = ToBeClassified;
        }
        field(50003; "MSL Qty"; Decimal)
        {
            Caption = 'MSL Qty';
            DataClassification = ToBeClassified;
        }
        field(50004; "ROL Qty"; Decimal)
        {
            Caption = 'ROL Qty';
            DataClassification = ToBeClassified;
        }
        field(50005; "Unit Price As Per CRM"; Decimal)
        {
            Caption = 'Unit Price As Per CRM';
            DataClassification = ToBeClassified;
        }
    }
}
