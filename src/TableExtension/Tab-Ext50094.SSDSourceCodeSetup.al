TableExtension 50094 "SSD Source Code Setup" extends "Source Code Setup"
{
    fields
    {
        field(50001; Indent; Code[10])
        {
            Caption = 'Indent';
            Description = 'IND';
            TableRelation = "Source Code";
            DataClassification = CustomerContent;
        }
    }
}
