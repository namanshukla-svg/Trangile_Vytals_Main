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
            //Atul::01122025
            Caption = 'Insert Status';
            //Atul::01122025;
        }
        field(50003; iscrmexception; Boolean)
        {
            DataClassification = CustomerContent;
            //Atul::01122025
            Caption = 'Exception Occurred';
            //Atul::01122025
        }
    }
}
