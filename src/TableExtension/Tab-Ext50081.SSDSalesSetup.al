TableExtension 50081 "SSD Sales Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "E-Way User Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Way User Name';
        }
        field(50101; "E-Way Password"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Way Password';
        }
        field(50102; "E-way Access Token"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'E-way Access Token';
        }
        field(50103; "E-way Access Token Validity"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'E-way Access Token Validity';
        }
        field(50104; "Sales Forecast Nos."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Sales Forecast Nos.';
        }
        field(50105; "Amazon Invoice Nos."; Code[10])
        {
            Description = 'Alle-[Amazon-HG]';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Amazon Invoice Nos.';
        }
        field(50106; "Amazon Posted Invoice Nos."; Code[20])
        {
            Description = 'Alle-[Amazon-HG]';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Amazon Posted Invoice Nos.';
        }
        field(50107; "Amazon Location Master"; Code[10])
        {
            Description = 'Alle-[Amazon-HG]';
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Amazon Location Master';
        }
        field(50108; "Amazon Credit Memo Nos."; Code[10])
        {
            Description = 'Alle-[Amazon-HG]';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Amazon Credit Memo Nos.';
        }
        field(50109; "Amazon Posted Credit Memo Nos."; Code[20])
        {
            Description = 'Alle-[Amazon-HG]';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Amazon Posted Credit Memo Nos.';
        }
        field(50110; "Sales Dispatch No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Sales Dispatch No.';
        }
        field(50111; "COA Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'COA Start Date';
        }
    }
}
