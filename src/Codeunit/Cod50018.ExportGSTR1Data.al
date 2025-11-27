Codeunit 50018 "Export GSTR 1 Data"
{
    Permissions = TableData "Sales Invoice Header"=rm,
        TableData "Sales Cr.Memo Header"=rm,
        TableData "Transfer Shipment Line"=rm;

    trigger OnRun()
    var
        recCompanyInfo: Record "Company Information";
        OutputFile: File;
        OutputStream: OutStream;
        txtFileName: Text;
        txtOutputText: Text;
        blnFileCreated: Boolean;
        recSalesInvoiceHeader: Record "Sales Invoice Header";
        recLocation: Record Location;
        recCustomer: Record Customer;
        recState: Record State;
        blnExportInvoice: Boolean;
        decCurrencyFactor: Decimal;
        recSalesInvoiceLines: Record "Sales Invoice Line";
        recUnitOfMeasure: Record "Unit of Measure";
        recGSTSetup: Record "GST Setup";
        decGSTPerc: Decimal;
        cdExportType: Code[10];
        cdPOS: Code[10];
        txtReturnFillingPeriod: Text;
        recSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        recSalesCrMemoLines: Record "Sales Cr.Memo Line";
        recTransferShipmentHeader: Record "Transfer Shipment Header";
        recToLoction: Record Location;
        cdCustomerGSTNo: Code[20];
        recDetailedGSTLedger: Record "Detailed GST Ledger Entry";
        recTransferShipmentLine: Record "Transfer Shipment Line";
    begin
        recPurchSetup.Get;
        recPurchSetup.TestField("GSTR 1 Start Date");
        recPurchSetup.TestField("GSTR 1 Client ID");
        recPurchSetup.TestField("GSTR Local Folder");
        recPurchSetup.TestField("FTP User ID");
        recPurchSetup.TestField("FTP User Password");
        recPurchSetup.TestField("GSTR FTP Input");
        recCompanyInfo.Get;
        recCompanyInfo.TestField("GST Registration No.");
        blnFileCreated:=false;
        recSalesInvoiceHeader.Reset;
        //recSalesInvoiceHeader.SETRANGE("GSTR 1 Exported", FALSE);
        recSalesInvoiceHeader.SetRange("Posting Date", recPurchSetup."GSTR 1 Start Date", Today + 3000);
        if recSalesInvoiceHeader.FindSet then begin
            Clear(OutputFile);
            Clear(OutputStream);
            blnFileCreated:=true;
            txtFileName:='GSTR1_ALL_' + recCompanyInfo."GST Registration No." + '_' + ConvertCurrentDateTime(Today) + '_' + recPurchSetup."GSTR 1 Client ID" + '.csv';
            //txtFileName := 'GSTR1.csv';
            //SSDOP OutputFile.Create(recPurchSetup."GSTR Local Folder" + txtFileName);
            //SSDOPOutputFile.CreateOutstream(OutputStream);
            txtOutputText:='Operating Unit,IO Code,IO Name,Supplier_GSTIN,Document_Status,TRX Number,Supply_Type,';
            txtOutputText:=txtOutputText + 'Invoice_Num,Invoice_Date,Invoice_Type,Note_Number,Note_Date,HSN/SAC,Item_Description,Quantity,';
            txtOutputText:=txtOutputText + 'UQC,Invoice_Value,Note_Value,Taxable_Value,GST_Rate,IGST_Amount,CGST_Amount,SGST_Amount,';
            txtOutputText:=txtOutputText + 'CESS_Amount,Revenue Account,Customer_GSTIN,Customer_Name,Place_of_Supply,Export_Type,Shipping_Bill_Number,';
            txtOutputText:=txtOutputText + 'Shipping_Bill_Date,Port_Number,GSTR1 Return Period,3B Auto-fill Period,Location Code,Locaction ID,Amortised_Cost';
            OutputStream.WriteText(txtOutputText);
            OutputStream.WriteText();
            repeat recLocation.Get(recSalesInvoiceHeader."Location Code");
                recCustomer.Get(recSalesInvoiceHeader."Bill-to Customer No.");
                if not recState.Get(recCustomer."State Code")then recState.Init();
                blnExportInvoice:=false;
                if recCustomer."Country/Region Code" <> 'IN' then blnExportInvoice:=true;
                if recSalesInvoiceHeader."Currency Factor" <> 0 then decCurrencyFactor:=1 / recSalesInvoiceHeader."Currency Factor"
                else
                    decCurrencyFactor:=1;
                recSalesInvoiceLines.Reset;
                recSalesInvoiceLines.SetRange("Document No.", recSalesInvoiceHeader."No.");
                recSalesInvoiceLines.SetFilter(Quantity, '<>%1', 0);
                recSalesInvoiceLines.SetRange("System-Created Entry", false);
                if recSalesInvoiceLines.FindSet then repeat if not recUnitOfMeasure.Get(recSalesInvoiceLines."Unit of Measure Code")then recUnitOfMeasure.Init;
                        decGSTPerc:=0;
                        recGSTSetup.Reset;
                        //recGSTSetup.SETRANGE("GST State Code", recLocation."State Code");
                        //SSD Comment Start
                        // recGSTSetup.SetRange("GST Group Code", recSalesInvoiceLines."GST Group Code");
                        // recGSTSetup.SetRange("GST Component Code", 'IGST');
                        // recGSTSetup.SetRange("Effective Date", 0D, recSalesInvoiceHeader."Posting Date");
                        // if recGSTSetup.FindLast then
                        //     decGSTPerc := recGSTSetup."GST Component %";
                        // cdExportType := '';
                        // if (blnExportInvoice = true) and (recSalesInvoiceLines."Total GST Amount" <> 0) then
                        //     cdExportType := 'WPAY';
                        // if (blnExportInvoice = true) and (recSalesInvoiceLines."Total GST Amount" = 0) then
                        //     cdExportType := 'WOPAY';
                        // if (recCustomer."GST Customer Type" in [recCustomer."gst customer type"::"SEZ Development", recCustomer."gst customer type"::"SEZ Unit"]) and (recSalesInvoiceLines."Total GST Amount" <> 0) then
                        //     cdExportType := 'WPAY';
                        // if (recCustomer."GST Customer Type" in [recCustomer."gst customer type"::"SEZ Development", recCustomer."gst customer type"::"SEZ Unit"]) and (recSalesInvoiceLines."Total GST Amount" = 0) then
                        //     cdExportType := 'WOPAY';
                        // if cdExportType = 'WOPAY' then
                        //     decGSTPerc := 0;
                        // if cdExportType <> '' then
                        //     cdPOS := '96'
                        // else
                        //     cdPOS := recState."State Code (GST Reg. No.)";
                        // if recLocation."State Code" <> recCustomer."State Code" then begin
                        //     txtOutputText := DelChr(Format(recSalesInvoiceLines."Total GST Amount"), '=', ',') + ',' + '' + ',' + '' + ',' + '';
                        // end else begin
                        //     txtOutputText := DelChr(Format(ROUND(recSalesInvoiceLines."Total GST Amount" / 2, 0.01)), '=', ',');
                        //     txtOutputText := '' + ',' + txtOutputText + ',' + txtOutputText + ',' + '';
                        // end;
                        // txtReturnFillingPeriod := Format(Date2dmy(recSalesInvoiceHeader."Posting Date", 2)) + Format(Date2dmy(recSalesInvoiceHeader."Posting Date", 3));
                        // txtOutputText := ClearCommas(recCompanyInfo.Name) + ',' + ClearCommas(recLocation.Code) + ',' +
                        //                         ClearCommas(recLocation.Name) + ',' + ClearCommas(recLocation."GST Registration No.") + ',' +
                        //                         'ADD' + ',' + recSalesInvoiceHeader."No." + ',' + 'Normal' + ',' + recSalesInvoiceHeader."No." +
                        //                         ',' + ConvertDate(recSalesInvoiceHeader."Posting Date") + ',' + 'Tax Invoice' + ',' + '' + ',' +
                        //                         '' + ',' + ClearCommas(recSalesInvoiceLines."HSN/SAC Code") + ',' + '' +
                        //                         ',' + ClearCommas(Format(recSalesInvoiceLines.Quantity)) + ',' + ClearCommas(recUnitOfMeasure.Code) + ',' +
                        //                         ClearCommas(Format(ROUND(recSalesInvoiceLines."Line Amount" * decCurrencyFactor, 0.01) +
                        //                         Abs(recSalesInvoiceLines."Total GST Amount"))) + ',' + '' + ',' + ClearCommas(Format(Abs(recSalesInvoiceLines."GST Base Amount"))) + ',' +
                        //                         ClearCommas(Format(decGSTPerc)) + ',' + txtOutputText + ',' + '' + ',' + recSalesInvoiceHeader."Customer GST Reg. No." + ',' +
                        //                         ClearCommas(recSalesInvoiceHeader."Sell-to Customer Name") + ',' + cdPOS + ',' + cdExportType + ',' +
                        //                         recSalesInvoiceHeader."Bill Of Export No." + ',' + ConvertDate(recSalesInvoiceHeader."Bill Of Export Date") +
                        //                         ',' + '' + ',' + txtReturnFillingPeriod + ',' + txtReturnFillingPeriod + ',' +
                        //                         ClearCommas(recLocation.Name) + ',' + ClearCommas(recSalesInvoiceHeader."Location Code") + ',' + '';
                        //SSD Comment End
                        OutputStream.WriteText(txtOutputText);
                        OutputStream.WriteText();
                    until recSalesInvoiceLines.Next = 0;
                recSalesInvoiceHeader."GSTR 1 Exported":=true;
                recSalesInvoiceHeader.Modify;
            until recSalesInvoiceHeader.Next = 0;
        end;
        recSalesCrMemoHeader.Reset;
        //recSalesCrMemoHeader.SETRANGE("GSTR 1 Exported", FALSE);
        recSalesCrMemoHeader.SetRange("Posting Date", recPurchSetup."GSTR 1 Start Date", Today + 3000);
        if recSalesCrMemoHeader.FindSet then begin
            if not blnFileCreated then begin
                Clear(OutputFile);
                Clear(OutputStream);
                blnFileCreated:=true;
                txtFileName:='GSTR1_ALL_' + recCompanyInfo."GST Registration No." + '_' + ConvertCurrentDateTime(Today) + '_' + recPurchSetup."GSTR 1 Client ID" + '.csv';
                //SSDOP OutputFile.Create(recPurchSetup."GSTR Local Folder" + txtFileName);
                //SSDOP OutputFile.CreateOutstream(OutputStream);
                txtOutputText:='Operating Unit,IO Code,IO Name,Supplier_GSTIN,Document_Status,TRX Number,Supply_Type,';
                txtOutputText:=txtOutputText + 'Invoice_Num,Invoice_Date,Invoice_Type,Note_Number,Note_Date,HSN/SAC,Item_Description,Quantity,';
                txtOutputText:=txtOutputText + 'UQC,Invoice_Value,Note_Value,Taxable_Value,GST_Rate,IGST_Amount,CGST_Amount,SGST_Amount,';
                txtOutputText:=txtOutputText + 'CESS_Amount,Revenue Account,Customer_GSTIN,Customer_Name,Place_of_Supply,Export_Type,Shipping_Bill_Number,';
                txtOutputText:=txtOutputText + 'Shipping_Bill_Date,Port_Number,GSTR1 Return Period,3B Auto-fill Period,Location Code,Locaction ID,Amortised_Cost';
                OutputStream.WriteText(txtOutputText);
                OutputStream.WriteText();
            end;
            repeat recLocation.Get(recSalesCrMemoHeader."Location Code");
                recCustomer.Get(recSalesCrMemoHeader."Bill-to Customer No.");
                if not recState.Get(recCustomer."State Code")then recState.Init();
                blnExportInvoice:=false;
                if recCustomer."Country/Region Code" <> 'IN' then blnExportInvoice:=true;
                if recSalesInvoiceHeader."Currency Factor" <> 0 then decCurrencyFactor:=1 / recSalesInvoiceHeader."Currency Factor"
                else
                    decCurrencyFactor:=1;
                recSalesCrMemoLines.Reset;
                recSalesCrMemoLines.SetRange("Document No.", recSalesCrMemoHeader."No.");
                recSalesCrMemoLines.SetFilter(Quantity, '<>%1', 0);
                recSalesCrMemoLines.SetRange("System-Created Entry", false);
                if recSalesCrMemoLines.FindSet then repeat if not recUnitOfMeasure.Get(recSalesCrMemoLines."Unit of Measure Code")then recUnitOfMeasure.Init;
                        decGSTPerc:=0;
                        recGSTSetup.Reset;
                        //recGSTSetup.SETRANGE("GST State Code", recLocation."State Code");
                        //SSD Comment Start
                        // recGSTSetup.SetRange("GST Group Code", recSalesCrMemoLines."GST Group Code");
                        // recGSTSetup.SetRange("GST Component Code", 'IGST');
                        // recGSTSetup.SetRange("Effective Date", 0D, recSalesCrMemoHeader."Posting Date");
                        // if recGSTSetup.FindLast then
                        //     decGSTPerc := recGSTSetup."GST Component %";
                        // cdExportType := '';
                        // if (blnExportInvoice = true) and (recSalesCrMemoLines."Total GST Amount" <> 0) then
                        //     cdExportType := 'WPAY';
                        // if (blnExportInvoice = true) and (recSalesCrMemoLines."Total GST Amount" = 0) then
                        //     cdExportType := 'WOPAY';
                        // if (recCustomer."GST Customer Type" in [recCustomer."gst customer type"::"SEZ Development", recCustomer."gst customer type"::"SEZ Unit"]) and (recSalesCrMemoLines."Total GST Amount" <> 0) then
                        //     cdExportType := 'WPAY';
                        // if (recCustomer."GST Customer Type" in [recCustomer."gst customer type"::"SEZ Development", recCustomer."gst customer type"::"SEZ Unit"]) and (recSalesCrMemoLines."Total GST Amount" <> 0) then
                        //     cdExportType := 'WOPAY';
                        // if cdExportType <> '' then
                        //     cdPOS := '96'
                        // else
                        //     cdPOS := recState."State Code (GST Reg. No.)";
                        // if recLocation."State Code" <> recCustomer."State Code" then begin
                        //     txtOutputText := DelChr(Format(recSalesCrMemoLines."Total GST Amount"), '=', ',') + ',' + '' + ',' + '' + ',' + '';
                        // end else begin
                        //     txtOutputText := DelChr(Format(ROUND(recSalesCrMemoLines."Total GST Amount" / 2, 0.01)), '=', ',');
                        //     txtOutputText := '' + ',' + txtOutputText + ',' + txtOutputText + ',' + '';
                        // end;
                        // txtReturnFillingPeriod := Format(Date2dmy(recSalesCrMemoHeader."Posting Date", 2)) + Format(Date2dmy(recSalesCrMemoHeader."Posting Date", 3));
                        // txtOutputText := ClearCommas(recCompanyInfo.Name) + ',' + ClearCommas(recLocation.Code) + ',' +
                        //                                 ClearCommas(recLocation.Name) + ',' + recLocation."GST Registration No." + ',' + 'ADD' + ',' +
                        //                                 recSalesCrMemoHeader."No." + ',' + 'Normal' + ',' + recSalesCrMemoHeader."No." + ',' +
                        //                                 ConvertDate(recSalesCrMemoHeader."Posting Date") + ',' + 'Credit Note' + ',' + recSalesCrMemoHeader."No." +
                        //                                 ',' + ConvertDate(recSalesCrMemoHeader."Posting Date") + ',' + ClearCommas(recSalesCrMemoLines."HSN/SAC Code") +
                        //                                 ',' + '' + ',' + DelChr(Format(recSalesCrMemoLines.Quantity), '=', ',') +
                        //                                 ',' + ClearCommas(recUnitOfMeasure.Code) + ',' + ClearCommas(Format(ROUND(recSalesCrMemoLines."Line Amount" * decCurrencyFactor, 0.01) +
                        //                                 Abs(recSalesCrMemoLines."Total GST Amount"))) + ',' + ClearCommas(Format(ROUND(recSalesCrMemoLines."Line Amount" * decCurrencyFactor, 0.01) +
                        //                                 Abs(recSalesCrMemoLines."Total GST Amount"))) + ',' + ClearCommas(Format(Abs(recSalesCrMemoLines."GST Base Amount"))) + ',' + ClearCommas(Format(decGSTPerc)) +
                        //                                 ',' + txtOutputText + ',' + '' + ',' + recSalesCrMemoHeader."Customer GST Reg. No." + ',' +
                        //                                 ClearCommas(recSalesCrMemoHeader."Sell-to Customer Name") + ',' + cdPOS + ',' + cdExportType + ',' +
                        //                                 recSalesCrMemoHeader."Bill Of Export No." + ',' + ConvertDate(recSalesCrMemoHeader."Bill Of Export Date") +
                        //                                 ',' + '' + ',' + txtReturnFillingPeriod + ',' + txtReturnFillingPeriod + ',' +
                        //                                 ClearCommas(recLocation.Name) + ',' + ClearCommas(recLocation.Code) + ',' + '';
                        //SSD Comment End
                        OutputStream.WriteText(txtOutputText);
                        OutputStream.WriteText();
                    until recSalesCrMemoLines.Next = 0;
                recSalesCrMemoHeader."GSTR 1 Exported":=true;
                recSalesCrMemoHeader.Modify;
            until recSalesCrMemoHeader.Next = 0;
        end;
        recTransferShipmentHeader.Reset();
        //recTransferShipmentHeader.SETRANGE("GSTR 1 Exported", FALSE);
        recTransferShipmentHeader.SetRange("Posting Date", recPurchSetup."GSTR 1 Start Date", Today + 3000);
        if recTransferShipmentHeader.FindSet then begin
            repeat recLocation.Get(recTransferShipmentHeader."Transfer-from Code");
                recLocation.TestField("State Code");
                recToLoction.Get(recTransferShipmentHeader."Transfer-to Code");
                recToLoction.TestField("State Code");
                if recLocation."State Code" <> recToLoction."State Code" then begin
                    if not blnFileCreated then begin
                        Clear(OutputFile);
                        Clear(OutputStream);
                        blnFileCreated:=true;
                        txtFileName:='GSTR1_ALL_' + recCompanyInfo."GST Registration No." + '_' + ConvertCurrentDateTime(Today) + '_' + recPurchSetup."GSTR 1 Client ID" + '.csv';
                        //SSDOP OutputFile.Create(recPurchSetup."GSTR Local Folder" + txtFileName);
                        //SSDOP OutputFile.CreateOutstream(OutputStream);
                        txtOutputText:='Operating Unit,IO Code,IO Name,Supplier_GSTIN,Document_Status,TRX Number,Supply_Type,';
                        txtOutputText:=txtOutputText + 'Invoice_Num,Invoice_Date,Invoice_Type,Note_Number,Note_Date,HSN/SAC,Item_Description,Quantity,';
                        txtOutputText:=txtOutputText + 'UQC,Invoice_Value,Note_Value,Taxable_Value,GST_Rate,IGST_Amount,CGST_Amount,SGST_Amount,';
                        txtOutputText:=txtOutputText + 'CESS_Amount,Revenue Account,Customer_GSTIN,Customer_Name,Place_of_Supply,Export_Type,Shipping_Bill_Number,';
                        txtOutputText:=txtOutputText + 'Shipping_Bill_Date,Port_Number,GSTR1 Return Period,3B Auto-fill Period,Location Code,Locaction ID,Amortised_Cost';
                        OutputStream.WriteText(txtOutputText);
                        OutputStream.WriteText();
                    end;
                    if not recState.Get(recToLoction."State Code")then recState.Init();
                    cdCustomerGSTNo:='';
                    recDetailedGSTLedger.Reset();
                    recDetailedGSTLedger.SetRange("Document No.", recTransferShipmentHeader."No.");
                    recDetailedGSTLedger.SetRange("Posting Date", recTransferShipmentHeader."Posting Date");
                    if recDetailedGSTLedger.FindFirst()then cdCustomerGSTNo:=recDetailedGSTLedger."Buyer/Seller Reg. No.";
                    recTransferShipmentLine.Reset;
                    recTransferShipmentLine.SetRange("Document No.", recTransferShipmentHeader."No.");
                    recTransferShipmentLine.SetFilter(Quantity, '<>%1', 0);
                    recTransferShipmentLine.SetFilter(Amount, '<>%1', 0);
                    if recTransferShipmentLine.FindSet then repeat if not recUnitOfMeasure.Get(recTransferShipmentLine."Unit of Measure Code")then recUnitOfMeasure.Init;
                            decGSTPerc:=0;
                            recGSTSetup.Reset;
                            //recGSTSetup.SETRANGE("GST State Code", recLocation."State Code");
                            //SSD Comment Start
                            // recGSTSetup.SetRange("GST Group Code", recTransferShipmentLine."GST Group Code");
                            // recGSTSetup.SetRange("GST Component Code", 'IGST');
                            // recGSTSetup.SetRange("Effective Date", 0D, recTransferShipmentHeader."Posting Date");
                            // if recGSTSetup.FindLast then
                            //     decGSTPerc := recGSTSetup."GST Component %";
                            // cdExportType := '';
                            // if (blnExportInvoice = true) and (recTransferShipmentLine."Total GST Amount" <> 0) then
                            //     cdExportType := 'EXPWP';
                            // if (blnExportInvoice = true) and (recTransferShipmentLine."Total GST Amount" = 0) then
                            //     cdExportType := 'EXPWOP';
                            // if cdExportType <> '' then
                            //     cdPOS := '96'
                            // else
                            //     cdPOS := recState."State Code (GST Reg. No.)";
                            // if recLocation."State Code" <> recToLoction."State Code" then begin
                            //     txtOutputText := DelChr(Format(recSalesCrMemoLines."Total GST Amount"), '=', ',') + ',' + '' + ',' + '' + ',' + '';
                            // end else begin
                            //     txtOutputText := DelChr(Format(ROUND(recSalesCrMemoLines."Total GST Amount" / 2, 0.01)), '=', ',');
                            //     txtOutputText := '' + ',' + txtOutputText + ',' + txtOutputText + ',' + '';
                            // end;
                            // txtReturnFillingPeriod := Format(Date2dmy(recTransferShipmentHeader."Posting Date", 2)) + Format(Date2dmy(recTransferShipmentHeader."Posting Date", 3));
                            // txtOutputText := ClearCommas(recCompanyInfo.Name) + ',' + ClearCommas(recLocation.Code) + ',' +
                            //                                 ClearCommas(recLocation.Name) + ',' + recLocation."GST Registration No." + ',' + 'ADD' + ',' +
                            //                                 recTransferShipmentHeader."No." + ',' + 'Normal' + ',' + recTransferShipmentHeader."No." + ',' +
                            //                                 ConvertDate(recTransferShipmentHeader."Posting Date") + ',' + 'Tax Invoice' + ',' + recTransferShipmentHeader."No." +
                            //                                 ',' + ConvertDate(recTransferShipmentHeader."Posting Date") + ',' + ClearCommas(recTransferShipmentLine."HSN/SAC Code") +
                            //                                 ',' + '' + ',' + DelChr(Format(recTransferShipmentLine.Quantity), '=', ',') +
                            //                                 ',' + ClearCommas(recUnitOfMeasure.Code) + ',' + ClearCommas(Format(recTransferShipmentLine.Amount +
                            //                                 Abs(recTransferShipmentLine."Total GST Amount"))) +
                            //                                 ',' + '' + ',' + ClearCommas(Format(Abs(recTransferShipmentLine."GST Base Amount"))) + ',' + ClearCommas(Format(decGSTPerc)) +
                            //                                 ',' + txtOutputText + ',' + '' + ',' + cdCustomerGSTNo + ',' +
                            //                                 ClearCommas(recTransferShipmentHeader."Transfer-to Name") + ',' + cdPOS + ',' + cdExportType + ',' +
                            //                                 recTransferShipmentHeader."Bill of Entry No." + ',' + ConvertDate(recTransferShipmentHeader."Bill of Entry Date") +
                            //                                 ',' + '' + ',' + txtReturnFillingPeriod + ',' + txtReturnFillingPeriod + ',' +
                            //                                 ClearCommas(recLocation.Name) + ',' + ClearCommas(recTransferShipmentHeader."Transfer-from Code") + ',' + '';
                            //SSD Comment End
                            OutputStream.WriteText(txtOutputText);
                            OutputStream.WriteText();
                        until recTransferShipmentLine.Next = 0;
                end;
                recTransferShipmentHeader."GSTR 1 Exported":=true;
                recTransferShipmentHeader.Modify;
            until recTransferShipmentHeader.Next = 0;
        end;
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
