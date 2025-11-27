Codeunit 50004 "Get Indent Lines"
{
    // //CF_SC_001 New Code Unit
    TableNo = "Purchase Line";

    trigger OnRun()
    begin
        PurchHeader.Get(Rec."Document Type", Rec."Document No.");
        PurchHeader.TestField(Status, PurchHeader.Status::Open);
    //BIS 1145
    /*
        GetIndents.SETTABLEVIEW(PostedIndentedLine);
        GetIndents.LOOKUPMODE := TRUE;
        GetIndents.SetPurchHeader(PurchHeader);
        GetIndents.RUNMODAL;
        */
    //BIS 1145
    end;
    var Text000: label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
    PurchHeader: Record "Purchase Header";
    PurchLine: Record "Purchase Line";
    PostedIndentHeader: Record "SSD Posted Indent Header";
    PostedIndentedLine: Record "SSD Posted Indent Line";
    PostedIndentLine3: Record "SSD Posted Indent Line";
    Difference1: Decimal;
    procedure CreateIndentLines(var PostedIndentLine2: Record "SSD Posted Indent Line")
    var
        NextLineNo: Integer;
    begin
        if PostedIndentLine2.Find('-')then begin
            PurchLine.LockTable;
            PurchLine.SetRange("Document Type", PurchHeader."Document Type");
            PurchLine.SetRange("Document No.", PurchHeader."No.");
            PurchLine."Document Type":=PurchHeader."Document Type";
            PurchLine."Document No.":=PurchHeader."No.";
            if PurchLine.Find('+')then NextLineNo:=PurchLine."Line No." + 10000
            else
                NextLineNo:=10000;
            repeat PurchLine."Line No.":=NextLineNo;
                PurchLine."Document Type":=PurchHeader."Document Type";
                PurchLine."Document No.":=PurchHeader."No.";
                PurchLine."Responsibility Center":=PurchHeader."Responsibility Center";
                PurchLine.Validate(Type, PostedIndentLine2.Type);
                PurchLine.Validate("No.", PostedIndentLine2."No.");
                PurchLine."Buy-from Vendor No.":=PurchHeader."Buy-from Vendor No.";
                PurchLine."Variant Code":=PostedIndentLine2."Variant Code";
                PurchLine.Validate("Location Code", PurchHeader."Location Code");
                PurchLine.Validate("Unit of Measure Code", PostedIndentLine2."Unit Of Measure Code");
                PurchLine."Qty. per Unit of Measure":=PostedIndentLine2."Qty. per Unit Of Measure";
                if PurchHeader."Prices Including VAT" then PurchLine.Validate("Direct Unit Cost", PostedIndentLine2."Direct Unit Cost" * (1 + PurchLine."VAT %" / 100))
                else
                    PurchLine.Validate("Direct Unit Cost", PostedIndentLine2."Direct Unit Cost");
                PurchLine."Shortcut Dimension 1 Code":=PostedIndentLine2."Shortcut Dimension 1 Code";
                PurchLine."Shortcut Dimension 2 Code":=PostedIndentLine2."Shortcut Dimension 2 Code";
                PurchLine.Description:=PostedIndentLine2.Description;
                PurchLine."Description 2":=PostedIndentLine2."Description 2";
                PurchLine."Item Category Code":=PostedIndentLine2."Item Category Code";
                //PurchLine."Product Group Code" := "Product Group Code";
                PurchLine."Document Subtype":=PurchHeader."Document Subtype";
                if PostedIndentLine2."Due Date" <> 0D then begin
                    PurchLine.Validate("Expected Receipt Date", PostedIndentLine2."Due Date");
                    PurchLine."Requested Receipt Date":=PurchLine."Planned Receipt Date";
                end;
                PurchLine."Outstanding Qty. (Base)":=0;
                PurchLine."Outstanding Quantity":=0;
                PurchLine."Quantity Received":=0;
                PurchLine."Qty. Received (Base)":=0;
                PurchLine."Quantity Invoiced":=0;
                PurchLine."Qty. Invoiced (Base)":=0;
                PurchLine."Sales Order No.":='';
                PurchLine."Sales Order Line No.":=0;
                PurchLine."Drop Shipment":=false;
                PurchLine."Special Order Sales No.":='';
                PurchLine."Special Order Sales Line No.":=0;
                PurchLine."Special Order":=false;
                Difference1:=0;
                PostedIndentLine3.Reset;
                PostedIndentLine3.SetRange(PostedIndentLine3."Document No.", PostedIndentLine2."Document No.");
                PostedIndentLine3.SetRange(PostedIndentLine3."Line No.", PostedIndentLine2."Line No.");
                PostedIndentLine3.SetRange(PostedIndentLine3."No.", PostedIndentLine2."No.");
                if PostedIndentLine3.Find('-')then begin
                    PostedIndentLine3.CalcFields(PostedIndentLine3."Qty. On Released Orders");
                    Difference1:=PostedIndentLine3.Quantity - PostedIndentLine3."Qty. On Released Orders";
                end;
                PurchLine.Validate(Quantity, Difference1);
                PurchLine."Shortcut Dimension 1 Code":=PostedIndentLine2."Shortcut Dimension 1 Code";
                PurchLine."Shortcut Dimension 2 Code":=PostedIndentLine2."Shortcut Dimension 2 Code";
                PurchLine."Posted Indent No.":=PostedIndentLine2."Document No.";
                PurchLine."Posted Indent Line No.":=PostedIndentLine2."Line No.";
                PurchLine.Insert;
                NextLineNo:=NextLineNo + 10000;
            until PostedIndentLine2.Next = 0;
        end;
    end;
    /// <summary>
    /// SetPurchHeaderIndent.
    /// </summary>
    /// <param name="PurchHeader2">VAR Record "Purchase Header".</param>
    procedure SetPurchHeaderIndent(var PurchHeader2: Record "Purchase Header")
    begin
        PurchHeader.Get(PurchHeader2."Document Type", PurchHeader2."No.");
    end;
}
