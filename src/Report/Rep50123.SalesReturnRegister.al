Report 50123 "Sales Return Register"
{
    // CML-011 DKU 191207
    //   - Export to Excel and Use "Purch. Inv. Header" table for processing fast by report
    // AlleZav1.01/050815 -- Ravik -- Field added in report Item Code,Description,Item Category and Sales Person Code.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sales Return Register.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = sorting("No.")order(ascending);
            RequestFilterFields = "Posting Date", "No.";

            column(ReportForNavId_8098;8098)
            {
            }
            column(CustomerName; Customer.Name)
            {
            }
            column(Summary; Summary)
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
            column(Purchase_Invoice_Line___eCess_Amount_; eCessAmount)
            {
            }
            // column(Purchase_Invoice_Line___Tax_Amount_;"Purchase Invoice Line"."Tax Amount")
            // {
            // }
            // column(Purchase_Invoice_Line___Amount_To_Customer___Purchase_Invoice_Line___Charges_To_Customer_;"Purchase Invoice Line"."Amount To Customer"+"Purchase Invoice Line"."Charges To Customer")
            // {
            // }
            // column(Purchase_Invoice_Line___Charges_To_Customer_;"Purchase Invoice Line"."Charges To Customer")
            // {
            // }
            column(Purchase_Invoice_Line___SHE_Cess_Amount_; SHECessAmount)
            {
            }
            // column(DataItem1000000026;"Purchase Invoice Line"."Line Amount"+"Purchase Invoice Line"."BED Amount"+"Purchase Invoice Line"."eCess Amount"+"Purchase Invoice Line"."SHE Cess Amount"+"Purchase Invoice Line"."AED(GSI) Amount")
            // {
            // }
            // column(Purchase_Invoice_Line___AED_GSI__Amount_;"Purchase Invoice Line"."AED(GSI) Amount")
            // {
            // }
            column(SALES_RETURN_REGISTERCaption; SALES_RETURN_REGISTERCaptionLbl)
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
            column(SHE_cess_AmountCaption; SHE_cess_AmountCaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Customer_CodeCaption; Customer_CodeCaptionLbl)
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
            column(Sales_Cr_Memo_Header_No_; "No.")
            {
            }
            column(SalespersonCode_SalesCrMemoHeader; "Sales Cr.Memo Header"."Salesperson Code")
            {
            }
            column(Item_Code; "Purchase Invoice Line"."No.")
            {
            }
            column(Item_Category_Code; "Purchase Invoice Line"."Item Category Code")
            {
            }
            column(Desc2; "Purchase Invoice Line"."Description 2")
            {
            }
            column(Sales_Person; "Sales Cr.Memo Header"."Salesperson Code")
            {
            }
            dataitem("Purchase Invoice Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.")order(ascending)where(Quantity=filter(<>0));
                RequestFilterFields = Type, "No.";

                column(ReportForNavId_8699;8699)
                {
                }
                column(Quantity_PurchaseInvoiceLine; Quantity)
                {
                }
                column(UnitPrice_PurchaseInvoiceLine; "Unit Price")
                {
                }
                column(UnitCostLCY_PurchaseInvoiceLine; "Unit Cost (LCY)")
                {
                }
                column(Customer_Name_1; Customer_Name_1)
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
                // column(Purchase_Invoice_Line__Amount_To_Customer_;"Amount To Customer")
                // {
                // }
                // column(Purchase_Invoice_Line__Tax_Amount_;"Tax Amount")
                // {
                // }
                // column(Purchase_Invoice_Line__Charges_To_Customer_;"Charges To Customer")
                // {
                // }
                column(Purchase_Invoice_Line__SHE_Cess_Amount_; SHECessAmount)
                {
                }
                column(Purchase_Invoice_Line__Document_No__; "Document No.")
                {
                }
                column(Sales_Cr_Memo_Header___External_Document_No__; "Sales Cr.Memo Header"."External Document No.")
                {
                }
                column(Sales_Cr_Memo_Header___Posting_Date_; "Sales Cr.Memo Header"."Posting Date")
                {
                }
                column(Purchase_Invoice_Line__Sell_to_Customer_No__; "Sell-to Customer No.")
                {
                }
                column(Vendor_Name; Vendor.Name)
                {
                }
                // column(Purchase_Invoice_Line__Purchase_Invoice_Line___AED_GSI__Amount_;"Purchase Invoice Line"."AED(GSI) Amount")
                // {
                // }
                // column(DataItem1000000017;"Line Amount"+"BED Amount"+"eCess Amount"+"Purchase Invoice Line"."SHE Cess Amount"+"Purchase Invoice Line"."AED(GSI) Amount")
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
                column(Purchase_Invoice_Line__eCess_Amount__Control1000000041; eCessAmount)
                {
                }
                // column(Purchase_Invoice_Line__Tax_Amount__Control1000000044;"Tax Amount")
                // {
                // }
                // column(Amount_To_Customer___Purchase_Invoice_Line___Charges_To_Customer_;"Amount To Customer"+"Purchase Invoice Line"."Charges To Customer")
                // {
                // }
                // column(Purchase_Invoice_Line__Purchase_Invoice_Line___Charges_To_Customer_;"Purchase Invoice Line"."Charges To Customer")
                // {
                // }
                column(Purchase_Invoice_Line__Purchase_Invoice_Line___SHE_Cess_Amount_; SHECessAmount)
                {
                }
                column(TaxRate; TaxRate)
                {
                }
                column(Purchase_Invoice_Line__Purchase_Invoice_Line___Tax_Area_Code__Control1000000012; "Purchase Invoice Line"."Tax Area Code")
                {
                }
                // column(DataItem1000000042;"Line Amount"+"BED Amount"+"eCess Amount"+"Purchase Invoice Line"."SHE Cess Amount"+"Purchase Invoice Line"."AED(GSI) Amount")
                // {
                // }
                // column(Purchase_Invoice_Line__Purchase_Invoice_Line___AED_GSI__Amount__Control1000000055;"Purchase Invoice Line"."AED(GSI) Amount")
                // {
                // }
                column(Vendor_Name_Control1000000009; Vendor.Name)
                {
                }
                column(Purchase_Invoice_Line__Sell_to_Customer_No___Control1000000071; "Sell-to Customer No.")
                {
                }
                column(Sales_Cr_Memo_Header___Posting_Date__Control1000000072; "Sales Cr.Memo Header"."Posting Date")
                {
                }
                column(Sales_Cr_Memo_Header___External_Document_No___Control1000000073; "Sales Cr.Memo Header"."External Document No.")
                {
                }
                column(Purchase_Invoice_Line__Document_No___Control1000000075; "Document No.")
                {
                }
                column(Purchase_Invoice_Line_Line_No_; "Line No.")
                {
                }
                column(GenBusPostingGroup_PurchaseInvoiceLine; "Purchase Invoice Line"."Gen. Bus. Posting Group")
                {
                }
                column(GenProdPostingGroup_PurchaseInvoiceLine; "Purchase Invoice Line"."Gen. Prod. Posting Group")
                {
                }
                column(ItemCategoryCode_PurchaseInvoiceLine; "Purchase Invoice Line"."Item Category Code")
                {
                }
                column(No_PurchaseInvoiceLine; "Purchase Invoice Line"."No.")
                {
                }
                column(Description2_PurchaseInvoiceLine; "Purchase Invoice Line"."Description 2")
                {
                }
                trigger OnAfterGetRecord()
                begin
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
                    Customer.Reset;
                    Customer.SetRange(Customer."No.", "Purchase Invoice Line"."Sell-to Customer No.");
                    if Customer.FindFirst then Customer_Name_1:=Customer.Name;
                end;
                trigger OnPreDataItem()
                begin
                    LastFieldNo:=FieldNo("Document No.");
                    Resp.SetFilter(Resp."Location Code", "Purchase Invoice Line"."Location Code");
                    if Resp.Find('-')then;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                TaxRate:=0;
                if Customer.Get("Sell-to Customer No.")then;
            end;
            trigger OnPreDataItem()
            begin
                //CML-011 DKU 191207 Start
                // CurrReport.CreateTotals("Purchase Invoice Line"."Line Amount","Purchase Invoice Line"."BED Amount",
                //         "Purchase Invoice Line"."eCess Amount","Purchase Invoice Line"."SHE Cess Amount",
                //      "Purchase Invoice Line"."Tax Amount","Purchase Invoice Line"."Amount To Customer","Purchase Invoice Line"."AED(GSI) Amount");
                if "Sales Cr.Memo Header".GetFilter("Sales Cr.Memo Header"."Posting Date") <> '' then begin
                    startingdate:=GetRangeMin("Sales Cr.Memo Header"."Posting Date");
                    endingdate:=GetRangemax("Sales Cr.Memo Header"."Posting Date");
                end
                else
                    Error(Text001);
                FirstTime:=false;
            //CML-011 DKU 191207 Finish
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(Summry; Summary)
                {
                    ApplicationArea = Basic;
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
    trigger OnPostReport()
    begin
    //PUR/PR/001 DKU 191207 Start
    /* // BIS 1145
        IF "Export To Excel" THEN BEGIN
          TempExcelBuffer1.CreateBook;
          TempExcelBuffer1.CreateSheet('Purchase Register', '', COMPANYNAME, USERID);
          TempExcelBuffer1.GiveUserControl;
        END;
        */
    // BIS 1145
    //PUR/PR/001 DKU 191207 Finish
    end;
    trigger OnPreReport()
    begin
        // rescen.Get(UserMgt.GetRespCenterFilter);
        //PUR/PR/001 DKU 191207 Start
        TempExcelBuffer1.DeleteAll;
        Clear(TempExcelBuffer1);
    //"Export To Excel":=TRUE;
    //IF "Purchase Invoice Line".GETFILTER("Purchase Invoice Line"."Posting Date") = '' THEN
    // ERROR(Text001);
    //PUR/PR/001 DKU 191207 Finish
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
    Vendor: Record Customer;
    tax_amt: Decimal;
    PurchaseInvoiceHeader: Record "Purch. Cr. Memo Hdr.";
    Resp: Record "Responsibility Center";
    startingdate: Date;
    endingdate: Date;
    TempExcelBuffer1: Record "Excel Buffer" temporary;
    "Export To Excel": Boolean;
    RowNo: Integer;
    Text001: label 'Please Enter the Posting Date';
    FirstTime: Boolean;
    Summary: Boolean;
    TaxRate: Decimal;
    SALES_RETURN_REGISTERCaptionLbl: label 'SALES RETURN REGISTER';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    From___CaptionLbl: label 'From  :';
    To___CaptionLbl: label '  To:  ';
    AmountCaptionLbl: label 'Amount';
    BED_AmountCaptionLbl: label 'BED Amount';
    E_cess_AmountCaptionLbl: label 'E-cess Amount';
    Total_AmountCaptionLbl: label 'Total Amount';
    Tax_AmountCaptionLbl: label 'Tax Amount';
    Others_AmountCaptionLbl: label 'Others Amount';
    SHE_cess_AmountCaptionLbl: label 'SHE-cess Amount';
    Customer_NameCaptionLbl: label 'Customer Name';
    Customer_CodeCaptionLbl: label 'Customer Code';
    Inv__DateCaptionLbl: label 'Inv. Date';
    Party_Bill_No_CaptionLbl: label 'Party Bill No.';
    Invoice_No_CaptionLbl: label 'Invoice No.';
    AEDCaptionLbl: label 'AED';
    Taxable_Amt_CaptionLbl: label 'Taxable Amt.';
    Tax_TypeCaptionLbl: label 'Tax Type';
    Tax_RateCaptionLbl: label 'Tax Rate';
    TotalCaptionLbl: label 'Total';
    Customer: Record Customer;
    Customer_Name_1: Text;
    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean)
    begin
        //CML-011 DKU 191207  Start
        TempExcelBuffer1.Init;
        TempExcelBuffer1.Validate("Row No.", RowNo);
        TempExcelBuffer1.Validate("Column No.", ColumnNo);
        TempExcelBuffer1."Cell Value as Text":=CellValue;
        TempExcelBuffer1.Formula:='';
        TempExcelBuffer1.Bold:=Bold;
        TempExcelBuffer1.Underline:=UnderLine;
        TempExcelBuffer1.Insert;
    //CML-011 DKU 191207  Finish
    end;
}
