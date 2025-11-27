tableextension 50101 "SSD Transfer Receipt Header" extends "Transfer Receipt Header"
{
    fields
    {
        field(50050; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50055; "Applied to Insurance Policy"; Code[30])
        {
            Description = 'ALLE-NM 01112019';
            DataClassification = CustomerContent;
            Caption = 'Applied to Insurance Policy';
        }
        field(65000; "Slip No."; Code[20])
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Slip No.';
        }
        field(65001; "Document Type"; Option)
        {
            Description = 'ALLE3.26';
            OptionCaption = ' ,Material Issue,Material Return,Line Rejection,Floor Rejection,Offer,ReOffer';
            OptionMembers = " ", "Material Issue", "Material Return", "Line Rejection", "Floor Rejection", Offer, ReOffer;
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(65006; Departments; Option)
        {
            Description = 'ALLE3.26';
            OptionCaption = ' ,PPC,AWP,WIP,Conveyor,ED,Store';
            OptionMembers = " ", PPC, AWP, WIP, Conveyor, ED, Store;
            DataClassification = CustomerContent;
            Caption = 'Departments';
        }
        field(65007; "Prod. Order Source No."; Code[20])
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Prod. Order Source No.';
        }
        field(65008; "Prod. Order Source Description"; Text[50])
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Prod. Order Source Description';
        }
        field(65009; "Prod. Order No."; Code[20])
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Prod. Order No.';
        }
        field(71000; "GSTR 2 Exported"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR 2 Exported';
        }
    }
}
