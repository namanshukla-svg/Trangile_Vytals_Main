TableExtension 50100 "SSD Transfer Line" extends "Transfer Line"
{
    fields
    {
        modify(Quantity)
        {
        trigger OnAfterValidate()
        begin
            "Amount DUP. CSP":="Trf Price DUP. CSP" * Quantity;
        end;
        }
        field(50050; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50051; "No. 2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("Item No.")));
            Description = 'CEN001 Flow field';
            FieldClass = FlowField;
            Caption = 'No. 2';
        }
        field(50052; "Inventory P Group"; Code[10])
        {
            Description = 'CN_RM23042007';
            DataClassification = CustomerContent;
            Caption = 'Inventory P Group';
        }
        field(50053; "Subcontracting Transfer Order"; Boolean)
        {
            Description = 'ALLEAA CML-033 230408';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Transfer Order';
        }
        field(50054; "Shipment Posted"; Boolean)
        {
            Description = 'ALLEAA CML-033 250408';
            DataClassification = CustomerContent;
            Caption = 'Shipment Posted';
        }
        field(50055; "Trf Price DUP. CSP"; Decimal)
        {
            Description = 'ALLE-NM 26062019';
            DataClassification = CustomerContent;
            Caption = 'Trf Price DUP. CSP';

            trigger OnValidate()
            begin
                "Amount DUP. CSP":="Trf Price DUP. CSP" * Quantity; //ALLE-NM 26062019
            end;
        }
        field(50056; "Amount DUP. CSP"; Decimal)
        {
            Description = 'ALLE-NM 26062019';
            DataClassification = CustomerContent;
            Caption = 'Amount DUP. CSP';
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
                SelectItemEntry(FieldNo("Applies-to Entry"));
            end;
        }
        field(65011; "Required Qty."; Decimal)
        {
            Description = 'ALLE3.26';
            DataClassification = CustomerContent;
            Caption = 'Required Qty.';
        }
    }
    local procedure SelectItemEntry(CurrentFieldNo: Integer)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        TransferLine2: Record "Transfer Line";
    begin
        SetItemLedgerEntryFilters(ItemLedgEntry);
        if PAGE.RunModal(PAGE::"Item Ledger Entries", ItemLedgEntry) = ACTION::LookupOK then begin
            TransferLine2:=Rec;
            TransferLine2.Validate("Appl.-to Item Entry", ItemLedgEntry."Entry No.");
            CheckItemAvailable(CurrentFieldNo);
            Rec:=TransferLine2;
        end;
    end;
    local procedure SetItemLedgerEntryFilters(var ItemLedgEntry: Record "Item Ledger Entry")
    begin
        ItemLedgEntry.SetRange("Item No.", "Item No.");
        if "Transfer-from Code" <> '' then ItemLedgEntry.SetRange("Location Code", "Transfer-from Code");
        ItemLedgEntry.SetRange("Variant Code", "Variant Code");
        ItemLedgEntry.SetRange(Positive, true);
        ItemLedgEntry.SetRange(Open, true);
    end;
}
