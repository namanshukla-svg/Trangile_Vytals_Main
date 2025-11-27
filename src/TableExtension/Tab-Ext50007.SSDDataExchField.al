TableExtension 50007 "SSD Data Exch. Field" extends "Data Exch. Field"
{
    fields
    {
        field(50200; "SSD Value2"; Text[250])
        {
            Caption = 'Value2';
            DataClassification = CustomerContent;
        }
        field(50201; "SSD Value3"; Text[250])
        {
            Caption = 'Value3';
            DataClassification = CustomerContent;
        }
        field(50202; "SSD Value4"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Value4';
        }
    }
}
