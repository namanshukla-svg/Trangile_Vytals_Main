Report 50038 "Purchase Return Register"
{
    // CML-011 DKU 191207
    //   - Export to Excel and Use "Purch. Inv. Header" table for processing fast by report
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Purchase Return Register.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = sorting("No.")order(ascending);
            RequestFilterFields = "Posting Date";

            column(ReportForNavId_9869;9869)
            {
            }
            column(Summary; Summary)
            {
            }
            column(VendorName; Vendor.Name)
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
            // column(Purchase_Invoice_Line___Amount_To_Vendor___Purchase_Invoice_Line___Charges_To_Vendor_; "Purchase Invoice Line"."Amount To Vendor" + "Purchase Invoice Line"."Charges To Vendor")
            // {
            // }
            // column(Purchase_Invoice_Line___Charges_To_Vendor_;"Purchase Invoice Line"."Charges To Vendor")
            // {
            // }
            // column(Purchase_Invoice_Line___SHE_Cess_Amount_;"Purchase Invoice Line"."SHE Cess Amount")
            // {
            // }
            // column(Purchase_Invoice_Line___ADC_VAT_Amount_;"Purchase Invoice Line"."ADC VAT Amount")
            // {
            // }
            // column(DataItem1000000055; "Purchase Invoice Line"."Line Amount" + "Purchase Invoice Line"."BED Amount" + "Purchase Invoice Line"."eCess Amount" + "Purchase Invoice Line"."SHE Cess Amount" + "Purchase Invoice Line"."ADC VAT Amount")
            // {
            // }
            column(PURCHASE_RETURN_REGISTERCaption; PURCHASE_RETURN_REGISTERCaptionLbl)
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
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(Vendor_CodeCaption; Vendor_CodeCaptionLbl)
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
            column(Purch__Cr__Memo_Hdr__No_; "No.")
            {
            }
            dataitem("Purchase Invoice Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.")order(ascending)where(Quantity=filter(<>0));
                RequestFilterFields = Type, "No.";

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
                column(Purch__Cr__Memo_Hdr____Vendor_Cr__Memo_No__; "Purch. Cr. Memo Hdr."."Vendor Cr. Memo No.")
                {
                }
                column(Purch__Cr__Memo_Hdr____Posting_Date_; "Purch. Cr. Memo Hdr."."Posting Date")
                {
                }
                column(Purchase_Invoice_Line__Buy_from_Vendor_No__; "Buy-from Vendor No.")
                {
                }
                column(Vendor_Name; Vendor.Name)
                {
                }
                // column(Purchase_Invoice_Line__Purchase_Invoice_Line___Tax___;"Purchase Invoice Line"."Tax %")
                // {
                // }
                column(Purchase_Invoice_Line__Purchase_Invoice_Line___Tax_Area_Code_; "Purchase Invoice Line"."Tax Area Code")
                {
                }
                // column(DataItem1000000058; "Line Amount" + "BED Amount" + "eCess Amount" + "Purchase Invoice Line"."SHE Cess Amount" + "Purchase Invoice Line"."ADC VAT Amount")
                // {
                // }
                // column(Purchase_Invoice_Line__Purchase_Invoice_Line___AED_GSI__Amount_; "Purchase Invoice Line"."AED(GSI) Amount")
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
                // column(Purchase_Invoice_Line__Purchase_Invoice_Line___AED_GSI__Amount__Control1000000010; "Purchase Invoice Line"."AED(GSI) Amount")
                // {
                // }
                // column(DataItem1000000011; "Line Amount" + "BED Amount" + "eCess Amount" + "Purchase Invoice Line"."SHE Cess Amount" + "Purchase Invoice Line"."ADC VAT Amount")
                // {
                // }
                column(Purchase_Invoice_Line__Purchase_Invoice_Line___Tax_Area_Code__Control1000000017; "Purchase Invoice Line"."Tax Area Code")
                {
                }
                column(TaxRate; TaxRate)
                {
                }
                column(Vendor_Name_Control1000000009; Vendor.Name)
                {
                }
                column(Purchase_Invoice_Line__Buy_from_Vendor_No___Control1000000066; "Buy-from Vendor No.")
                {
                }
                column(Purch__Cr__Memo_Hdr____Posting_Date__Control1000000068; "Purch. Cr. Memo Hdr."."Posting Date")
                {
                }
                column(Purch__Cr__Memo_Hdr____Vendor_Cr__Memo_No___Control1000000069; "Purch. Cr. Memo Hdr."."Vendor Cr. Memo No.")
                {
                }
                column(Purchase_Invoice_Line__Document_No___Control1000000070; "Document No.")
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
                // if "Tax %" <> 0 then
                //     TaxRate := ROUND("Tax %", 1, '>');
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
                if Vendor.Get("Buy-from Vendor No.")then;
            end;
            trigger OnPreDataItem()
            begin
                // CurrReport.CreateTotals("Purchase Invoice Line"."Line Amount", "Purchase Invoice Line"."BED Amount",
                //      "Purchase Invoice Line"."eCess Amount", "Purchase Invoice Line"."SHE Cess Amount", "Purchase Invoice Line"."AED(GSI) Amount",
                //      "Purchase Invoice Line"."Tax Amount", "Purchase Invoice Line"."Charges To Vendor", "Purchase Invoice Line"."Amount To Vendor");
                if "Purch. Cr. Memo Hdr.".GetFilter("Purch. Cr. Memo Hdr."."Posting Date") <> '' then begin
                    startingdate:=GetRangeMin("Purch. Cr. Memo Hdr."."Posting Date");
                    endingdate:=GetRangemax("Purch. Cr. Memo Hdr."."Posting Date");
                end
                else
                    Error(Text001);
                FirstTime:=false;
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
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        // rescen.Get(UserMgt.GetRespCenterFilter);
        TempExcelBuffer1.DeleteAll;
        Clear(TempExcelBuffer1);
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
    PURCHASE_RETURN_REGISTERCaptionLbl: label 'PURCHASE RETURN REGISTER';
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
    Vendor_NameCaptionLbl: label 'Vendor Name';
    Vendor_CodeCaptionLbl: label 'Vendor Code';
    Inv__DateCaptionLbl: label 'Inv. Date';
    Party_Bill_No_CaptionLbl: label 'Party Bill No.';
    Invoice_No_CaptionLbl: label 'Invoice No.';
    AEDCaptionLbl: label 'AED';
    Taxable_Amt_CaptionLbl: label 'Taxable Amt.';
    Tax_TypeCaptionLbl: label 'Tax Type';
    Tax_RateCaptionLbl: label 'Tax Rate';
    TotalCaptionLbl: label 'Total';
    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean)
    begin
        TempExcelBuffer1.Init;
        TempExcelBuffer1.Validate("Row No.", RowNo);
        TempExcelBuffer1.Validate("Column No.", ColumnNo);
        TempExcelBuffer1."Cell Value as Text":=CellValue;
        TempExcelBuffer1.Formula:='';
        TempExcelBuffer1.Bold:=Bold;
        TempExcelBuffer1.Underline:=UnderLine;
        TempExcelBuffer1.Insert;
    end;
}
