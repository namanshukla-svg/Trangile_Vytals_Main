Report 50037 "New Purchase Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/New Purchase Register.rdl';
    ApplicationArea = ALL;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = sorting("No.")order(ascending);
            RequestFilterFields = "Posting Date";

            column(ReportForNavId_3733;3733)
            {
            }
            column(ResponsibilityCenter_State_______ResponsibilityCenter__Country_Region_Code_; ResponsibilityCenter.State + ' , ' + ResponsibilityCenter."Country/Region Code")
            {
            }
            column(ResponsibilityCenter__Address_2_; ResponsibilityCenter."Address 2")
            {
            }
            column(ResponsibilityCenter_City_______ResponsibilityCenter__Post_Code_; ResponsibilityCenter.City + ' - ' + ResponsibilityCenter."Post Code")
            {
            }
            column(ResponsibilityCenter_Address; ResponsibilityCenter.Address)
            {
            }
            column(ResponsibilityCenter_Name; ResponsibilityCenter.Name)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(UserId; UserId)
            {
            }
            column(startingdate; startingdate)
            {
            }
            column(endingdate; endingdate)
            {
            }
            column(rescen__Country_Region_Code_; rescen."Country/Region Code")
            {
            }
            column(rescen_City; rescen.City)
            {
            }
            column(rescen__Post_Code_; rescen."Post Code")
            {
            }
            column(rescen_State; rescen.State)
            {
            }
            column(rescen__Address_2_; rescen."Address 2")
            {
            }
            column(rescen_Address; rescen.Address)
            {
            }
            column(rescen_Name; rescen.Name)
            {
            }
            column(Purchase_Invoice_Line___Line_Amount_; "Purchase Invoice Line"."Line Amount")
            {
            }
            // column(Purchase_Invoice_Line___BED_Amount_;"Purchase Invoice Line"."BED Amount")
            // {
            // }
            // column(Purchase_Invoice_Line___eCess_Amount_;"Purchase Invoice Line"."eCess Amount")
            // {
            // }
            // column(Purchase_Invoice_Line___Tax_Amount_;"Purchase Invoice Line"."Tax Amount")
            // {
            // }
            // column(Purchase_Invoice_Line___Amount_To_Vendor_;"Purchase Invoice Line"."Amount To Vendor")
            // {
            // }
            // column(Purchase_Invoice_Line___Charges_To_Vendor_;"Purchase Invoice Line"."Charges To Vendor")
            // {
            // }
            // column(Purchase_Invoice_Line___SHE_Cess_Amount_;"Purchase Invoice Line"."SHE Cess Amount")
            // {
            // }
            // column(DataItem1000000011;"Purchase Invoice Line"."Line Amount"+"Purchase Invoice Line"."BED Amount"+"Purchase Invoice Line"."eCess Amount"+"Purchase Invoice Line"."SHE Cess Amount"+"Purchase Invoice Line"."ADC VAT Amount")
            // {
            // }
            // column(Purchase_Invoice_Line___ADC_VAT_Amount_;"Purchase Invoice Line"."ADC VAT Amount")
            // {
            // }
            column(PURCHASE_REGISTERCaption; PURCHASE_REGISTERCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(From___Caption; From___CaptionLbl)
            {
            }
            column(To___Caption; To___CaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(BED_AmountCaption; BED_AmountCaptionLbl)
            {
            }
            column(E_cess_AmountCaption; E_cess_AmountCaptionLbl)
            {
            }
            column(Total_AmountCaption; Total_AmountCaptionLbl)
            {
            }
            column(Tax_AmountCaption; Tax_AmountCaptionLbl)
            {
            }
            column(Others_AmountCaption; Others_AmountCaptionLbl)
            {
            }
            column(SH_cess_Amt_Caption; SH_cess_Amt_CaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(Vend_CodeCaption; Vend_CodeCaptionLbl)
            {
            }
            column(Inv__DateCaption; Inv__DateCaptionLbl)
            {
            }
            column(Party_Bill_No_Caption; Party_Bill_No_CaptionLbl)
            {
            }
            column(Invoice_No_Caption; Invoice_No_CaptionLbl)
            {
            }
            column(Grn_No_Caption; Grn_No_CaptionLbl)
            {
            }
            column(RecQtyCaption; RecQtyCaptionLbl)
            {
            }
            column(Gl_DescCaption; Gl_DescCaptionLbl)
            {
            }
            column(AEDCaption; AEDCaptionLbl)
            {
            }
            column(Taxable_Amt_Caption; Taxable_Amt_CaptionLbl)
            {
            }
            column(Tax_TypeCaption; Tax_TypeCaptionLbl)
            {
            }
            column(Tax_RateCaption; Tax_RateCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Purch__Inv__Header_No_; "No.")
            {
            }
            column(Summary; Summary)
            {
            }
            dataitem("Purchase Invoice Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.")order(ascending)where(Quantity=filter(<>0));
                RequestFilterFields = "Item Category Code";

                column(ReportForNavId_8699;8699)
                {
                }
                column(Purchase_Invoice_Line__Line_Amount_; "Line Amount")
                {
                }
                // column(Purchase_Invoice_Line__BED_Amount_;"BED Amount")
                // {
                // }
                column(Purchase_Invoice_Line__eCess_Amount_; eCessAmount)
                {
                }
                // column(Purchase_Invoice_Line__Amount_To_Vendor_;"Amount To Vendor")
                // {
                // }
                // column(Purchase_Invoice_Line__Tax_Amount_;"Tax Amount")
                // {
                // }
                // column(Purchase_Invoice_Line__Charges_To_Vendor_;"Charges To Vendor")
                // {
                // }
                column(Purchase_Invoice_Line__SHE_Cess_Amount_; SHECessAmount)
                {
                }
                column(Purchase_Invoice_Line__Document_No__; "Document No.")
                {
                }
                column(Purch__Inv__Header___Vendor_Invoice_No__; "Purch. Inv. Header"."Vendor Invoice No.")
                {
                }
                column(Purch__Inv__Header___Document_Date_; "Purch. Inv. Header"."Document Date")
                {
                }
                column(Purchase_Invoice_Line__Buy_from_Vendor_No__; "Buy-from Vendor No.")
                {
                }
                column(Vendor_Name; Vendor.Name)
                {
                }
                column(Receiptno; Receiptno)
                {
                }
                column(recqty; recqty)
                {
                }
                column(GLacc_Name; GLacc.Name)
                {
                }
                // column(Purchase_Invoice_Line__Purchase_Invoice_Line___ADC_VAT_Amount_;"Purchase Invoice Line"."ADC VAT Amount")
                // {
                // }
                // column(DataItem1000000058;"Line Amount"+"BED Amount"+"eCess Amount"+"Purchase Invoice Line"."SHE Cess Amount"+"Purchase Invoice Line"."AED(GSI) Amount")
                // {
                // }
                column(Purchase_Invoice_Line__Purchase_Invoice_Line___Tax_Area_Code_; "Purchase Invoice Line"."Tax Area Code")
                {
                }
                // column(Purchase_Invoice_Line__Purchase_Invoice_Line___Tax___;"Purchase Invoice Line"."Tax %")
                // {
                // }
                column(Purchase_Invoice_Line__Line_Amount__Control1000000038; "Line Amount")
                {
                }
                // column(Purchase_Invoice_Line__BED_Amount__Control1000000039;"BED Amount")
                // {
                // }
                // column(Purchase_Invoice_Line__eCess_Amount__Control1000000041;"eCess Amount")
                // {
                // }
                // column(Purchase_Invoice_Line__Tax_Amount__Control1000000044;"Tax Amount")
                // {
                // }
                // column(Amount_To_Vendor___Purchase_Invoice_Line___Charges_To_Vendor_;"Amount To Vendor"+"Purchase Invoice Line"."Charges To Vendor")
                // {
                // }
                // column(Purchase_Invoice_Line__Purchase_Invoice_Line___Charges_To_Vendor_;"Purchase Invoice Line"."Charges To Vendor")
                // {
                // }
                // column(Purchase_Invoice_Line__Purchase_Invoice_Line___SHE_Cess_Amount_;"Purchase Invoice Line"."SHE Cess Amount")
                // {
                // }
                column(TaxRate; TaxRate)
                {
                }
                column(Purchase_Invoice_Line__Purchase_Invoice_Line___Tax_Area_Code__Control1000000010; "Purchase Invoice Line"."Tax Area Code")
                {
                }
                // column(DataItem1000000012;"Line Amount"+"BED Amount"+"eCess Amount"+"Purchase Invoice Line"."SHE Cess Amount"+"Purchase Invoice Line"."AED(GSI) Amount")
                // {
                // }
                // column(Purchase_Invoice_Line__Purchase_Invoice_Line___ADC_VAT_Amount__Control1000000051;"Purchase Invoice Line"."ADC VAT Amount")
                // {
                // }
                column(Vendor_Name_Control1000000009; Vendor.Name)
                {
                }
                column(Purchase_Invoice_Line__Buy_from_Vendor_No___Control1000000071; "Buy-from Vendor No.")
                {
                }
                column(Purch__Inv__Header___Document_Date__Control1000000072; "Purch. Inv. Header"."Document Date")
                {
                }
                column(Purch__Inv__Header___Vendor_Invoice_No___Control1000000073; "Purch. Inv. Header"."Vendor Invoice No.")
                {
                }
                column(Purchase_Invoice_Line__Document_No___Control1000000075; "Document No.")
                {
                }
                column(Purchase_Invoice_Line_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    eCessAmount:=0;
                    SHECessAmount:=0;
                    TDSEntry.Reset();
                    TDSEntry.SetRange("Document No.", "Document No.");
                    TDSEntry.SetRange("Posting Date", "Posting Date");
                    if TDSEntry.FindSet()then repeat begin
                            eCessAmount:=TDSEntry."eCess Amount";
                            SHECessAmount:=TDSEntry."SHE Cess Amount";
                        end;
                        until TDSEntry.Next() = 0;
                    // if "Tax %"<> 0 then
                    //   TaxRate:=ROUND("Tax %",1,'>');
                    Glentry.SetRange(Glentry."Document No.", "Purchase Invoice Line"."Document No.");
                    Glentry.SetRange(Glentry."Gen. Bus. Posting Group", "Purchase Invoice Line"."Gen. Bus. Posting Group");
                    Glentry.SetRange(Glentry."Gen. Prod. Posting Group", "Purchase Invoice Line"."Gen. Prod. Posting Group");
                    if Glentry.Find('-')then if GLacc.Get(Glentry."G/L Account No.")then;
                    PostWhRecLine.SetCurrentkey(PostWhRecLine."Posted Source No.", "Posting Date");
                    recqty:=0;
                    Receiptno:='';
                    qtyoninv:=0;
                    Shortqty:=0;
                    // PurRcptLine.SetRange(PurRcptLine."Document No.","Purchase Invoice Line"."Receipt Document No.");
                    // PurRcptLine.SetRange(PurRcptLine."Line No.","Purchase Invoice Line"."Receipt Document Line No.");
                    // if PurRcptLine.Find('+') then
                    // begin
                    //  Receiptno:=PurRcptLine."Document No.";
                    //  //recqty:=PurRcptLine.Quantity;
                    //  PostWhRecLine.SetRange(PostWhRecLine."Posted Source No.",Receiptno);
                    //  PostWhRecLine.SetRange(PostWhRecLine."Posting Date",PurRcptLine."Posting Date");
                    //  PostWhRecLine.SetRange(PostWhRecLine."Posted Source Line No.",PurRcptLine."Line No.");
                    //  if PostWhRecLine.Find('+') then
                    //  begin
                    //   recqty:=PostWhRecLine."Accepted Qty.";
                    //   qtyoninv:= PostWhRecLine."Qty. On Invoice";
                    //   Shortqty:=PostWhRecLine."Shortage Qty.";
                    //  end;
                    // end;
                    // //   CurrReport.SHOWOUTPUT:=Summary;
                    if "Export To Excel" and Summary then begin
                        RowNo+=1;
                        EnterCell(RowNo, 1, Format("Document No."), false, false, 1);
                        EnterCell(RowNo, 2, Format("Purch. Inv. Header"."Vendor Invoice No."), false, false, 1);
                        EnterCell(RowNo, 3, Format("Purch. Inv. Header"."Document Date"), false, false, 2);
                        EnterCell(RowNo, 4, Format("Buy-from Vendor No."), false, false, 1);
                        EnterCell(RowNo, 5, Format(Vendor.Name), false, false, 1);
                        EnterCell(RowNo, 6, Format("No."), false, false, 1);
                        EnterCell(RowNo, 7, Format(Description), false, false, 1);
                        EnterCell(RowNo, 8, Format("Unit of Measure"), false, false, 1);
                        EnterCell(RowNo, 9, Format(Quantity), false, false, 0);
                        EnterCell(RowNo, 10, Format("Unit Cost (LCY)"), false, false, 0);
                        EnterCell(RowNo, 11, Format("Line Amount"), false, false, 0);
                        // EnterCell(RowNo,12,Format("BED Amount"),false,false,0);
                        // EnterCell(RowNo,13,Format("eCess Amount"),false,false,0);
                        // EnterCell(RowNo,14,Format("SHE Cess Amount"),false,false,0);
                        // EnterCell(RowNo,15,Format("Tax Amount"),false,false,0);
                        // EnterCell(RowNo,16,Format("Charges To Vendor"),false,false,0);
                        // EnterCell(RowNo,17,Format("Amount To Vendor"),false,false,0);
                        EnterCell(RowNo, 18, Format(Receiptno), false, false, 1);
                        EnterCell(RowNo, 19, Format(recqty), false, false, 0);
                        EnterCell(RowNo, 20, Format("Purchase Invoice Line"."Posting Date"), false, false, 2);
                        EnterCell(RowNo, 21, Format(qtyoninv), false, false, 0);
                        EnterCell(RowNo, 22, Format(Shortqty), false, false, 0);
                        EnterCell(RowNo, 23, GLacc.Name, false, false, 1);
                        EnterCell(RowNo, 24, Format("Purch. Inv. Header"."Vendor Invoice Date"), false, false, 2);
                    end;
                end;
                trigger OnPreDataItem()
                begin
                    LastFieldNo:=FieldNo("Document No.");
                    Resp.SetFilter(Resp."Location Code", "Purchase Invoice Line"."Location Code");
                    if Resp.Find('-')then;
                    if not showGL then SetFilter(Type, '<>%1', Type::"G/L Account");
                    Glentry.SetCurrentkey("Document No.", "Posting Date"); //,"Entry No.");
                end;
            }
            trigger OnAfterGetRecord()
            begin
                TaxRate:=0;
                Vendor.Get("Purch. Inv. Header"."Buy-from Vendor No.");
            end;
            trigger OnPreDataItem()
            begin
                // CurrReport.CreateTotals("Purchase Invoice Line"."Line Amount","Purchase Invoice Line"."BED Amount",
                //      "Purchase Invoice Line"."eCess Amount","Purchase Invoice Line"."SHE Cess Amount","Purchase Invoice Line"."AED(GSI) Amount",
                //      "Purchase Invoice Line"."Tax Amount","Purchase Invoice Line"."Charges To Vendor","Purchase Invoice Line"."Amount To Vendor",
                //      "Purchase Invoice Line"."ADC VAT Amount");
                if "Purch. Inv. Header".GetFilter("Purch. Inv. Header"."Posting Date") <> '' then begin
                    startingdate:=GetRangeMin("Purch. Inv. Header"."Posting Date");
                    endingdate:=GetRangemax("Purch. Inv. Header"."Posting Date");
                end
                else
                    Error(Text001);
                FirstTime:=false;
                if "Export To Excel" then begin
                    RowNo+=1;
                    EnterCell(RowNo, 1, Format(rescen.Name), false, false, 1);
                    RowNo+=1;
                    EnterCell(RowNo, 1, Format(rescen.Address), false, false, 1);
                    RowNo+=1;
                    EnterCell(RowNo, 1, Format(rescen."Address 2"), false, false, 1);
                    RowNo+=1;
                    EnterCell(RowNo, 1, Format(rescen.City), false, false, 1);
                    EnterCell(RowNo, 2, Format(rescen."Post Code"), false, false, 1);
                    EnterCell(RowNo, 18, Format(Today, 0, 4), false, false, 1);
                    RowNo+=1;
                    EnterCell(RowNo, 1, Format(rescen.State), false, false, 1);
                    EnterCell(RowNo, 2, Format(rescen."Country/Region Code"), false, false, 1);
                    EnterCell(RowNo, 18, Format(UserId), false, false, 1);
                    RowNo+=1;
                    EnterCell(RowNo, 5, 'PURCHASE REGISTER', true, false, 1);
                    RowNo+=1;
                    EnterCell(RowNo, 1, 'From', true, false, 1);
                    EnterCell(RowNo, 2, Format(startingdate), true, false, 1);
                    EnterCell(RowNo, 3, 'TO', true, false, 1);
                    EnterCell(RowNo, 4, Format(endingdate), true, false, 1);
                end;
                if "Export To Excel" then begin
                    RowNo+=1;
                    EnterCell(RowNo, 1, Format('Invoice No.'), true, false, 1);
                    EnterCell(RowNo, 2, Format('Party Bill No.'), true, false, 1);
                    EnterCell(RowNo, 3, Format('Inv. Date'), true, false, 1);
                    EnterCell(RowNo, 4, Format('Vendor Code'), true, false, 1);
                    EnterCell(RowNo, 5, Format('Vendor Name'), true, false, 1);
                    EnterCell(RowNo, 6, Format('Item Code'), true, false, 1);
                    EnterCell(RowNo, 7, Format('Description'), true, false, 1);
                    EnterCell(RowNo, 8, Format('UOM'), true, false, 1);
                    EnterCell(RowNo, 9, Format('Quantity'), true, false, 0);
                    EnterCell(RowNo, 10, Format('Unit Cost'), true, false, 0);
                    EnterCell(RowNo, 11, Format('Amount'), true, false, 0);
                    EnterCell(RowNo, 12, Format('BED Amount'), true, false, 0);
                    EnterCell(RowNo, 13, Format('eCess Amount'), true, false, 0);
                    EnterCell(RowNo, 14, Format('SHE Cess Amount'), true, false, 0);
                    EnterCell(RowNo, 15, Format('Tax Amount'), true, false, 0);
                    EnterCell(RowNo, 16, Format('Other Amount'), true, false, 0);
                    EnterCell(RowNo, 17, Format('Total Amount'), true, false, 0);
                    EnterCell(RowNo, 18, Format('Receipt No.'), true, false, 1);
                    EnterCell(RowNo, 19, Format('Qty Received'), true, false, 0);
                    EnterCell(RowNo, 20, 'Posting Date', true, false, 1);
                    EnterCell(RowNo, 21, Format('Qty On Invoice'), true, false, 0);
                    EnterCell(RowNo, 22, Format('Short qty'), true, false, 0);
                    EnterCell(RowNo, 23, Format('Gl Desc'), true, false, 1);
                    EnterCell(RowNo, 24, Format('Party Invoice Date'), true, false, 1);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(Summary; Summary)
                {
                    ApplicationArea = Basic;
                }
                field(showGL; showGL)
                {
                    ApplicationArea = Basic;
                    Caption = 'Show GL';
                }
                field("Export To Excel"; "Export To Excel")
                {
                    ApplicationArea = Basic;
                    Caption = 'Export To Excel';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        showGL:=true;
    end;
    trigger OnPostReport()
    begin
        // BIS 1145
        if "Export To Excel" then begin
        //   ExcelBuf.CreateBookAndOpenExcel('Sheet 1','','Report',COMPANYNAME,UserId);
        //TempExcelBuffer1.CreateBook('Purchase Register1');
        //TempExcelBuffer1.WriteSheet('Purchase Register', COMPANYNAME, USERID);
        //TempExcelBuffer1.GiveUserControl;
        end;
    // BIS 1145
    end;
    trigger OnPreReport()
    begin
    // if ResponsibilityCenter.Get(UserSetupMgt.GetRespCenterFilter) then;
    //MinDate := "Sales Invoice Header".GETRANGEMIN("Posting Date");
    //MaxDate := "Sales Invoice Header".GETRANGEMAX("Posting Date");
    // rescen.Get(UserMgt.GetRespCenterFilter);
    //TempExcelBuffer1.DELETEALL;
    //CLEAR(TempExcelBuffer1);
    end;
    var TDSEntry: Record "TDS Entry";
    eCessAmount: Decimal;
    SHECessAmount: Decimal;
    rescen: Record "Responsibility Center";
    UserMgt: Codeunit "User Setup Management";
    LastFieldNo: Integer;
    FooterPrinted: Boolean;
    TotalFor: label 'Total for ';
    Tax: Integer;
    Vendor: Record Vendor;
    tax_amt: Decimal;
    PurchaseInvoiceHeader: Record "Purch. Inv. Header";
    Resp: Record "Responsibility Center";
    startingdate: Date;
    endingdate: Date;
    TempExcelBuffer1: Record "Excel Buffer" temporary;
    "Export To Excel": Boolean;
    RowNo: Integer;
    Text001: label 'Please Enter the Posting Date';
    FirstTime: Boolean;
    PurRcptLine: Record "Purch. Rcpt. Line";
    recqty: Decimal;
    Receiptno: Code[20];
    ValueEntry: Record "Value Entry";
    ILEno: Integer;
    ILE: Record "Item Ledger Entry";
    PostWhRecLine: Record "Posted Whse. Receipt Line";
    qtyoninv: Decimal;
    Shortqty: Decimal;
    showGL: Boolean;
    Glentry: Record "G/L Entry";
    GLacc: Record "G/L Account";
    purchline: Record "Purchase Line";
    unitcost: Decimal;
    purchheader: Record "Purchase Header";
    Summary: Boolean;
    TaxRate: Decimal;
    PURCHASE_REGISTERCaptionLbl: label 'PURCHASE REGISTER';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    From___CaptionLbl: label 'From  :';
    To___CaptionLbl: label '  To:  ';
    AmountCaptionLbl: label 'Amount';
    BED_AmountCaptionLbl: label 'BED Amount';
    E_cess_AmountCaptionLbl: label 'E-cess Amount';
    Total_AmountCaptionLbl: label 'Total Amount';
    Tax_AmountCaptionLbl: label 'Tax Amount';
    Others_AmountCaptionLbl: label 'Others Amount';
    SH_cess_Amt_CaptionLbl: label 'SH-cess Amt.';
    Vendor_NameCaptionLbl: label 'Vendor Name';
    Vend_CodeCaptionLbl: label 'Vend Code';
    Inv__DateCaptionLbl: label 'Inv. Date';
    Party_Bill_No_CaptionLbl: label 'Party Bill No.';
    Invoice_No_CaptionLbl: label 'Invoice No.';
    Grn_No_CaptionLbl: label 'Grn No.';
    RecQtyCaptionLbl: label 'RecQty';
    Gl_DescCaptionLbl: label 'Gl Desc';
    AEDCaptionLbl: label 'AED';
    Taxable_Amt_CaptionLbl: label 'Taxable Amt.';
    Tax_TypeCaptionLbl: label 'Tax Type';
    Tax_RateCaptionLbl: label 'Tax Rate';
    TotalCaptionLbl: label 'Total';
    ResponsibilityCenter: Record "Responsibility Center";
    UserSetupMgt: Codeunit "User Setup Management";
    ExcelBuf: Record "Excel Buffer" temporary;
    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; CellType: Option Number, Text, Date, Time)
    begin
        ExcelBuf.Init;
        ExcelBuf.Validate("Row No.", RowNo);
        ExcelBuf.Validate("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text":=CellValue;
        ExcelBuf.Formula:='';
        ExcelBuf.Bold:=Bold;
        ExcelBuf.Underline:=UnderLine;
        ExcelBuf."Cell Type":=CellType;
        ExcelBuf.Insert;
    end;
    procedure CreateExcelbook()
    begin
    // ExcelBuf.CreateBookAndOpenExcel('Data','','New Purchase Register',COMPANYNAME,UserId);
    //ERROR('');
    end;
}
