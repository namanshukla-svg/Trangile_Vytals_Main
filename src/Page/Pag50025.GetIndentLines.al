Page 50025 "Get Indent Lines"
{
    // //CF_SC_001 New Form - Get Indent Lines
    Editable = false;
    PageType = List;
    SourceTable = "SSD Posted Indent Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
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
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. On Released Orders"; Rec."Qty. On Released Orders")
                {
                    ApplicationArea = All;
                }
                field("Qty Received"; Rec."Qty Received")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit Of Measure"; Rec."Qty. per Unit Of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Indent Date"; Rec."Indent Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Cost"; Rec."Expected Cost")
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
                }
                field("PO Qty"; Rec."PO Qty")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Req. Line"; Rec."Qty. on Req. Line")
                {
                    ApplicationArea = All;
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
                field("Pending PO"; Rec."Pending PO")
                {
                    ApplicationArea = All;
                }
                field("Quotation Qty"; Rec."Quotation Qty")
                {
                    ApplicationArea = All;
                }
                field("Template Name"; Rec."Template Name")
                {
                    ApplicationArea = All;
                }
                field("Batch Name"; Rec."Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Receipt qty"; Rec."Receipt qty")
                {
                    ApplicationArea = All;
                }
                field("Created Doc. Line No."; Rec."Created Doc. Line No.")
                {
                    ApplicationArea = All;
                }
                field("Schedule Qty"; Rec."Schedule Qty")
                {
                    ApplicationArea = All;
                }
                field("Pending PO Qty"; Rec."Pending PO Qty")
                {
                    ApplicationArea = All;
                }
                field("Gen.Prod.Posting Group"; Rec."Gen.Prod.Posting Group")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnQueryClosePage(CloseAction: action): Boolean begin
        if CloseAction = Action::LookupOK then LookupOKOnPush;
    end;
    var PurchHeader: Record "Purchase Header";
    PurchLine: Record "Purchase Line";
    PurchIndentHeader: Record "SSD Posted Indent Header";
    PurchIndentLine: Record "SSD Posted Indent Line";
    GetIndents: Codeunit "Get Indent Lines";
    PostedIndentLine3: Record "SSD Posted Indent Line";
    procedure SetPurchHeader(var PurchHeader2: Record "Purchase Header")
    begin
        PurchHeader.Get(PurchHeader2."Document Type", PurchHeader2."No.");
    end;
    local procedure IsFirstDocLine(): Boolean var
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
    /*
        TempPurchRcptLine.RESET;
        TempPurchRcptLine.COPYFILTERS(Rec);
        TempPurchRcptLine.SETRANGE("Document No.","Document No.");
        IF NOT TempPurchRcptLine.FIND('-') THEN BEGIN
          PurchRcptLine.COPYFILTERS(Rec);
          PurchRcptLine.SETRANGE("Document No.","Document No.");
          PurchRcptLine.FIND('-');
          TempPurchRcptLine := PurchRcptLine;
          TempPurchRcptLine.INSERT;
        END;
        IF "Line No." = TempPurchRcptLine."Line No." THEN
          EXIT(TRUE);
        */
    end;
    local procedure LookupOKOnPush()
    begin
        CurrPage.SetSelectionFilter(Rec);
        GetIndents.SetPurchHeaderIndent(PurchHeader);
        GetIndents.CreateIndentLines(Rec);
    end;
}
