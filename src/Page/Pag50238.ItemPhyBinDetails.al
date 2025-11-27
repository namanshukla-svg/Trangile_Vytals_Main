Page 50238 "Item Phy. Bin Details"
{
    PageType = Worksheet;
    ShowFilter = false;
    SourceTable = "SSD Item Phy. Bin Details";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Phy. Bin Code"; Rec."Phy. Bin Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        Text001: label 'Quantity should be multiple of pack size.';
                    begin
                        Rec.TestField("Phy. Bin Code");
                        if Item.Get(Rec."Item No.")then if Item."Pack Size" = 0 then PackSize:=1
                            else
                                PackSize:=Item."Pack Size";
                        if Rec."Document Type" = Rec."document type"::Output then Ratio:=Rec.Quantity MOD PackSize;
                        if Ratio <> 0 then Message(Text001);
                    //CORP::PK 210819
                    end;
                }
                field("Qty. Per Unit Of Measure"; Rec."Qty. Per Unit Of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;

                action(CopyLine)
                {
                    ApplicationArea = All;
                    Caption = 'CopyLine';
                    Image = Copy;
                    Promoted = true;

                    trigger OnAction()
                    var
                        LineNo: Integer;
                    begin
                        Rec.TestField(Quantity);
                        Rec.TestField("Phy. Bin Code");
                        ItemPhyBinDetails.Reset;
                        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                        if ItemPhyBinDetails.FindLast then LineNo:=ItemPhyBinDetails."Line No." + 10000;
                        ItemPhyBinDetails.Init;
                        ItemPhyBinDetails.Validate("Document No.", Rec."Document No.");
                        ItemPhyBinDetails.Validate("Line No.", LineNo);
                        ItemPhyBinDetails.Validate("Document Line No.", Rec."Document Line No.");
                        ItemPhyBinDetails.Validate("Item No.", Rec."Item No.");
                        ItemPhyBinDetails.Validate("Location Code", Rec."Location Code");
                        ItemPhyBinDetails.Validate("Unit Of Measure", Rec."Unit Of Measure");
                        ItemPhyBinDetails.Validate("Bin Code", Rec."Bin Code");
                        ItemPhyBinDetails.Validate("Lot No.", Rec."Lot No.");
                        ItemPhyBinDetails.Validate("Qty. Per Unit Of Measure", Rec."Qty. Per Unit Of Measure");
                        ItemPhyBinDetails.Validate("Document Type", Rec."Document Type");
                        ItemPhyBinDetails.Validate("Posting Date", Rec."Posting Date");
                        ItemPhyBinDetails.Validate("Journal Batch Name", Rec."Journal Batch Name");
                        ItemPhyBinDetails.Validate("Journal Template Name", Rec."Journal Template Name");
                        ItemPhyBinDetails.Insert;
                    end;
                }
                action("Phy. Bin Details")
                {
                    ApplicationArea = All;
                    Caption = 'Phy. Bin Details';
                    Image = "Report";
                    Promoted = true;

                    trigger OnAction()
                    begin
                        ItemPhyBinDetails.Reset;
                        ItemPhyBinDetails.SetRange("Location Code", Rec."Location Code");
                        ItemPhyBinDetails.SetRange("Bin Code", Rec."Bin Code");
                        ItemPhyBinDetails.SetRange("Item No.", Rec."Item No.");
                        ItemPhyBinDetails.SetRange("Lot No.", Rec."Lot No.");
                        Report.RunModal(50263, true, false, ItemPhyBinDetails);
                    end;
                }
            }
        }
    }
    trigger OnDeleteRecord(): Boolean begin
    // IF "Document Type" = "Document Type"::Transfer THEN
    //  ERROR('You can not delete this line');
    //CORP::PK 140120
    end;
    trigger OnQueryClosePage(CloseAction: action): Boolean begin
        if Rec.FindFirst then repeat ItemPhyBinDetails.Reset;
                ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                if ItemPhyBinDetails.FindFirst then begin
                    Qty:=0;
                    LotQty:=0;
                    if Rec."Document Type" = Rec."document type"::"Whse. Receipt" then begin
                        ReservationEntry.Reset;
                        ReservationEntry.SetRange("MRN No.", Rec."Document No.");
                        ReservationEntry.SetRange("Item Ledger Entry No.", 0);
                        ReservationEntry.SetRange("MRN Line No.", Rec."Document Line No.");
                        ReservationEntry.SetRange("Lot No.", Rec."Lot No.");
                        if ReservationEntry.FindSet then repeat LotQty+=ReservationEntry."Quantity (Base)";
                            until ReservationEntry.Next = 0;
                    end;
                    if(Rec."Document Type" = Rec."document type"::Output) or (Rec."Document Type" = Rec."document type"::"Negative Adjmt.") or (Rec."Document Type" = Rec."document type"::"Positive Adjmt.") or (Rec."Document Type" = Rec."document type"::Transfer)then begin
                        ReservationEntry.Reset;
                        ReservationEntry.SetRange("Source ID", Rec."Journal Template Name");
                        ReservationEntry.SetRange("Source Ref. No.", Rec."Document Line No.");
                        ReservationEntry.SetRange("Item No.", Rec."Item No.");
                        ReservationEntry.SetRange("Lot No.", Rec."Lot No.");
                        if ReservationEntry.FindSet then repeat LotQty+=ReservationEntry."Quantity (Base)";
                            until ReservationEntry.Next = 0;
                    end;
                    if Rec."Document Type" = Rec."document type"::Consumption then begin
                        ReservationEntry.Reset;
                        ReservationEntry.SetRange("Source ID", Rec."Document No.");
                        ReservationEntry.SetRange("Source Ref. No.", Rec."Document Line No.");
                        ReservationEntry.SetRange("Item No.", Rec."Item No.");
                        ReservationEntry.SetRange("Lot No.", Rec."Lot No.");
                        ReservationEntry.SetRange("Source Type", 5407);
                        if ReservationEntry.FindSet then repeat LotQty+=ReservationEntry."Quantity (Base)";
                            until ReservationEntry.Next = 0;
                    end; //CORP::090120
                    if(LotQty <> 0) and (Rec."Document Type" = Rec."document type"::Consumption)then begin
                        QtyConsumption:=0;
                        ItemPhyBinDetails.Reset;
                        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                        ItemPhyBinDetails.SetRange("Document Line No.", Rec."Document Line No.");
                        ItemPhyBinDetails.SetRange("Location Code", Rec."Location Code");
                        ItemPhyBinDetails.SetRange("Item No.", Rec."Item No.");
                        ItemPhyBinDetails.SetRange("Whse. Entry  No.", 0);
                        if ItemPhyBinDetails.FindSet then repeat QtyConsumption+=ItemPhyBinDetails."ILE Quantity";
                            until ItemPhyBinDetails.Next = 0;
                        ProdOrderComponent.Reset;
                        ProdOrderComponent.SetRange("Prod. Order No.", ItemPhyBinDetails."Document No.");
                        ProdOrderComponent.SetRange("Line No.", ItemPhyBinDetails."Document Line No.");
                        ProdOrderComponent.SetRange("Item No.", ItemPhyBinDetails."Item No.");
                        if ProdOrderComponent.FindFirst then if Abs(ProdOrderComponent."Qty. To Consume") <> Abs(QtyConsumption)then Error('Quantity Must be equal to %1', ProdOrderComponent."Qty. To Consume");
                    end; //CORP::PK 100120
                    if(LotQty = 0) and (Rec."Document Type" = Rec."document type"::Consumption)then begin
                        ReservationEntry.Reset;
                        ReservationEntry.SetRange("Source ID", 'CONSUMPTIO');
                        //ReservationEntry.SETFILTER("Source Batch Name",'%1|%2','DEFAULT','M');  //ALLE-151220 commented
                        ReservationEntry.SetRange("Source Batch Name", Rec."Journal Batch Name"); //ALLE-151220
                        ReservationEntry.SetRange("Item No.", Rec."Item No.");
                        ReservationEntry.SetRange("Lot No.", Rec."Lot No.");
                        ReservationEntry.SetRange("Source Type", 83);
                        if ReservationEntry.FindSet then repeat LotQty+=ReservationEntry."Quantity (Base)";
                            until ReservationEntry.Next = 0;
                    end; //CORP::090120
                    if(Rec."Document Type" = Rec."document type"::"Sales Invoice") or (Rec."Document Type" = Rec."document type"::"Purch. Credit Memo") or (Rec."Document Type" = Rec."document type"::"Transfer Order Ship") or (Rec."Document Type" = Rec."document type"::"Transfer Order Receipt")then begin
                        ReservationEntry.Reset;
                        ReservationEntry.SetRange("Source ID", Rec."Document No.");
                        ReservationEntry.SetRange("Item Ledger Entry No.", 0);
                        //ReservationEntry.SETRANGE("Source Ref. No.","Document Line No.");
                        ReservationEntry.SetRange("Location Code", Rec."Location Code");
                        ReservationEntry.SetRange("Item No.", Rec."Item No.");
                        ReservationEntry.SetRange("Lot No.", Rec."Lot No.");
                        if ReservationEntry.FindSet then repeat LotQty+=ReservationEntry."Quantity (Base)";
                            until ReservationEntry.Next = 0;
                    end;
                    if Rec."Document Type" = Rec."document type"::"Sub Con. Order Send" then begin
                        ReservationEntry.Reset;
                        ReservationEntry.SetRange("Source ID", Rec."Document No.");
                        ReservationEntry.SetRange("Item Ledger Entry No.", 0);
                        ReservationEntry.SetRange("Source Ref. No.", Rec."Document Line No.");
                        ReservationEntry.SetRange("Lot No.", Rec."Lot No.");
                        ReservationEntry.SetRange("Source Type", 16321);
                        if ReservationEntry.FindSet then repeat LotQty+=ReservationEntry."Quantity (Base)";
                            until ReservationEntry.Next = 0;
                    end;
                    if Rec."Document Type" = Rec."document type"::"Sub Con. Order Receive" then begin
                        ReservationEntry.Reset;
                        ReservationEntry.SetRange("Item No.", Rec."Item No.");
                        ReservationEntry.SetRange("Item Ledger Entry No.", 0);
                        ReservationEntry.SetRange("Location Code", Rec."Location Code");
                        ReservationEntry.SetRange("Lot No.", Rec."Lot No.");
                        ReservationEntry.SetRange("Source ID", Rec."Document No.");
                        ReservationEntry.SetRange("Source Type", 5406);
                        if ReservationEntry.FindSet then repeat LotQty+=ReservationEntry."Quantity (Base)";
                            until ReservationEntry.Next = 0;
                    end;
                    if Rec."Document Type" <> Rec."document type"::Transfer then begin //add 05082019
                        ItemPhyBinDetails.Reset;
                        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                        ItemPhyBinDetails.SetRange("Document Line No.", Rec."Document Line No.");
                        ItemPhyBinDetails.SetRange("Lot No.", Rec."Lot No.");
                        ItemPhyBinDetails.SetRange("Location Code", Rec."Location Code");
                        ItemPhyBinDetails.SetRange("Whse. Entry  No.", 0);
                        if ItemPhyBinDetails.FindSet then repeat Qty+=ItemPhyBinDetails."ILE Quantity";
                            until ItemPhyBinDetails.Next = 0;
                    end; //add 05082019
                    if Rec."Document Type" = Rec."document type"::Transfer then begin
                        ItemPhyBinDetails.Reset;
                        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                        ItemPhyBinDetails.SetRange("Document Line No.", Rec."Document Line No.");
                        ItemPhyBinDetails.SetRange("Lot No.", Rec."Lot No.");
                        //ItemPhyBinDetails.SETRANGE("Location Code","Location Code");
                        ItemPhyBinDetails.SetFilter(Quantity, '>%1', 0);
                        ItemPhyBinDetails.SetRange("Whse. Entry  No.", 0);
                        if ItemPhyBinDetails.FindSet then repeat Qty+=ItemPhyBinDetails."ILE Quantity";
                            until ItemPhyBinDetails.Next = 0;
                    end;
                    if Rec."Document Type" = Rec."document type"::Consumption then if Qty <> LotQty then Error('Quantity mismatch Qty %1 Lot Qty %2', Qty, LotQty);
                    if Abs(Qty) <> Abs(LotQty)then Error('Quantity mismatch! Qty %1 Lot Qty %2', Qty, LotQty);
                end;
                Qty:=0;
                if Rec."Document Type" = Rec."document type"::Transfer then begin
                    ItemPhyBinDetails.Reset;
                    ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                    ItemPhyBinDetails.SetRange("Document Line No.", Rec."Document Line No.");
                    ItemPhyBinDetails.SetRange("Lot No.", Rec."Lot No.");
                    ItemPhyBinDetails.SetRange("Whse. Entry  No.", 0);
                    if ItemPhyBinDetails.FindSet then repeat Qty+=ItemPhyBinDetails."ILE Quantity";
                        until ItemPhyBinDetails.Next = 0;
                    ItemPhyBinDetails.Reset;
                    ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                    ItemPhyBinDetails.SetRange("Document Line No.", Rec."Document Line No.");
                    ItemPhyBinDetails.SetRange("Lot No.", Rec."Lot No.");
                    ItemPhyBinDetails.SetFilter(Quantity, '>%1', 0);
                    if ItemPhyBinDetails.FindFirst then begin
                        ItemPhyBinDetails1.Reset;
                        ItemPhyBinDetails1.SetRange("Document No.", Rec."Document No.");
                        ItemPhyBinDetails1.SetRange("Document Line No.", Rec."Document Line No.");
                        ItemPhyBinDetails1.SetRange("Lot No.", Rec."Lot No.");
                        ItemPhyBinDetails1.SetFilter(Quantity, '<%1', 0);
                        if ItemPhyBinDetails1.FindFirst then begin
                            if Qty <> 0 then Error('Quantity mismatch!');
                        end;
                    end;
                end;
                if Location.Get(Rec."Location Code")then if Rec."Phy. Bin Code" = '' then Error('Phy. Bin Must Have Value For Location %1', Rec."Location Code");
                Qty:=0;
                Qty1:=0;
                if(Rec."Document Type" = Rec."document type"::Transfer) or (Rec."Document Type" = Rec."document type"::"Transfer Order Ship") or (Rec."Document Type" = Rec."document type"::"Transfer Order Receipt")then begin
                    ItemPhyBinDetails.Reset;
                    ItemPhyBinDetails.SetFilter("ILE Quantity", '<%1', 0);
                    ItemPhyBinDetails.SetRange("Item No.", Rec."Item No.");
                    ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                    ItemPhyBinDetails.SetRange("Location Code", Rec."Location Code");
                    ItemPhyBinDetails.SetRange("Bin Code", Rec."Bin Code");
                    ItemPhyBinDetails.SetRange("Phy. Bin Code", Rec."Phy. Bin Code");
                    ItemPhyBinDetails.SetRange("Lot No.", Rec."Lot No.");
                    ItemPhyBinDetails.SetRange("Whse. Entry  No.", 0);
                    if ItemPhyBinDetails.FindSet then repeat Qty+=ItemPhyBinDetails."ILE Quantity";
                        until ItemPhyBinDetails.Next = 0;
                    ItemPhyBinDetails.Reset;
                    ItemPhyBinDetails.SetRange("Item No.", Rec."Item No.");
                    ItemPhyBinDetails.SetRange("Location Code", Rec."Location Code");
                    ItemPhyBinDetails.SetRange("Bin Code", Rec."Bin Code");
                    ItemPhyBinDetails.SetRange("Phy. Bin Code", Rec."Phy. Bin Code");
                    ItemPhyBinDetails.SetRange("Lot No.", Rec."Lot No.");
                    ItemPhyBinDetails.SetFilter("Whse. Entry  No.", '<>%1', 0);
                    if ItemPhyBinDetails.FindSet then repeat Qty1+=ItemPhyBinDetails."ILE Quantity";
                        until ItemPhyBinDetails.Next = 0;
                    if Abs(Qty1) < Abs(Qty)then Error('Insufficient Quantity in Phy. Bin %1', Rec."Phy. Bin Code");
                end;
            until Rec.Next = 0;
        //CORP::PK 130520 >>>
        ItemPhyBinDetails.Reset;
        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
        ItemPhyBinDetails.SetRange("Item No.", '');
        ItemPhyBinDetails.SetRange("Line No.", 0);
        if ItemPhyBinDetails.FindSet then ItemPhyBinDetails.DeleteAll;
    //CORP::PK 130520 <<<
    end;
    var ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    ReservationEntry: Record "Reservation Entry";
    LotQty: Decimal;
    Qty: Decimal;
    ItemPhyBinDetails1: Record "SSD Item Phy. Bin Details";
    Location: Record Location;
    QtyToReceive: Decimal;
    QtyToReceive2: Decimal;
    Qty1: Decimal;
    Item: Record Item;
    Ratio: Decimal;
    PackSize: Integer;
    QtyConsumption: Decimal;
    ProdOrderComponent: Record "Prod. Order Component";
}
