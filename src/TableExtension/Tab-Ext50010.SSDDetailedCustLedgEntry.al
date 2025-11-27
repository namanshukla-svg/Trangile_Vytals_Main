TableExtension 50010 "SSD Detailed Cust. Ledg. Entry" extends "Detailed Cust. Ledg. Entry"
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
        field(50002; crminsertflag; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'crminsertflag';
        }
        field(50003; iscrmexception; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'iscrmexception';
        }
    }
}
