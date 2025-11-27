Page 50007 "Purch. Invoice Subform Direct"
{
    AutoSplitKey = true;
    Caption = 'Purch. Invoice Subform';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type"=filter(Invoice));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                    //SSDU Comment
                    // Rec.ShowShortcutDimCode(ShortcutDimCode);
                    // NoOnAfterValidate;
                    //SSDU Comment End
                    end;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnValidate()
                    var
                        PurchaseLineService: Record "Purchase Line";
                        PurchaseHeaderRec: Record "Purchase Header";
                        PurchaseHeaderService: Record "Purchase Header";
                    begin
                    // //Alle 17062021
                    // PurchaseHeaderRec.RESET;
                    // PurchaseHeaderRec.SETRANGE("No.",Rec."Document No.");
                    // IF PurchaseHeaderRec.FINDFIRST THEN;
                    //
                    // PurchaseHeaderService.RESET;
                    // PurchaseHeaderService.SETRANGE("No.",PurchaseHeaderRec."Service Order No.");
                    // IF PurchaseHeaderService.FINDFIRST THEN;
                    //
                    // PurchaseLineService.RESET;
                    // PurchaseLineService.SETRANGE("Document No.",PurchaseHeaderService."No.");
                    // PurchaseLineService.SETRANGE("Line No.",Rec."Line No.");
                    // PurchaseLineService.SETRANGE("No.",Rec."No.");
                    // IF PurchaseLineService.FINDFIRST THEN;
                    //
                    // IF PurchaseHeaderRec."Service Order No." <> '' THEN BEGIN
                    //  IF (PurchaseLineService."Outstanding Quantity"<Rec.Quantity) OR (PurchaseLineService."Outstanding Quantity" = Rec.Quantity) THEN
                    //    MESSAGE('You can not take more than %1',PurchaseLineService."Outstanding Quantity");
                    // END;
                    //
                    // IF PurchaseHeaderRec."Service Order No." <> '' THEN BEGIN
                    //  IF (PurchaseLineService."Outstanding Amount"=Rec."Outstanding Amount") OR (PurchaseLineService."Outstanding Amount"<Rec."Outstanding Amount") THEN
                    //    ERROR('You can not take Outstanding Amount more than %1',PurchaseLineService."Outstanding Amount");
                    // END;
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnValidate()
                    var
                        PurchaseHeaderRec: Record "Purchase Header";
                        PurchaseHeaderService: Record "Purchase Header";
                        PurchaseLineService: Record "Purchase Line";
                    begin
                    // //Alle 17062021
                    // PurchaseHeaderRec.RESET;
                    // PurchaseHeaderRec.SETRANGE("No.",Rec."Document No.");
                    // IF PurchaseHeaderRec.FINDFIRST THEN;
                    //
                    // PurchaseHeaderService.RESET;
                    // PurchaseHeaderService.SETRANGE("No.",PurchaseHeaderRec."Service Order No.");
                    // IF PurchaseHeaderService.FINDFIRST THEN;
                    //
                    // PurchaseLineService.RESET;
                    // PurchaseLineService.SETRANGE("Document No.",PurchaseHeaderService."No.");
                    // PurchaseLineService.SETRANGE("Line No.",Rec."Line No.");
                    // PurchaseLineService.SETRANGE("No.",Rec."No.");
                    // IF PurchaseLineService.FINDFIRST THEN;
                    //
                    // IF PurchaseHeaderRec."Service Order No." <> '' THEN BEGIN
                    //  IF (PurchaseLineService."Outstanding Amount"=Rec."Outstanding Amount") OR (PurchaseLineService."Outstanding Amount"<Rec."Outstanding Amount") THEN
                    //     ERROR('You can not take Outstanding Amount more than %1',PurchaseLineService."Outstanding Amount");
                    // END;
                    end;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Outstanding Amount (LCY)"; Rec."Outstanding Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Nature of Remittance"; Rec."Nature of Remittance")
                {
                    ApplicationArea = All;
                }
                field(Supplementary; Rec.Supplementary)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Source Document Type"; Rec."Source Document Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord;
                        Rec.ShowItemChargeAssgnt;
                        UpdateForm(false);
                    end;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("GST Group Type"; Rec."GST Group Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("GST Reverse Charge"; Rec."GST Reverse Charge")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Exempted; Rec.Exempted)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Service Order No."; Rec."Service Order No.")
                {
                    ApplicationArea = All;
                }
                field("Service Outstanding Amount"; Rec."Service Outstanding Amount")
                {
                    ApplicationArea = All;
                }
            }
            group(ItemPanel)
            {
                Caption = 'Item Information';

                field("STRSUBSTNO('(%1)',PurchInfoPaneMgt.CalcAvailability(Rec))"; StrSubstNo('(%1)', PurchInfoPaneMgt.CalcAvailability(Rec)))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("STRSUBSTNO('(%1)',PurchInfoPaneMgt.CalcNoOfPurchasePrices(Rec))"; StrSubstNo('(%1)', PurchInfoPaneMgt.CalcNoOfPurchasePrices(Rec)))
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("STRSUBSTNO('(%1)',PurchInfoPaneMgt.CalcNoOfPurchLineDisc(Rec))"; StrSubstNo('(%1)', PurchInfoPaneMgt.CalcNoOfPurchLineDisc(Rec)))
                {
                    ApplicationArea = All;
                    Editable = false;
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

                group("Item Availability by")
                {
                    Caption = 'Item Availability by';

                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50006. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            _ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50006. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            _ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50006. Unsupported part was commented. Please check it.
                            /*CurrPage.PurchLines.PAGE.*/
                            _ItemAvailability(2);
                        end;
                    }
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50006. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50006. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _ShowLineComments;
                    end;
                }
                action("Item Charge &Assignment")
                {
                    ApplicationArea = All;
                    Caption = 'Item Charge &Assignment';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50006. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        ItemChargeAssgnt;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50006. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _OpenItemTrackingLines;
                    end;
                }
                action("Detailed GST")
                {
                    ApplicationArea = All;
                    Caption = 'Detailed GST';
                    Image = ServiceTax;
                    RunObject = Page "Detailed GST Entry Buffer";
                    RunPageLink = "Transaction Type"=filter(Purchase), "Document Type"=field("Document Type"), "Document No."=field("Document No."), "Line No."=field("Line No.");
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';

                action("E&xplode BOM")
                {
                    ApplicationArea = All;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50006. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Texts';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50006. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        _InsertExtendedText(true);
                    end;
                }
                action("&Get Receipt Lines")
                {
                    ApplicationArea = All;
                    Caption = '&Get Receipt Lines';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50006. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.PAGE.*/
                        GetReceipt;
                    end;
                }
            }
            action("Purchase Line &Discounts")
            {
                ApplicationArea = All;
                Caption = 'Purchase Line &Discounts';

                trigger OnAction()
                begin
                    ShowLineDisc;
                    CurrPage.Update;
                end;
            }
            action("Purcha&se Prices")
            {
                ApplicationArea = All;
                Caption = 'Purcha&se Prices';
                Image = SalesPrices;

                trigger OnAction()
                begin
                    ShowPrices;
                    CurrPage.Update;
                end;
            }
            action("Availa&bility")
            {
                ApplicationArea = All;
                Caption = 'Availa&bility';

                trigger OnAction()
                begin
                    ItemAvailability(0);
                    CurrPage.Update(true);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;
    trigger OnDeleteRecord(): Boolean var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        if(Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.")then begin
            Commit;
            if not ReservePurchLine.DeleteLineConfirm(Rec)then exit(false);
            ReservePurchLine.DeleteLine(Rec);
        end;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type:=xRec.Type;
        Clear(ShortcutDimCode);
    end;
    var TransferExtendedText: Codeunit "Transfer Extended Text";
    ShortcutDimCode: array[8]of Code[20];
    UpdateAllowedVar: Boolean;
    Text000: label 'Unable to execute this function while in view only mode.';
    PurchInfoPaneMgt: Codeunit "Purchases Info-Pane Management";
    PurchHeader: Record "Purchase Header";
    PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
    procedure ApproveCalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Purch.-Disc. (Yes/No)", Rec);
    end;
    procedure CalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Purch.-Calc.Discount", Rec);
    end;
    procedure ExplodeBOM()
    begin
        Codeunit.Run(Codeunit::"Purch.-Explode BOM", Rec);
    end;
    procedure GetReceipt()
    begin
        Codeunit.Run(Codeunit::"Purch.-Get Receipt", Rec);
    end;
    procedure _InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally)then begin
            CurrPage.SaveRecord;
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then UpdateForm(true);
    end;
    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally)then begin
            CurrPage.SaveRecord;
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then UpdateForm(true);
    end;
    procedure _ItemAvailability(AvailabilityType: Option Date, Variant, Location, Bin)
    begin
    //Rec.ItemAvailability(AvailabilityType); // BIS 1145
    end;
    procedure ItemAvailability(AvailabilityType: Option Date, Variant, Location, Bin)
    begin
    //Rec.ItemAvailability(AvailabilityType); // BIS 1145
    end;
    procedure _ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;
    procedure ItemChargeAssgnt()
    begin
        //ALLEEAA CML-033 120508 Start >>
        if Rec.Subcontracting then begin
            Rec.TestField(Quantity);
            Rec.TestField("Unit Cost");
        end;
        //ALLEEAA CML-033 120508 End <<
        Rec.ShowItemChargeAssgnt;
    end;
    procedure _OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;
    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;
    procedure ShowPrices()
    begin
        PurchHeader.Get(Rec."Document Type", Rec."Document No.");
        Clear(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;
    procedure ShowLineDisc()
    begin
        PurchHeader.Get(Rec."Document Type", Rec."Document No.");
        Clear(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;
    procedure _ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;
    procedure ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;
    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if(Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and (xRec."No." <> '')then CurrPage.SaveRecord;
    end;
    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;
}
