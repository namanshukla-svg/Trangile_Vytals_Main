TableExtension 50082 "SSD Sales Cr.Memo Header" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50010; "Gate Pass"; Boolean)
        {
            CalcFormula = exist("SSD Gate Pass Line" where("Invoice No."=field("No.")));
            Description = 'ALLE-GP001';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Gate Pass';
        }
        field(50011; crminsertflag; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'crminsertflag';
        }
        field(50012; isCRMexception; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'isCRMexception';
        }
        field(50013; "exception detail"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'exception detail';
        }
        field(71000; "GSTR 1 Exported"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR 1 Exported';
        }
        field(85035; "Type of Invoice";Enum "Type Of Invoice Sales")
        {
            Caption = 'Type of Invoice';
        }
    }
}
