Report 50366 "Work Order New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Work Order.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";

            column(ReportForNavId_6640;6640)
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
            // column(RecCustomer__C_S_T__No__; RecCustomer."C.S.T. No.")
            // {
            // }
            // column(RecCustomer__T_I_N__No__; RecCustomer."T.I.N. No.")
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
            column(DataItem1000000021; "Sales Header"."Bill-to Address" + ' ' + "Sales Header"."Bill-to Address 2" + ' ' + "Sales Header"."Bill-to City" + ', ' + StateRec.Description + ', ' + "Bill-to Post Code")
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
            column(PO_Audit_Work_Order_Despatch_InstructionsCaption; PO_Audit_Work_Order_Despatch_InstructionsCaptionLbl)
            {
            }
            column(Wo_noCaption; Wo_noCaptionLbl)
            {
            }
            column(Wo_dateCaption; Wo_dateCaptionLbl)
            {
            }
            column(PO_noCaption; PO_noCaptionLbl)
            {
            }
            column(PO_dateCaption; PO_dateCaptionLbl)
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
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(Dist_Dt_Caption; Dist_Dt_CaptionLbl)
            {
            }
            column(Qty_UOMCaption; Qty_UOMCaptionLbl)
            {
            }
            column(RateCaption; RateCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
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
                column(bool; bool)
                {
                }
                column(RecCrossReference__Cross_Reference_No__; RecCrossReference."Reference No.")
                {
                }
                column(Sales_Line__Sales_Line___Shipment_Date_; "Sales Line"."Shipment Date")
                {
                }
                column(HSNSACCode_SalesLine; "Sales Line"."HSN/SAC Code")
                {
                }
                column(GSTText; GSTText)
                {
                }
                // column(TotalGSTAmount; "Total GST Amount")
                // {
                // }
                column(Sales_Line_Quantity; Quantity)
                {
                }
                column(Sales_Line__Sales_Line___Unit_of_Measure_Code_; "Sales Line"."Unit of Measure Code")
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
                column(Type_SalesLine; "Sales Line".Type)
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(RecShipmentMethod_Description; RecShipmentMethod.Description)
                {
                }
                column(RecShipAgent_Name; RecShipAgent.Name)
                {
                }
                column(SalesPerson_Name; SalesPerson.Name)
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
                // column(Sales_Line__BED_Amount_; "BED Amount")
                // {
                // }
                // column(Sales_Line__Sales_Line___eCess_Amount_; "Sales Line"."eCess Amount")
                // {
                // }
                // column(Sales_Line__Sales_Line___SHE_Cess_Amount_; "Sales Line"."SHE Cess Amount")
                // {
                // }
                // column(Line_Amount___BED_Amount___eCess_Amount___SHE_Cess_Amount_; "Line Amount" + "BED Amount" + "eCess Amount" + "SHE Cess Amount")
                // {
                // }
                // column(Sales_Line__Sales_Line___Tax_Amount_; "Sales Line"."Tax Amount")
                // {
                // }
                // column(Sales_Line__Sales_Line___Charges_To_Customer_; "Sales Line"."Charges To Customer")
                // {
                // }
                // column(Line_Amount___BED_Amount___eCess_Amount___SHE_Cess_Amount___Sales_Line___Charges_To_Customer___Sales_Line___Tax_Amount_; "Line Amount" + "BED Amount" + "eCess Amount" + "SHE Cess Amount" + "Sales Line"."Charges To Customer" + "Sales Line"."Tax Amount")
                // {
                // }
                // column(FORMAT___ExcisePostingSetup__BED__________; ' @ ' + Format(ExcisePostingSetup."BED %") + '%')
                // {
                // }
                // column(FORMAT___ExcisePostingSetup__eCess___________; ' @ ' + Format(ExcisePostingSetup."eCess %") + '%')
                // {
                // }
                // column(FORMAT__ExcisePostingSetup__SHE_Cess___________; ' @ ' + Format(ExcisePostingSetup."SHE Cess %") + '%')
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
                column(Frt_basisCaption; Frt_basisCaptionLbl)
                {
                }
                column(Frt_label2; Basis_Caption2)
                {
                }
                column(TransportCaption; TransportCaptionLbl)
                {
                }
                column(Remo__Dt_Caption; Remo__Dt_CaptionLbl)
                {
                }
                column(SmanCaption; SmanCaptionLbl)
                {
                }
                column(Ship_ToCaption; Ship_ToCaptionLbl)
                {
                }
                column(Sales_Line__Line_Amount_Caption; FieldCaption("Line Amount"))
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
                column(Tax_AmountCaption; Tax_AmountCaptionLbl)
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
                column(Prepared_ByCaption; Prepared_ByCaptionLbl)
                {
                }
                column(Auth__Sign_Caption; Auth__Sign_CaptionLbl)
                {
                }
                column(FM_MKT_01__Rev_No_01__Effective_Date_01_11_2007Caption; FM_MKT_01__Rev_No_01__Effective_Date_01_11_2007CaptionLbl)
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
                trigger OnAfterGetRecord()
                var
                    CustLocal: Record Customer;
                    SalesCommentLine: Record "Sales Comment Line";
                begin
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
                                CGST_Amt+=TaxTransactionValue.Amount;
                                CGST_Perc:=TaxTransactionValue.Percent;
                            end;
                            IF TaxTransactionValue."Value ID" = 3 then begin
                                IGST_Amt+=TaxTransactionValue.Amount;
                                IGST_Perc:=TaxTransactionValue.Percent;
                            end;
                            IF TaxTransactionValue."Value ID" = 6 then begin
                                SGST_Amt+=TaxTransactionValue.Amount;
                                SGST_Perc:=TaxTransactionValue.Percent;
                            end;
                        until TaxTransactionValue.Next() = 0;
                    XX:=XX - 1;
                    //IF taxPercent = 0 THEN
                    //  taxPercent := "Tax %";
                    // ALLE1.01 Sk Start
                    // GSTText := '';
                    // if "Sales Line"."GST Jurisdiction Type" = "Sales Line"."gst jurisdiction type"::Intrastate then begin
                    //     DetailedGSTLedgerEntry.Reset;
                    //     DetailedGSTLedgerEntry.SetRange("Document No.", "Sales Line"."Document No.");
                    //     DetailedGSTLedgerEntry.SetRange("Line No.", "Sales Line"."Line No.");
                    //     //  DetailedGSTLedgerEntry.SETRANGE("Document Type",DetailedGSTLedgerEntry."Document Type"::) ;
                    //     //DetailedGSTLedgerEntry.SETRANGE(DetailedGSTLedgerEntry."No.","No.");
                    //     DetailedGSTLedgerEntry.SetFilter(DetailedGSTLedgerEntry."GST Component Code", '%1|%2', 'SGST', 'CGST');
                    //     if DetailedGSTLedgerEntry.FindSet then
                    //         repeat
                    //             if GSTText = '' then
                    //                 GSTText := DetailedGSTLedgerEntry."GST Component Code" + Format(ROUND(DetailedGSTLedgerEntry."GST %", 0.1, '=')) + '%  ' + ' Rs. ' + Format(Abs(DetailedGSTLedgerEntry."GST Amount"))
                    //             else
                    //                 GSTText := GSTText + '    ' + DetailedGSTLedgerEntry."GST Component Code" + Format(ROUND(DetailedGSTLedgerEntry."GST %", 0.1, '=')) + '%  ' + ' Rs. ' + Format(Abs(DetailedGSTLedgerEntry."GST Amount"));
                    //         until DetailedGSTLedgerEntry.Next = 0;
                    // end else begin
                    //     if GSTGroup.Get("Sales Line"."GST Group Code") then
                    //         GSTText := 'I' + GSTGroup.Description + ' Rs. ' + Format("Total GST Amount");
                    // end;
                    // TotalGstAMount := TotalGstAMount + "Total GST Amount";
                    // if ("Tax Amount" <> 0) and (taxPercent = 0) then begin
                    //     TaxAreaLine.SetCurrentkey("Tax Area", "Calculation Order");
                    //     TaxAreaLine.SetRange("Tax Area", "Tax Area Code");
                    //     if TaxAreaLine.Find('-') then begin
                    //         TaxJurisdiction.Get(TaxAreaLine."Tax Jurisdiction Code");
                    //         TaxDetail.Reset;
                    //         TaxDetail.SetRange("Tax Jurisdiction Code", TaxAreaLine."Tax Jurisdiction Code");
                    //         TaxDetail.SetFilter("Tax Group Code", '%1', "Tax Group Code");
                    //         TaxDetail.SetRange("Form Code", "Form Code");
                    //         TaxDetail.SetFilter("Effective Date", '<=%1', "Sales Header"."Posting Date");
                    //         if TaxDetail.Find('+') then
                    //             taxPercent := TaxDetail."Tax Below Maximum";
                    //     end;
                    // end;
                    // if "Excise Amount" <> 0 then begin
                    //     ExcisePostingSetup.SetRange("Excise Bus. Posting Group", "Excise Bus. Posting Group");
                    //     ExcisePostingSetup.SetRange("Excise Prod. Posting Group", "Excise Prod. Posting Group");
                    //     if ("Posting Date" <> 0D) then
                    //         ExcisePostingSetup.SetRange("From Date", 0D, "Posting Date")
                    //     else
                    //         ExcisePostingSetup.SetRange("From Date", 0D, WorkDate);
                    //     if ExcisePostingSetup.Find('+') then;
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
                    SalesCommentLine.Reset;
                    SalesCommentLine.SetRange("Document Type", SalesCommentLine."document type"::Order);
                    SalesCommentLine.SetRange("No.", "Sales Header"."No.");
                    SalesCommentLine.SetRange("Document Line No.", 0);
                    if SalesCommentLine.Find('-')then Comments[1]:=SalesCommentLine.Comment;
                    if SalesCommentLine.Next <> 0 then Comments[2]:=SalesCommentLine.Comment;
                    if not SalesPerson.Get("Sales Header"."Salesperson Code")then SalesPerson.Init;
                    RecCrossReference.Reset;
                    RecCrossReference.SetRange("Item No.", "Sales Line"."No.");
                    RecCrossReference.SetRange("Reference Type", RecCrossReference."Reference Type"::Customer);
                    RecCrossReference.SetRange(RecCrossReference."Reference Type No.", "Sales Line"."Sell-to Customer No.");
                    if not RecCrossReference.FindFirst then RecCrossReference."Reference No.":='';
                    SrNo+=1;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                column(ReportForNavId_1000000068;1000000068)
                {
                }
                column(PageLoopCounter; PageLoop)
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
                if "Tax Area Code" <> '' then TaxText:="Tax Area Code";
                // if "Form Code" <> '' then
                //     TaxText := TaxText + ' (Form ' + "Form Code" + ')';
                RecSIL.Reset;
                RecSIL.SetRange("Document No.", "No.");
                RecSIL.SetRange(Type, RecSIL.Type::Item);
                if RecSIL.FindLast then begin
                    if RecSIL."GST Jurisdiction Type" = RecSIL."gst jurisdiction type"::Intrastate then bool:=false
                    else
                        bool:=true;
                end;
                taxPercent:=0;
                SHArchive.Reset;
                SHArchive.SetRange("Document Type", "Document Type");
                SHArchive.SetRange("No.", "No.");
                if SHArchive.FindLast then begin
                    RevisionNo:='(Rev No.  ' + Format(SHArchive."Version No.") + ')';
                    RevisionDt:='(Rev Date ' + Format(SHArchive."Date Archived") + ')';
                end;
                if RecCustomer.Get("Bill-to Customer No.")then;
                if not StateRec.Get(State)then StateRec.Init;
            end;
            trigger OnPreDataItem()
            begin
                XX:=10;
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
    var TaxTransactionValue: Record "Tax Transaction Value";
    SBCess: Decimal;
    DetailedGSTEntryBuffer: Record "Detailed GST Ledger Entry";
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
    Comments: array[2]of Text[80];
    SalesPerson: Record "Salesperson/Purchaser";
    TaxText: Text[100];
    taxPercent: Decimal;
    TaxAreaLine: Record "Tax Area Line";
    TaxJurisdiction: Record "Tax Jurisdiction";
    TaxDetail: Record "Tax Detail";
    SHArchive: Record "Sales Header Archive";
    RevisionNo: Text[30];
    RevisionDt: Text[30];
    PO_Audit_Work_Order_Despatch_InstructionsCaptionLbl: label 'PO Audit/Work Order/Despatch Instructions';
    Wo_noCaptionLbl: label 'Wo_no';
    Wo_dateCaptionLbl: label 'Wo_date';
    PO_noCaptionLbl: label 'PO_no';
    PO_dateCaptionLbl: label 'PO_date';
    ECC_NoCaptionLbl: label 'GSTIN';
    S_T__NoCaptionLbl: label 'S.T. No';
    Desti_CaptionLbl: label 'Desti.';
    Sold_ToCaptionLbl: label 'Sold To';
    CTCCaptionLbl: label 'CTC';
    EmailCaptionLbl: label 'Email';
    V_CodeCaptionLbl: label 'V Code';
    DescriptionCaptionLbl: label 'Description';
    Item_CodeCaptionLbl: label 'Item Code';
    Dist_Dt_CaptionLbl: label 'Dist Dt.';
    Qty_UOMCaptionLbl: label 'Qty/UOM';
    RateCaptionLbl: label 'Rate';
    AmountCaptionLbl: label 'Amount';
    Frt_basisCaptionLbl: label 'Price Basis';
    Basis_Caption2: label '(INCOTERMS 2020)';
    TransportCaptionLbl: label 'Transport';
    Remo__Dt_CaptionLbl: label 'Remo. Dt.';
    SmanCaptionLbl: label 'Sman';
    Ship_ToCaptionLbl: label 'Ship To';
    BED_AmountCaptionLbl: label 'BED Amount';
    Ecess_AmountCaptionLbl: label 'Ecess Amount';
    SHECess_AmountCaptionLbl: label 'SHECess Amount';
    TotalCaptionLbl: label 'Total';
    Tax_AmountCaptionLbl: label 'Tax Amount';
    FreightCaptionLbl: label 'Freight';
    Grand_TotalCaptionLbl: label 'Grand Total';
    RemarksCaptionLbl: label 'Remarks';
    Prepared_ByCaptionLbl: label 'Prepared By';
    Auth__Sign_CaptionLbl: label 'Auth. Sign.';
    FM_MKT_01__Rev_No_01__Effective_Date_01_11_2007CaptionLbl: label 'FM-MKT-01, Rev No 01, Effective Date 01/11/2007';
    XX: Integer;
    PageLoop: label 'PageLoopCounter';
    recItem: Record Item;
    GSTGroup: Record "GST Group";
    GSTText: Text;
    GSTSetup: Record "GST Setup";
    DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    CGSTAMT: Decimal;
    bool: Boolean;
    TotalGstAMount: Decimal;
    TotalGstAMountintext: array[5]of Text[250];
    RecSIL: Record "Sales Line";
}
