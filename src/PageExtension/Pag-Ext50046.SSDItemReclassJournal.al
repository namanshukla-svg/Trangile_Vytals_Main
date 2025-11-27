PageExtension 50046 "SSD Item Reclass. Journal" extends "Item Reclass. Journal"
{
    layout
    {
        modify("Document No.")
        {
            trigger OnBeforeValidate()
            begin
                ItemPhyBinDetails.RESET;
                ItemPhyBinDetails.SETRANGE("Document No.", xRec."Document No.");
                ItemPhyBinDetails.SETRANGE("Posted Document No.", '');
                ItemPhyBinDetails.SETRANGE("Whse. Entry  No.", 0);
                ItemPhyBinDetails.SETRANGE("Item No.", xRec."Item No.");
                IF NOT ItemPhyBinDetails.ISEMPTY THEN ERROR('Phy. Bin Details exist.');
            end;
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            begin
                IF Rec.Quantity = 0 THEN BEGIN
                    ItemPhyBinDetails.RESET;
                    ItemPhyBinDetails.SETRANGE("Document No.", Rec."Document No.");
                    ItemPhyBinDetails.SETRANGE("Document Line No.", Rec."Line No.");
                    ItemPhyBinDetails.SETRANGE("Item No.", Rec."Item No.");
                    ItemPhyBinDetails.SETRANGE("Whse. Entry  No.", 0);
                    IF ItemPhyBinDetails.FINDSET THEN ItemPhyBinDetails.DELETEALL;
                END;
            end;
        }
        modify("New Bin Code")
        {
            Visible = true;
        }
        addafter("New Bin Code")
        {
            field("Phy. Bin Code"; Rec."Phy. Bin Code")
            {
                ApplicationArea = All;
                Editable = EditablebyBatch;
            }
            field("New Phy. Bin Code"; Rec."New Phy. Bin Code")
            {
                ApplicationArea = All;
                Editable = EditablebyBatch;
            }
        }
        addafter("Gen. Prod. Posting Group")
        {
            field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
            {
                ApplicationArea = All;
            }
        }
        addafter("Reason Code")
        {
            field("Entry Type"; Rec."Entry Type")
            {
                ApplicationArea = All;
                Editable = EditablebyBatch;
            }
        }
        modify("Bin Code")
        {
            Visible = true;
        }
        moveafter("Qty. per Unit of Measure"; "Bin Code")
    }
    actions
    {
        addafter("&Print")
        {
            action("Phy. Item Details")
            {
                ApplicationArea = All;
                Caption = 'Phy. Item Details';
                Image = BinJournal;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Shift+Ctrl+P';

                trigger OnAction()
                var
                    Item: Record Item;
                    LineNo: Integer;
                begin
                    //CORP::PK 010719 >>>
                    if Rec."Journal Batch Name" <> 'DEFAULT' then begin
                        if Location.Get(Rec."Location Code")then;
                        if Location1.Get(Rec."New Location Code")then;
                        if Item.Get(Rec."Item No.")then;
                        if(((Location."Phy. Bin Required") or (Location1."Phy. Bin Required")) and (Item."Phy. Bin Required"))then begin
                            ItemPhyBinDetails.Reset;
                            ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                            ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                            ItemPhyBinDetails.SetRange("Posted Document No.", '');
                            if not ItemPhyBinDetails.FindFirst then begin
                                ReservationEntry.Reset;
                                ReservationEntry.SetRange("Source ID", Rec."Journal Template Name");
                                ReservationEntry.SetRange("Source Batch Name", Rec."Journal Batch Name");
                                ReservationEntry.SetRange("Item No.", Rec."Item No.");
                                ReservationEntry.SetRange("Source Ref. No.", Rec."Line No."); //CORP 221019
                                if ReservationEntry.FindSet then repeat ItemPhyBinDetails.Reset;
                                        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                                        if ItemPhyBinDetails.FindLast then LineNo:=ItemPhyBinDetails."Line No." + 10000
                                        else
                                            LineNo:=10000;
                                        if Rec."Entry Type" = Rec."entry type"::Transfer then begin
                                            if Location."Phy. Bin Required" then begin
                                                ItemPhyBinDetails.Init;
                                                ItemPhyBinDetails.Validate("Line No.", LineNo);
                                                ItemPhyBinDetails.Validate("Document No.", Rec."Document No.");
                                                ItemPhyBinDetails.Validate("Document Line No.", Rec."Line No.");
                                                ItemPhyBinDetails.Validate("Item No.", Rec."Item No.");
                                                ItemPhyBinDetails.Validate("Qty. Per Unit Of Measure", Rec."Qty. per Unit of Measure");
                                                ItemPhyBinDetails.Validate("Unit Of Measure", Rec."Unit of Measure Code");
                                                ItemPhyBinDetails.Validate("Location Code", Rec."Location Code");
                                                ItemPhyBinDetails.Validate("Bin Code", Rec."Bin Code");
                                                ItemPhyBinDetails.Validate("Lot No.", ReservationEntry."Lot No.");
                                                ItemPhyBinDetails.Validate("Journal Batch Name", Rec."Journal Batch Name");
                                                ItemPhyBinDetails.Validate("Posting Date", Rec."Posting Date");
                                                ItemPhyBinDetails.Validate(Quantity, ReservationEntry."Quantity (Base)");
                                                ItemPhyBinDetails.Validate("Journal Template Name", Rec."Journal Template Name");
                                                ItemPhyBinDetails.Validate("Phy. Bin Code", Rec."Phy. Bin Code");
                                                if Rec."Entry Type" = Rec."entry type"::Transfer then ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::Transfer);
                                                ItemPhyBinDetails.Insert;
                                            end;
                                            if Location1."Phy. Bin Required" then begin
                                                ItemPhyBinDetails.Init;
                                                ItemPhyBinDetails.Validate("Line No.", LineNo + 10000);
                                                ItemPhyBinDetails.Validate("Document No.", Rec."Document No.");
                                                ItemPhyBinDetails.Validate("Document Line No.", Rec."Line No.");
                                                ItemPhyBinDetails.Validate("Item No.", Rec."Item No.");
                                                ItemPhyBinDetails.Validate("Unit Of Measure", Rec."Unit of Measure Code");
                                                ItemPhyBinDetails.Validate("Qty. Per Unit Of Measure", Rec."Qty. per Unit of Measure");
                                                ItemPhyBinDetails.Validate("Location Code", Rec."New Location Code");
                                                ItemPhyBinDetails.Validate("Bin Code", Rec."New Bin Code");
                                                ItemPhyBinDetails.Validate("Posting Date", Rec."Posting Date");
                                                ItemPhyBinDetails.Validate("Lot No.", ReservationEntry."Lot No.");
                                                ItemPhyBinDetails.Validate("Journal Batch Name", Rec."Journal Batch Name");
                                                ItemPhyBinDetails.Validate("Journal Template Name", Rec."Journal Template Name");
                                                ItemPhyBinDetails.Validate(Quantity, -ReservationEntry."Quantity (Base)");
                                                ItemPhyBinDetails.Validate("Phy. Bin Code", Rec."New Phy. Bin Code");
                                                //ItemPhyBinDetails.VALIDATE("Phy. Bin Code",PhysicalBin);
                                                if Rec."Entry Type" = Rec."entry type"::Transfer then ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::Transfer);
                                                ItemPhyBinDetails.Insert;
                                            end;
                                        end;
                                        if(Rec."Entry Type" = Rec."entry type"::"Positive Adjmt.") or (Rec."Entry Type" = Rec."entry type"::"Negative Adjmt.")then begin
                                            if Location."Phy. Bin Required" then begin
                                                ItemPhyBinDetails.Init;
                                                ItemPhyBinDetails.Validate("Line No.", LineNo);
                                                ItemPhyBinDetails.Validate("Document No.", Rec."Document No.");
                                                ItemPhyBinDetails.Validate("Document Line No.", Rec."Line No.");
                                                ItemPhyBinDetails.Validate("Item No.", Rec."Item No.");
                                                ItemPhyBinDetails.Validate("Qty. Per Unit Of Measure", Rec."Qty. per Unit of Measure");
                                                ItemPhyBinDetails.Validate("Unit Of Measure", Rec."Unit of Measure Code");
                                                ItemPhyBinDetails.Validate("Location Code", Rec."Location Code");
                                                ItemPhyBinDetails.Validate("Bin Code", Rec."Bin Code");
                                                ItemPhyBinDetails.Validate("Lot No.", ReservationEntry."Lot No.");
                                                ItemPhyBinDetails.Validate("Journal Batch Name", Rec."Journal Batch Name");
                                                ItemPhyBinDetails.Validate("Posting Date", Rec."Posting Date");
                                                //ItemPhyBinDetails.VALIDATE("Phy. Bin Code","Phy. Bin Code");
                                                if Rec."Entry Type" = Rec."entry type"::"Positive Adjmt." then begin
                                                    ItemPhyBinDetails.Validate(Quantity, ReservationEntry."Quantity (Base)");
                                                    ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::"Positive Adjmt.");
                                                end;
                                                if Rec."Entry Type" = Rec."entry type"::"Negative Adjmt." then begin
                                                    ItemPhyBinDetails.Validate(Quantity, ReservationEntry."Quantity (Base)");
                                                    ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::"Negative Adjmt.");
                                                end;
                                                ItemPhyBinDetails.Validate("Journal Template Name", Rec."Journal Template Name");
                                                ItemPhyBinDetails.Insert;
                                            end;
                                        end;
                                    until ReservationEntry.Next = 0;
                            end;
                            Commit;
                            ItemPhyBinDetails.Reset;
                            ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                            ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                            ItemPhyBinDetails.SetRange("Posted Document No.", '');
                            Page.RunModal(50238, ItemPhyBinDetails);
                        end;
                    end
                    else
                    begin
                        ItemPhyBinDetails.Reset;
                        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                        ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                        ItemPhyBinDetails.SetRange("Posted Document No.", '');
                        Page.RunModal(50238, ItemPhyBinDetails);
                    end;
                //CORP::PK 010719 <<<
                end;
            }
        }
    }
    var Item: Record Item;
    Qty: Decimal;
    Qty1: Decimal;
    ItemPhyBinDetails1: Record "SSD Item Phy. Bin Details";
    Location: Record Location;
    ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    Location1: Record Location;
    ReservationEntry: Record "Reservation Entry";
    EditablebyBatch: Boolean;
    trigger OnDeleteRecord(): Boolean begin
        ItemPhyBinDetails.RESET;
        ItemPhyBinDetails.SETRANGE("Document No.", Rec."Document No.");
        ItemPhyBinDetails.SETRANGE("Document Line No.", Rec."Line No.");
        ItemPhyBinDetails.SETRANGE("Item No.", Rec."Item No.");
        ItemPhyBinDetails.SETRANGE("Whse. Entry  No.", 0);
        IF ItemPhyBinDetails.FINDSET THEN ItemPhyBinDetails.DELETEALL;
    end;
}
