Report 50367 "Order Confirmation New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Order Confirmation.rdl';
    ApplicationArea = all;
    UsageCategory = Administration;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "Document Type", "No.";

            column(ReportForNavId_6640;6640)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo."New Logo1")
            {
            }
            column(CompnayInfo_Name; CompanyInfo.Name)
            {
            }
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header__Sales_Header___Order_Date_; "Sales Header"."Order Date")
            {
            }
            column(Sales_Header__Sales_Header___External_Document_No__; "Sales Header"."External Document No.")
            {
            }
            column(Sales_Header__Sales_Header___External_Doc__Date_; "Sales Header"."External Doc. Date")
            {
            }
            column(RecCustomer__E_C_C__No__; RecCustomer."GST Registration No.")
            {
            }
            // column(RecCustomer__C_S_T__No__;RecCustomer."C.S.T. No.")
            // {
            // }
            // column(RecCustomer__T_I_N__No__;RecCustomer."T.I.N. No.")
            // {
            // }
            column(Sales_Header__Ship_to_City_; "Ship-to City")
            {
            }
            column(Sales_Header__Sales_Header___Bill_to_Customer_No__; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(Sales_Header__Sales_Header___Bill_to_Name_; "Sales Header"."Bill-to Name")
            {
            }
            column(Sales_Header___Bill_to_Address________Sales_Header___Bill_to_Address_2_; "Sales Header"."Bill-to Address" + '  ' + "Sales Header"."Bill-to Address 2")
            {
            }
            column(Sales_Header___Bill_to_City___________StateRec_Description__________Bill_to_Post_Code_; "Sales Header"."Bill-to City" + ', ' + StateRec.Description + ', ' + "Bill-to Post Code")
            {
            }
            column(RecCustomer_Contact; RecCustomer.Contact)
            {
            }
            column(RecCustomer__E_Mail_; RecCustomer."E-Mail")
            {
            }
            column(RecCustomer__Our_Account_No__; RecCustomer."Our Account No.")
            {
            }
            column(RevisionNo; RevisionNo)
            {
            }
            column(RevisionDt; RevisionDt)
            {
            }
            column(PaymentTermsText; PaymentTermsText)
            {
            }
            column(Purchase_Order_AcknowledgementCaption; Purchase_Order_AcknowledgementCaptionLbl)
            {
            }
            column(Sales_Order__Caption; Sales_Order__CaptionLbl)
            {
            }
            column(Sales_Order_DateCaption; Sales_Order_DateCaptionLbl)
            {
            }
            column(PO__Caption; PO__CaptionLbl)
            {
            }
            column(PO_DateCaption; PO_DateCaptionLbl)
            {
            }
            column(ECC_NoCaption; ECC_NoCaptionLbl)
            {
            }
            column(S_T__NoCaption; S_T__NoCaptionLbl)
            {
            }
            column(Desti_Caption; Desti_CaptionLbl)
            {
            }
            column(Sold_ToCaption; Sold_ToCaptionLbl)
            {
            }
            column(CTCCaption; CTCCaptionLbl)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            column(V_CodeCaption; V_CodeCaptionLbl)
            {
            }
            column(PaymentTermsTextCaption; PaymentTermsTextCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Customer_Item_CodeCaption; Customer_Item_CodeCaptionLbl)
            {
            }
            column(Expected_Delivery_Date_Caption; Expected_Delivery_Date_CaptionLbl)
            {
            }
            column(Qty_UOMCaption; Qty_UOMCaptionLbl)
            {
            }
            column(RateCaption; RateCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaption)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                column(ReportForNavId_2844;2844)
                {
                }
                column(Sales_Line_Description; Description)
                {
                }
                column(RecCrossReference__Cross_Reference_No__; RecCrossReference."Reference No.")
                {
                }
                column(GSTText; GSTText)
                {
                }
                column(bool; bool)
                {
                }
                // column(TotalGSTAmount;"Total GST Amount")
                // {
                // }
                column(HSNSACCode_SalesLine; "Sales Line"."HSN/SAC Code")
                {
                }
                column(Sales_Line__Sales_Line___Planned_Delivery_Date_; "Sales Line"."Planned Delivery Date")
                {
                }
                column(Sales_Line_Quantity; Quantity)
                {
                }
                column(Sales_Line__Sales_Line___Unit_of_Measure_Code_; "Sales Line"."Unit of Measure Code")
                {
                }
                column(Type_SalesLine; "Sales Line".Type)
                {
                }
                column(Sales_Line__Sales_Line___Unit_Price_; "Sales Line"."Unit Price")
                {
                }
                column(Sales_Line__Sales_Line___Line_Amount_; "Sales Line"."Line Amount")
                {
                }
                column(Sales_Line__Description_2_; "Description 2")
                {
                }
                column(Sales_Line__No__; "No.")
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(ShipingVariance; ShipingVariance)
                {
                }
                column(RecShipmentMethod_Description; RecShipmentMethod.Description)
                {
                }
                column(RecShipAgent_Name; RecShipAgent.Name)
                {
                }
                column(SalesPerson_Name; SalesPerson.Name + '  ' + SalesPerson."E-Mail" + '    ' + SalesPerson."Phone No.")
                {
                }
                column(SalesPerson_ZCC; SalesPerson."Resp. CCare Exe. Name" + '  ' + SalesPerson."Resp. CCare Exe. Phone No." + ' ' + SalesPerson."Resp. CCare Exe. Email Id")
                {
                }
                column(test1; ShipToAddr[1])
                {
                }
                column(ShipToAddr_2_; ShipToAddr[2])
                {
                }
                column(ShipToAddr_3_; ShipToAddr[3])
                {
                }
                column(ShipToAddr_4_; ShipToAddr[4])
                {
                }
                column(Sales_Line__Line_Amount_; "Line Amount")
                {
                }
                // column(Sales_Line__BED_Amount_;"BED Amount")
                // {
                // }
                // column(Sales_Line__Sales_Line___eCess_Amount_;"Sales Line"."eCess Amount")
                // {
                // }
                // column(Sales_Line__Sales_Line___SHE_Cess_Amount_;"Sales Line"."SHE Cess Amount")
                // {
                // }
                // column(Line_Amount___BED_Amount___eCess_Amount___SHE_Cess_Amount_;"Line Amount"+"BED Amount"+"eCess Amount"+"SHE Cess Amount")
                // {
                // }
                // column(Sales_Line__Sales_Line___Tax_Amount_;"Sales Line"."Tax Amount")
                // {
                // }
                // column(Sales_Line__Sales_Line___Charges_To_Customer_;"Sales Line"."Charges To Customer")
                // {
                // }
                // column(Line_Amount___BED_Amount___eCess_Amount___SHE_Cess_Amount___Sales_Line___Charges_To_Customer___Sales_Line___Tax_Amount_;"Line Amount"+"BED Amount"+"eCess Amount"+"SHE Cess Amount"+"Sales Line"."Charges To Customer"+"Sales Line"."Tax Amount")
                // {
                // }
                // column(FORMAT___ExcisePostingSetup__BED__________;' @ ' + Format ( ExcisePostingSetup."BED %") + '%')
                // {
                // }
                // column(FORMAT___ExcisePostingSetup__eCess___________;' @ ' + Format ( ExcisePostingSetup."eCess %") + '%' )
                // {
                // }
                // column(FORMAT__ExcisePostingSetup__SHE_Cess___________;' @ ' + Format (ExcisePostingSetup."SHE Cess %") + '%' )
                // {
                // }
                column(FORMAT__taxPercent________;' @ ' + Format(taxPercent) + '%')
                {
                }
                column(RecDimValue_Name; RecDimValue.Name)
                {
                }
                column(ShipToAddr_5_; ShipToAddr[5])
                {
                }
                column(Comments_1_; Comments[1])
                {
                }
                column(Comments_2_; Comments[2])
                {
                }
                column(TaxText; TaxText)
                {
                }
                column(Comments_3_; Comments[3])
                {
                }
                column(Comments_4_; Comments[4])
                {
                }
                column(Comments_5_; Comments[5])
                {
                }
                column(Comments_6_; Comments[6])
                {
                }
                column(Comments_7_; Comments[7])
                {
                }
                column(TransportMethod_Description; TransportMethod.Description)
                {
                }
                column(Freight_BasisCaption; Freight_BasisCaptionLbl)
                {
                }
                column(Planned_TransportCaption; Planned_TransportCaptionLbl)
                {
                }
                column(ZD_Sales_ManagerCaption; ZD_Sales_ManagerCaptionLbl)
                {
                }
                column(Ship_ToCaption; Ship_ToCaptionLbl)
                {
                }
                column(Total_AmountCaption; Total_AmountCaptionLbl)
                {
                }
                column(BED_AmountCaption; BED_AmountCaptionLbl)
                {
                }
                column(Ecess_AmountCaption; Ecess_AmountCaptionLbl)
                {
                }
                column(SHECess_AmountCaption; SHECess_AmountCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(FreightCaption; FreightCaptionLbl)
                {
                }
                column(Grand_TotalCaption; Grand_TotalCaptionLbl)
                {
                }
                column(RemarksCaption; RemarksCaptionLbl)
                {
                }
                column(Planned_Transport_MethodCaption; Planned_Transport_MethodCaptionLbl)
                {
                }
                column(Thank_you_for_your_business__Caption; Thank_you_for_your_business__CaptionLbl)
                {
                }
                column(FM_MKT_05__Rev_02__Effective_Date_20_02_2014_Caption; FM_MKT_05__Rev_02__Effective_Date_20_02_2014_CaptionLbl)
                {
                }
                column(Sales_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Line_Line_No_; "Line No.")
                {
                }
                column(IGST_Perc; IGST_Perc)
                {
                }
                column(IGST_Amt; IGST_Amt)
                {
                }
                column(CGST_Perc; CGST_Perc)
                {
                }
                column(CGST_Amt; CGST_Amt)
                {
                }
                column(SGST_Perc; SGST_Perc)
                {
                }
                column(SGST_Amt; SGST_Amt)
                {
                }
                trigger OnAfterGetRecord()
                var
                    CustLocal: Record Customer;
                    SalesCommentLine: Record "Sales Comment Line";
                begin
                    XX:=XX - 1;
                    IGST_Perc:=0;
                    IGST_Amt:=0;
                    CGST_Perc:=0;
                    CGST_Amt:=0;
                    SGST_Perc:=0;
                    SGST_Amt:=0;
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", "Sales Line".RecordId);
                    TaxTransactionValue.SetRange("Tax Type", 'GST');
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    IF TaxTransactionValue.FindSet()then repeat if TaxTransactionValue."Value ID" = 2 then begin
                                CGST_Amt:=TaxTransactionValue.Amount;
                                CGST_Perc:=TaxTransactionValue.Percent;
                            end;
                            IF TaxTransactionValue."Value ID" = 3 then begin
                                IGST_Amt:=TaxTransactionValue.Amount;
                                IGST_Perc:=TaxTransactionValue.Percent;
                            end;
                            IF TaxTransactionValue."Value ID" = 6 then begin
                                SGST_Amt:=TaxTransactionValue.Amount;
                                SGST_Perc:=TaxTransactionValue.Percent;
                            end;
                        until TaxTransactionValue.Next() = 0;
                    //IF taxPercent = 0 THEN
                    //  taxPercent := "Tax %";
                    // ALLE1.01 Sk Start
                    // GSTText :='';
                    // if "Sales Line"."GST Jurisdiction Type"  ="Sales Line"."gst jurisdiction type"::Intrastate then begin
                    //     DetailedGSTLedgerEntry.Reset;
                    //     DetailedGSTLedgerEntry.SetRange("Document No.","Sales Line"."Document No.");
                    //     DetailedGSTLedgerEntry.SetRange("Line No.","Sales Line"."Line No.");
                    //   //  DetailedGSTLedgerEntry.SETRANGE("Document Type",DetailedGSTLedgerEntry."Document Type"::Invoice);
                    //   //  DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."No.","No.");
                    //     DetailedGSTLedgerEntry.SetFilter(DetailedGSTLedgerEntry."GST Component Code",'%1|%2','SGST','CGST');
                    //     if DetailedGSTLedgerEntry.FindSet then
                    //       repeat
                    //       if GSTText ='' then
                    //         GSTText :=DetailedGSTLedgerEntry."GST Component Code"+Format(ROUND(DetailedGSTLedgerEntry."GST %",0.1,'='))+'%  '  +' Rs. '+Format(Abs(DetailedGSTLedgerEntry."GST Amount"))
                    //       else
                    //         GSTText :=GSTText+'    '+DetailedGSTLedgerEntry."GST Component Code"+Format(ROUND(DetailedGSTLedgerEntry."GST %",0.1,'='))+'%  ' +' Rs. '+Format(Abs(DetailedGSTLedgerEntry."GST Amount"));
                    //     until DetailedGSTLedgerEntry.Next =0;
                    // end else  begin
                    //  if GSTGroup.Get("Sales Line"."GST Group Code") then
                    //   GSTText:= 'I'+GSTGroup.Description +' Rs. '+Format("Total GST Amount");
                    // end;
                    // TotalGstAMount :=TotalGstAMount+"Total GST Amount";
                    // if ("Tax Amount" <> 0) and (taxPercent = 0) then begin
                    //   TaxAreaLine.SetCurrentkey("Tax Area","Calculation Order");
                    //   TaxAreaLine.SetRange("Tax Area","Tax Area Code");
                    //   if TaxAreaLine.Find('-') then begin
                    //     TaxJurisdiction.Get(TaxAreaLine."Tax Jurisdiction Code");
                    //     TaxDetail.Reset;
                    //     TaxDetail.SetRange("Tax Jurisdiction Code",TaxAreaLine."Tax Jurisdiction Code");
                    //     TaxDetail.SetFilter("Tax Group Code",'%1',"Tax Group Code");
                    //     TaxDetail.SetRange("Form Code","Form Code");
                    //     TaxDetail.SetFilter("Effective Date",'<=%1',"Sales Header"."Posting Date");
                    //     if TaxDetail.Find('+') then
                    //       taxPercent := TaxDetail."Tax Below Maximum";
                    //   end;
                    // end;
                    // if "Excise Amount" <> 0 then begin
                    //   ExcisePostingSetup.SetRange("Excise Bus. Posting Group","Excise Bus. Posting Group");
                    //   ExcisePostingSetup.SetRange("Excise Prod. Posting Group","Excise Prod. Posting Group");
                    //   if ("Posting Date" <> 0D) then
                    //     ExcisePostingSetup.SetRange("From Date",0D,"Posting Date")
                    //     else
                    //     ExcisePostingSetup.SetRange("From Date",0D,WorkDate);
                    //     if ExcisePostingSetup.Find('+') then ;
                    // end;
                    if "Sales Header"."Sell-to Customer No." <> "Sales Header"."Bill-to Customer No." then begin
                        if RecSalesHeader.Get("Sales Header"."Document Type", "Sales Header"."No.")then;
                    end
                    else
                        OptionalText:='SAME AS CONSIGNEE';
                    //>>
                    StateRec.Init;
                    Clear(ShipToAddr);
                    CustLocal.Get("Sales Header"."Sell-to Customer No.");
                    if CustLocal."Print Ship to Addr. on Inv." then begin
                        if not StateRec.Get("Sales Header"."GST Bill-to State Code")then StateRec.Init;
                        ShipToAddr[1]:="Sales Header"."Sell-to Customer No.";
                        ShipToAddr[2]:="Sales Header"."Ship-to Name";
                        ShipToAddr[3]:="Sales Header"."Ship-to Address";
                        ShipToAddr[4]:="Sales Header"."Ship-to Address 2";
                        ShipToAddr[5]:="Sales Header"."Ship-to City" + ', ' + StateRec.Description + ', ' + "Sales Header"."Ship-to Post Code";
                    //  ShipToAddr[5] :=  'CST No.: ' + CustLocal."C.S.T. No.";
                    //  ShipToAddr[6] :=  'ECC No.: ' + CustLocal."E.C.C. No.";
                    end
                    else
                        ShipToAddr[1]:='SAME AS CONSIGNEE';
                    //<<
                    if RecShipmentMethod.Get("Sales Header"."Shipment Method Code")then;
                    if RecShipAgent.Get("Sales Header"."Shipping Agent Code")then;
                    /*
                    //MPG BIS
                    IF RecDocDimension.GET(36,"Sales Header"."Document Type","Sales Header"."No.",0,'SALESAREA') THEN
                      IF RecDimValue.GET('SALESAREA',RecDocDimension."Dimension Value Code") THEN;
                    */
                    RecCrossReference.Reset;
                    RecCrossReference.SetRange("Item No.", "Sales Line"."No.");
                    RecCrossReference.SetRange("Reference Type", RecCrossReference."Reference Type"::Customer);
                    RecCrossReference.SetRange(RecCrossReference."Reference Type No.", "Sales Line"."Sell-to Customer No.");
                    if not RecCrossReference.FindFirst then RecCrossReference."Reference No.":='';
                    SrNo+=1;
                    //<<<< ALLE[551]
                    ShipingVariance:='';
                    Item.Reset;
                    if Item.Get("Sales Line"."No.")then if Item."Allow Shipping Variance" then ShipingVariance:='(Invoiced quantity against order quantity may vary +/- 10% due to manufacturing/SCM constraints. Please accommodate accordingly.)';
                    //>>>> ALLE[551]
                    SalesCommentLine.Reset;
                    SalesCommentLine.SetRange("Document Type", SalesCommentLine."document type"::Order);
                    SalesCommentLine.SetRange("No.", "Sales Header"."No.");
                    SalesCommentLine.SetRange("Document Line No.", 0);
                    if SalesCommentLine.Find('-')then Comments[1]:=SalesCommentLine.Comment;
                    if SalesCommentLine.Next <> 0 then Comments[2]:=SalesCommentLine.Comment;
                    if not SalesPerson.Get("Sales Header"."Salesperson Code")then SalesPerson.Init;
                    Comments[3]:='1. *Expected Delivery Date at customer location subject to clearance from Finance Department.' + ' Consignor has the right to ship the material prior to the';
                    Comments[4]:=' Expected Delivery Date. In case of any delays beyond the specified Expected Delivery Date you shall be informed.';
                    Comments[5]:='2. In case of any errors/omissions please notify us in writing within two days of receipt of this acknowledgement.';
                    Comments[6]:='3. In case of any order amendments you shall be sent a fresh order acknowledgement.';
                    Comments[7]:='4. Consignor shall have the right to short close any orders based on manufacturing/logistics requirements.';
                    if("Sales Header"."Currency Code" = 'INR') or ("Sales Header"."Currency Code" = '')then //Alle
 GSTText:=GSTText
                    else
                        GSTText:='';
                end;
                trigger OnPreDataItem()
                begin
                    SrNo:=0;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                column(ReportForNavId_1000000069;1000000069)
                {
                }
                column(CountLoop; CountLoop)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    XX:=XX - 1;
                end;
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, XX);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                TaxText:='Tax Amount';
                if "Sales Header"."Currency Code" in['', 'INR']then //Alle
 AmountCaption:=AmountCaptionLbl
                else
                    AmountCaption:=AmountCaptionLbl + ' in ' + "Sales Header"."Currency Code";
                if "Tax Area Code" <> '' then TaxText:="Tax Area Code";
                // if "Form Code" <> '' then
                //   TaxText := TaxText + ' (Form ' + "Form Code" + ')';
                taxPercent:=0;
                RecSIL.Reset;
                RecSIL.SetRange("Document No.", "No.");
                RecSIL.SetRange(Type, RecSIL.Type::Item);
                if RecSIL.FindLast then begin
                    if RecSIL."GST Jurisdiction Type" = RecSIL."gst jurisdiction type"::Intrastate then bool:=false
                    else
                        bool:=true;
                end;
                SHArchive.Reset;
                SHArchive.SetRange("Document Type", "Document Type");
                SHArchive.SetRange("No.", "No.");
                if SHArchive.FindLast then begin
                    RevisionNo:='(Rev No.  ' + Format(SHArchive."Version No.") + ')';
                    RevisionDt:='(Rev Date ' + Format(SHArchive."Date Archived") + ')';
                end;
                if PaymentTerms.Get("Payment Terms Code")then PaymentTermsText:=PaymentTerms.Description;
                if not TransportMethod.Get("Transport Method")then TransportMethod.Init;
                if RecCustomer.Get("Bill-to Customer No.")then;
                if not StateRec.Get(State)then StateRec.Init;
            end;
            trigger OnPreDataItem()
            begin
                XX:=5;
            end;
        }
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields("New Logo1");
    end;
    var TaxTransactionValue: Record "Tax Transaction Value";
    IGST_Perc: Decimal;
    IGST_Amt: Decimal;
    CGST_Perc: Decimal;
    CGST_Amt: Decimal;
    SGST_Perc: Decimal;
    SGST_Amt: Decimal;
    RecCustomer: Record Customer;
    RecCrossReference: Record "Item Reference";
    SrNo: Integer;
    RecSalesHeader: Record "Sales Header";
    OptionalText: Text[100];
    RecShipmentMethod: Record "Shipment Method";
    RecShipAgent: Record "Shipping Agent";
    // ExcisePostingSetup: Record UnknownRecord13711;
    SBC: Integer;
    RecDimValue: Record "Dimension Value";
    Per: Text[2];
    StateRec: Record State;
    ShipToAddr: array[10]of Text[100];
    Comments: array[20]of Text[200];
    SalesPerson: Record "Salesperson/Purchaser";
    TaxText: Text[100];
    taxPercent: Decimal;
    TaxAreaLine: Record "Tax Area Line";
    TaxJurisdiction: Record "Tax Jurisdiction";
    TaxDetail: Record "Tax Detail";
    SHArchive: Record "Sales Header Archive";
    RevisionNo: Text[30];
    RevisionDt: Text[30];
    PaymentTermsText: Text[100];
    PaymentTerms: Record "Payment Terms";
    TransportMethod: Record "Transport Method";
    Item: Record Item;
    ShipingVariance: Text[250];
    Purchase_Order_AcknowledgementCaptionLbl: label 'Purchase Order Acknowledgement';
    Sales_Order__CaptionLbl: label 'Sales Order #';
    Sales_Order_DateCaptionLbl: label 'Sales Order Date';
    PO__CaptionLbl: label 'PO #';
    PO_DateCaptionLbl: label 'PO Date';
    ECC_NoCaptionLbl: label 'GSTIN';
    S_T__NoCaptionLbl: label 'S.T. No';
    Desti_CaptionLbl: label 'Desti.';
    Sold_ToCaptionLbl: label 'Sold To';
    CTCCaptionLbl: label 'CTC';
    EmailCaptionLbl: label 'Email';
    V_CodeCaptionLbl: label 'V Code';
    PaymentTermsTextCaptionLbl: label 'Payment Terms';
    DescriptionCaptionLbl: label 'Description';
    Customer_Item_CodeCaptionLbl: label 'Customer Item Code';
    Expected_Delivery_Date_CaptionLbl: label 'Expected Delivery Date*';
    Qty_UOMCaptionLbl: label 'Qty/UOM';
    RateCaptionLbl: label 'Rate';
    AmountCaptionLbl: label 'Amount';
    Freight_BasisCaptionLbl: label 'Price Basis (INCOTERMS 2020)';
    Planned_TransportCaptionLbl: label 'Planned Transport';
    ZD_Sales_ManagerCaptionLbl: label 'Sales Manager';
    Ship_ToCaptionLbl: label 'Ship To';
    Total_AmountCaptionLbl: label 'Total Amount';
    BED_AmountCaptionLbl: label 'BED Amount';
    Ecess_AmountCaptionLbl: label 'Ecess Amount';
    SHECess_AmountCaptionLbl: label 'SHECess Amount';
    TotalCaptionLbl: label 'Total';
    FreightCaptionLbl: label 'Freight';
    Grand_TotalCaptionLbl: label 'Grand Total';
    RemarksCaptionLbl: label 'Remarks';
    Planned_Transport_MethodCaptionLbl: label 'Planned Transport Method';
    Thank_you_for_your_business__CaptionLbl: label 'Thank you for your business!!';
    FM_MKT_05__Rev_02__Effective_Date_20_02_2014_CaptionLbl: label '<FM-MKT-05, Rev-02, Effective Date 20.02.2014>';
    CountLoop: label 'CountLoop';
    XX: Integer;
    CompanyInfo: Record "Company Information";
    GSTGroup: Record "GST Group";
    GSTText1: Text;
    GSTText: Text;
    GSTSetup: Record "GST Setup";
    DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    CGSTAMT: Decimal;
    bool: Boolean;
    TotalGstAMount: Decimal;
    TotalGstAMountintext: array[5]of Text[250];
    RecSIL: Record "Sales Line";
    AmountCaption: Text;
}
