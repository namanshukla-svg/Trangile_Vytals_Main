PageExtension 50076 "SSD Production Journal" extends "Production Journal"
{
    layout
    {
        modify("Location Code")
        {
            Visible = true;

            trigger OnBeforeValidate()
            var
                Location: Record Location;
            begin
                Location.Reset();
                IF Location.GET(Rec."Location Code")THEN Location.TESTFIELD("Quality Rejects", FALSE);
            end;
        }
        modify("Starting Time")
        {
            trigger OnBeforeValidate()
            begin
                IF((Rec."Starting Time" <> 0T) AND (Rec."Ending Time" <> 0T) AND (Rec."Starting Time" < Rec."Ending Time"))THEN BEGIN
                    Rec."Run Time":=(Rec."Ending Time" - Rec."Starting Time") / 60000;
                    Rec.VALIDATE("Run Time");
                END;
            end;
        }
        modify("Ending Time")
        {
            trigger OnBeforeValidate()
            begin
                IF((Rec."Starting Time" <> 0T) AND (Rec."Ending Time" <> 0T) AND (Rec."Starting Time" < Rec."Ending Time"))THEN BEGIN
                    Rec."Run Time":=(Rec."Ending Time" - Rec."Starting Time") / 60000;
                    Rec.VALIDATE("Run Time");
                END;
            end;
        }
        addafter(FlushingFilter)
        {
            field("Manufacturing Date New"; Rec."Manufacturing Date New")
            {
                ApplicationArea = All;
                Caption = 'Manufaction Date';
                Editable = false;
            }
        }
        addafter("Order Line No.")
        {
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document No.")
        {
            field("Unit Amount"; Rec."Unit Amount")
            {
                ApplicationArea = All;
            }
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Quality Required"; Rec."Quality Required")
            {
                ApplicationArea = All;
            }
            field("New Bin Code"; Rec."New Bin Code")
            {
                ApplicationArea = All;
            }
            field("New Location Code"; Rec."New Location Code")
            {
                ApplicationArea = All;
            }
            field("Sent for Quality"; Rec."Sent for Quality")
            {
                ApplicationArea = All;
            }
            field("Quality Done"; Rec."Quality Done")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sample Quantity"; Rec."Sample Quantity")
            {
                ApplicationArea = All;
            }
            field("Quality Template Master"; Rec."Quality Template Master")
            {
                ApplicationArea = All;
            }
        }
        modify("Bin Code")
        {
            Visible = true;
        }
    }
    actions
    {
        addafter("Bin Contents")
        {
            action("Create Quality Order")
            {
                ApplicationArea = All;
                Caption = 'Create Quality Order';

                trigger OnAction()
                var
                    RoutingLine: Record "Routing Line";
                    Lines: Integer;
                    ItemJnlLine: Record "Item Journal Line";
                    QualityManagement: Codeunit "Quality Management";
                    ItemLocal: Record Item;
                    SourceTypeLocal: Option Purchase, Manufacturing, , Calibration;
                    TemplateTypeLocal: Option Receipt, Manufacturing, , Calibration;
                begin
                    ItemJournalLine2.Copy(Rec);
                    begin
                        if(ItemJournalLine2."Entry Type" = ItemJournalLine2."entry type"::Output) and (ItemJournalLine2."Quality Required")then begin
                            Rec.TestField("Sent for Quality", false);
                            Rec.TestField("Quality Done", false);
                            Rec.TestField("Quality Required", true);
                            Rec.TestField("Location Code");
                            if Rec."Sample Quantity" = 0 then Rec.TestField("Sample Quantity");
                            RoutingLine.Reset;
                            RoutingLine.SetRange(RoutingLine."Routing No.", Rec."Routing No.");
                            RoutingLine.SetRange(RoutingLine."Version Code", Rec."Variant Code");
                            RoutingLine.SetRange(RoutingLine."Operation No.", Rec."Operation No.");
                            if RoutingLine.FindFirst then RoutingLine.TestField(RoutingLine."Quality Sampling No.");
                            if Confirm(Text0010)then begin
                                Lines:=0;
                                ItemJnlLine.Reset;
                                ItemJnlLine.SetRange("Entry Type", ItemJnlLine."entry type"::Output);
                                ItemJnlLine.SetRange(ItemJnlLine."Order No.", Rec."Order No.");
                                ItemJnlLine.SetRange(ItemJnlLine."Routing No.", Rec."Routing No.");
                                ItemJnlLine.SetRange("Quality Required", true);
                                ItemJnlLine.SetRange("Sent for Quality", false);
                                ItemJnlLine.SetFilter("Output Quantity", '<>%1', 0);
                                //  ItemJnlLine.SETRANGE("Not Applicable",FALSE);
                                if ItemJnlLine.Find('-')then begin
                                    ItemLocal.Get(ItemJnlLine."Item No.");
                                    QualityManagement.CreateQOrdFromProd(Sourcetypelocal::Manufacturing, Rec, Templatetypelocal::Manufacturing);
                                    Lines:=Lines + 1;
                                end
                                else
                                    Message(Text001);
                            end;
                        end;
                    end;
                end;
            }
            action("Quality Orders")
            {
                ApplicationArea = All;
                Caption = 'Quality Orders';
                RunObject = Page "Man. Quality Order Card";
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Sent for Quality", true);
                    Clear(ManQualityOrderCard);
                    QualityOrderHdr.Reset;
                    QualityOrderHdr.SetCurrentkey("Lot No.", "Source Document No.", "Source Doc. Line No.");
                    QualityOrderHdr.SetRange("Source Document No.", Rec."Order No.");
                    QualityOrderHdr.SetRange("Process/Operation No.", Rec."Operation No.");
                    if QualityOrderHdr.FindLast then begin
                        ManQualityOrderCard.SetRecord(QualityOrderHdr);
                        ManQualityOrderCard.SetTableview(QualityOrderHdr);
                        ManQualityOrderCard.RunModal;
                    end;
                end;
            }
            action("Show &Quality Orders")
            {
                ApplicationArea = All;
                Caption = 'Show &Quality Orders';

                trigger OnAction()
                begin
                    ShowQualityOrder;
                end;
            }
            action("Show &Posted Quality Orders")
            {
                ApplicationArea = All;
                Caption = 'Show &Posted Quality Orders';

                trigger OnAction()
                begin
                    ShowPostedQualityOrder;
                end;
            }
        }
        addafter("Ledger E&ntries")
        {
            action("Print &Barcode Label")
            {
                ApplicationArea = All;
                Caption = 'Print &Barcode Label';

                trigger OnAction()
                begin
                    ReservationEntry1.Reset;
                    ReservationEntry1.SetCurrentkey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Location Code", "Item No.", "Variant Code");
                    ReservationEntry1.SetRange(ReservationEntry1."Source ID", Rec."Journal Template Name");
                    ReservationEntry1.SetRange(ReservationEntry1."Item No.", Rec."Item No.");
                    if ReservationEntry1.FindFirst then begin
                        BarcodeManufacturing.SetTableview(ReservationEntry1);
                        BarcodeManufacturing.RunModal;
                    end;
                end;
            }
        }
        addafter("Post and &Print")
        {
            action("Item Phy. Bin Details")
            {
                ApplicationArea = All;
                Caption = 'Item Phy. Bin Details';
                Image = BinJournal;
                Promoted = true;
                ShortCutKey = 'Shift+Ctrl+P';

                trigger OnAction()
                var
                    ReservationEntry: Record "Reservation Entry";
                    EntryNo: Integer;
                    LotNo: Code[20];
                    Item: Record Item;
                    LineNo: Integer;
                begin
                    if Rec."Entry Type" = Rec."entry type"::Output then begin
                        if Location.Get(Rec."Location Code")then;
                        if Item.Get(Rec."Item No.")then;
                        if(Location."Phy. Bin Required") and (Item."Phy. Bin Required")then begin
                            ItemPhyBinDetails.Reset;
                            ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                            //ItemPhyBinDetails.SETRANGE("Document Line No.","Line No.");
                            ItemPhyBinDetails.SetRange("Item No.", Rec."Item No.");
                            ItemPhyBinDetails.SetRange("Document Type", ItemPhyBinDetails."document type"::Output);
                            ItemPhyBinDetails.SetRange("Posted Document No.", '');
                            if not ItemPhyBinDetails.FindFirst then begin
                                ReservationEntry.Reset;
                                ReservationEntry.SetRange("Source ID", Rec."Document No.");
                                ReservationEntry.SetRange("Source Type", 5406);
                                ReservationEntry.SetRange("Source Subtype", 3);
                                ReservationEntry.SetRange("Item No.", Rec."Item No.");
                                if ReservationEntry.FindFirst then //REPEAT
                                    ItemPhyBinDetails.Reset;
                                ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                                if ItemPhyBinDetails.FindLast then LineNo:=ItemPhyBinDetails."Line No." + 10000
                                else
                                    LineNo:=10000;
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
                                ItemPhyBinDetails.Validate("Journal Template Name", Rec."Journal Template Name");
                                ItemPhyBinDetails.Validate("Posting Date", Rec."Posting Date");
                                //IF "Entry Type"  = "Entry Type"::Consumption THEN
                                //ItemPhyBinDetails.VALIDATE("Document Type",ItemPhyBinDetails."Document Type"::Consumption);
                                if Rec."Entry Type" = Rec."entry type"::Output then ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::Output);
                                ItemPhyBinDetails.Insert;
                            // UNTIL ReservationEntry.NEXT = 0;
                            end;
                            Commit;
                            ItemPhyBinDetails.Reset;
                            ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                            ItemPhyBinDetails.SetRange("Item No.", Rec."Item No.");
                            ItemPhyBinDetails.SetRange("Document Type", ItemPhyBinDetails."document type"::Output);
                            ItemPhyBinDetails.SetRange("Posted Document No.", '');
                            Page.RunModal(50238, ItemPhyBinDetails);
                        end;
                    end
                    else
                        Message('Please assign Phy.Bin Details for consumption on component');
                end;
            }
        }
    }
    var ProdOrderHeaderL: Record "Production Order";
    ProdOrderLineL: Record "Prod. Order Line";
    Text0000123: label 'Lot not scnned  for %1';
    Text003: label 'Create Quality Order for the Template Name = %1,  Batch Name = %2, Line No = %3';
    ManQualityOrderCard: Page "Man. Quality Order Card";
    QualityOrderHdr: Record "SSD Quality Order Header";
    ItemJournalLine2: Record "Item Journal Line";
    Text0010: label 'Do you want to create Quality Order ?';
    Text002: label '%1 nos. of Quality Order Generated ';
    Text001: label 'No Lines found for Quality Order Generation';
    Text50000: label 'Quality is Pending.';
    ItemJournalLine3: Record "Item Journal Line";
    ReservationEntry1: Record "Reservation Entry";
    BarcodeManufacturing: Report "BARCODE LEBEL MANUFACTURING4x6";
    ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";
    Location: Record Location;
    ReservationEntry: Record "Reservation Entry";
    procedure ShowQualityOrder()
    var
        QualityOrdHdrLocal: Record "SSD Quality Order Header";
        FrmQltOrderList: Page "Quality Order List";
    begin
        //CF001.01 St
        Rec.TestField("Quality Required", true);
        QualityOrdHdrLocal.Reset;
        QualityOrdHdrLocal.FilterGroup(2);
        QualityOrdHdrLocal.SetRange("Template Type", QualityOrdHdrLocal."template type"::Manufacturing);
        QualityOrdHdrLocal.SetRange("Entry Source Type", QualityOrdHdrLocal."entry source type"::"Manufac.");
        QualityOrdHdrLocal.SetRange("Source Document No.", Rec."Order No.");
        QualityOrdHdrLocal.SetRange("Process/Operation No.", Rec."Operation No.");
        QualityOrdHdrLocal.FilterGroup(2);
        if QualityOrdHdrLocal.Find('-')then begin
            Clear(FrmQltOrderList);
            FrmQltOrderList.SetTableview(QualityOrdHdrLocal);
            FrmQltOrderList.RunModal;
        end;
    end;
    procedure ShowPostedQualityOrder()
    var
        QualityOrdHdrLocal: Record "SSD Posted Quality Order Hdr";
        FrmQltOrderList: Page "Posted Quality Order List";
    begin
        Rec.TestField("Quality Required", true);
        Rec.TestField("Quality Done", true);
        QualityOrdHdrLocal.Reset;
        QualityOrdHdrLocal.FilterGroup(2);
        QualityOrdHdrLocal.SetRange("Source Document No.", Rec."Order No.");
        QualityOrdHdrLocal.SetRange("Process/Operation No.", Rec."Operation No.");
        QualityOrdHdrLocal.FilterGroup(2);
        Clear(FrmQltOrderList);
        FrmQltOrderList.SetTableview(QualityOrdHdrLocal);
        FrmQltOrderList.RunModal;
    end;
}
