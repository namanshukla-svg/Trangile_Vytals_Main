Codeunit 50019 "CreateAmazon Sales Invoice"
{
    // Alle-[Amazon-HG]-Created a new codeunit for Amazon SI Integration
    trigger OnRun()
    begin
        CreateSalesInvoice;
        Message('Process Completed');
    end;

    var
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        SL1: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        //IG_DS_Before NoSeriesManagement: Codeunit NoSeriesManagement;
        NoSeriesManagement: Codeunit "No. Series";
        NoSeries: Record "No. Series";
        Item: Record Item;
        PrevAmazonOrderId: Code[35];
        LineNo: Integer;
        AmazonStaging: Record "SSD Amazon Staging";
        PSDate: Date;
        SH1: Record "Sales Header";
        SL2: Record "Sales Line";
        AmzShippingTotal: Decimal;
        AmzShipPromoAmtTot: Decimal;
        SL3: Record "Sales Line";
        AmazSatg2: Record "SSD Amazon Staging";
        SH2: Record "Sales Header";
        GLSetup: Record "General Ledger Setup";
        AmanStging3: Record "SSD Amazon Staging";
        linecount: Integer;
        ShiptoAddress: Record "Ship-to Address";
        Customer: Record Customer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ReferenceInvoiceNo1: Record "Reference Invoice No.";
        GLAccount: Record "G/L Account";

    procedure CreateSalesInvoice()
    begin
        Clear(PrevAmazonOrderId);
        Clear(LineNo);
        AmazonStaging.Reset;
        //AmazonStaging.SETCURRENTKEY("Amazon OrderId");
        AmazonStaging.SetCurrentkey("Entry Type", "Amazon OrderId"); //new
        //AmazonStaging.SETCURRENTKEY("Entry Type");//new
        AmazonStaging.SetRange("Invoice/Credit Memo Created", false);
        if AmazonStaging.FindSet then
            repeat
                if PrevAmazonOrderId <> AmazonStaging."Amazon OrderId" then begin
                    linecount := 0;
                    Clear(SH);
                    LineNo := 10000;
                    SH.Init;
                    SH.SetCurrentkey("Document Type", "No.");
                    if AmazonStaging."Entry Type" = AmazonStaging."entry type"::"Credit Memo" then
                        SH.Validate("Document Type", SH."document type"::"Credit Memo")
                    else
                        SH.Validate("Document Type", SH."document type"::Invoice);
                    if SH."No." = '' then begin
                        if SH."Document Type" = SH."document type"::Invoice then begin
                            SalesSetup.Get;
                            SalesSetup.TestField("Amazon Invoice Nos.");
                            //IG_DS_Before  NoSeriesManagement.InitSeries(SalesSetup."Amazon Invoice Nos.", '', 0D, SH."No.", NoSeries.Code);
                            //  if NoSeriesManagement.AreRelated(SalesSetup."Amazon Invoice Nos.", '') then
                            //  "No. Series" := xRec."No. Series";
                            SH."No. Series" := SalesSetup."Amazon Invoice Nos.";
                            SH."No." := NoSeriesManagement.GetNextNo(SH."No. Series");
                        end
                        else if SH."Document Type" = SH."document type"::"Credit Memo" then begin
                            SalesSetup.Get;
                            SalesSetup.TestField("Amazon Credit Memo Nos.");
                            //IG_DS_Before  NoSeriesManagement.InitSeries(SalesSetup."Amazon Credit Memo Nos.", '', 0D, SH."No.", NoSeries.Code);
                            // if NoSeriesManagement.AreRelated(SalesSetup."Amazon Credit Memo Nos.", '') then
                            // "No. Series" := xRec."No. Series";
                            SH."No. Series" := SalesSetup."Amazon Credit Memo Nos.";
                            SH."No." := NoSeriesManagement.GetNextNo(SH."No. Series");
                        end;
                    end;
                    SH.Validate("No.");
                    SH.Validate("Sell-to Customer No.", AmazonStaging."ZD Customer Code");
                    SH.Validate("External Document No.", AmazonStaging."Amazon OrderId");
                    if SH."Document Type" = SH."document type"::Invoice then
                        SH.Validate("Posting No.", AmazonStaging."Amazon Posted Invoice No.")
                    else if SH."Document Type" = SH."document type"::"Credit Memo" then SH."Posting No." := SalesSetup."Amazon Posted Credit Memo Nos.";
                    //IF SH."Document Type" = SH."Document Type"::"Credit Memo" THEN
                    //SH.VALIDATE("Posting No.",AmazonStaging."Amazon Posted Credit Memo No.");
                    SalesSetup.Get;
                    SH.Validate(State);
                    //SH.VALIDATE("Nature of Supply");
                    Customer.Reset;
                    if Customer.Get(AmazonStaging."ZD Customer Code") then begin
                        SH.Validate("GST Customer Type", Customer."GST Customer Type");
                        SH.Validate("GST Bill-to State Code", Customer."State Code");
                        SH.Validate("Customer GST Reg. No.", Customer."GST Registration No.");
                    end;
                    SH.Validate("Part No.", AmazonStaging."End Customer Name"); //Part No of SH for End Cust Name
                    SH.Validate("Customer Quote No.", AmazonStaging."End Customer Name Address"); //Customer Quote No. OF SH for End Customer Name Address
                    SH.Validate("Ship-to Code", AmazonStaging."Customer Ship-to-Code");
                    ShiptoAddress.Reset;
                    ShiptoAddress.SetRange(Code, AmazonStaging."Customer Ship-to-Code");
                    if ShiptoAddress.FindFirst then begin
                        SH.Validate("GST Ship-to State Code", ShiptoAddress.State);
                    end;
                    //Posting No. Series
                    SalesSetup.Get;
                    SalesSetup.TestField("Amazon Posted Invoice Nos.");
                    SalesSetup.TestField("Amazon Posted Credit Memo Nos.");
                    SH.Insert(true);
                    if SH."Document Type" = SH."document type"::Invoice then begin
                        SH."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
                        SH."Shipping No." := NoSeriesManagement.GetNextNo(SalesSetup."Posted Shipment Nos.", WorkDate, true);
                        SH."Posting No. Series" := SalesSetup."Amazon Posted Invoice Nos.";
                    end
                    else if SH."Document Type" = SH."document type"::"Credit Memo" then begin
                        SH."Posting No. Series" := SalesSetup."Amazon Posted Credit Memo Nos.";
                        SH."Posting No." := NoSeriesManagement.GetNextNo(SalesSetup."Amazon Posted Credit Memo Nos.", WorkDate, true);
                        SH."Posting No. Series" := SalesSetup."Amazon Posted Credit Memo Nos.";
                    end;
                    SH.Validate("Posting Date", AmazonStaging."Posting Date");
                    SH.Validate("Expected Delivery Date", AmazonStaging."Posting Date");
                    SH."Amazon Invoice/Credit Memo" := true;
                    //SH.VALIDATE("ST38 No",SH."Applied to Insurance Policy");
                    SH.Validate("Location Code", SalesSetup."Amazon Location Master"); //01.09.20
                    //SH.VALIDATE("Location Code");//,SalesSetup."Amazon Location Master");//Not validating as casuing issue with No. series.//01.09.20
                    //SH.VALIDATE("Ship-to Code",AmazonStaging."Customer Ship-to-Code");
                    SH.Modify;
                    //For Credit Memo case+
                    if SH."Document Type" = SH."document type"::"Credit Memo" then begin
                        SalesInvoiceHeader.Reset;
                        SalesInvoiceHeader.SetRange("No.", AmazonStaging."Original Invoice No.");
                        if SalesInvoiceHeader.FindFirst then begin
                            SH.Validate("Applies-to Doc. Type", SH."applies-to doc. type"::Invoice);
                            SH.Validate("Applies-to Doc. No.", SalesInvoiceHeader."No.");
                            SH.Validate("Reference Invoice No.", SalesInvoiceHeader."No.");
                            //        IF SH.Structure = 'GST' THEN BEGIN
                            //          ReferenceInvoiceNo1.RESET;
                            //          ReferenceInvoiceNo1.INIT;
                            //          ReferenceInvoiceNo1.VALIDATE("Document No.",SH."No.");
                            //          ReferenceInvoiceNo1.VALIDATE("Document Type",SH."Document Type");
                            //          ReferenceInvoiceNo1.VALIDATE("Source No.",SH."Sell-to Customer No.");
                            //          ReferenceInvoiceNo1.VALIDATE("Source Type",ReferenceInvoiceNo1."Source Type"::Customer);
                            //          ReferenceInvoiceNo1.VALIDATE("Journal Batch Name",'');
                            //          ReferenceInvoiceNo1.VALIDATE("Journal Template Name",'');
                            //          ReferenceInvoiceNo1.VALIDATE("Reference Invoice Nos.",SalesInvoiceHeader."No.");
                            //          ReferenceInvoiceNo1.VALIDATE(Verified,TRUE);
                            //          ReferenceInvoiceNo1.INSERT(TRUE)
                            //        END;
                        end;
                    end;
                    //For Credit Memo case-
                    SH.Modify;
                    CreateSalesLine(SH, AmazonStaging);
                    PrevAmazonOrderId := AmazonStaging."Amazon OrderId";
                end
                else begin
                    LineNo += 10000;
                    CreateSalesLine(SH, AmazonStaging);
                end;
                AmazonStaging."Invoice/Credit Memo Created" := true;
                AmazonStaging."NAV SI Created No." := SH."No.";
                AmazonStaging."Invoice Created DateTime" := CurrentDatetime;
                AmazonStaging.Modify;
            until AmazonStaging.Next = 0;
        //InsertGLSalesLine;
    end;

    procedure CreateSalesLine(SalesHeader: Record "Sales Header"; AmazonStaging: Record "SSD Amazon Staging")
    begin
        SalesSetup.Get;
        linecount += 1;
        SL.Init;
        SL.Validate("Document Type", SH."Document Type");
        SL.Validate("Document No.", SH."No.");
        SL.Validate("Line No.", LineNo);
        //For Type=Item
        SL.Validate(Type, SL.Type::Item);
        SL.Validate("No.", AmazonStaging."ZD FG Code");
        SL.Validate(Quantity, AmazonStaging."Quantity Shipped");
        SL.Validate("Currency Code", SH."Currency Code");
        SL.Validate("Unit Price", AmazonStaging."Item Price");
        SL.Validate("Location Code", SH."Location Code");
        SL.Validate("Amazon Invoice/Credit Memo", SH."Amazon Invoice/Credit Memo"); //030920
        //MESSAGE('%1,%2',FORMAT(AmazonStaging."Entry Type"),FORMAT(AmazonStaging."Amazon OrderId"));
        SL.Insert(true);
        SL.Validate("Amazon Ship Promo Discount", AmazonStaging."Ship Promotion Discount");
        SL.Validate("Amazon Shipping Price", AmazonStaging."Shipping Price");
        //SL.VALIDATE("Line Discount Amount",AmazonStaging."Ship-promotion-discount");//Not needed will insert using GL
        Item.Reset;
        if Item.Get(SL."No.") then begin
            SL.Validate("GST Group Code", Item."GST Group Code");
            SL.Validate("HSN/SAC Code", Item."HSN/SAC Code");
        end;
        //SL.VALIDATE("Shortcut Dimension 1 Code");
        //SL.VALIDATE("Shortcut Dimension 2 Code");
        SL.Validate("Amazon SKU", AmazonStaging.SKU);
        //SL.VALIDATE("Amazon Invoice No.",SH."Amazon Invoice No.");
        SL.Validate("Amazon Invoice/Credit Memo", SH."Amazon Invoice/Credit Memo");
        SL.Validate("GST Place of Supply", SL."gst place of supply"::"Ship-to Address");
        //SL.VALIDATE("Dimension Set ID",SH."Dimension Set ID");
        SL.Modify;
        //SL.CalculateStructures(SH);
        //SL.AdjustStructureAmounts(SH);
        //SL.UpdateSalesLines(SH);
        //SL.UpdateAmounts;
        //InsertGLLine
        AmanStging3.Reset;
        AmanStging3.SetCurrentkey("Entry Type", "Amazon OrderId");
        //AmanStging3.SETRANGE("Entry Type",SH."Document Type");
        //AmanStging3.SETCURRENTKEY("Entry Type");
        //AmanStging3.SETRANGE("Invoice/Credit Memo Created",FALSE);
        AmanStging3.SetRange("Entry Type", AmazonStaging."Entry Type");
        AmanStging3.SetRange("Amazon OrderId", AmazonStaging."Amazon OrderId");
        AmanStging3.CalcSums("Ship Promotion Discount", "Shipping Price");
        //MESSAGE('%1,%2,%3',AmanStging3.COUNT,linecount,AmanStging3."Amazon OrderId");
        if AmanStging3.Count = linecount then begin
            AmzShipPromoAmtTot := 0;
            AmzShippingTotal := 0;
            AmzShipPromoAmtTot := AmanStging3."Ship Promotion Discount";
            AmzShippingTotal := AmanStging3."Shipping Price";
            if (AmzShipPromoAmtTot <> 0) or (AmzShippingTotal <> 0) then begin
                SL.Init;
                SL.Validate("Document Type", SH."Document Type");
                SL.Validate("Document No.", SH."No.");
                SL.Validate("Line No.", LineNo);
                //SL.VALIDATE("Location Code",SalesSetup."Amazon Location Master");
                SL2.Reset;
                SL2.SetRange("Document Type", SL."Document Type");
                SL2.SetRange("Document No.", SL."Document No.");
                if SL2.FindLast then SL."Line No." := SL."Line No." + 10000;
                //MESSAGE('%1,%2,%3',AmanStging3.COUNT,linecount,AmanStging3."Amazon OrderId");
                SL.Insert(true);
                //For Type=G/L Account
                SL.Validate(Type, SL.Type::"G/L Account");
                //new
                GLAccount.Reset;
                if GLAccount.Get(SL."No.") then begin
                    SL.Validate("GST Group Code", GLAccount."GST Group Code");
                    SL.Validate("HSN/SAC Code", GLAccount."HSN/SAC Code");
                end;
                //new
                GLSetup.Get;
                SL.Validate("No.", GLSetup."Amazon Freight GL"); //GL Setup based
                SL.Validate(Quantity, 1);
                SL.Validate("Amazon Invoice/Credit Memo", SH."Amazon Invoice/Credit Memo");
                SL.Validate("GST Place of Supply", SL."gst place of supply"::"Ship-to Address");
                //condition for if AmzShipPromoAmtTot =0 but AmzShippingTotal <>0
                if AmzShipPromoAmtTot <> 0 then begin
                    SL.Validate("Unit Price", AmzShipPromoAmtTot);
                    if SL."Line Amount" <> 0 then SL.Validate("Line Discount Amount", SL."Line Amount");
                    SL.Validate("GST Place of Supply", SL."gst place of supply"::"Ship-to Address");
                end
                else begin
                    SL.Validate("Unit Price", AmzShippingTotal);
                    SL.Validate("GST Place of Supply", SL."gst place of supply"::"Ship-to Address");
                end;
                SL.Validate("Amazon Invoice/Credit Memo", SH."Amazon Invoice/Credit Memo");
                SL.Validate("GST Place of Supply", SL."gst place of supply"::"Ship-to Address");
                SL.Modify;
            end;
        end;
        //InsertGLLine-
    end;
}
