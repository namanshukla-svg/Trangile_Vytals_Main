tableextension 50011 "SSD Detailed GST Ledger Entry" extends "Detailed GST Ledger Entry"
{
    fields
    {
        field(71000; "GSTR 2 Reco. Initiated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR 2 Reco. Initiated';
        }
        field(71001; "GSTR 2 Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Matched,Accepted,Mis-Matched';
            OptionMembers = " ", Matched, Accepted, "Mis-Matched";
            Caption = 'GSTR 2 Status';
        }
        field(71002; "GSTR Base Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR Base Amount';
        }
    }
}
