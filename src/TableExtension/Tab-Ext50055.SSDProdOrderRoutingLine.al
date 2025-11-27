TableExtension 50055 "SSD Prod. Order Routing Line" extends "Prod. Order Routing Line"
{
    fields
    {
        field(50001; "Quality Required"; Boolean)
        {
            Caption = 'Quality Required';
            Description = 'QA-013/014';
            DataClassification = CustomerContent;
        }
        field(50002; "Sent for Quality"; Boolean)
        {
            Caption = 'Sent for Quality';
            Description = 'QA-013/014';
            DataClassification = CustomerContent;
        }
        field(50003; "Process Description"; Text[250])
        {
            Caption = 'Process Description';
            Description = 'MFG-067';
            DataClassification = CustomerContent;
        }
        field(50004; "Quality Done"; Boolean)
        {
            Caption = 'Quality Done';
            Description = 'QA-013/014';
            DataClassification = CustomerContent;
        }
        field(50007; "Quality Template Master"; Code[20])
        {
            Caption = 'Quality Template Master';
            Description = 'QA-013/014';
            TableRelation = "SSD Sampling Temp. Header" where("Template Type"=const(Manufacturing));
            DataClassification = CustomerContent;
        }
        field(50012; "Sample Quantity"; Decimal)
        {
            Caption = 'Sample Quantity';
            Description = 'QA-013/014';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}
