TableExtension 50054 "SSD Prod. Order Line" extends "Prod. Order Line"
{
    fields
    {
        field(50000; "Sales Order No."; Code[20])
        {
            Description = '5.51 to flow S order no when created from order planning.';
            DataClassification = CustomerContent;
            Caption = 'Sales Order No.';
        }
        field(50001; "No. of Archvied Version"; Integer)
        {
            Description = 'ALLE NV';
            DataClassification = CustomerContent;
            Caption = 'No. of Archvied Version';
        }
    }
}
