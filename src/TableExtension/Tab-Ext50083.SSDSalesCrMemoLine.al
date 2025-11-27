TableExtension 50083 "SSD Sales Cr.Memo Line" extends "Sales Cr.Memo Line"
{
    fields
    {
        field(50005; crminsertflag; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'crminsertflag';
        }
        field(50007; isCRMexception; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'isCRMexception';
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
