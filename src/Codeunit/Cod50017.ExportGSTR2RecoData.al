Codeunit 50017 "Export GSTR 2 Reco. Data"
{
    Permissions = TableData "Vendor Ledger Entry"=rm,
        TableData "Purch. Inv. Header"=rm,
        TableData "Purch. Cr. Memo Hdr."=rm,
        TableData "Detailed GST Ledger Entry"=rm;

    trigger OnRun()
    var
        recCompanyInfo: Record "Company Information";
        //SSDU qryDetailedGST: Query "GSTR 2 Reconciliation"; 
        blnFileCreated: Boolean;
        OutputFile: File;
        OutputStream: OutStream;
        txtFileName: Text;
        txtOutputText: Text;
        recDetailedGSTLedger: Record "Detailed GST Ledger Entry";
        recLocation: Record Location;
        recBankAccount: Record "Bank Account";
        txtDocumentType: Text;
        recBankLedgerEntry: Record "Bank Account Ledger Entry";
        recGSTSummary: Record "Detailed GST Ledger Entry" temporary;
        cdITCEligible: Code[10];
        txtEligibilityType: Text;
        cdReverCharge: Code[10];
        recPurchInvHeader: Record "Purch. Inv. Header";
        recVendor: Record Vendor;
        recPurchInvLines: Record "Purch. Inv. Line";
        recGSTSetup: Record "GST Setup";
        recCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        recCrMemoLines: Record "Purch. Cr. Memo Line";
        cdUOM: Code[10];
        recUnitOfMeasure: Record "Unit of Measure";
        cdSupplyType: Code[10];
        recVendorLedgerEntry: Record "Vendor Ledger Entry";
        txtReturnFillingPeriod: Text;
        blnImport: Boolean;
        txtImportType: Text;
        decGSTPrec: Decimal;
        decAmountToVendor: Decimal;
        recTransferReceiptHeader: Record "Transfer Receipt Header";
        recFromLocation: Record Location;
        recTransferReceiptLine: Record "Transfer Receipt Line";
        cdVendorGSTRegNo: Code[20];
    begin
        //SSDU Commented 
        recPurchSetup.Get;
        recPurchSetup.TestField("GSTR 2 Start Date");
        recPurchSetup.TestField("GSTR 2 Client ID");
        recPurchSetup.TestField("GSTR Local Folder");
        recPurchSetup.TestField("FTP User ID");
        recPurchSetup.TestField("FTP User Password");
        recPurchSetup.TestField("GSTR FTP Input");
        recDetailedGSTLedger.Reset;
        recDetailedGSTLedger.SetRange("GSTR 2 Reco. Initiated", true);
        if recDetailedGSTLedger.FindFirst then begin
            recDetailedGSTLedger.ModifyAll("GSTR 2 Status", recDetailedGSTLedger."gstr 2 status"::" ");
            recDetailedGSTLedger.ModifyAll("GSTR 2 Reco. Initiated", false);
        end;
        recPurchInvHeader.Reset;
        recPurchInvHeader.SetFilter("GSTR 2 Status", '<>%1', recPurchInvHeader."gstr 2 status"::" ");
        if recPurchInvHeader.FindFirst then repeat recPurchInvHeader."GSTR 2 Status":=recPurchInvHeader."gstr 2 status"::" ";
                recPurchInvHeader.Modify;
            until recPurchInvHeader.Next = 0;
        recCrMemoHeader.Reset;
        recCrMemoHeader.SetFilter("GSTR 2 Status", '<>%1', recCrMemoHeader."gstr 2 status"::" ");
        if recCrMemoHeader.FindFirst then repeat recCrMemoHeader."GSTR 2 Status":=recCrMemoHeader."gstr 2 status"::" ";
                recCrMemoHeader.Modify;
            until recCrMemoHeader.Next = 0;
        recCompanyInfo.Get;
        recCompanyInfo.TestField("GST Registration No.");
        blnFileCreated:=false;
        //SSDU Commented 
        // Clear(qryDetailedGST);
        // qryDetailedGST.SetRange(Posting_Date, recPurchSetup."GSTR 2 Start Date", recPurchSetup."GSTR 2 Start Date" + 36500);
        // qryDetailedGST.Open;
        // while qryDetailedGST.Read do begin
        //     if blnFileCreated = false then begin
        //         Clear(OutputFile);
        //         Clear(OutputStream);
        //         txtFileName := 'GSTR2_ALL_' + recCompanyInfo."GST Registration No." + '_' + ConvertCurrentDateTime(Today) + '_' +
        //                             recPurchSetup."GSTR 2 Client ID" + '.csv';
        //         //SSDOP OutputFile.Create(recPurchSetup."GSTR Local Folder" + txtFileName);
        //         //SSDOPOutputFile.CreateOutstream(OutputStream);
        //         txtOutputText := 'Operating Unit,IO Code,IO Name,TRX ID,Customer_GSTIN,Supplier_GSTIN,Supplier_Name,Document_Status,Supply_Type,';
        //         txtOutputText := txtOutputText + 'Invoice_Num,Invoice_Date,Invoice_Type,Note_Number,Note_Date,HSN/SAC,Item_Description,Quantity,';
        //         txtOutputText := txtOutputText + 'UQC,Invoice_Value,Note_Value,Taxable_Value,GST_Rate,IGST_Amount,CGST_Amount,SGST_Amount,';
        //         txtOutputText := txtOutputText + 'CESS_Amount,Revenue Account,Place_of_Supply,Location_Code,Locaction ID,ITC_Eligibility,';
        //         txtOutputText := txtOutputText + 'Eligibility_Category,Reverse_Charge,Import_Type,Bill_of_entry_number,Bill_of_entry_date,';
        //         txtOutputText := txtOutputText + 'Port_Code,GSTR2 Return Period,3B Auto-fill Period,Document Number,Document Date';
        //         OutputStream.WriteText(txtOutputText);
        //         OutputStream.WriteText();
        //         blnFileCreated := true;
        //     end;
        //     if (qryDetailedGST.Source_Type = qryDetailedGST.Source_type::Vendor) and (qryDetailedGST.Document_Type = qryDetailedGST.Document_type::Payment) then begin
        //         recGSTSummary.Reset;
        //         recGSTSummary.DeleteAll;
        //         recDetailedGSTLedger.Reset;
        //         recDetailedGSTLedger.SetCurrentkey("Document No.", "Document Line No.", "GST Component Code");
        //         recDetailedGSTLedger.SetRange("Document No.", qryDetailedGST.Document_No);
        //         recDetailedGSTLedger.SetRange("Posting Date", qryDetailedGST.Posting_Date);
        //         recDetailedGSTLedger.SetRange("Document Type", qryDetailedGST.Document_Type);
        //         recDetailedGSTLedger.SetRange("Source No.", qryDetailedGST.Source_No);
        //         recDetailedGSTLedger.SetRange("Location Code", qryDetailedGST.Location_Code);
        //         //recDetailedGSTLedger.SETRANGE("GSTR 2 Reco. Initiated", FALSE);
        //         recDetailedGSTLedger.FindSet;
        //         repeat
        //             recGSTSummary.Reset;
        //             recGSTSummary.SetRange("External Document No.", recDetailedGSTLedger."External Document No.");
        //             recGSTSummary.SetRange("HSN/SAC Code", recDetailedGSTLedger."HSN/SAC Code");
        //             if recGSTSummary.FindFirst then begin
        //                 recGSTSummary."GST Base Amount" += recDetailedGSTLedger."GST Base Amount";
        //                 if recDetailedGSTLedger."GST Component Code" = 'IGST' then begin
        //                     recGSTSummary."GST Amount" += recDetailedGSTLedger."GST Amount";
        //                     recGSTSummary.Quantity += recDetailedGSTLedger.Quantity;
        //                     recGSTSummary."CAJ Amount" += recDetailedGSTLedger."GST Base Amount" + recDetailedGSTLedger."GST Amount";
        //                 end;
        //                 if recDetailedGSTLedger."GST Component Code" = 'CGST' then begin
        //                     recGSTSummary."Amount Loaded on Item" += recDetailedGSTLedger."GST Amount";
        //                     recGSTSummary."CAJ Amount" += recDetailedGSTLedger."GST Amount";
        //                 end;
        //                 if recDetailedGSTLedger."GST Component Code" = 'SGST' then begin
        //                     recGSTSummary."CAJ Base Amount" += recDetailedGSTLedger."GST Amount";
        //                     recGSTSummary."CAJ Amount" += recDetailedGSTLedger."GST Amount";
        //                 end;
        //                 recGSTSummary.Modify;
        //             end else begin
        //                 recGSTSummary.Init;
        //                 recGSTSummary."Entry No." := recDetailedGSTLedger."Entry No.";
        //                 recGSTSummary."External Document No." := recDetailedGSTLedger."External Document No.";
        //                 recGSTSummary."HSN/SAC Code" := recDetailedGSTLedger."HSN/SAC Code";
        //                 recGSTSummary.Quantity := recDetailedGSTLedger.Quantity;
        //                 recGSTSummary."Document No." := 'OTH';
        //                 recGSTSummary."GST Base Amount" := recDetailedGSTLedger."GST Base Amount";
        //                 recGSTSummary."GST %" := recDetailedGSTLedger."GST %";
        //                 recGSTSummary."CAJ Amount" := recDetailedGSTLedger."GST Base Amount" + recDetailedGSTLedger."GST Amount";
        //                 if recDetailedGSTLedger."GST Component Code" = 'IGST' then
        //                     recGSTSummary."GST Amount" := recDetailedGSTLedger."GST Amount";
        //                 if recDetailedGSTLedger."GST Component Code" = 'CGST' then
        //                     recGSTSummary."Amount Loaded on Item" := recDetailedGSTLedger."GST Amount";
        //                 if recDetailedGSTLedger."GST Component Code" = 'SGST' then
        //                     recGSTSummary."CAJ Base Amount" := recDetailedGSTLedger."GST Amount";
        //                 recGSTSummary.Insert;
        //             end;
        //             recDetailedGSTLedger."GSTR 2 Reco. Initiated" := true;
        //             recDetailedGSTLedger.Modify;
        //         until recDetailedGSTLedger.Next = 0;
        //         recLocation.Get(recDetailedGSTLedger."Location Code");
        //         recVendor.Get(recDetailedGSTLedger."Source No.");
        //         recVendorLedgerEntry.Reset;
        //         recVendorLedgerEntry.SetCurrentkey("Document No.");
        //         recVendorLedgerEntry.SetRange("Document No.", recDetailedGSTLedger."Document No.");
        //         recVendorLedgerEntry.SetRange("Vendor No.", recDetailedGSTLedger."Source No.");
        //         recVendorLedgerEntry.FindFirst;
        //         txtDocumentType := '';
        //         if qryDetailedGST.Document_Type = qryDetailedGST.Document_type::Invoice then
        //             txtDocumentType := 'Tax Invoice'
        //         else
        //             if qryDetailedGST.Document_Type = qryDetailedGST.Document_type::"Credit Memo" then
        //                 txtDocumentType := 'Credit Note'
        //             else
        //                 if qryDetailedGST.Document_Type = qryDetailedGST.Document_type::Payment then
        //                     txtDocumentType := 'Tax Invoice'
        //                 else
        //                     Error('Invalid Document Type.');
        //         if recDetailedGSTLedger."GST Credit" = recDetailedGSTLedger."gst credit"::Availment then
        //             cdITCEligible := 'Y'
        //         else
        //             cdITCEligible := 'N';
        //         if recDetailedGSTLedger."GST Group Type" = recDetailedGSTLedger."gst group type"::Goods then
        //             txtEligibilityType := 'Input Goods'
        //         else
        //             txtEligibilityType := 'Input Service';
        //         if recDetailedGSTLedger."Reverse Charge" then
        //             cdReverCharge := 'Y'
        //         else
        //             cdReverCharge := 'N';
        //         if recDetailedGSTLedger."GST Vendor Type" = recDetailedGSTLedger."gst vendor type"::Registered then
        //             cdSupplyType := 'B2B';
        //         if (recDetailedGSTLedger."GST Vendor Type" = recDetailedGSTLedger."gst vendor type"::SEZ) and (recDetailedGSTLedger."GST Amount" <> 0) then
        //             cdSupplyType := 'SEZWP';
        //         if (recDetailedGSTLedger."GST Vendor Type" = recDetailedGSTLedger."gst vendor type"::SEZ) and (recDetailedGSTLedger."GST Amount" = 0) then
        //             cdSupplyType := 'SEZWOP';
        //         recGSTSummary.Reset;
        //         recGSTSummary.FindFirst;
        //         repeat
        //             txtReturnFillingPeriod := Format(Date2dmy(recDetailedGSTLedger."Posting Date", 2)) + Format(Date2dmy(recDetailedGSTLedger."Posting Date", 3));
        //             txtOutputText := ClearCommas(recCompanyInfo.Name) + ',' + ClearCommas(recLocation.Code) + ',' + ClearCommas(recLocation.Name) + ',' +
        //                                                 recDetailedGSTLedger."Document No." + ',' + recDetailedGSTLedger."Location  Reg. No." + ',' +
        //                                                 recDetailedGSTLedger."Buyer/Seller Reg. No." + ',' + ClearCommas(recVendor.Name) + ',' + 'ADD' +
        //                                                 ',' + cdSupplyType + ',' + ClearCommas(recGSTSummary."External Document No.") + ',' +
        //                                                 ConvertDate(recVendorLedgerEntry."Document Date") + ',' + txtDocumentType + ',' + '' + ',' + ''
        //                                                 + ',' + ClearCommas(recGSTSummary."HSN/SAC Code") + ',' + 'Bank Charges' + ',' +
        //                                                 ClearCommas(Format(recGSTSummary.Quantity)) + ',' + recGSTSummary."Document No." + ',' +
        //                                                 ClearCommas(Format(recGSTSummary."CAJ Amount")) + ',' + '' + ',' + ClearCommas(Format(Abs(recGSTSummary."GST Base Amount"))) +
        //                                                 ',' + ClearCommas(Format(recGSTSummary."GST %")) + ',' + ClearCommas(Format(Abs(recGSTSummary."GST Amount"))) + ',' +
        //                                                 ClearCommas(Format(Abs(recGSTSummary."Amount Loaded on Item"))) + ',' + ClearCommas(Format(Abs(recGSTSummary."CAJ Base Amount"))) +
        //                                                 ',' + '' + ',' + '' + ',' + CopyStr(recDetailedGSTLedger."Location  Reg. No.", 1, 2) + ',' + ClearCommas(recLocation.Name) +
        //                                                 ',' + ClearCommas(recDetailedGSTLedger."Location Code") + ',' + cdITCEligible + ',' + txtEligibilityType + ',' + cdReverCharge +
        //                                                 ',' + '' + ',' + '' + ',' + '' + ',' + '' + ',' + txtReturnFillingPeriod + ',' + txtReturnFillingPeriod +
        //                                                 ',' + recDetailedGSTLedger."Document No." + ',' + ConvertDate(recVendorLedgerEntry."Posting Date");
        //             OutputStream.WriteText(txtOutputText);
        //             OutputStream.WriteText();
        //         until recGSTSummary.Next = 0;
        //     end;
        //     if (qryDetailedGST.Source_Type = qryDetailedGST.Source_type::Vendor) and (qryDetailedGST.Document_Type = qryDetailedGST.Document_type::Invoice) then begin
        //         recDetailedGSTLedger.Reset;
        //         recDetailedGSTLedger.SetCurrentkey("Document No.", "Document Line No.", "GST Component Code");
        //         recDetailedGSTLedger.SetRange("Document No.", qryDetailedGST.Document_No);
        //         recDetailedGSTLedger.SetRange("Posting Date", qryDetailedGST.Posting_Date);
        //         recDetailedGSTLedger.SetRange("Document Type", qryDetailedGST.Document_Type);
        //         recDetailedGSTLedger.SetRange("Source No.", qryDetailedGST.Source_No);
        //         recDetailedGSTLedger.SetRange("Location Code", qryDetailedGST.Location_Code);
        //         //recDetailedGSTLedger.SETRANGE("GSTR 2 Reco. Initiated", FALSE);
        //         recDetailedGSTLedger.FindSet;
        //         repeat
        //             recDetailedGSTLedger."GSTR 2 Reco. Initiated" := true;
        //             recDetailedGSTLedger.Modify;
        //         until recDetailedGSTLedger.Next = 0;
        //         recPurchInvHeader.Get(qryDetailedGST.Document_No);
        //         recLocation.Get(recPurchInvHeader."Location Code");
        //         recVendor.Get(recPurchInvHeader."Buy-from Vendor No.");
        //         if recPurchInvHeader."Local GSTIN No." <> '' then
        //             cdVendorGSTRegNo := recPurchInvHeader."Local GSTIN No."
        //         else
        //             cdVendorGSTRegNo := recPurchInvHeader."Vendor GST Reg. No.";
        //         blnImport := false;
        //         if recVendor."Country/Region Code" <> 'IN' then
        //             blnImport := true;
        //         recPurchInvLines.Reset;
        //         recPurchInvLines.SetRange("Document No.", recPurchInvHeader."No.");
        //         recPurchInvLines.SetFilter(Quantity, '<>%1', 0);
        //         recPurchInvLines.SetRange("System-Created Entry", false);
        //         if recPurchInvLines.FindSet then
        //             repeat
        //                 if recPurchInvLines."GST Reverse Charge" then
        //                     cdReverCharge := 'Y'
        //                 else
        //                     cdReverCharge := 'N';
        //                 if recPurchInvLines."GST Credit" = recPurchInvLines."gst credit"::Availment then
        //                     cdITCEligible := 'Y'
        //                 else
        //                     cdITCEligible := 'N';
        //                 txtImportType := '';
        //                 if recPurchInvLines."GST Group Type" = recPurchInvLines."gst group type"::Goods then begin
        //                     txtEligibilityType := 'Input Goods';
        //                     if blnImport then
        //                         txtImportType := 'Import Goods';
        //                 end else begin
        //                     txtEligibilityType := 'Input Service';
        //                     if blnImport then
        //                         txtImportType := 'Import Service';
        //                 end;
        //                 recGSTSetup.Reset;
        //                 //recGSTSetup.SETRANGE("GST State Code", recLocation."State Code");
        //                 //SSD Comment Start
        //                 // recGSTSetup.SetRange("GST Group Code", recPurchInvLines."GST Group Code");
        //                 // recGSTSetup.SetRange("GST Component Code", 'IGST');
        //                 // recGSTSetup.SetRange("Effective Date", 0D, recPurchInvHeader."Posting Date");
        //                 // recGSTSetup.FindLast;
        //                 // decGSTPrec := recGSTSetup."GST Component %";
        //                 // if blnImport then
        //                 //     decAmountToVendor := recPurchInvLines."GST Base Amount" + recPurchInvLines."Total GST Amount"
        //                 // else
        //                 //     decAmountToVendor := recPurchInvLines."Line Amount" + recPurchInvLines."Total GST Amount";
        //                 // if recLocation."State Code" <> recVendor."State Code" then begin
        //                 //     txtOutputText := DelChr(Format(recPurchInvLines."Total GST Amount"), '=', ',') + ',' + '' + ',' + '' + ',' + '';
        //                 // end else begin
        //                 //     txtOutputText := DelChr(Format(ROUND(recPurchInvLines."Total GST Amount" / 2, 0.01)), '=', ',');
        //                 //     txtOutputText := '' + ',' + txtOutputText + ',' + txtOutputText + ',' + '';
        //                 // end;
        //                 // if recPurchInvLines."Unit of Measure Code" = '' then
        //                 //     cdUOM := 'OTH'
        //                 // else
        //                 //     cdUOM := recPurchInvLines."Unit of Measure Code";
        //                 // if recDetailedGSTLedger."GST Vendor Type" = recDetailedGSTLedger."gst vendor type"::Registered then
        //                 //     cdSupplyType := 'B2B';
        //                 // if (recDetailedGSTLedger."GST Vendor Type" = recDetailedGSTLedger."gst vendor type"::SEZ) and (recDetailedGSTLedger."GST Amount" <> 0) then
        //                 //     cdSupplyType := 'SEZWP';
        //                 // if (recDetailedGSTLedger."GST Vendor Type" = recDetailedGSTLedger."gst vendor type"::SEZ) and (recDetailedGSTLedger."GST Amount" = 0) then
        //                 //     cdSupplyType := 'SEZWOP';
        //                 // txtReturnFillingPeriod := Format(Date2dmy(recPurchInvHeader."Posting Date", 2)) + Format(Date2dmy(recPurchInvHeader."Posting Date", 3));
        //                 // txtOutputText := ClearCommas(recCompanyInfo.Name) + ',' + ClearCommas(recPurchInvHeader."Location Code") + ',' + ClearCommas(recLocation.Name) +
        //                 //                                     ',' + recPurchInvHeader."No." + ',' + recDetailedGSTLedger."Location  Reg. No." + ',' +
        //                 //                                     cdVendorGSTRegNo + ',' + ClearCommas(recVendor.Name) + ',' + 'ADD' + ',' +
        //                 //                                     cdSupplyType + ',' + ClearCommas(recPurchInvHeader."Vendor Invoice No.") + ',' +
        //                 //                                     ConvertDate(recPurchInvHeader."Document Date") + ',' + 'Tax Invoice' + ',' + '' + ',' + '' + ',' +
        //                 //                                     ClearCommas(recPurchInvLines."HSN/SAC Code") + ',' + '' + ',' +
        //                 //                                     ClearCommas(Format(recPurchInvLines.Quantity)) + ',' + cdUOM + ',' + ClearCommas(Format(Abs(decAmountToVendor))) +
        //                 //                                     ',' + '' + ',' + ClearCommas(Format(Abs(recPurchInvLines."GST Base Amount"))) + ',' +
        //                 //                                     ClearCommas(Format(decGSTPrec)) + ',' + txtOutputText + ',' + '' + ',' +
        //                 //                                     CopyStr(recLocation."GST Registration No.", 1, 2) + ',' + ClearCommas(recLocation.Name) + ',' +
        //                 //                                     ClearCommas(recPurchInvHeader."Location Code") + ',' + cdITCEligible + ',' + txtEligibilityType + ',' +
        //                 //                                     cdReverCharge + ',' + '' + ',' + recPurchInvHeader."Bill of Entry No." + ',' + ConvertDate(recPurchInvHeader."Bill of Entry Date") +
        //                 //                                     ',' + '' + ',' + txtReturnFillingPeriod + ',' + txtReturnFillingPeriod + ',' + recPurchInvHeader."No." +
        //                 //                                     ',' + ConvertDate(recPurchInvHeader."Posting Date");
        //                 //SSD Comment End    
        //                 OutputStream.WriteText(txtOutputText);
        //                 OutputStream.WriteText();
        //             until recPurchInvLines.Next = 0;
        //         recPurchInvHeader."GSTR 2 Exported" := true;
        //         recPurchInvHeader.Modify;
        //     end;
        //     if (qryDetailedGST.Source_Type = qryDetailedGST.Source_type::Vendor) and (qryDetailedGST.Document_Type = qryDetailedGST.Document_type::"Credit Memo") then begin
        //         recDetailedGSTLedger.Reset;
        //         recDetailedGSTLedger.SetCurrentkey("Document No.", "Document Line No.", "GST Component Code");
        //         recDetailedGSTLedger.SetRange("Document No.", qryDetailedGST.Document_No);
        //         recDetailedGSTLedger.SetRange("Posting Date", qryDetailedGST.Posting_Date);
        //         recDetailedGSTLedger.SetRange("Document Type", qryDetailedGST.Document_Type);
        //         recDetailedGSTLedger.SetRange("Source No.", qryDetailedGST.Source_No);
        //         recDetailedGSTLedger.SetRange("Location Code", qryDetailedGST.Location_Code);
        //         //recDetailedGSTLedger.SETRANGE("GSTR 2 Reco. Initiated", FALSE);
        //         recDetailedGSTLedger.FindSet;
        //         repeat
        //             recDetailedGSTLedger."GSTR 2 Reco. Initiated" := true;
        //             recDetailedGSTLedger.Modify;
        //         until recDetailedGSTLedger.Next = 0;
        //         recCrMemoHeader.Get(qryDetailedGST.Document_No);
        //         recLocation.Get(recCrMemoHeader."Location Code");
        //         recVendor.Get(recCrMemoHeader."Buy-from Vendor No.");
        //         blnImport := false;
        //         if recVendor."Country/Region Code" <> 'IN' then
        //             blnImport := true;
        //         recCrMemoLines.Reset;
        //         recCrMemoLines.SetRange("Document No.", recCrMemoHeader."No.");
        //         recCrMemoLines.SetFilter(Quantity, '<>%1', 0);
        //         recCrMemoLines.SetRange("System-Created Entry", false);
        //         if recCrMemoLines.FindSet then
        //             repeat
        //                 if recCrMemoLines."GST Reverse Charge" then
        //                     cdReverCharge := 'Y'
        //                 else
        //                     cdReverCharge := 'N';
        //                 if recCrMemoLines."GST Credit" = recCrMemoLines."gst credit"::Availment then
        //                     cdITCEligible := 'Y'
        //                 else
        //                     cdITCEligible := 'N';
        //                 txtImportType := '';
        //                 if recCrMemoLines."GST Group Type" = recCrMemoLines."gst group type"::Goods then begin
        //                     txtEligibilityType := 'Input Goods';
        //                     if blnImport then
        //                         txtImportType := 'Import Goods';
        //                 end else begin
        //                     txtEligibilityType := 'Input Service';
        //                     if blnImport then
        //                         txtImportType := 'Import Service';
        //                 end;
        //                 recGSTSetup.Reset;
        //                 //recGSTSetup.SETRANGE("GST State Code", recLocation."State Code");
        //                 //SSD Comment Start
        //                 // recGSTSetup.SetRange("GST Group Code", recCrMemoLines."GST Group Code");
        //                 // recGSTSetup.SetRange("GST Component Code", 'IGST');
        //                 // recGSTSetup.SetRange("Effective Date", 0D, recCrMemoHeader."Posting Date");
        //                 // recGSTSetup.FindLast;
        //                 // decGSTPrec := recGSTSetup."GST Component %";
        //                 // if blnImport then
        //                 //     decAmountToVendor := recCrMemoLines."GST Base Amount" + recCrMemoLines."Total GST Amount"
        //                 // else
        //                 //     decAmountToVendor := recCrMemoLines."Line Amount" + recCrMemoLines."Total GST Amount";
        //                 // if recLocation."State Code" <> recVendor."State Code" then begin
        //                 //     txtOutputText := DelChr(Format(recCrMemoLines."Total GST Amount"), '=', ',') + ',' + '' + ',' + '' + ',' + '';
        //                 // end else begin
        //                 //     txtOutputText := DelChr(Format(ROUND(recCrMemoLines."Total GST Amount" / 2, 0.01)), '=', ',');
        //                 //     txtOutputText := '' + ',' + txtOutputText + ',' + txtOutputText + ',' + '';
        //                 // end;
        //                 // if recCrMemoLines."Unit of Measure Code" = '' then
        //                 //     cdUOM := 'OTH'
        //                 // else
        //                 //     cdUOM := recCrMemoLines."Unit of Measure Code";
        //                 // if recDetailedGSTLedger."GST Vendor Type" = recDetailedGSTLedger."gst vendor type"::Registered then
        //                 //     cdSupplyType := 'B2B';
        //                 // if (recDetailedGSTLedger."GST Vendor Type" = recDetailedGSTLedger."gst vendor type"::SEZ) and (recDetailedGSTLedger."GST Amount" <> 0) then
        //                 //     cdSupplyType := 'SEZWP';
        //                 // if (recDetailedGSTLedger."GST Vendor Type" = recDetailedGSTLedger."gst vendor type"::SEZ) and (recDetailedGSTLedger."GST Amount" = 0) then
        //                 //     cdSupplyType := 'SEZWOP';
        //                 // txtReturnFillingPeriod := Format(Date2dmy(recCrMemoHeader."Posting Date", 2)) + Format(Date2dmy(recCrMemoHeader."Posting Date", 3));
        //                 // txtOutputText := ClearCommas(recCompanyInfo.Name) + ',' + ClearCommas(recCrMemoHeader."Location Code") + ',' + ClearCommas(recLocation.Name) +
        //                 //                                 ',' + recCrMemoHeader."No." + ',' + recDetailedGSTLedger."Location  Reg. No." + ',' +
        //                 //                                 recCrMemoHeader."Vendor GST Reg. No." + ',' + ClearCommas(recVendor.Name) + ',' + 'ADD' + ',' +
        //                 //                                 cdSupplyType + ',' + ClearCommas(recCrMemoHeader."Vendor Cr. Memo No.") + ',' + ConvertDate(recCrMemoHeader."Document Date") +
        //                 //                                 ',' + 'Credit Note' + ',' + ClearCommas(recCrMemoHeader."Vendor Cr. Memo No.") + ',' + ConvertDate(recCrMemoHeader."Document Date") +
        //                 //                                 ',' + ClearCommas(recCrMemoLines."HSN/SAC Code") + ',' + '' + ',' +
        //                 //                                 ClearCommas(Format(recCrMemoLines.Quantity)) + ',' + cdUOM + ',' + ClearCommas(Format(Abs(decAmountToVendor))) + ',' +
        //                 //                                 ClearCommas(Format(Abs(decAmountToVendor))) + ',' +
        //                 //                                 ClearCommas(Format(Abs(recCrMemoLines."GST Base Amount"))) + ',' + ClearCommas(Format(decGSTPrec)) + ',' +
        //                 //                                 txtOutputText + ',' + '' + ',' + CopyStr(recLocation."GST Registration No.", 1, 2) + ',' +
        //                 //                                 ClearCommas(recLocation.Name) + ',' + ClearCommas(recCrMemoHeader."Location Code") + ',' + cdITCEligible +
        //                 //                                 ',' + txtEligibilityType + ',' + cdReverCharge + ',' + '' + ',' + recCrMemoHeader."Bill of Entry No." + ',' +
        //                 //                                 ConvertDate(recCrMemoHeader."Bill of Entry Date") + ',' + '' + ',' +
        //                 //                                 txtReturnFillingPeriod + ',' + txtReturnFillingPeriod + ',' + recCrMemoHeader."No." + ',' +
        //                 //                                 ConvertDate(recCrMemoHeader."Document Date");
        //                 //SSD Comment End
        //                 OutputStream.WriteText(txtOutputText);
        //                 OutputStream.WriteText();
        //             until recCrMemoLines.Next = 0;
        //         recCrMemoHeader."GSTR 2 Exported" := true;
        //         recCrMemoHeader.Modify;
        //     end;
        //     if (qryDetailedGST.Source_Type = qryDetailedGST.Source_type::" ") and (qryDetailedGST.Document_Type = qryDetailedGST.Document_type::Invoice) then begin
        //         recDetailedGSTLedger.Reset;
        //         recDetailedGSTLedger.SetCurrentkey("Document No.", "Document Line No.", "GST Component Code");
        //         recDetailedGSTLedger.SetRange("Document No.", qryDetailedGST.Document_No);
        //         recDetailedGSTLedger.SetRange("Posting Date", qryDetailedGST.Posting_Date);
        //         recDetailedGSTLedger.SetRange("Document Type", qryDetailedGST.Document_Type);
        //         recDetailedGSTLedger.SetRange("Source No.", qryDetailedGST.Source_No);
        //         recDetailedGSTLedger.SetRange("Location Code", qryDetailedGST.Location_Code);
        //         //recDetailedGSTLedger.SETRANGE("GSTR 2 Reco. Initiated", FALSE);
        //         recDetailedGSTLedger.FindSet;
        //         repeat
        //             recDetailedGSTLedger."GSTR 2 Reco. Initiated" := true;
        //             recDetailedGSTLedger.Modify;
        //         until recDetailedGSTLedger.Next = 0;
        //         recTransferReceiptHeader.Get(qryDetailedGST.Document_No);
        //         recLocation.Get(recTransferReceiptHeader."Transfer-to Code");
        //         recLocation.TestField("State Code");
        //         recFromLocation.Get(recTransferReceiptHeader."Transfer-from Code");
        //         recFromLocation.TestField("State Code");
        //         if recFromLocation."State Code" <> recLocation."State Code" then begin
        //             recTransferReceiptLine.Reset();
        //             recTransferReceiptLine.SetRange("Document No.", recTransferReceiptHeader."No.");
        //             recTransferReceiptLine.SetFilter(Quantity, '<>%1', 0);
        //             if recTransferReceiptLine.FindSet then
        //                 repeat
        //                     cdReverCharge := 'N';
        //                     if recTransferReceiptLine."GST Credit" = recTransferReceiptLine."gst credit"::Availment then
        //                         cdITCEligible := 'Y'
        //                     else
        //                         cdITCEligible := 'N';
        //                     txtImportType := '';
        //                     txtEligibilityType := 'Input Goods';
        //                     if blnImport then
        //                         txtImportType := 'Import Goods';
        //                     recGSTSetup.Reset;
        //                     //recGSTSetup.SETRANGE("GST State Code", recLocation."State Code");
        //                     //SSD Comment Start
        //                     // recGSTSetup.SetRange("GST Group Code", recTransferReceiptLine."GST Group Code");
        //                     // recGSTSetup.SetRange("GST Component Code", 'IGST');
        //                     // recGSTSetup.SetRange("Effective Date", 0D, recTransferReceiptHeader."Posting Date");
        //                     // recGSTSetup.FindLast;
        //                     // decGSTPrec := recGSTSetup."GST Component %";
        //                     // decAmountToVendor := recTransferReceiptLine.Amount + recTransferReceiptLine."Total GST Amount";
        //                     // if recLocation."State Code" <> recFromLocation."State Code" then begin
        //                     //     txtOutputText := DelChr(Format(recTransferReceiptLine."Total GST Amount"), '=', ',') + ',' + '' + ',' + '' + ',' + '';
        //                     // end else begin
        //                     //     txtOutputText := DelChr(Format(ROUND(recTransferReceiptLine."Total GST Amount" / 2, 0.01)), '=', ',');
        //                     //     txtOutputText := '' + ',' + txtOutputText + ',' + txtOutputText + ',' + '';
        //                     // end;
        //                     // cdUOM := recTransferReceiptLine."Unit of Measure Code";
        //                     // cdSupplyType := 'B2B';
        //                     // txtReturnFillingPeriod := Format(Date2dmy(recTransferReceiptHeader."Posting Date", 2)) + Format(Date2dmy(recTransferReceiptHeader."Posting Date", 3));
        //                     // txtOutputText := ClearCommas(recCompanyInfo.Name) + ',' + ClearCommas(recTransferReceiptHeader."Transfer-to Code") + ',' + ClearCommas(recLocation.Name) +
        //                     //                                     ',' + recTransferReceiptHeader."No." + ',' + recDetailedGSTLedger."Location  Reg. No." + ',' +
        //                     //                                     recDetailedGSTLedger."Buyer/Seller Reg. No." + ',' + ClearCommas(recFromLocation.Name) + ',' + 'ADD' + ',' +
        //                     //                                     cdSupplyType + ',' + ClearCommas(recDetailedGSTLedger."External Document No.") + ',' +
        //                     //                                     ConvertDate(recTransferReceiptHeader."Posting Date") + ',' + 'Tax Invoice' + ',' + '' + ',' + '' + ',' +
        //                     //                                     ClearCommas(recTransferReceiptLine."HSN/SAC Code") + ',' + '' + ',' +
        //                     //                                     ClearCommas(Format(recTransferReceiptLine.Quantity)) + ',' + cdUOM + ',' + ClearCommas(Format(Abs(decAmountToVendor))) +
        //                     //                                     ',' + '' + ',' + ClearCommas(Format(Abs(recTransferReceiptLine.Amount))) + ',' +
        //                     //                                     ClearCommas(Format(decGSTPrec)) + ',' + txtOutputText + ',' + '' + ',' +
        //                     //                                     CopyStr(recLocation."GST Registration No.", 1, 2) + ',' + ClearCommas(recLocation.Name) + ',' +
        //                     //                                     ClearCommas(recTransferReceiptHeader."Transfer-to Code") + ',' + cdITCEligible + ',' + txtEligibilityType + ',' +
        //                     //                                     cdReverCharge + ',' + '' + ',' + recTransferReceiptHeader."Bill of Entry No." + ',' + ConvertDate(recTransferReceiptHeader."Bill of Entry Date") +
        //                     //                                     ',' + '' + ',' + txtReturnFillingPeriod + ',' + txtReturnFillingPeriod + ',' + recTransferReceiptHeader."No." +
        //                     //                                     ',' + ConvertDate(recTransferReceiptHeader."Posting Date");
        //                     //SSD Comment End
        //                     OutputStream.WriteText(txtOutputText);
        //                     OutputStream.WriteText();
        //                 until recTransferReceiptLine.Next = 0;
        //         end;
        //         recTransferReceiptHeader."GSTR 2 Exported" := true;
        //         recTransferReceiptHeader.Modify;
        //     end;
        // end;
        // qryDetailedGST.Close();
        //Upload the File
        if blnFileCreated then begin
            //SSDOP OutputFile.Close();
            UPloadFileToFTP(txtFileName, recPurchSetup."GSTR Local Folder" + txtFileName);
        //FILE.ERASE(recPurchSetup."GSTR Local Folder" + txtFileName);
        end;
    end;
    var recPurchSetup: Record "Purchases & Payables Setup";
    local procedure ConvertCurrentDateTime(CurrentDate: Date)DateTimeAsText: Text begin
        DateTimeAsText:=Format(Date2dmy(CurrentDate, 3));
        if StrLen(DateTimeAsText) = 2 then DateTimeAsText:='20' + DateTimeAsText;
        if StrLen(Format(Date2dmy(CurrentDate, 2))) < 2 then DateTimeAsText:=DateTimeAsText + '0' + Format(Date2dmy(CurrentDate, 2))
        else
            DateTimeAsText:=DateTimeAsText + Format(Date2dmy(CurrentDate, 2));
        if StrLen(Format(Date2dmy(CurrentDate, 1))) < 2 then DateTimeAsText:=DateTimeAsText + '0' + Format(Date2dmy(CurrentDate, 1))
        else
            DateTimeAsText:=DateTimeAsText + Format(Date2dmy(CurrentDate, 1));
        DateTimeAsText:=DateTimeAsText + DelChr(CopyStr(Format(Time), 1, 5), '=', ':');
    end;
    local procedure ConvertDate(PostingDate: Date)DateAsText: Text var
        intDay: Integer;
        opMonth: Option " ", Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec;
        intYear: Integer;
    begin
        DateAsText:='';
        if PostingDate <> 0D then begin
            intDay:=Date2dmy(PostingDate, 1);
            opMonth:=Date2dmy(PostingDate, 2);
            intYear:=Date2dmy(PostingDate, 3);
            DateAsText:=Format(intDay) + '-' + Format(opMonth) + '-' + Format(intYear);
        end;
    end;
    local procedure ClearCommas(InputText: Text)OutputText: Text begin
        OutputText:=DelChr(InputText, '=', ',');
    end;
    local procedure UPloadFileToFTP(FileName: Text; FileNameWithPath: Text)
    var
    //SSD Comment Start
    // FTPWebRequest: dotnet FtpWebRequest;
    // NetworkCredential: dotnet NetworkCredential;
    // FileStream: dotnet FileStream;
    // FileDotNet: dotnet File;
    // Stream: dotnet FileStream;
    // FTPWebResponse: dotnet FileWebResponse;
    begin
    // FTPWebRequest := FTPWebRequest.Create(recPurchSetup."GSTR FTP Input" + FileName);
    // FTPWebRequest.Credentials := NetworkCredential.NetworkCredential(recPurchSetup."FTP User ID", recPurchSetup."FTP User Password");
    // FTPWebRequest.UseBinary := true;
    // FTPWebRequest.UsePassive := true;
    // FTPWebRequest.Method := 'STOR';
    // FileStream := FileDotNet.OpenRead(FileNameWithPath);
    // Stream := FTPWebRequest.GetRequestStream();
    // FileStream.CopyTo(Stream);
    // Stream.Close;
    // FTPWebResponse := FTPWebRequest.GetResponse();
    // FTPWebResponse.Close();
    //SSD Comment End
    end;
}
