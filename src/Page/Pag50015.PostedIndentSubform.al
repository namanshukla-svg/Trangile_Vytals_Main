Page 50015 "Posted Indent Subform"
{
    // SSD-0001 Cancelled Quantity Field added
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "SSD Posted Indent Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Cancelled Quantity"; Rec."Cancelled Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit Of Measure"; Rec."Qty. per Unit Of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Expected Cost"; Rec."Expected Cost")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Requester ID"; Rec."Requester ID")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                }
                field("Inventory Main Store"; Rec."Inventory Main Store")
                {
                    ApplicationArea = All;
                }
                field("Capital Item"; Rec."Capital Item")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen.Prod.Posting Group"; Rec."Gen.Prod.Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. On Requisition"; QtyOnReQ)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity On Requisition';

                    trigger OnDrillDown()
                    var
                        ReqLine: Record "Requisition Line";
                    begin
                        ShowRequisition();
                    end;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    ApplicationArea = All;
                }
                field("Action Message"; Rec."Action Message")
                {
                    ApplicationArea = All;
                }
                field("Created Doc. SubType"; Rec."Created Doc. SubType")
                {
                    ApplicationArea = All;
                }
                field("Created Doc. No."; Rec."Created Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Created Doc. Line No."; Rec."Created Doc. Line No.")
                {
                    ApplicationArea = All;
                }
                field("Pending PO Qty"; Rec."Pending PO Qty")
                {
                    ApplicationArea = All;
                }
                field("Pending PO"; Rec."Pending PO")
                {
                    ApplicationArea = All;
                }
                field("Quotation Qty"; Rec."Quotation Qty")
                {
                    ApplicationArea = All;
                }
                field("Schedule Qty"; Rec."Schedule Qty")
                {
                    ApplicationArea = All;
                }
                field("PO Qty"; Rec."PO Qty")
                {
                    ApplicationArea = All;
                }
                field("Receipt qty"; Rec."Receipt qty")
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

                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50014. Unsupported part was commented. Please check it.
                        /*CurrPage.IndentLines.PAGE.*/
                        ShowCard;
                    end;
                }
                group("Item Avalibility By")
                {
                    Caption = 'Item Avalibility By';

                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50014. Unsupported part was commented. Please check it.
                            /*CurrPage.IndentLines.PAGE.*/
                            ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50014. Unsupported part was commented. Please check it.
                            /*CurrPage.IndentLines.PAGE.*/
                            ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';

                        trigger OnAction()
                        begin
                            //This functionality was copied from page #50014. Unsupported part was commented. Please check it.
                            /*CurrPage.IndentLines.PAGE.*/
                            ItemAvailability(2);
                        end;
                    }
                }
                action(Dimension)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50014. Unsupported part was commented. Please check it.
                        /*CurrPage.IndentLines.PAGE.*/
                        ShowDimensions;
                    end;
                }
                action("Order")
                {
                    ApplicationArea = All;
                    Caption = 'Order';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50014. Unsupported part was commented. Please check it.
                        /*CurrPage.IndentLines.PAGE.*/
                        ShowOrder;
                    end;
                }
                action(Requisition)
                {
                    ApplicationArea = All;
                    Caption = 'Requisition';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50014. Unsupported part was commented. Please check it.
                        /*CurrPage.IndentLines.PAGE.*/
                        ShowRequisition;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        QtyOnReQOnFormat(Format(QtyOnReQ));
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type:=xRec.Type;
    end;
    var Item: Record Item;
    ItemAvailByDate: Page "Item Availability by Periods";
    ItemAvailByVar: Page "Item Availability by Variant";
    ItemAvailByLoc: Page "Item Availability by Location";
    Text001: label 'Change %1 from %2 to %3?';
    QtyOnReQ: Decimal;
    QtyOnPO: Decimal;
    QtyOnRcpt: Decimal;
    QtyOnQuote: Decimal;
    ReceiptDone: Integer;
    procedure ItemAvailability(AvailabilityType: Option Date, Variant, Location, Bin)
    begin
        Rec.TestField(Type, Rec.Type::"Fixed Asset");
        Rec.TestField("No.");
        Item.Reset;
        Item.Get(Rec."No.");
        Item.SetRange("No.", Rec."No.");
        Item.SetRange("Date Filter", 0D, Rec."Indent Date");
        case AvailabilityType of Availabilitytype::Date: begin
            Item.SetRange("Variant Filter", Rec."Variant Code");
            Clear(ItemAvailByDate);
            ItemAvailByDate.LookupMode(true);
            ItemAvailByDate.SetRecord(Item);
            ItemAvailByDate.SetTableview(Item);
            if ItemAvailByDate.RunModal = Action::LookupOK then if Rec."Indent Date" <> ItemAvailByDate.GetLastDate then if Confirm(Text001, true, Rec.FieldCaption("Indent Date"), Rec."Indent Date", ItemAvailByDate.GetLastDate)then Rec.Validate("Indent Date", ItemAvailByDate.GetLastDate);
        end;
        Availabilitytype::Variant: begin
            Clear(ItemAvailByVar);
            ItemAvailByVar.LookupMode(true);
            ItemAvailByVar.SetRecord(Item);
            ItemAvailByVar.SetTableview(Item);
            if ItemAvailByVar.RunModal = Action::LookupOK then if Rec."Variant Code" <> ItemAvailByVar.GetLastVariant then if Confirm(Text001, true, Rec.FieldCaption("Variant Code"), Rec."Variant Code", ItemAvailByVar.GetLastVariant)then Rec.Validate("Variant Code", ItemAvailByVar.GetLastVariant);
        end;
        Availabilitytype::Location: begin
            Item.SetRange("Variant Filter", Rec."Variant Code");
            Clear(ItemAvailByLoc);
            ItemAvailByLoc.LookupMode(true);
            ItemAvailByLoc.SetRecord(Item);
            ItemAvailByLoc.SetTableview(Item);
            if ItemAvailByLoc.RunModal = Action::LookupOK then;
        end;
        end;
    end;
    procedure ShowCard()
    var
        Item: Record Item;
    begin
        Item.SetRange("No.", Rec."No.");
        Page.Run(30, Item);
    end;
    procedure ShowReceipt()
    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PostedReqPurchLineLocal: Record "SSD Posted Req. Purch. Line";
    begin
        PostedReqPurchLineLocal.Reset;
        PostedReqPurchLineLocal.SetCurrentkey("Posted Indent Document No.", "Posted Indent Line No.", "Purch. Document Type");
        PostedReqPurchLineLocal.FilterGroup(2);
        PostedReqPurchLineLocal.SetRange("Posted Indent Document No.", Rec."Document No.");
        PostedReqPurchLineLocal.SetRange("Posted Indent Line No.", Rec."Line No.");
        PostedReqPurchLineLocal.SetRange("Purch. Document Type", PostedReqPurchLineLocal."purch. document type"::Receipt);
        PostedReqPurchLineLocal.FilterGroup(0);
        Page.RunModal(0, PostedReqPurchLineLocal);
    end;
    procedure ShowOrder()
    var
        PurchLine: Record "Purchase Line";
        PostedReqPurchLineLocal: Record "SSD Posted Req. Purch. Line";
    begin
        PostedReqPurchLineLocal.Reset;
        PostedReqPurchLineLocal.SetCurrentkey("Posted Indent Document No.", "Posted Indent Line No.", "Purch. Document Type");
        PostedReqPurchLineLocal.FilterGroup(2);
        PostedReqPurchLineLocal.SetRange("Posted Indent Document No.", Rec."Document No.");
        PostedReqPurchLineLocal.SetRange("Posted Indent Line No.", Rec."Line No.");
        PostedReqPurchLineLocal.SetRange("Purch. Document Type", PostedReqPurchLineLocal."purch. document type"::Order);
        PostedReqPurchLineLocal.FilterGroup(0);
        //PurchLine.SETFILTER("Outstanding Quantity",'<>%1',0);
        Page.RunModal(0, PostedReqPurchLineLocal);
    end;
    procedure ShowRequisition()
    var
        ReqLine: Record "Requisition Line";
    begin
        ReqLine.SetCurrentkey("Indent No.", "Indent Line No.", Posted);
        ReqLine.SetRange("Indent No.", Rec."Document No.");
        ReqLine.SetRange("Indent Line No.", Rec."Line No.");
        ReqLine.SetRange(Posted, false);
        Page.Run(50019, ReqLine);
    end;
    procedure CalcReqQty()
    var
        ReqLine: Record "Requisition Line";
    begin
        ReqLine.SetCurrentkey("Indent No.", "Indent Line No.", Posted);
        ReqLine.SetRange("Indent No.", Rec."Document No.");
        ReqLine.SetRange("Indent Line No.", Rec."Line No.");
        ReqLine.SetRange(Posted, false);
        ReqLine.CalcSums(Quantity);
        if ReqLine.Quantity < Rec.Quantity then QtyOnReQ:=ReqLine.Quantity
        else
            QtyOnReQ:=Rec.Quantity;
    end;
    procedure ShowDimensions()
    begin
        Rec.TestField("Document No.");
        Rec.TestField("Line No.");
    /* //  BIS 1145
        PostedDocDim.SETRANGE("Table ID",DATABASE::"Posted Indent Line");
        PostedDocDim.SETRANGE("Document No.","Document No.");
        PostedDocDim.SETRANGE("Line No.","Line No.");
        PostedDocDimensions.SETTABLEVIEW(PostedDocDim);
        PostedDocDimensions.RUNMODAL;
        */
    end;
    procedure ShowQuotation()
    var
        PurchLine: Record "Purchase Line";
        PostedReqPurchLineLocal: Record "SSD Posted Req. Purch. Line";
    begin
        PostedReqPurchLineLocal.Reset;
        PostedReqPurchLineLocal.SetCurrentkey("Posted Indent Document No.", "Posted Indent Line No.", "Purch. Document Type");
        PostedReqPurchLineLocal.FilterGroup(2);
        PostedReqPurchLineLocal.SetRange("Posted Indent Document No.", Rec."Document No.");
        PostedReqPurchLineLocal.SetRange("Posted Indent Line No.", Rec."Line No.");
        PostedReqPurchLineLocal.SetRange("Purch. Document Type", PostedReqPurchLineLocal."purch. document type"::Quote);
        PostedReqPurchLineLocal.FilterGroup(0);
        /*
        PurchLine.SETFILTER("Outstanding Quantity",'<>%1',0);
        IF PurchLine.FIND('-') THEN
          PAGE.RUN(518, PurchLine);
        */
        Page.RunModal(0, PostedReqPurchLineLocal);
    end;
    local procedure QtyOnReQOnFormat(Text: Text[1024])
    begin
        CalcReqQty();
        Text:=Format(QtyOnReQ);
    end;
}
