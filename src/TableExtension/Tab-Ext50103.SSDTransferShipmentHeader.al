TableExtension 50103 "SSD Transfer Shipment Header" extends "Transfer Shipment Header"
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
        field(50100; "SSD E-Way Bill No."; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill No.';
        }
        field(50101; "E-Way Bill Date"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill Date';
        }
        field(50102; "E-Way Bill Validity"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill Validity';
        }
        field(50103; "E-Way-to generate"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way-to generate';
        }
        field(50104; "E-Way Generated"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Generated';
        }
        field(50105; "New Vechile No."; Code[10])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'New Vechile No.';
        }
        field(50106; "Vechile No. Update Remark"; Text[250])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'Vechile No. Update Remark';
        }
        field(50107; "E-Way Canceled"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Canceled';
        }
        field(50108; "Transportation Distance"; Integer)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'Transportation Distance';
        }
        field(60075; "Gate Pass"; Boolean)
        {
            CalcFormula = exist("SSD Gate Pass Line" where("Invoice No."=field("No.")));
            Description = 'ALLE-GP001';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Gate Pass';
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
        field(71000; "GSTR 1 Exported"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR 1 Exported';
        }
    }
}
