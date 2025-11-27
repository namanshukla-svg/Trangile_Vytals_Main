Report 50011 "Indent Post"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Indent Post.rdl';
    UseRequestPage = false;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        Text001: label 'Do you want to post the Indent';
        Text005: label 'Posting lines              #2######\';
        Text006: label 'Posting to Requisition     #3######\';
        window: Dialog;
        PostedIndentHeader: Record "SSD Posted Indent Header";
        PostedIndentLine: Record "SSD Posted Indent Line";
        IndentHeader2: Record "SSD Indent Header";
        IndentLine: Record "SSD Indent Line";
        IndentSetup: Record "SSD AddOn Setup";
        ReqLine: Record "Requisition Line";
        FromInvCommentLine: Record "Inventory Comment Line";
        ToInvCommentLine: Record "Inventory Comment Line";
        DimMgt: Codeunit DimensionManagement;
        Text028: label 'The combination of dimensions used in %1 %2 is blocked. %3.';
        Text029: label 'The combination of dimensions used in %1 %2, line no. %3 is blocked. %4.';
        Text030: label 'The dimensions used in %1 %2 are invalid. %3.';
        Text031: label 'The dimensions used in %1 %2, line no. %3 are invalid. %4.';
        ResponsibilityCenter: Record "Responsibility Center";
        TemplateName: Code[20];
        BatchName: Code[20];
        "--Alle": Integer;
        IndentHeaderRec: Record "SSD Indent Header";
        IndentLineRec: Record "SSD Indent Line";
        IndentHeaderNew: Record "SSD Indent Header2";
        IndentLineNew: Record "SSD Indent Line2";
        filename: Text[1024];
        ItemJournalLinePost: Record "Item Journal Line";
        InsertItemJournalLine: Boolean;
        BalanceQty: Decimal;

    local procedure CopyIndentAttachments(var PostedIndentHeader: Record "SSD Posted Indent Header"; IndentHeader: Record "SSD Indent Header");
    var
        FromDocumentAttachment: Record "Document Attachment";
        ToDocumentAttachment: Record "Document Attachment";
    begin
        FromDocumentAttachment.SetRange("Table ID", Database::"SSD Indent Header");
        if FromDocumentAttachment.IsEmpty() then
            exit;

        FromDocumentAttachment.SetRange("No.", IndentHeader."No.");
        if FromDocumentAttachment.FindSet() then
            repeat
                Clear(ToDocumentAttachment);
                ToDocumentAttachment.Init();
                ToDocumentAttachment.TransferFields(FromDocumentAttachment);
                ToDocumentAttachment.Validate("Table ID", Database::"SSD Posted Indent Header");
                ToDocumentAttachment.Validate("No.", PostedIndentHeader."No.");
                ToDocumentAttachment.Validate("Document Type", Enum::"Attachment Document Type"::Indent);
                if not ToDocumentAttachment.Insert(true) then;
                ToDocumentAttachment."Attached Date" := FromDocumentAttachment."Attached Date";
                ToDocumentAttachment.Modify();
            until FromDocumentAttachment.Next() = 0;
    end;

    procedure IndentPost(IndentHeader: Record "SSD Indent Header")
    var
        IndentLineCount: Integer;
        ReqLineCount: Integer;
        ReqLineNo: Integer;
    begin
        if Confirm(Text001) then begin
            if GuiAllowed then window.Open('#1#################################\\' + Text005 + Text006);
            if GuiAllowed then window.Update(1, StrSubstNo('%1', IndentHeader."No."));
            TemplateName := GetIndentTemplate(IndentHeader);
            BatchName := GetIndentBatch(IndentHeader);
            CheckIndent(IndentHeader);
            IndentHeader2.Get(IndentHeader."No.");
            PostedIndentHeader.Init;
            PostedIndentHeader.TransferFields(IndentHeader);
            PostedIndentHeader.Insert;
            //IG_DS>>
            CopyIndentAttachments(PostedIndentHeader, IndentHeader);
            //IG_DS<<
            IndentLine.SetRange("Document No.", IndentHeader."No.");
            IndentLine.Findset;
            repeat
                IndentLineCount := IndentLineCount + 1;
                if GuiAllowed then window.Update(2, StrSubstNo('%1', IndentLineCount));
                PostedIndentLine.Init;
                PostedIndentLine.TransferFields(IndentLine);
                PostedIndentLine."Pending PO Qty" := IndentLine.Quantity; // Alle
                PostedIndentLine.Insert;
            until IndentLine.Next = 0;
            ReqLine.LockTable;
            ReqLine.SetRange("Worksheet Template Name", TemplateName);
            ReqLine.SetRange("Journal Batch Name", BatchName);
            if ReqLine.Find('+') then ReqLineNo := ReqLine."Line No.";
            IndentLine.Find('-');
            repeat
                ReqLineCount := ReqLineCount + 1;
                if GuiAllowed then window.Update(3, StrSubstNo('%1', ReqLineCount));
                ReqLine.Init;
                ReqLine.Validate("Worksheet Template Name", TemplateName);
                ReqLine.Validate("Journal Batch Name", BatchName);
                ReqLineNo := ReqLineNo + 10000;
                ReqLine."Line No." := ReqLineNo;
                // VALIDATE(Type, IndentLine.Type);
                ReqLine.Validate(Type, IndentLine."SSD Req Line Type");
                ReqLine.Validate("No.", IndentLine."No.");
                ReqLine.Validate("Action Message", ReqLine."action message"::New);
                ReqLine.Validate("Location Code", IndentHeader."Location Code"); //IG_DS
                ReqLine.Validate(Quantity, IndentLine.Quantity);
                ReqLine.Validate("Due Date", IndentLine."Due Date");
                ReqLine.Validate("Variant Code", IndentLine."Variant Code");
                ReqLine."Description 2" := IndentLine."Description 2"; //ALLE-NM 10102019
                ReqLine."Description 3" := IndentLine."Description 3";
                if IndentLine.Type = IndentLine.Type::Item then begin
                    ReqLine.Validate("Unit of Measure Code", IndentLine."Unit Of Measure Code");
                    ReqLine.Validate("Qty. per Unit of Measure", IndentLine."Qty. per Unit Of Measure");
                    ReqLine.Validate("Item Category Code", IndentLine."Item Category Code");
                    //SSD ReqLine.Validate("Product Group Code", IndentLine."Product Group Code");
                end;
                ReqLine.Validate("Indent No.", IndentLine."Document No.");
                ReqLine.Validate("Indent Line No.", IndentLine."Line No.");
                ReqLine.Validate("Shortcut Dimension 1 Code", IndentLine."Shortcut Dimension 1 Code");
                ReqLine.Validate("Shortcut Dimension 2 Code", IndentLine."Shortcut Dimension 2 Code");
                ReqLine."Shelf No." := IndentLine."Shelf No.";
                ReqLine.Remarks := IndentLine.Remarks;
                ReqLine."Responsibility Center" := IndentLine."Responsibility Center";
                //>>SM_MUA35
                ReqLine."Requester ID" := IndentHeader."Indenter ID";
                //<<SM_MUA35
                // Alle 141016 <<
                ReqLine.Posted := true;
                ReqLine."Pending PO" := true;
                ReqLine."Pending PO Qty" := IndentLine.Quantity;
                ReqLine."Created PO Doc. type" := ReqLine."created po doc. type"::Order;
                // ReqLine."Location Code" := IndentHeader."Location Code"; //IG_DS
                // Alle 141016 <<
                ReqLine.Insert(true);
            until IndentLine.Next = 0;
            IndentHeader.Delete(true);
            if GuiAllowed then window.Close;
        end;
    end;
    /// <summary>
    /// CheckIndent.
    /// </summary>
    /// <param name="IndentHeader">Record "SSD Indent Header".</param>
    procedure CheckIndent(IndentHeader: Record "SSD Indent Header")
    var
        IndentLine: Record "SSD Indent Line";
    begin
        IndentHeader.TestField("No.");
        IndentHeader.TestField("Due Date");
        IndentHeader.TestField("Indent Date");
        IndentHeader.TestField("Posting Date");
        IndentHeader.TestField("Location Code");
        IndentHeader.TestField(Status, IndentHeader.Status::Released);
        IndentLine.SetRange("Document No.", IndentHeader."No.");
        if IndentLine.FindSet() then
            repeat
                IndentLine.TestField("No.");
                IndentLine.TestField(Quantity);
                IndentLine.TestField("Due Date");
                IndentLine.TestField("Shortcut Dimension 1 Code");
                //IndentLine.TESTFIELD("Shortcut Dimension 2 Code");
                IndentLine.TestField("Location Code");
                if IndentLine.Type = IndentLine.Type::Item then begin
                    IndentLine.TestField("Qty. per Unit Of Measure");
                    IndentLine.TestField("Unit Of Measure Code");
                end;
                IndentLine.TestField("Quantity (Base)");
                IndentLine.TestField("Indent Date");
            until IndentLine.Next = 0;
        IndentSetup.Get;
    end;

    procedure GetIndentTemplate(IndentHeader: Record "SSD Indent Header"): Code[20]
    begin
        IndentSetup.Get;
        IndentSetup.TestField("Indent Template Name");
        exit(IndentSetup."Indent Template Name");
    end;

    procedure GetIndentBatch(IndentHeader: Record "SSD Indent Header"): Code[20]
    begin
        IndentSetup.Get;
        IndentSetup.TestField("Indent Batch Name");
        exit(IndentSetup."Indent Batch Name");
    end;

    procedure InsertReqlineIfItemAvailable(IndentHeader: Record "SSD Indent Header")
    var
        IndentLineCount: Integer;
        ReqLineCount: Integer;
        ReqLineNo: Integer;
    begin
        //ALLE-AT IND>>
        IndentLine.SetRange("Document No.", IndentHeader."No.");
        IndentLine.Find('-');
        repeat
            ReqLine.LockTable;
            ReqLine.SetRange("Worksheet Template Name", TemplateName);
            ReqLine.SetRange("Journal Batch Name", BatchName);
            if ReqLine.Find('+') then ReqLineNo := ReqLine."Line No.";
            ReqLineCount := ReqLineCount + 1;
            if GuiAllowed then window.Update(3, StrSubstNo('%1', ReqLineCount));
            ReqLine.Init;
            ReqLine.Validate("Worksheet Template Name", TemplateName);
            ReqLine.Validate("Journal Batch Name", BatchName);
            ReqLineNo := ReqLineNo + 10000;
            ReqLine."Line No." := ReqLineNo;
            if IndentLine.Type = IndentLine.Type::Item then ReqLine.Validate(Type, ReqLine.Type::Item);
            if IndentLine.Type = IndentLine.Type::" " then ReqLine.Validate(Type, ReqLine.Type::" ");
            ReqLine.Validate("No.", IndentLine."No.");
            ReqLine.Validate("Action Message", ReqLine."action message"::New);
            ReqLine.Validate(Quantity, IndentLine.Quantity);
            ReqLine.Validate("Due Date", IndentLine."Due Date");
            ReqLine.Validate("Variant Code", IndentLine."Variant Code");
            ReqLine."Description 2" := IndentLine."Description 2";
            if IndentLine.Type = IndentLine.Type::Item then begin
                ReqLine.Validate("Unit of Measure Code", IndentLine."Unit Of Measure Code");
                ReqLine.Validate("Qty. per Unit of Measure", IndentLine."Qty. per Unit Of Measure");
                ReqLine.Validate("Item Category Code", IndentLine."Item Category Code");
            end;
            ReqLine.Validate("Indent No.", IndentLine."Document No.");
            ReqLine.Validate("Indent Line No.", IndentLine."Line No.");
            ReqLine.Validate("Shortcut Dimension 1 Code", IndentLine."Shortcut Dimension 1 Code");
            ReqLine.Validate("Shortcut Dimension 2 Code", IndentLine."Shortcut Dimension 2 Code");
            ReqLine."Shelf No." := IndentLine."Shelf No.";
            ReqLine.Remarks := IndentLine.Remarks;
            ReqLine."Responsibility Center" := IndentLine."Responsibility Center";
            ReqLine."Requester ID" := IndentHeader."Indenter ID";
            ReqLine.Posted := true;
            ReqLine."Pending PO" := true;
            ReqLine."Pending PO Qty" := IndentLine.Quantity;
            ReqLine."Created PO Doc. type" := ReqLine."created po doc. type"::Order;
            ReqLine.Insert(true);
        until IndentLine.Next = 0;
        //InsertNPostItemJnlLineNeg(IndentLine."Document No.",ReqLine); dp
        //ALLE-AT IND <<
    end;

    procedure InsertNPostItemJnlLineNeg(IndentNo: Code[20]; var RequisitionLine: Record "SSD Indent Line")
    var
        ItemJournalLine: Record "Item Journal Line";
        LineNo: Integer;
        IJLCOunt: Integer;
        IndentHeader2: Record "SSD Indent Header2";
    begin
        //ALLE-AT
        // TemplateName := GetIndentTemplate(IndentNo);
        // BatchName := GetIndentBatch(IndentHeader);
        ///RequisitionLine.SETRANGE("Indent No.",IndentHeader."No.");
         //IF RequisitionLine.FINDSET THEN
        //  REPEAT
        IndentHeader2.Reset;
        IndentHeader2.SetRange("No.", RequisitionLine."Document No.");
        if IndentHeader2.FindFirst then;
        ItemJournalLine.SetRange("Journal Template Name", 'ISSUE');
        ItemJournalLine.SetRange("Journal Batch Name", 'NEGTEST');
        if ItemJournalLine.Find('+') then LineNo := ItemJournalLine."Line No.";
        IJLCOunt := IJLCOunt + 1;
        if GuiAllowed then window.Update(3, StrSubstNo('%1', IJLCOunt));
        ItemJournalLine.Init();
        ItemJournalLine.Validate("Journal Template Name", 'ISSUE');
        ItemJournalLine.Validate("Journal Batch Name", 'NEGTEST');
        LineNo := LineNo + 10000;
        ItemJournalLine.Validate("Line No.", LineNo);
        //ItemJournalLine.Insert(true);
        //ItemJournalLine.VALIDATE("Posting Date", Today); //SSD_Sunil Remove
        ItemJournalLine.Validate("Posting Date", IndentHeader2."Posting Date"); //Alle AU 14042021
        ItemJournalLine.Validate("Entry Type", ItemJournalLine."entry type"::"Negative Adjmt.");
        ItemJournalLine.Validate("Item No.", RequisitionLine."No.");
        ItemJournalLine.Validate("Description 2", RequisitionLine."Description 2");
        ItemJournalLine.Validate("Document No.", RequisitionLine."Document No.");
        // VALIDATE("Location Code",RequisitionLine."Location Code");
        ItemJournalLine.Validate("Shortcut Dimension 1 Code", RequisitionLine."Shortcut Dimension 1 Code");
        ItemJournalLine.Validate("Shortcut Dimension 2 Code", RequisitionLine."Shortcut Dimension 2 Code");
        ItemJournalLine.Validate(Quantity, BalanceQty); //RequisitionLine.Quantity);
        ItemJournalLine.Validate("Unit of Measure Code", RequisitionLine."Unit Of Measure Code");
        ItemJournalLine.Validate("Posting Date", IndentHeader2."Posting Date"); //Alle AU 14042021
        //ItemJournalLine.Modify(true);
        ItemJournalLine.Insert(true);
        //ALLE-AT
        //UNTIL RequisitionLine.NEXT = 0;
    end;

    procedure InsertNPostItemJnlLineNegIG(IndentNo: Code[20]; var RequisitionLine: Record "SSD Indent Line")
    var
        ItemJournalLine: Record "Item Journal Line";
        LineNo: Integer;
        IJLCOunt: Integer;
        IndentHeader2: Record "SSD Indent Header2";
    begin
        //ALLE-AT
        // TemplateName := GetIndentTemplate(IndentNo);
        // BatchName := GetIndentBatch(IndentHeader);
        ///RequisitionLine.SETRANGE("Indent No.",IndentHeader."No.");
         //IF RequisitionLine.FINDSET THEN
        //  REPEAT
        IndentHeader2.Reset;
        IndentHeader2.SetRange("No.", RequisitionLine."Document No.");
        if IndentHeader2.FindFirst then;
        ItemJournalLine.SetRange("Journal Template Name", 'ISSUE');
        ItemJournalLine.SetRange("Journal Batch Name", 'NEGTEST');
        if ItemJournalLine.Find('+') then LineNo := ItemJournalLine."Line No.";
        IJLCOunt := IJLCOunt + 1;
        //  if GuiAllowed then window.Update(3, StrSubstNo('%1', IJLCOunt));
        ItemJournalLine.Init();
        ItemJournalLine.Validate("Journal Template Name", 'ISSUE');
        ItemJournalLine.Validate("Journal Batch Name", 'NEGTEST');
        LineNo := LineNo + 10000;
        ItemJournalLine.Validate("Line No.", LineNo);
        //ItemJournalLine.Insert(true);
        //ItemJournalLine.VALIDATE("Posting Date", Today); //SSD_Sunil Remove
        ItemJournalLine.Validate("Posting Date", IndentHeader2."Posting Date"); //Alle AU 14042021
        ItemJournalLine.Validate("Entry Type", ItemJournalLine."entry type"::"Negative Adjmt.");
        ItemJournalLine.Validate("Item No.", RequisitionLine."No.");
        ItemJournalLine.Validate("Description 2", RequisitionLine."Description 2");
        ItemJournalLine.Validate("Document No.", RequisitionLine."Document No.");
        // VALIDATE("Location Code",RequisitionLine."Location Code");
        ItemJournalLine.Validate("Shortcut Dimension 1 Code", RequisitionLine."Shortcut Dimension 1 Code");
        ItemJournalLine.Validate("Shortcut Dimension 2 Code", RequisitionLine."Shortcut Dimension 2 Code");
        ItemJournalLine.Validate(Quantity, BalanceQty); //RequisitionLine.Quantity);
        ItemJournalLine.Validate("Unit of Measure Code", RequisitionLine."Unit Of Measure Code");
        ItemJournalLine.Validate("Posting Date", IndentHeader2."Posting Date"); //Alle AU 14042021
        //ItemJournalLine.Modify(true);
        ItemJournalLine.Insert(true);
        //ALLE-AT
        //UNTIL RequisitionLine.NEXT = 0;
    end;

    procedure IndentPost2(IndentHeader: Record "SSD Indent Header2")
    var
        IndentLineCount: Integer;
        ReqLineCount: Integer;
        ReqLineNo: Integer;
        BalanceQty: Decimal;
        BalanceQty2: Decimal;
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
    begin
        if Confirm(Text001) then begin
            if GuiAllowed then window.Open('#1#################################\\' + Text005 + Text006);
            if GuiAllowed then window.Update(1, StrSubstNo('%1', IndentHeader."No."));
            TemplateName := GetIndentTemplate2(IndentHeader);
            BatchName := GetIndentBatch2(IndentHeader);
            CheckIndent2(IndentHeader);
            BalanceQty2 := 0;
            IndentLineNew.Reset; //Alle 12032021
            IndentLineNew.SetRange("Document No.", IndentHeader."No.");
            IndentLineNew.Find('-');
            repeat
                BalanceQty2 += IndentLineNew.Quantity - IndentLineNew."Issued Qty";
            until IndentLineNew.Next = 0;
            IndentHeaderNew.Get(IndentHeader."No.");
            if BalanceQty2 > 0 then begin
                IndentHeaderRec.Init;
                IndentHeaderRec.TransferFields(IndentHeader);
                IndentHeaderRec."Issue Slip No." := IndentHeader."No.";
                IndentHeaderRec.Insert(true);
                IndentLineNew.Reset; //Alle 12032021
                IndentLineNew.SetRange("Document No.", IndentHeader."No.");
                IndentLineNew.Find('-');
                repeat
                    BalanceQty := IndentLineNew.Quantity - IndentLineNew."Issued Qty";
                    if BalanceQty > 0 then begin
                        IndentLineNew.TestField("Location Code");
                        IndentLineCount := IndentLineCount + 1;
                        if GuiAllowed then window.Update(2, StrSubstNo('%1', IndentLineCount));
                        IndentLineRec.Init;
                        IndentLineRec.TransferFields(IndentLineNew);
                        IndentLineRec.Quantity := IndentLineNew."Balance Qty";
                        IndentLineRec.Validate("Document No.", IndentHeaderRec."No."); // Alle
                        IndentLineRec.Insert;
                        //    InsertNPostItemJnlLineNeg(IndentHeader."No.",IndentLineNew);
                        InsertNPostItemJnlLineNeg(IndentHeaderRec."No.", IndentLineRec); //Alle 08082021
                        IndentLineNew."Indent Issued Qty." := IndentLineNew."Balance Qty";
                        IndentLineNew.Modify;
                    end;
                until IndentLineNew.Next = 0;
                BalanceQty := IndentLineNew.Quantity - IndentLineNew."Issued Qty";
                //if BalanceQty > 0 then
                //EmailSendForInventory3(IndentHeader."No.");
                //   ELSE
                //     EmailSendForInventory2(IndentHeader."No.");
            end;
            //Alle
            IndentLineNew.Reset; //IG_DS
            IndentLineNew.SetRange("Document No.", IndentHeader."No.");
            IndentLineNew.Find('-');
            repeat
                IndentLineNew.TestField("Issued Qty");
            // if IndentLineNew."Issued Qty" > 0 then begin
            //     InsertNPostItemJnlLineNeg2(IndentHeader."No.", IndentLineNew, ItemJournalLinePost);
            //     InsertItemJournalLine := true;
            //     if ItemJnlPostLine.RunWithCheck(ItemJournalLinePost) then //Alle 08072021
            //         ItemJournalLinePost.Delete;
            // end;
            until IndentLineNew.Next = 0; //IG_DS

            ItemJournalLinePost.RESET;
            ItemJournalLinePost.SetRange("Journal Template Name", 'ISSUE');
            ItemJournalLinePost.SetRange("Journal Batch Name", 'ISSUESLIP');
            ItemJournalLinePost.SetRange("Document No.", IndentHeader."No.");
            if ItemJournalLinePost.FindFirst() then begin
                CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJournalLinePost);
                //  ItemJnlPostLine.RunWithCheck(ItemJournalLinePost);
                InsertItemJournalLine := true;
            end;

            if InsertItemJournalLine then begin //Alle 080
                Message('Successfully Post');
            end;

            IndentHeader.Post := true;
            IndentHeader.Modify;
            if GuiAllowed then window.Close;
        end;
    end;
    //IG_DS_24-06-2025>>
    procedure IndentPost2IG(IndentHeader: Record "SSD Indent Header2")
    var
        IndentLineCount: Integer;
        ReqLineCount: Integer;
        ReqLineNo: Integer;
        BalanceQty: Decimal;
        BalanceQty2: Decimal;
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        Text001A: Label 'Do you want to assign item tracking';
    begin
        if Confirm(Text001A) then begin
            // if GuiAllowed then window.Open('#1#################################\\' + Text005 + Text006);
            //  if GuiAllowed then window.Update(1, StrSubstNo('%1', IndentHeader."No."));
            TemplateName := GetIndentTemplate2(IndentHeader);
            BatchName := GetIndentBatch2(IndentHeader);
            CheckIndent2(IndentHeader);
            BalanceQty2 := 0;
            IndentLineNew.Reset; //Alle 12032021
            IndentLineNew.SetRange("Document No.", IndentHeader."No.");
            IndentLineNew.Find('-');
            repeat
                BalanceQty2 += IndentLineNew.Quantity - IndentLineNew."Issued Qty";
            until IndentLineNew.Next = 0;
            IndentHeaderNew.Get(IndentHeader."No.");
            if BalanceQty2 > 0 then begin
                IndentHeaderRec.Init;
                IndentHeaderRec.TransferFields(IndentHeader);
                IndentHeaderRec."Issue Slip No." := IndentHeader."No.";
                IndentHeaderRec.Insert(true);
                IndentLineNew.Reset; //Alle 12032021
                IndentLineNew.SetRange("Document No.", IndentHeader."No.");
                IndentLineNew.Find('-');
                repeat
                    BalanceQty := IndentLineNew.Quantity - IndentLineNew."Issued Qty";
                    if BalanceQty > 0 then begin
                        IndentLineNew.TestField("Location Code");
                        IndentLineCount := IndentLineCount + 1;
                        //  if GuiAllowed then window.Update(2, StrSubstNo('%1', IndentLineCount));
                        IndentLineRec.Init;
                        IndentLineRec.TransferFields(IndentLineNew);
                        IndentLineRec.Quantity := IndentLineNew."Balance Qty";
                        IndentLineRec.Validate("Document No.", IndentHeaderRec."No."); // Alle
                        IndentLineRec.Insert;
                        //    InsertNPostItemJnlLineNeg(IndentHeader."No.",IndentLineNew);
                        InsertNPostItemJnlLineNegIG(IndentHeaderRec."No.", IndentLineRec); //Alle 08082021
                        IndentLineNew."Indent Issued Qty." := IndentLineNew."Balance Qty";
                        IndentLineNew.Modify;
                    end;
                until IndentLineNew.Next = 0;
                BalanceQty := IndentLineNew.Quantity - IndentLineNew."Issued Qty";
                //if BalanceQty > 0 then
                //EmailSendForInventory3(IndentHeader."No.");
                //   ELSE
                //     EmailSendForInventory2(IndentHeader."No.");
            end;
            //Alle
            IndentLineNew.Reset;
            IndentLineNew.SetRange("Document No.", IndentHeader."No.");
            IndentLineNew.Find('-');
            repeat
                if IndentLineNew."Issued Qty" > 0 then begin
                    InsertNPostItemJnlLineNeg2IG(IndentHeader."No.", IndentLineNew, ItemJournalLinePost);
                    // InsertItemJournalLine := true;
                    // if ItemJnlPostLine.RunWithCheck(ItemJournalLinePost) then //Alle 08072021
                    //     ItemJournalLinePost.Delete;
                end;
            until IndentLineNew.Next = 0;
            // if InsertItemJournalLine then begin //Alle 080
            //     Message('Successfully Post');
            // end;
            IndentHeader.Post := true;
            IndentHeader.Modify;
            //  if GuiAllowed then window.Close;

        end;
    end;
    //IG_DS_24-06-2025<<
    procedure GetIndentTemplate2(IndentHeader: Record "SSD Indent Header2"): Code[20]
    begin
        if IndentHeader."Responsibility Center" <> '' then begin
            ResponsibilityCenter.Get(IndentHeader."Responsibility Center");
            if ResponsibilityCenter."Indent Template Name" <> '' then begin
                ResponsibilityCenter.TestField("Indent Template Name");
                exit(ResponsibilityCenter."Indent Template Name");
            end;
        end;
        IndentSetup.Get;
        IndentSetup.TestField("Indent Template Name");
        exit(IndentSetup."Indent Template Name");
    end;

    procedure GetIndentBatch2(IndentHeader: Record "SSD Indent Header2"): Code[20]
    begin
        if IndentHeader."Responsibility Center" <> '' then begin
            ResponsibilityCenter.Get(IndentHeader."Responsibility Center");
            if ResponsibilityCenter."Indent Batch Name" <> '' then begin
                ResponsibilityCenter.TestField("Indent Batch Name");
                exit(ResponsibilityCenter."Indent Batch Name");
            end;
        end;
        IndentSetup.Get;
        IndentSetup.TestField("Indent Batch Name");
        exit(IndentSetup."Indent Batch Name");
    end;

    procedure CheckIndent2(IndentHeader: Record "SSD Indent Header2")
    var
        IndentLine: Record "SSD Indent Line2";
    begin
        IndentHeader.TestField("No.");
        IndentHeader.TestField("Due Date");
        IndentHeader.TestField("Indent Date");
        IndentHeader.TestField("Posting Date");
        IndentHeader.TestField(Status, IndentHeader.Status::Released);
        IndentLine.SetRange("Document No.", IndentHeader."No.");
        IndentLine.Find('-');
        repeat
            IndentLine.TestField("No.");
            IndentLine.TestField(Quantity);
            IndentLine.TestField("Due Date");
            IndentLine.TestField("Shortcut Dimension 1 Code");
            //IndentLine.TESTFIELD("Shortcut Dimension 2 Code");
            if IndentLine.Type = IndentLine.Type::Item then begin
                IndentLine.TestField("Qty. per Unit Of Measure");
                IndentLine.TestField("Unit Of Measure Code");
            end;
            IndentLine.TestField("Quantity (Base)");
            IndentLine.TestField("Indent Date");
        until IndentLine.Next = 0;
        IndentSetup.Get;
    end;

    procedure InsertNPostItemJnlLineNeg2(IndentNo: Code[20]; var RequisitionLine: Record "SSD Indent Line2"; var ItemJournalLine: Record "Item Journal Line")
    var
        ItemJournalLine2: Record "Item Journal Line";
        LineNo: Integer;
        IJLCOunt: Integer;
        IndentHeader2: Record "SSD Indent Header2";
    begin
        //ALLE-AT
        // TemplateName := GetIndentTemplate(IndentNo);
        // BatchName := GetIndentBatch(IndentHeader);
        ///RequisitionLine.SETRANGE("Indent No.",IndentHeader."No.");
         //IF RequisitionLine.FINDSET THEN
        //  REPEAT
        IndentHeader2.Reset;
        IndentHeader2.SetRange("No.", RequisitionLine."Document No.");
        if IndentHeader2.FindFirst then;
        ItemJournalLine.SetRange("Journal Template Name", 'ISSUE');
        ItemJournalLine.SetRange("Journal Batch Name", 'NEGTEST');
        if ItemJournalLine.Find('+') then LineNo := ItemJournalLine."Line No.";
        IJLCOunt := IJLCOunt + 1;
        if GuiAllowed then window.Update(3, StrSubstNo('%1', IJLCOunt));
        ItemJournalLine.Init();
        ItemJournalLine.Validate("Journal Template Name", 'ISSUE');
        ItemJournalLine.Validate("Journal Batch Name", 'NEGTEST');
        LineNo := LineNo + 10000;
        ItemJournalLine.Validate("Line No.", LineNo);
        // VALIDATE("Posting Date",TODAY());
        ItemJournalLine.Validate("Posting Date", IndentHeader2."Posting Date"); //Alle AU 14042021
        ItemJournalLine.Validate("Entry Type", ItemJournalLine."entry type"::"Negative Adjmt.");
        ItemJournalLine.Validate("Item No.", RequisitionLine."No.");
        ItemJournalLine.Validate("Description 2", RequisitionLine."Description 2");
        ItemJournalLine.Validate("Document No.", RequisitionLine."Document No.");
        ItemJournalLine.Validate("Location Code", RequisitionLine."Location Code");
        ItemJournalLine.Validate("Shortcut Dimension 1 Code", RequisitionLine."Shortcut Dimension 1 Code");
        ItemJournalLine.Validate("Shortcut Dimension 2 Code", RequisitionLine."Shortcut Dimension 2 Code");
        ItemJournalLine.Validate(Quantity, RequisitionLine."Issued Qty");
        ItemJournalLine.Validate("Unit of Measure Code", RequisitionLine."Unit Of Measure Code");
        //VALIDATE("Bin Code",'CON'); //Comment by Hemant for Removing BIN Code Validation
        ItemJournalLine.Insert(true);
        //ALLE-AT
        //UNTIL RequisitionLine.NEXT = 0;
    end;

    procedure InsertNPostItemJnlLineNeg2IG(IndentNo: Code[20]; var RequisitionLine: Record "SSD Indent Line2"; var ItemJournalLine: Record "Item Journal Line")
    var
        ItemJournalLine2: Record "Item Journal Line";
        LineNo: Integer;
        IJLCOunt: Integer;
        IndentHeader2: Record "SSD Indent Header2";
    begin
        //ALLE-AT
        // TemplateName := GetIndentTemplate(IndentNo);
        // BatchName := GetIndentBatch(IndentHeader);
        ///RequisitionLine.SETRANGE("Indent No.",IndentHeader."No.");
         //IF RequisitionLine.FINDSET THEN
        //  REPEAT
        IndentHeader2.Reset;
        IndentHeader2.SetRange("No.", RequisitionLine."Document No.");
        if IndentHeader2.FindFirst then;
        ItemJournalLine.SetRange("Journal Template Name", 'ISSUE');
        ItemJournalLine.SetRange("Journal Batch Name", 'NEGTEST');
        if ItemJournalLine.Find('+') then LineNo := ItemJournalLine."Line No.";
        IJLCOunt := IJLCOunt + 1;
        //  if GuiAllowed then window.Update(3, StrSubstNo('%1', IJLCOunt));
        ItemJournalLine.Init();
        ItemJournalLine.Validate("Journal Template Name", 'ISSUE');
        ItemJournalLine.Validate("Journal Batch Name", 'NEGTEST');
        LineNo := LineNo + 10000;
        ItemJournalLine.Validate("Line No.", LineNo);
        // VALIDATE("Posting Date",TODAY());
        ItemJournalLine.Validate("Posting Date", IndentHeader2."Posting Date"); //Alle AU 14042021
        ItemJournalLine.Validate("Entry Type", ItemJournalLine."entry type"::"Negative Adjmt.");
        ItemJournalLine.Validate("Item No.", RequisitionLine."No.");
        ItemJournalLine.Validate("Description 2", RequisitionLine."Description 2");
        ItemJournalLine.Validate("Document No.", RequisitionLine."Document No.");
        ItemJournalLine.Validate("Location Code", RequisitionLine."Location Code");
        ItemJournalLine.Validate("Shortcut Dimension 1 Code", RequisitionLine."Shortcut Dimension 1 Code");
        ItemJournalLine.Validate("Shortcut Dimension 2 Code", RequisitionLine."Shortcut Dimension 2 Code");
        ItemJournalLine.Validate(Quantity, RequisitionLine."Issued Qty");
        ItemJournalLine.Validate("Unit of Measure Code", RequisitionLine."Unit Of Measure Code");
        //VALIDATE("Bin Code",'CON'); //Comment by Hemant for Removing BIN Code Validation
        ItemJournalLine.Insert(true);
        //ALLE-AT
        //UNTIL RequisitionLine.NEXT = 0;
    end;
}
