TableExtension 50110 "SSD Vendor Bank Account" extends "Vendor Bank Account"
{
    fields
    {
        field(50000; "Beneficiary Name"; Text[60])
        {
            Description = 'Alle VPB FRD 2.15';
            DataClassification = CustomerContent;
            Caption = 'Beneficiary Name';
        }
        field(50001; "Beneficiary Address"; Text[50])
        {
            Description = 'Alle VPB FRD 2.15';
            DataClassification = CustomerContent;
            Caption = 'Beneficiary Address';
        }
        field(50002; "Beneficiary Address 2"; Text[50])
        {
            Description = 'Alle VPB FRD 2.15';
            DataClassification = CustomerContent;
            Caption = 'Beneficiary Address 2';
        }
        field(50003; "Beneficiary City"; Text[30])
        {
            Description = 'Alle VPB FRD 2.15';
            DataClassification = CustomerContent;
            Caption = 'Beneficiary City';
        }
        field(50004; "Beneficiary Post Code"; Code[20])
        {
            Description = 'Alle VPB FRD 2.15';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Beneficiary Post Code';
        }
        field(50005; "NEFT/RTGS Code"; Code[20])
        {
            Description = 'Alle VPB FRD 2.15';
            DataClassification = CustomerContent;
            Caption = 'NEFT/RTGS Code';
        }
    }
}
