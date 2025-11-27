Table 50113 "SSD Requision Slip Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Req. Slip Document No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Req. Slip Document No.';
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Prod. Order No.';
        }
        field(3; "Prod. Order Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Prod. Order Line No.';
        }
        field(4; "Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(5; "Item No."; Code[20])
        {
            Editable = true;
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Item No.';

            trigger OnValidate()
            begin
                if RequisionSlipHeader.Get("Document Type", "Document No.")then begin
                    RequisionSlipHeader.TestField("Transfer-From Location");
                    RequisionSlipHeader.TestField("Transfer-To Location");
                    RequisionSlipHeader.TestField("Shortcut Dimension 1 Code");
                // RequisionSlipHeader.TESTFIELD("Shortcut Dimension 2 Code");
                end;
                if ItemRec.Get("Item No.")then begin
                    Description:=ItemRec.Description;
                    "Unit of Measure Code":=ItemRec."Base Unit of Measure"; //HSI-22-02-10
                //"Lot Size For Material Issuance" := ItemRec."Lot Size For Material Issuance"; 5.51
                end;
                if RequisionSlipHeader.Get("Document Type", "Document No.")then if RequisionSlipHeader."Manual Requisition" then begin
                        Validate("From-Location Code", RequisionSlipHeader."Transfer-From Location");
                        Validate("Location Code", RequisionSlipHeader."Transfer-To Location");
                        Validate("Shortcut Dimension 1 Code", RequisionSlipHeader."Shortcut Dimension 1 Code");
                        Validate("Shortcut Dimension 2 Code", RequisionSlipHeader."Shortcut Dimension 2 Code");
                        "Req. Slip Document No.":="Document No.";
                    end;
            end;
        }
        field(6; Description; Text[100])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Item Unit of Measure".Code where("Item No."=field("Item No."));
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code';
        }
        field(8; Quantity; Decimal)
        {
            DecimalPlaces = 5: 5;
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                if RequisionSlipHeader.Get("Document Type", "Document No.")then if RequisionSlipHeader."Manual Requisition" then begin
                        Validate("From-Location Code", RequisionSlipHeader."Transfer-From Location");
                        Validate("Location Code", RequisionSlipHeader."Transfer-To Location");
                        Validate("Shortcut Dimension 1 Code", RequisionSlipHeader."Shortcut Dimension 1 Code");
                        Validate("Shortcut Dimension 2 Code", RequisionSlipHeader."Shortcut Dimension 2 Code");
                        "Req. Slip Document No.":="Document No.";
                    end;
            //CheckAvailableInventory("Item No.","From-Location Code",Quantity,RequisionSlipHeader."Req. Date");
            end;
        }
        field(9; "Routing Link Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Routing Link";
            DataClassification = CustomerContent;
            Caption = 'Routing Link Code';
        }
        field(10; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date';
        }
        field(11; "Due Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Time';
        }
        field(12; "Due Date-Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Due Date-Time';
        }
        field(13; "Location Code"; Code[10])
        {
            TableRelation = Location where("Use As In-Transit"=const(false));
            DataClassification = CustomerContent;
            Caption = 'Location Code';
        }
        field(14; "Remaining Qty"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Remaining Qty';
        }
        field(15; "Issued Qty"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Issued Qty';
        }
        field(16; "Qty. to Issue"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Issue';
        }
        field(17; "From-Location Code"; Code[10])
        {
            Editable = false;
            TableRelation = Location where("Use As In-Transit"=const(false));
            DataClassification = CustomerContent;
            Caption = 'From-Location Code';
        }
        field(18; "Responsibility Center"; Code[20])
        {
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(19; "Shortcut Dimension 1 Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code';
        }
        field(20; "Shortcut Dimension 2 Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code';
        }
        field(21; "Quantity Per"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Quantity Per';
        }
        field(22; "Document Type"; Option)
        {
            OptionCaption = ' ,Material Issue,Material Return';
            OptionMembers = " ", "Material Issue", "Material Return";
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(23; "Document Sub Type"; Option)
        {
            OptionCaption = ' ,Requisition,Indent,Mannual,Material Offer,PDI';
            OptionMembers = " ", Requisition, Indent, Mannual, "Material Offer", PDI;
            DataClassification = CustomerContent;
            Caption = 'Document Sub Type';
        }
        field(24; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
        }
        field(25; "Lot Size For Material Issuance"; Code[20])
        {
            Description = 'SP_NDM003';
            DataClassification = CustomerContent;
            Caption = 'Lot Size For Material Issuance';
        }
        field(26; "To Location Stock"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No."=field("Item No."), "Location Code"=field("From-Location Code")));
            Description = 'SP_NDM003';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'To Location Stock';
        }
        field(65006; Departments; Option)
        {
            OptionCaption = ' ,PPC,AWP,WIP,Conveyor,ED,Store';
            OptionMembers = " ", PPC, AWP, WIP, Conveyor, ED, Store;
            DataClassification = CustomerContent;
            Caption = 'Departments';
        }
        field(65007; "Prod.Order Source No."; Code[20])
        {
            Description = 'HSI-100310';
            DataClassification = CustomerContent;
            Caption = 'Prod.Order Source No.';
        }
        field(75000; "From-Location Inventory"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No."=field("Item No."), "Location Code"=field("From-Location Code")));
            FieldClass = FlowField;
            Caption = 'From-Location Inventory';
        }
    }
    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Prod. Order No.", "Prod.Order Source No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        "Location Code":=RequisionSlipHeader."Transfer-To Location";
        if RequisionSlipHeader.Get("Document Type", "Document No.")then if RequisionSlipHeader."Manual Requisition" then begin
                Validate("From-Location Code", RequisionSlipHeader."Transfer-From Location");
                Validate("Location Code", RequisionSlipHeader."Transfer-To Location");
                Validate("Shortcut Dimension 1 Code", RequisionSlipHeader."Shortcut Dimension 1 Code");
                Validate("Shortcut Dimension 2 Code", RequisionSlipHeader."Shortcut Dimension 2 Code");
                "Req. Slip Document No.":="Document No.";
            end;
    end;
    var ItemRec: Record Item;
    RequisionSlipHeader: Record "SSD Requision Slip Header";
    procedure GetRequisionSlipHeader()
    begin
        RequisionSlipHeader.Get("Document Type", "Document No.");
    end;
    procedure CheckAvailableInventory(var ItemNo: Code[20]; var LocCode: Code[20]; var Qty: Decimal; var PDate: Date)
    var
        ItemLedgEntryTabl: Record "Item Ledger Entry";
        AvailQty: Decimal;
        RecItem: Record Item;
    begin
        //ALLE2.11 Start
        if RecItem.Get(ItemNo)then begin
            RecItem.SetRange("Location Filter", LocCode);
            //RecItem.SETRANGE("Variant Filter",Variantcode);
            RecItem.SetRange("Date Filter", 0D, PDate);
            RecItem.CalcFields(Inventory);
            if(Qty > RecItem.Inventory)then Error('Posting Operation can not be started as Quantity for Item No. %1 exceeding available Stock' + 'at Location %2', ItemNo, LocCode);
        end;
    //ALLE2.11 End
    end;
}
