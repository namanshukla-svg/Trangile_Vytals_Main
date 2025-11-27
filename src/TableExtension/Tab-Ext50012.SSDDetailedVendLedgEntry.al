TableExtension 50012 "SSD Detailed Vend Ledg. Entry" extends "Detailed Vendor Ledg. Entry"
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
        field(75000; "PO No."; Code[20])
        {
            Description = 'ALLE 2.16';
            DataClassification = CustomerContent;
            Caption = 'PO No.';
        }
    }
}
