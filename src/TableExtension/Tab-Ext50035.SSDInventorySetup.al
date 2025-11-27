TableExtension 50035 "SSD Inventory Setup" extends "Inventory Setup"
{
    fields
    {
        field(50001; "Issue Slip No."; Code[10])
        {
            Description = 'Alle 01032021';
            DataClassification = CustomerContent;
            Caption = 'Issue Slip No.';
        }
        field(75004; "Freight Zone No. Series"; Code[10])
        {
            Description = 'ALLE 3.08';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Freight Zone No. Series';
        }
        //IG_DS
        field(75005; "Issue Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(75006; "Issue Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        //IG_DS

    }
}
