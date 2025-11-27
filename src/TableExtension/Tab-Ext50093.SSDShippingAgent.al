TableExtension 50093 "SSD Shipping Agent" extends "Shipping Agent"
{
    fields
    {
        field(50000; "Contact3 Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact3 Name';
        }
        field(50001; "Contact3 Mobile"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact3 Mobile';
        }
        field(50002; "Contact3 Email"; Text[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact3 Email';
        }
        field(50003; "Transporter GST No."; Code[20])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'Transporter GST No.';
        }
    }
}
