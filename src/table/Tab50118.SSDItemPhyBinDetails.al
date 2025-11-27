Table 50118 "SSD Item Phy. Bin Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Whse. Entry  No."; Integer)
        {
            Caption = 'Whse. Entry  No.';
            DataClassification = CustomerContent;
        }
        field(4; "Item No."; Code[20])
        {
            TableRelation = Item;
            Caption = 'Item No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ItemRec.Get("Item No.")then "Item Description":=ItemRec.Description;
            end;
        }
        field(5; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = CustomerContent;
        }
        field(6; "Posted Document No."; Code[20])
        {
            Caption = 'Posted Document No.';
            DataClassification = CustomerContent;
        }
        field(7; "Item Description"; Text[50])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
        }
        field(8; "Unit Of Measure"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No."=field("Item No."));
            Caption = 'Unit Of Measure';
            DataClassification = CustomerContent;
        }
        field(9; Quantity; Decimal)
        {
            DecimalPlaces = 0: 5;
            Caption = 'Quantity';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RoundQty: Decimal;
            begin
                Qty:=0;
                if("Document Type" = "document type"::Consumption) or ("Document Type" = "document type"::"Negative Adjmt.") or ("Document Type" = "document type"::"Sales Invoice") or ("Document Type" = "document type"::"Sub Con. Order Send") or ("Document Type" = "document type"::"Transfer Order Ship") or ("Document Type" = "document type"::"Purch. Credit Memo")then begin
                    Quantity:=-Quantity;
                    ItemPhyBinDetails.Reset;
                    ItemPhyBinDetails.SetRange("Item No.", "Item No.");
                    ItemPhyBinDetails.SetRange("Location Code", "Location Code");
                    ItemPhyBinDetails.SetRange("Bin Code", "Bin Code");
                    ItemPhyBinDetails.SetRange("Phy. Bin Code", "Phy. Bin Code");
                    ItemPhyBinDetails.SetRange("Lot No.", "Lot No.");
                    ItemPhyBinDetails.SetFilter("Whse. Entry  No.", '<>%1', 0);
                    if ItemPhyBinDetails.FindSet then repeat Qty+=ItemPhyBinDetails."ILE Quantity";
                        until ItemPhyBinDetails.Next = 0;
                    RoundQty:=ROUND(Qty, 0.0001, '=');
                    if("Document Type" = "document type"::Consumption) and (Quantity < 0)then if Abs(Quantity) > Abs(RoundQty)then Error('Insufficient Quantity in Phy. Bin %1', "Phy. Bin Code");
                    if("Document Type" <> "document type"::Consumption)then if Abs(Quantity) > Abs(RoundQty)then Error('Insufficient Quantity in Phy. Bin %1', "Phy. Bin Code");
                end;
                /*
                ItemPhyBinDetails1.RESET;
                ItemPhyBinDetails1.SETRANGE("Document No.","Document No.");
                ItemPhyBinDetails1.SETRANGE("Qty. Per Unit Of Measure",0);
                IF ItemPhyBinDetails1.FINDSET THEN
                  REPEAT
                    ItemPhyBinDetails1."Qty. Per Unit Of Measure" := 1;
                    ItemPhyBinDetails1.MODIFY;
                  UNTIL ItemPhyBinDetails1.NEXT = 0;
                  */
                //COPR::PK 280520
                if "Qty. Per Unit Of Measure" = 0 then begin
                    "Qty. Per Unit Of Measure":=1;
                //MODIFY
                end;
                "ILE Quantity":=Quantity * "Qty. Per Unit Of Measure";
            end;
        }
        field(10; "Location Code"; Code[10])
        {
            TableRelation = Location;
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(11; "Bin Code"; Code[10])
        {
            TableRelation = Bin.Code where("Location Code"=field("Location Code"));
            Caption = 'Bin Code';
            DataClassification = CustomerContent;
        }
        field(12; "Phy. Bin Code"; Code[20])
        {
            TableRelation = "SSD Phy. Bin Details"."Phy. Bin Code" where("Location Code"=field("Location Code"), "Bin Code"=field("Bin Code"));
            Caption = 'Phy. Bin Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Qty:=0;
                if("Document Type" = "document type"::Consumption) or ("Document Type" = "document type"::"Negative Adjmt.") or ("Document Type" = "document type"::"Sales Invoice") or ("Document Type" = "document type"::"Sub Con. Order Send") or ("Document Type" = "document type"::"Transfer Order Ship")then begin
                    Quantity:=-Quantity;
                    ItemPhyBinDetails.Reset;
                    ItemPhyBinDetails.SetRange("Item No.", "Item No.");
                    ItemPhyBinDetails.SetRange("Location Code", "Location Code");
                    ItemPhyBinDetails.SetRange("Bin Code", "Bin Code");
                    ItemPhyBinDetails.SetRange("Phy. Bin Code", "Phy. Bin Code");
                    ItemPhyBinDetails.SetRange("Lot No.", "Lot No.");
                    ItemPhyBinDetails.SetFilter("Whse. Entry  No.", '<>%1', 0);
                    if ItemPhyBinDetails.FindSet then repeat Qty+=ItemPhyBinDetails."ILE Quantity";
                        until ItemPhyBinDetails.Next = 0;
                    if Abs(Quantity) > Abs(Qty)then Error('Insufficient Quantity in Phy. Bin %1', "Phy. Bin Code");
                end;
            end;
        }
        field(13; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            DataClassification = CustomerContent;
        }
        field(14; "Document Type"; Option)
        {
            OptionCaption = ' ,Whse. Receipt,Consumption,Output,Positive Adjmt.,Negative Adjmt.,Transfer,Sales Invoice,Sub Con. Order Send,Purch. Credit Memo,Sub Con. Order Receive,Transfer Order Ship,Transfer Order Receipt,Whse. Receipt SRO';
            OptionMembers = " ", "Whse. Receipt", Consumption, Output, "Positive Adjmt.", "Negative Adjmt.", Transfer, "Sales Invoice", "Sub Con. Order Send", "Purch. Credit Memo", "Sub Con. Order Receive", "Transfer Order Ship", "Transfer Order Receipt", "Whse. Receipt SRO";
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(15; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(16; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(17; "Qty. Per Unit Of Measure"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Editable = true;
            Caption = 'Qty. Per Unit Of Measure';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
            /*
                IF "Qty. Per Unit Of Measure" = 0 THEN BEGIN
                  "Qty. Per Unit Of Measure" := 1;
                  MODIFY;
                END;
                "ILE Quantity" := Quantity*"Qty. Per Unit Of Measure";
                */
            end;
        }
        field(18; "ILE Quantity"; Decimal)
        {
            DecimalPlaces = 0: 5;
            Editable = false;
            Caption = 'ILE Quantity';
            DataClassification = CustomerContent;
        }
        field(19; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(20; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            Description = 'Alle 26052021';
            TableRelation = "Item Variant".Code where("Item No."=field("Item No."));
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Whse. Entry  No.")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(Test; "Item No.", "Lot No.")
        {
        }
    }
    var ItemRec: Record Item;
    Qty: Decimal;
    ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    ItemPhyBinDetails1: Record "SSD Item Phy. Bin Details";
}
