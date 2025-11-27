TableExtension 50009 "SSD Delivery Challan Line" extends "Delivery Challan Line"
{
    Caption = 'Delivery Challan Line';

    fields
    {
        field(50001; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50002; "No.2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("Item No.")));
            FieldClass = FlowField;
            Caption = 'No.2';
        }
        field(50007; "Old Delivery Challan No."; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Old Delivery Challan No.';
        }
        field(50008; "Old Delivery Challan Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Old Delivery Challan Date';
        }
        field(50010; "Ref. PO No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Ref. PO No.';
        }
        field(50011; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
        }
        field(50012; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            Description = 'CF001';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
        }
        field(50045; "Company Bin Code"; Code[20])
        {
            Caption = 'Company Bin Code';
            Description = 'CF001';
            TableRelation = Bin.Code where("Location Code"=field("Company Location"), "Item Filter"=field("Item No."), "Variant Filter"=field("Variant Code"));
            DataClassification = CustomerContent;
        }
        field(50046; "Vendor Bin Code"; Code[10])
        {
            Caption = 'Vendor Bin Code';
            Description = 'CF001';
            TableRelation = Bin.Code where("Location Code"=field("Vendor Location"), "Item Filter"=field("Item No."), "Variant Filter"=field("Variant Code"));
            DataClassification = CustomerContent;
        }
        field(50050; "OutPut Item Quantity"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'OutPut Item Quantity';
        }
        field(50051; "OutPut Item UOM"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
            Caption = 'OutPut Item UOM';
        }
        field(50052; "57 F4 Posted"; Boolean)
        {
            Description = 'ALLE-NM 01102019';
            DataClassification = CustomerContent;
            Caption = '57 F4 Posted';
        }
    }
    keys
    {
        key(KeySSD; "Vendor No.", "Delivery Challan No.", "Posting Date")
        {
        }
    }
    trigger OnAfterInsert()
    var
        DeliveryChallanHeader: Record "Delivery Challan Header";
    begin
        if DeliveryChallanHeader.Get("Delivery Challan No.")then "Responsibility Center":=DeliveryChallanHeader."Responsibility Center";
    end;
    var DeliveryChallanHeader: Record "Delivery Challan Header";
}
