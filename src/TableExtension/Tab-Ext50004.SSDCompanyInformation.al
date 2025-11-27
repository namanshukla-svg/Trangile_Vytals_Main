TableExtension 50004 "SSD Company Information" extends "Company Information"
{
    fields
    {
        field(50001; "Main Menu ID"; Integer)
        {
            Description = 'CF001 for Starting form';
            DataClassification = CustomerContent;
            Caption = 'Main Menu ID';
        }
        field(50002; "LUT No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'LUT No.';
        }
        field(50003; "LUT Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'LUT Date';
        }
        field(50004; "New Logo1"; Blob)
        {
            Description = 'ZEV-IMPL-II-5.51';
            SubType = Bitmap;
            DataClassification = CustomerContent;
            Caption = 'New Logo1';
        }
        field(50005; "New Logo2"; Blob)
        {
            Description = 'ZEV-IMPL-II-5.51';
            SubType = Bitmap;
            DataClassification = CustomerContent;
            Caption = 'New Logo2';
        }
        field(50006; "Valid Upto"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Valid Upto';
        }
        field(50007; "Company Registration  No."; Code[21])
        {
            DataClassification = CustomerContent;
            Caption = 'Company Registration  No.';
        }
        field(50008; "Letter Head Header"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Letter Head Header';
            Subtype = Bitmap;
        }
        field(50009; "Letter Head Footer"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Letter Head Footer';
            Subtype = Bitmap;
        }
    }
}
