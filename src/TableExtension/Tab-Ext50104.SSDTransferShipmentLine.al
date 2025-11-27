TableExtension 50104 "SSD Transfer Shipment Line" extends "Transfer Shipment Line"
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
        field(50055; "Trf Price DUP. CSP"; Decimal)
        {
            Description = 'ALLE-NM 26062019';
            DataClassification = CustomerContent;
            Caption = 'Trf Price DUP. CSP';
        }
        field(50056; "Amount DUP. CSP"; Decimal)
        {
            Description = 'ALLE-NM 26062019';
            DataClassification = CustomerContent;
            Caption = 'Amount DUP. CSP';
        }
        field(50057; "57 F4 Posted"; Boolean)
        {
            Description = 'ALLE-NM 01102019';
            DataClassification = CustomerContent;
            Caption = '57 F4 Posted';
        }
        field(50058; "Line Closed Date"; Date)
        {
            Description = 'ALLE-AT 201020';
            DataClassification = CustomerContent;
            Caption = 'Line Closed Date';
        }
        field(50059; "Challan Closed Date"; Date)
        {
            Description = 'ALLE-AT 201020';
            DataClassification = CustomerContent;
            Caption = 'Challan Closed Date';
        }
        field(50060; "Challan Age"; Decimal)
        {
            Description = 'ALLE-AT 201020';
            DataClassification = CustomerContent;
            Caption = 'Challan Age';
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
        field(65002; "Indent No."; Code[20])
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Indent No.';
        }
        field(65006; Departments; Option)
        {
            Description = 'ALLE3.26';
            OptionCaption = ' ,PPC,AWP,WIP,Conveyor,ED,Store';
            OptionMembers = " ", PPC, AWP, WIP, Conveyor, ED, Store;
            DataClassification = CustomerContent;
            Caption = 'Departments';
        }
        field(65007; "Packing Std. For Req."; Integer)
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Packing Std. For Req.';
        }
        field(65008; "Prod. Order No."; Code[20])
        {
            Description = 'ALLE3.26';
            TableRelation = "Production Order"."No." where("No."=field("Prod. Order No."), Status=const(Released));
            DataClassification = CustomerContent;
            Caption = 'Prod. Order No.';
        }
        field(65009; "Prod.Order Source No."; Code[20])
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Prod.Order Source No.';
        }
        field(65010; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
            //SelectItemEntry(FIELDNO("Applies-to Entry"));
            end;
            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                "---MeS": Integer;
                RespCent: Record "Responsibility Center";
                UserMgt: Codeunit "SSD User Setup Management";
                ILELocal: Record "Item Ledger Entry";
            begin
            end;
        }
        field(65011; "Required Qty."; Decimal)
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Required Qty.';
        }
    }
}
