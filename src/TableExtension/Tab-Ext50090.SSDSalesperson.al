TableExtension 50090 "SSD Salesperson" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; "Resp. CCare Exe. Name"; Text[50])
        {
            Description = 'ALLE-DD1.0';
            DataClassification = CustomerContent;
            Caption = 'Resp. CCare Exe. Name';
        }
        field(50001; "Resp. CCare Exe. Phone No."; Code[20])
        {
            Description = 'ALLE-DD1.0';
            DataClassification = CustomerContent;
            Caption = 'Resp. CCare Exe. Phone No.';
        }
        field(50002; "Resp. CCare Exe. Email Id"; Text[80])
        {
            Description = 'ALLE-DD1.0';
            DataClassification = CustomerContent;
            Caption = 'Resp. CCare Exe. Email Id';
        }
        field(50003; "RSM Name"; Text[30])
        {
            Description = 'BP20122016';
            DataClassification = CustomerContent;
            Caption = 'RSM Name';
        }
        field(50004; "RSM Email ID"; Text[30])
        {
            Description = 'BP20122016';
            DataClassification = CustomerContent;
            Caption = 'RSM Email ID';
        }
        field(50005; "RSM Contact No."; Text[30])
        {
            Description = 'BP20122016';
            DataClassification = CustomerContent;
            Caption = 'RSM Contact No.';
        }
        field(50006; "NSM Name"; Text[30])
        {
            Description = 'BP20122016';
            DataClassification = CustomerContent;
            Caption = 'NSM Name';
        }
        field(50007; "NSM Email ID"; Text[30])
        {
            Description = 'BP20122016';
            DataClassification = CustomerContent;
            Caption = 'NSM Email ID';
        }
        field(50008; "NSM Contact No."; Text[30])
        {
            Description = 'BP20122016';
            DataClassification = CustomerContent;
            Caption = 'NSM Contact No.';
        }
        field(50009; Category; Enum "SalesPerson Category")
        {
            DataClassification = CustomerContent;
            Caption = 'Category';
        }
        field(50010; "Sales Region"; Enum "Sales Region")
        {
            Caption = 'Sales Region';
            DataClassification = ToBeClassified;
        }
    }
}
