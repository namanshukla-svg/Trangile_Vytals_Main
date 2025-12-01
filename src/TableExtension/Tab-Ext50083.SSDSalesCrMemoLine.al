TableExtension 50083 "SSD Sales Cr.Memo Line" extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50005; crminsertflag; Boolean)
        {
            DataClassification = CustomerContent;
            //Atul::01122025
            Caption = 'Insert Status';
            //Atul::01122025;
        }
        field(50007; isCRMexception; Boolean)
        {
            DataClassification = CustomerContent;
            //Atul::01122025
            Caption = 'Exception Occurred';
            //Atul::01122025
        }
        field(50008; "exception detail"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'exception detail';
        }
        field(50030; "Revised Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Shipment Date';
        }
        field(85045; "MOQ Quantity"; Decimal)
        {
            Description = 'Alle-[Amazon-HG]';
            DataClassification = CustomerContent;
            Caption = 'MOQ Quantity';
            Editable = false;
        }
    }
}
