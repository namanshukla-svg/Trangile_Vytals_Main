Report 50173 "Purch. Cr. as Sales InvoiceNew"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Purch. Cr.as Sales Invoice New.rdl';
    ApplicationArea = ALL;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Purch. Cr. as Sales Invoice New';

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(ReportForNavId_1000000248; 1000000248)
            {
            }
            column(QRCode; QRCodeStr.QRCode)
            {
            }
            column(InvNo_; CopyStr("Purch. Cr. Memo Hdr."."No.", StrLen("Purch. Cr. Memo Hdr."."No.") - 4, 5))
            {
            }
            column(ShipToAddr_8_; 'Packing : TOTAL ' + Format(TotalPack) + ' PKGS ( GWT ' + Format(TotalWeight) + ' KGS ) ' + '     PKG Slip No.: ' + PackingSlipNo)
            {
            }
            column(ShipToAddr_1_; ShipToAddr[1])
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
            column(Bool; bool)
            {
            }
            column(ShipToAddr_5_; ShipToAddr[5])
            {
            }
            column(TotalGstAMountintext; TotalGstAMountintext[1])
            {
            }
            column(Purch__Cr__Memo_Line__Amount; "Purch. Cr. Memo Line".Amount)
            {
            }
            // column(ABS__Purch__Cr__Memo_Line___BED_Amount__;Abs("Purch. Cr. Memo Line"."BED Amount"))
            // {
            // }
            // column(ABS__Purch__Cr__Memo_Line___SHE_Cess_Amount__;Abs("Purch. Cr. Memo Line"."SHE Cess Amount"))
            // {
            // }
            // column(ABS__Purch__Cr__Memo_Line___eCess_Amount__;Abs("Purch. Cr. Memo Line"."eCess Amount"))
            // {
            // }
            // column(Purch__Cr__Memo_Line__Amount_ABS__Purch__Cr__Memo_Line___Excise_Amount__;"Purch. Cr. Memo Line".Amount+Abs("Purch. Cr. Memo Line"."Excise Amount"))
            // {
            // }
            column(FreightAmt; FreightAmt)
            {
            }
            // column(Purch__Cr__Memo_Line___Tax_Amount_;"Purch. Cr. Memo Line"."Tax Amount")
            // {
            //     DecimalPlaces = 2:2;
            // }
            column(ForAmt; ForAmt)
            {
            }
            // column(Purch__Cr__Memo_Line___Amount_To_Vendor__PurchCrLine__Line_Amount_; "Purch. Cr. Memo Line"."Amount To Vendor" + PurchCrLine."Line Amount")
            // {
            // }
            column(Purch__Cr__Memo_hdr____Vehicle_No___; '"Purch. Cr. Memo hdr."."Vehicle No."')
            {
            }
            column(ShipmentMethod_Description_Control1000000061; ShipmentMethod.Description)
            {
            }
            column(NoInText_1_; NoInText[1])
            {
            }
            column(ExInText_1_; ExInText[1])
            {
            }
            column(Assessable_Value_; 'Assessable Value')
            {
            }
            column(BED1; BED1)
            {
            }
            column(Ecess; Ecess)
            {
            }
            column(SHE; SHE)
            {
            }
            column(TaxText; TaxText)
            {
            }
            column(RoundValue; RoundValue)
            {
            }
            column(PurchCrLine__Line_Amount_; PurchCrLine."Line Amount")
            {
            }
            column(Ship_To__; 'Ship To:')
            {
            }
            column(ShipToAddr_6__Control1000000076; ShipToAddr[6])
            {
            }
            column(ShippingAgent_Name; ShippingAgent.Name)
            {
            }
            column(Remarks______Comments_1__________Comments_2_; 'Remarks: ' + Comments[1] + ' ' + Comments[2])
            {
            }
            column(Taxable_AmountCaption; Taxable_AmountCaptionLbl)
            {
            }
            column(FreightCaption; FreightCaptionLbl)
            {
            }
            column(ForwardingCaption; ForwardingCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(TransportCaption; TransportCaptionLbl)
            {
            }
            column(Vehicle_NoCaption; Vehicle_NoCaptionLbl)
            {
            }
            column(Frt_BasisCaption; Frt_BasisCaptionLbl)
            {
            }
            column(Total_DutyCaption; Total_DutyCaptionLbl)
            {
            }
            column(Inv_ValueCaption; Inv_ValueCaptionLbl)
            {
            }
            column(RoundingCaption; RoundingCaptionLbl)
            {
            }
            column(Purch__Cr__Memo_Hdr__No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_1000000207; 1000000207)
                {
                }
                column(OutputNo; OutputNo)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));

                    column(ReportForNavId_1000000206; 1000000206)
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(Sales_Invoice_Header___Posting_Date_; Format("Purch. Cr. Memo Hdr."."Posting Date"))
                    {
                    }
                    column(Sales_Invoice_Header___No__; CopyStr("Purch. Cr. Memo Hdr."."No.", StrLen("Purch. Cr. Memo Hdr."."No.") - 4, 5))
                    {
                    }
                    column(FORMAT__Purch__Cr__Memo_Hdr____Date_Of_Removal_________FORMAT__Purch__Cr__Memo_Hdr____Time_Of_Removals__; Format("Purch. Cr. Memo Hdr."."Date Of Removal") + ' / ' + Format("Purch. Cr. Memo Hdr."."Time Of Removals"))
                    {
                    }
                    column(ExciseTarrifNos_1_________ExciseTarrifNos_2_; ExciseTarrifNos[1] + '/' + ExciseTarrifNos[2])
                    {
                    }
                    column(ReturnOrderNo; ReturnOrderNo)
                    {
                    }
                    column(Purch__Cr__Memo_Hdr____Ship_to_City_; "Purch. Cr. Memo Hdr."."Ship-to City")
                    {
                    }
                    column(PaymentTerms_Description_Control1000000009; PaymentTerms.Description)
                    {
                    }
                    column(Not_Applicable_; 'Not Applicable')
                    {
                    }
                    column(Vend_Contact; Vend.Contact)
                    {
                    }
                    column(Vend__Phone_No__; Vend."Phone No.")
                    {
                    }
                    // column(Vend__C_S_T__No__;Vend."C.S.T. No.")
                    // {
                    // }
                    column(BillToPANNo; BillTo."P.A.N. No.")
                    {
                    }
                    // column(BillTo__T_I_N__No__;BillTo."T.I.N. No.")
                    // {
                    // }
                    column(BillTo__E_C_C__No__; recVend."GST Registration No.")
                    {
                    }
                    column(Vend__Our_Account_No__; Vend."Our Account No.")
                    {
                    }
                    column(Purch__Cr__Memo_Hdr____Vendor_Cr__Memo_No__; "Purch. Cr. Memo Hdr."."Vendor Cr. Memo No.")
                    {
                    }
                    column(Purch__Cr__Memo_Hdr____Document_Date_; "Purch. Cr. Memo Hdr."."Document Date")
                    {
                    }
                    column(ExciseTarrifNos_3_________ExciseTarrifNos_4_; ExciseTarrifNos[3] + '/' + ExciseTarrifNos[4])
                    {
                    }
                    column(Invoice_No_Caption; Invoice_No_CaptionLbl)
                    {
                    }
                    column(Sales_Invoice_Header___Posting_Date_Caption; Sales_Invoice_Header___Posting_Date_CaptionLbl)
                    {
                    }
                    column(Removal_Date_TimeCaption; Removal_Date_TimeCaptionLbl)
                    {
                    }
                    column(Excise_Tarrif_No_Caption; Excise_Tarrif_No_CaptionLbl)
                    {
                    }
                    column(WO_No____DateCaption; WO_No____DateCaptionLbl)
                    {
                    }
                    column(DestinationCaption; DestinationCaptionLbl)
                    {
                    }
                    column(Payment_TermsCaption; Payment_TermsCaptionLbl)
                    {
                    }
                    column(Goods_insured_under_O_I_C_Marine_Cargo_Caption; Goods_insured_under_O_I_C_Marine_Cargo_CaptionLbl)
                    {
                    }
                    column(Insurance_Policy_No_Caption; Insurance_Policy_No_CaptionLbl)
                    {
                    }
                    column(CTC_Caption; CTC_CaptionLbl)
                    {
                    }
                    column(Phone_NoCaption; Phone_NoCaptionLbl)
                    {
                    }
                    column(ST_NoCaption; ST_NoCaptionLbl)
                    {
                    }
                    column(ECC_No_Caption; ECC_No_CaptionLbl)
                    {
                    }
                    column(P_O__No_Caption; P_O__No_CaptionLbl)
                    {
                    }
                    column(TIN_No_Caption; TIN_No_CaptionLbl)
                    {
                    }
                    column(V__CodeCaption; V__CodeCaptionLbl)
                    {
                    }
                    column(DateCaption; DateCaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(DimText; DimText)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purch. Cr. Memo Hdr.";
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                        column(ReportForNavId_1000000164; 1000000164)
                        {
                        }
                        column(DimensionLoop1_Number; DimensionLoop1.Number)
                        {
                        }
                        column(DimText_Control98; DimText)
                        {
                        }
                        column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            /* // BIS 1145
                                IF Number = 1 THEN BEGIN
                                  IF NOT PostedDocDim1.FIND('-') THEN
                                    CurrReport.BREAK;
                                END ELSE
                                  IF NOT Continue THEN
                                    CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                  OldDimText := DimText;
                                  IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                      '%1 %2',PostedDocDim1."Dimension Code",PostedDocDim1."Dimension Value Code")
                                  ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3',DimText,
                                        PostedDocDim1."Dimension Code",PostedDocDim1."Dimension Value Code");
                                  IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                  END;
                                UNTIL (PostedDocDim1.NEXT = 0);
                                */
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then CurrReport.Break;
                        end;
                    }
                    dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Purch. Cr. Memo Hdr.";
                        DataItemTableView = sorting("Document No.", "Line No.") where(Quantity = filter(<> 0));

                        column(ReportForNavId_1000000159; 1000000159)
                        {
                        }
                        column(PCL; 1)
                        {
                        }
                        column(Per_CGST; Per_CGST)
                        {
                        }
                        column(Per_SGST; Per_SGST)
                        {
                        }
                        column(Per_IGST; Per_IGST)
                        {
                        }
                        column(CGST_Amt; CGST_Amt)
                        {
                        }
                        column(IGST_Amt; IGST_Amt)
                        {
                        }
                        column(SGST_Amt; SGST_Amt)
                        {
                        }
                        // column(GrandTotal;"Purch. Cr. Memo Line"."Amount To Vendor"+PurchCrLine."Line Amount")
                        // {
                        // }
                        column(Sales_Invoice_Line__Line_Amount_; "Line Amount")
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(GSTText; GSTText1 + GSTText2 + ' ' + GSTText3)
                        {
                        }
                        column(Sales_Invoice_Line_Description; Description)
                        {
                        }
                        column(Sales_Invoice_Line__No__; SrNo)
                        {
                        }
                        column(Type_PurchCrMemoLine; "Purch. Cr. Memo Line".Type)
                        {
                        }
                        column(Sales_Invoice_Line_Description_Control65; "No." + '-' + Description)
                        {
                        }
                        column(Sales_Invoice_Line_Quantity; Quantity)
                        {
                        }
                        // column(CGSTAMT;"Total GST Amount")
                        // {
                        // }
                        column(Sales_Invoice_Line__Unit_of_Measure_; "Unit of Measure Code")
                        {
                        }
                        column(Sales_Invoice_Line__Unit_Price_; "Unit Cost")
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control70; "Line Amount")
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Purch__Cr__Memo_Line__Description_2_; "Description 2")
                        {
                        }
                        column(PackDesc_1_; PackDesc[1])
                        {
                        }
                        column(HSNSACCode_PurchCrMemoLine; "Purch. Cr. Memo Line"."HSN/SAC Code")
                        {
                        }
                        column(PackDesc_2_; PackDesc[2])
                        {
                        }
                        column(PackDescQty_1_; PackDescQty[1])
                        {
                        }
                        column(PackDescQty_2_; PackDescQty[2])
                        {
                        }
                        column(FORMAT_DespLine__Actual_Wt________KGS___; 'FORMAT(DespLine."Actual Wt")' + ' ( KGS )')
                        {
                        }
                        column(RecCrossReference__Cross_Reference_No__; RecCrossReference."Reference No.")
                        {
                        }
                        column(Ref_____FORMAT__Source_Document_Type__0_; 'Ref: ' + Format("Source Document Type", 0))
                        {
                        }
                        column(Sales_Invoice_Line__Source_Document_No__; "Source Document No.")
                        {
                        }
                        column(Supplementary; Supplementary)
                        {
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control86; "Line Amount")
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control99; "Line Amount")
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Hdr."."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Hdr."."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Hdr."."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Sales_Invoice_Line_Amount; Amount)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Hdr."."Currency Code";
                            AutoFormatType = 1;
                        }
                        // column(Sales_Invoice_Line__Amount_Including_VAT_;"Amount To Vendor")
                        // {
                        //     AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                        //     AutoFormatType = 1;
                        // }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Hdr."."Currency Code";
                            AutoFormatType = 1;
                        }
                        // column(Sales_Invoice_Line__Excise_Amount_;"Excise Amount")
                        // {
                        //     AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                        //     AutoFormatType = 1;
                        // }
                        // column(Sales_Invoice_Line__Tax_Amount_;"Tax Amount")
                        // {
                        //     AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                        //     AutoFormatType = 1;
                        // }
                        column(ServiceTaxAmt; ServiceTaxAmt)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ChargesAmount; ChargesAmount)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(OtherTaxesAmount; OtherTaxesAmount)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        // column(TotalGSTAmount_PurchCrMemoLine;"Purch. Cr. Memo Line"."Total GST Amount")
                        // {
                        // }
                        column(ServiceTaxECessAmt; ServiceTaxECessAmt)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Sales_Invoice_Line___Total_TDS_TCS_Incl__SHE_CESS_; TotalTCSAmount)
                        {
                        }
                        column(AppliedServiceTaxAmt; AppliedServiceTaxAmt)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxECessAmt; AppliedServiceTaxECessAmt)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ServiceTaxSHECessAmt; ServiceTaxSHECessAmt)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxSHECessAmt; AppliedServiceTaxSHECessAmt)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalTaxAmt; TotalTaxAmt)
                        {
                        }
                        column(TotalExciseAmt; TotalExciseAmt)
                        {
                        }
                        column(Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Hdr."."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Header___VAT_Base_Discount___; "Purch. Cr. Memo Hdr."."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscountOnVAT; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control60; TotalInclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText_Control61; VATAmountLine.VATAmountText)
                        {
                        }
                        column(Amount_Including_VAT____Amount_Control62; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line_Amount_Control63; Amount)
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Amount_Including_VAT__Control71; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Purch. Cr. Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control72; TotalExclVATText)
                        {
                        }
                        column(TotalAmountVAT; TotalAmountVAT)
                        {
                        }
                        column(Sales_Invoice_Line__No__Caption; Sales_Invoice_Line__No__CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line_Description_Control65Caption; Sales_Invoice_Line_Description_Control65CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line_QuantityCaption; Sales_Invoice_Line_QuantityCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(No___Description_of_PackagesCaption; No___Description_of_PackagesCaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control85; ContinuedCaption_Control85Lbl)
                        {
                        }
                        column(Inv__Discount_Amount_Caption; Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line__Excise_Amount_Caption; Sales_Invoice_Line__Excise_Amount_CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line__Tax_Amount_Caption; Sales_Invoice_Line__Tax_Amount_CaptionLbl)
                        {
                        }
                        column(Service_Tax_AmountCaption; Service_Tax_AmountCaptionLbl)
                        {
                        }
                        column(ChargesAmountCaption; ChargesAmountCaptionLbl)
                        {
                        }
                        column(OtherTaxesAmountCaption; OtherTaxesAmountCaptionLbl)
                        {
                        }
                        column(Service_Tax_eCess_AmountCaption; Service_Tax_eCess_AmountCaptionLbl)
                        {
                        }
                        column(TCS_AmountCaption; TCS_AmountCaptionLbl)
                        {
                        }
                        column(Svc_Tax_Amt__Applied_Caption; Svc_Tax_Amt__Applied_CaptionLbl)
                        {
                        }
                        column(Svc_Tax_eCess_Amt__Applied_Caption; Svc_Tax_eCess_Amt__Applied_CaptionLbl)
                        {
                        }
                        column(Service_Tax_SHE_Cess_AmountCaption; Service_Tax_SHE_Cess_AmountCaptionLbl)
                        {
                        }
                        column(Svc_Tax_SHECess_Amt_Applied_Caption; Svc_Tax_SHECess_Amt_Applied_CaptionLbl)
                        {
                        }
                        column(Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__Caption; Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__CaptionLbl)
                        {
                        }
                        column(Purch__Cr__Memo_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Purch__Cr__Memo_Line_Line_No_; "Line No.")
                        {
                        }
                        trigger OnAfterGetRecord()
                        var
                        // StructureLineDetails: Record UnknownRecord13798;
                        begin
                            Per_CGST := 0;
                            CGST_Amt := 0;
                            Per_SGST := 0;
                            SGST_Amt := 0;
                            Per_IGST := 0;
                            IGST_Amt := 0;
                            DetailedGSTLedgerEntry1.Reset();
                            DetailedGSTLedgerEntry1.SetRange("Transaction Type", DetailedGSTLedgerEntry1."Transaction Type"::Purchase);
                            DetailedGSTLedgerEntry1.SetRange("Document Type", DetailedGSTLedgerEntry1."Document Type"::"Credit Memo");
                            DetailedGSTLedgerEntry1.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
                            DetailedGSTLedgerEntry1.SetRange("Document Line No.", "Line No.");
                            // DetailedGSTLedgerEntry1.SetFilter(DetailedGSTLedgerEntry1."Payment Type", '<>%1', DetailedGSTLedgerEntry1."Payment Type"::Advance);
                            if DetailedGSTLedgerEntry1.FindSet() then
                                repeat
                                    if DetailedGSTLedgerEntry1."GST Component Code" = 'IGST' then begin
                                        Per_IGST := DetailedGSTLedgerEntry1."GST %";
                                        IGST_Amt := Abs(DetailedGSTLedgerEntry1."GST Amount");
                                        GSTText1 := 'IGST ' + FORMAT(Per_IGST) + '% Rs.' + Format(IGST_Amt);
                                    end;
                                    if DetailedGSTLedgerEntry1."GST Component Code" = 'CGST' then begin
                                        Per_CGST := DetailedGSTLedgerEntry1."GST %";
                                        CGST_Amt := abs(DetailedGSTLedgerEntry1."GST Amount");
                                        GSTText2 := 'CGST ' + FORMAT(Per_CGST) + '% Rs.' + Format(CGST_Amt);
                                    end;
                                    if DetailedGSTLedgerEntry1."GST Component Code" = 'SGST' then begin
                                        Per_SGST := DetailedGSTLedgerEntry1."GST %";
                                        SGST_Amt := abs(DetailedGSTLedgerEntry1."GST Amount");
                                        GSTText3 := 'SGST ' + FORMAT(Per_SGST) + '% Rs.' + Format(SGST_Amt);
                                    end;
                                until DetailedGSTLedgerEntry1.Next() = 0;
                            XX := XX - 1;
                            if "System-Created Entry" then CurrReport.Skip;
                            SrNo += 1;
                            PostedShipmentDate := 0D;
                            if Quantity <> 0 then PostedShipmentDate := FindPostedShipmentDate;
                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then "No." := '';
                            //>>Alle VPB
                            Clear(PackDesc);
                            Clear(PackDescQty);
                            // ALLE1.01 Sk Start
                            // GSTText := '';
                            // if "Purch. Cr. Memo Line"."GST Jurisdiction Type" = "Purch. Cr. Memo Line"."gst jurisdiction type"::Intrastate then begin
                            //     DetailedGSTLedgerEntry.Reset;
                            //     DetailedGSTLedgerEntry.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
                            //     DetailedGSTLedgerEntry.SetRange("Document Type", DetailedGSTLedgerEntry."document type"::Invoice);
                            //     DetailedGSTLedgerEntry.SetRange(DetailedGSTLedgerEntry."No.", "No.");
                            //     DetailedGSTLedgerEntry.SetFilter(DetailedGSTLedgerEntry."GST Component Code", '%1|%2', 'SGST', 'CGST');
                            //     if DetailedGSTLedgerEntry.FindSet then
                            //         repeat
                            //             if GSTText = '' then
                            //                 GSTText := DetailedGSTLedgerEntry."GST Component Code" + Format(ROUND(DetailedGSTLedgerEntry."GST %", 0.1, '=')) + '%  ' + ' Rs. ' + Format(Abs(DetailedGSTLedgerEntry."GST Amount"))
                            //             else
                            //                 GSTText := GSTText + '    ' + DetailedGSTLedgerEntry."GST Component Code" + Format(ROUND(DetailedGSTLedgerEntry."GST %", 0.1, '=')) + '%  ' + ' Rs. ' + Format(Abs(DetailedGSTLedgerEntry."GST Amount"));
                            //         until DetailedGSTLedgerEntry.Next = 0;
                            // end else begin
                            //     if GSTGroup.Get("Purch. Cr. Memo Line"."GST Group Code") then
                            //         GSTText := 'I' + GSTGroup.Description + ' Rs. ' + Format("Total GST Amount");
                            // end;
                            // TotalGstAMount := TotalGstAMount + "Total GST Amount";
                            Check.InitTextVariable();
                            //Check.FormatNoText(NoInText,"Sales Invoice Line"."Excise Amount",'');
                            Check.FormatNoText(TotalGstAMountintext, TotalGstAMount, ''); //Alle[Z]- Added-01-06-2015
                            //message('%1',TotalGstAMountintext[1]);
                            // ALLE1.01 Sk Start
                            if not "System-Created Entry" then begin
                                BED1 := 'CENVAT ' + Format(0) + ' %';
                                Ecess := 'Edu Cess ' + Format(0) + ' %';
                                SHE := 'Hr. Cess ' + Format(0) + ' %';
                            end;
                            // ExciseSetup.Reset;
                            // ExciseSetup.SetCurrentkey("Excise Bus. Posting Group", "Excise Prod. Posting Group", "From Date", SSI);
                            // ExciseSetup.SetRange("Excise Bus. Posting Group", "Excise Bus. Posting Group");
                            // ExciseSetup.SetRange("Excise Prod. Posting Group", "Excise Prod. Posting Group");
                            // ExciseSetup.SetFilter("From Date", '<=%1', "Posting Date");
                            // if ExciseSetup.FindLast then begin
                            //     BED1 := 'CENVAT ' + Format(ExciseSetup."BED %") + ' %';
                            //     Ecess := 'Edu Cess ' + Format(ExciseSetup."eCess %") + ' %';
                            //     SHE := 'Hr. Cess ' + Format(ExciseSetup."SHE Cess %") + ' %';
                            // end;
                            // VATAmountLine.Init;
                            // VATAmountLine."VAT Identifier" := "VAT Identifier";
                            // VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            // VATAmountLine."Tax Group Code" := "Tax Group Code";
                            // VATAmountLine."VAT %" := "VAT %";
                            // VATAmountLine."VAT Base" := Amount;
                            // VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            // VATAmountLine."Line Amount" := "Line Amount";
                            // if "Allow Invoice Disc." then
                            //     VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            // VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            // VATAmountLine.InsertLine;
                            // //TotalTCSAmount += "Total TDS/TCS Incl. SHE CESS";
                            // if ISSERVICETIER then begin
                            //     TotalSubTotal += "Line Amount";
                            //     TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            //     TotalAmount += Amount;
                            //     TotalAmountVAT += "Amount Including VAT" - Amount;
                            //     // TotalAmountInclVAT += "Amount Including VAT";
                            //     TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                            //     TotalAmountInclVAT += "Amount To Vendor";
                            //     TotalExciseAmt += "Excise Amount";
                            //     TotalTaxAmt += "Tax Amount";
                            //     ServiceTaxAmount += "Service Tax Amount";
                            //     ServiceTaxeCessAmount += "Service Tax eCess Amount";
                            //     ServiceTaxSHECessAmount += "Service Tax SHE Cess Amount";
                            // end;
                            // StructureLineDetails.Reset;
                            // StructureLineDetails.SetRange(Type, StructureLineDetails.Type::Sale);
                            // StructureLineDetails.SetRange("Document Type", StructureLineDetails."document type"::Invoice);
                            // StructureLineDetails.SetRange("Invoice No.", "Document No.");
                            // StructureLineDetails.SetRange("Item No.", "No.");
                            // StructureLineDetails.SetRange("Line No.", "Line No.");
                            // if StructureLineDetails.Find('-') then
                            //     repeat
                            //         if not StructureLineDetails."Payable to Third Party" then begin
                            //             if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::Charges then
                            //                 ChargesAmount := ChargesAmount + Abs(StructureLineDetails.Amount);
                            //             if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::"Other Taxes" then
                            //                 OtherTaxesAmount := OtherTaxesAmount + Abs(StructureLineDetails.Amount);
                            //         end;
                            //     until StructureLineDetails.Next = 0;
                            /*
                            IF ISSERVICETIER THEN BEGIN
                            IF "Sales Invoice Header"."Transaction No. Serv. Tax" <> 0 THEN BEGIN
                              ServiceTaxEntry.RESET;
                              ServiceTaxEntry.SETRANGE(Type,ServiceTaxEntry.Type::Sale);
                              ServiceTaxEntry.SETRANGE("Document Type",ServiceTaxEntry."Document Type"::Invoice);
                              ServiceTaxEntry.SETRANGE("Document No.","Document No.");
                              IF ServiceTaxEntry.FINDFIRST THEN BEGIN
                            
                                IF "Sales Invoice Header"."Currency Code" <> '' THEN BEGIN
                                 ServiceTaxEntry."Service Tax Amount" :=
                                   ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                                     "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                                     ServiceTaxEntry."Service Tax Amount","Sales Invoice Header"."Currency Factor"));
                                 ServiceTaxEntry."eCess Amount" :=
                                   ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                                     "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                                     ServiceTaxEntry."eCess Amount","Sales Invoice Header"."Currency Factor"));
                                 ServiceTaxEntry."SHE Cess Amount" :=
                                   ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                                     "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                                     ServiceTaxEntry."SHE Cess Amount","Sales Invoice Header"."Currency Factor"));
                                END;
                            
                            
                                ServiceTaxAmt := ABS(ServiceTaxEntry."Service Tax Amount");
                                ServiceTaxECessAmt := ABS(ServiceTaxEntry."eCess Amount");
                                ServiceTaxSHECessAmt := ABS(ServiceTaxEntry."SHE Cess Amount");
                                AppliedServiceTaxAmt := ServiceTaxAmount - ABS(ServiceTaxEntry."Service Tax Amount");
                                AppliedServiceTaxECessAmt := ServiceTaxeCessAmount - ABS(ServiceTaxEntry."eCess Amount");
                                AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount - ABS(ServiceTaxEntry."SHE Cess Amount");
                              END ELSE BEGIN
                                AppliedServiceTaxAmt := ServiceTaxAmount;
                                AppliedServiceTaxECessAmt := ServiceTaxeCessAmount;
                                AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
                              END;
                            END ELSE BEGIN
                              ServiceTaxAmt := ServiceTaxAmount;
                              ServiceTaxECessAmt := ServiceTaxeCessAmount;
                              ServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
                            END;
                            END;
                            */
                            //>>Alle VPB
                            RecCrossReference.Init;
                            if Type = Type::Item then begin
                                RecCrossReference.Reset;
                                RecCrossReference.SetRange("Item No.", "No.");
                                RecCrossReference.SetRange("Reference Type", RecCrossReference."Reference Type"::Vendor);
                                RecCrossReference.SetRange(RecCrossReference."Reference Type No.", "Buy-from Vendor No.");
                                if not RecCrossReference.FindFirst then RecCrossReference."Reference No." := '';
                            end;
                            //<<Alle VPB
                            if "System-Created Entry" then begin
                                SrNo := 0;
                                "Unit Cost" := 0;
                                Quantity := 0;
                            end;
                            // GTotal += "Purch. Cr. Memo Line"."Amount To Vendor" + PurchCrLine."Line Amount" + RoundValue;
                            // Check.InitTextVariable();
                            // Check.FormatNoText(NoInText, "Purch. Cr. Memo Line"."Excise Amount", '');
                            // Check.FormatNoText(ExInText, GTotal, '');
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DeleteAll;
                            SalesShipmentBuffer.Reset;
                            SalesShipmentBuffer.DeleteAll;
                            FirstValueEntryNo := 0;
                            MoreLines := Find('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do MoreLines := Next(-1) <> 0;
                            if not MoreLines then CurrReport.Break;
                            SetRange("Line No.", 0, "Line No.");
                            // CurrReport.CreateTotals("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount", "Excise Amount", "Tax Amount",
                            //   "Service Tax Amount", "Service Tax eCess Amount", "Amount To Vendor");
                            // CurrReport.CreateTotals("Service Tax SHE Cess Amount");//,DespLine."Actual Wt");
                            SrNo := 0;
                            GTotal := 0;
                            XX := 10;
                            TotalGstAMount := 0;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := Text003;
                        // if ISSERVICETIER then
                        OutputNo += 1;
                    end;
                    CurrReport.PageNo := 1;
                    if ISSERVICETIER then begin
                        TotalSubTotal := 0;
                        TotalInvoiceDiscountAmount := 0;
                        TotalAmount := 0;
                        TotalAmountVAT := 0;
                        TotalAmountInclVAT := 0;
                        TotalPaymentDiscountOnVAT := 0;
                        TotalExciseAmt := 0;
                        TotalTaxAmt := 0;
                        ServiceTaxAmount := 0;
                        ServiceTaxeCessAmount := 0;
                        ServiceTaxSHECessAmount := 0;
                    end;
                    OtherTaxesAmount := 0;
                    ChargesAmount := 0;
                    AppliedServiceTaxSHECessAmt := 0;
                    AppliedServiceTaxECessAmt := 0;
                    AppliedServiceTaxAmt := 0;
                    ServiceTaxSHECessAmt := 0;
                    ServiceTaxECessAmt := 0;
                    ServiceTaxAmt := 0;
                    TotalTCSAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    //IF NOT CurrReport.PREVIEW THEN
                    //  SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 5;
                    IF NoOfLoops <= 0 THEN NoOfLoops := 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    //NoOfLoops := ABS(NoOfCopies) + vend."Invoice Copies" + 1;
                    //IF NoOfLoops <= 0 THEN
                    // NoOfLoops := 5;
                    //CopyText := '';
                    // SetRange(Number, 1, NoOfLoops);
                    if ISSERVICETIER then OutputNo := 1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                PurchCrLine: Record "Purch. Cr. Memo Line";
                StateRec: Record State;
                ExcTarrifCounter: Integer;
                vendLocal: Record Vendor;
                ReturnShptHeaderL: Record "Return Shipment Header";
            begin
                if LanguageCode.Get("Language Code") then CurrReport.Language := LanguageCode."Windows Language ID";
                if BillTo.Get("Purch. Cr. Memo Hdr."."Pay-to Vendor No.") then;
                if recVend.Get("Purch. Cr. Memo Hdr."."Buy-from Vendor No.") then;
                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end
                else begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                end;
                PCML.Reset;
                PCML.SetRange("Document No.", "No.");
                PCML.SetRange(Type, PCML.Type::Item);
                if PCML.FindLast then begin
                    if PCML."GST Jurisdiction Type" = PCML."gst jurisdiction type"::Intrastate then
                        bool := false
                    else
                        bool := true;
                end;
                if "Purchaser Code" = '' then begin
                    SalesPurchPerson.Init;
                    SalesPersonText := '';
                end
                else begin
                    SalesPurchPerson.Get("Purchaser Code");
                    SalesPersonText := Text000;
                end;
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FieldCaption("Your Reference");
                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FieldCaption("VAT Registration No.");
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(Text13700, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(Text13701, GLSetup."LCY Code");
                end
                else begin
                    TotalText := StrSubstNo(Text001, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text13700, "Currency Code");
                    TotalExclVATText := StrSubstNo(Text13701, "Currency Code");
                end;
                //FormatAddr.SalesInvBillToNew(CustAddr,"Sales Invoice Header");
                FormatAddr.PurchCrMemoPayTo(CustAddr, "Purch. Cr. Memo Hdr.");
                //>> Alle VPB
                Clear(CustAddr);
                if not StateRec.Get("Purch. Cr. Memo Hdr."."Location State Code") then StateRec.Init;
                CustAddr[1] := "Purch. Cr. Memo Hdr."."Pay-to Name";
                CustAddr[2] := "Purch. Cr. Memo Hdr."."Pay-to Address";
                CustAddr[3] := "Purch. Cr. Memo Hdr."."Pay-to Address 2";
                CustAddr[4] := "Purch. Cr. Memo Hdr."."Pay-to City" + ', ' + StateRec.Description + ', ' + "Purch. Cr. Memo Hdr."."Pay-to Post Code";
                //<<Alle VPB
                if not Vend.Get("Pay-to Vendor No.") then Clear(Vend);
                if "Payment Terms Code" = '' then
                    PaymentTerms.Init
                else begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init
                else begin
                    ShipmentMethod.Get("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;
                //FormatAddr.SalesInvShipToNew(ShipToAddr,"Sales Invoice Header");
                FormatAddr.PurchCrMemoShipTo(ShipToAddr, "Purch. Cr. Memo Hdr.");
                ShowShippingAddr := "Buy-from Vendor No." <> "Pay-to Vendor No.";
                for i := 1 to ArrayLen(ShipToAddr) do if ShipToAddr[i] <> CustAddr[i] then ShowShippingAddr := true;
                //>> Alle VPB
                Clear(ShipToAddr);
                vendLocal.Get("Buy-from Vendor No.");
                if "Buy-from Vendor No." <> "Pay-to Vendor No." then begin
                    if not StateRec.Get("Purch. Cr. Memo Hdr."."Location State Code") then StateRec.Init;
                    ShipToAddr[1] := "Purch. Cr. Memo Hdr."."Ship-to Name";
                    ShipToAddr[2] := "Purch. Cr. Memo Hdr."."Ship-to Address";
                    ShipToAddr[3] := "Purch. Cr. Memo Hdr."."Ship-to Address 2";
                    ShipToAddr[4] := "Purch. Cr. Memo Hdr."."Ship-to City" + ', ' + StateRec.Description + ', ' + "Purch. Cr. Memo Hdr."."Ship-to Post Code";
                    // ShipToAddr[5] := 'CST No.: ' + vendLocal."C.S.T. No.";
                    // ShipToAddr[6] := 'ECC No.: ' + vendLocal."E.C.C. No.";
                end
                else
                    ShipToAddr[1] := 'SAME AS CONSIGNEE';
                //<<Alle VPB
                SupplementaryText := '';
                PurchCrLine.SetRange("Document No.", "No.");
                PurchCrLine.SetRange(Supplementary, true);
                if PurchCrLine.Find('-') then SupplementaryText := Text16500;
                if PaymentTerms.Get("Payment Terms Code") then;
                // PSOLDet.Reset;
                // PSOLDet.SetCurrentkey(Type, "Calculation Order", "Document Type", "Invoice No.",
                //                       "Item No.", "Line No.", "Tax/Charge Type", "Tax/Charge Group", "Tax/Charge Code");
                // PSOLDet.SetRange(Type, PSOLDet.Type::Sale);
                // PSOLDet.SetRange("Document Type", PSOLDet."document type"::Invoice);
                // PSOLDet.SetRange("Invoice No.", "No.");
                // PSOLDet.SetRange("Tax/Charge Type", PSOLDet."tax/charge type"::Charges);
                // PSOLDet.SetFilter("Tax/Charge Group", '%1', 'FREIGHT');
                // if PSOLDet.FindFirst then
                //     FreightAmt := 0;
                // repeat
                //     FreightAmt += PSOLDet.Amount;
                // until PSOLDet.Next = 0;
                // PSOLDet1.Reset;
                // PSOLDet1.SetCurrentkey(Type, "Calculation Order", "Document Type", "Invoice No.",
                //                       "Item No.", "Line No.", "Tax/Charge Type", "Tax/Charge Group", "Tax/Charge Code");
                // PSOLDet1.SetRange(Type, PSOLDet1.Type::Sale);
                // PSOLDet1.SetRange("Document Type", PSOLDet1."document type"::Invoice);
                // PSOLDet1.SetRange("Invoice No.", "No.");
                // PSOLDet1.SetRange("Tax/Charge Type", PSOLDet1."tax/charge type"::Charges);
                // PSOLDet1.SetFilter("Tax/Charge Group", '%1', 'FORWARDING');
                // if PSOLDet1.FindFirst then
                //     ForAmt := 0;
                // repeat
                //     ForAmt += PSOLDet1.Amount;
                // until PSOLDet1.Next = 0;
                // //>>Alle VPB
                // ReturnOrderNo := '';
                // Clear(ExciseTarrifNos);
                // ExcTarrifCounter := 1;
                // PurchCrLine.Reset;
                // PurchCrLine.SetRange("Document No.", "No.");
                // PurchCrLine.SetRange(Type, PurchCrLine.Type::Item);
                // if PurchCrLine.Find('-') then
                //     repeat
                //         if PurchCrLine."Ret. Shipment No." <> '' then
                //             if ReturnShptHeaderL.Get(PurchCrLine."Ret. Shipment No.") then
                //                 if ReturnShptHeaderL."Return Order No." <> '' then
                //                     ReturnOrderNo := CopyStr(ReturnShptHeaderL."Return Order No.",
                //                                              StrLen(ReturnShptHeaderL."Return Order No.") - 4, 5)
                //                                      + ' / ' + Format(ReturnShptHeaderL."Posting Date");
                //         ExciseTarrifNos[ExcTarrifCounter] := PurchCrLine."Excise Prod. Posting Group";
                //         ExcTarrifCounter += 1;
                //     until PurchCrLine.Next = 0;
                // TotalPack := 0;
                // TotalWeight := 0;
                // //<<Alle VPB
                // if "Tax Area Code" <> '' then
                //     TaxText := "Tax Area Code";
                // if "Form Code" <> '' then
                //     TaxText := TaxText + ' (Form ' + "Form Code" + ')';
                // RoundValue := 0;
                // PurchCrLine.Reset;
                // PurchCrLine.SetRange("Document No.", "No.");
                // PurchCrLine.SetRange(Type, PurchCrLine.Type::Item);
                // if PurchCrLine.FindFirst then
                //     if PurchCrLine."Tax %" <> 0 then
                //         TaxText := TaxText + ' ' + Format(PurchCrLine."Tax %") + '%';
                PurchCrLine.Reset;
                PurchCrLine.SetRange("Document No.", "No.");
                PurchCrLine.SetRange("System-Created Entry", true);
                if not PurchCrLine.FindFirst then PurchCrLine.Init;
                RoundValue := PurchCrLine."Line Amount";
                PurchCommentLine.Reset;
                PurchCommentLine.SetRange("Document Type", PurchCommentLine."document type"::"Posted Credit Memo");
                PurchCommentLine.SetRange("No.", "No.");
                PurchCommentLine.SetRange("Document Line No.", 0);
                if PurchCommentLine.Find('-') then Comments[1] += PurchCommentLine.Comment;
                if PurchCommentLine.Next <> 0 then Comments[2] := PurchCommentLine.Comment;
                if not ShipmentMethod.Get("Shipment Method Code") then ShipmentMethod.Init;
                //CORP::PK 200819 >>
                QRCodeMgt.BarcodeForCrMemo("Purch. Cr. Memo Hdr."."No.", "Purch. Cr. Memo Hdr."."Posting Date", "Purch. Cr. Memo Hdr."."Vendor Cr. Memo No.", "Purch. Cr. Memo Hdr."."Buy-from Vendor Name");
                QRCodeStr.FindFirst;
                QRCodeStr.CalcFields(QRCode);
                //CORP::PK 200819 <<<
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
        GLSetup.Get;
        CompanyInfo.Get;
        PurchSetup.Get;
    end;

    var
        GSTText1: Text;
        GSTText2: Text;
        GSTText3: Text;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        PurchSetup: Record "Purchases & Payables Setup";
        Vend: Record Vendor;
        VATAmountLine: Record "VAT Amount Line" temporary;
        RespCenter: Record "Responsibility Center";
        // Language: Record Language; //IG_DS_before
        LanguageCode: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[150];
        ShipToAddr: array[8] of Text[150];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[80];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        CalculatedExchRate: Decimal;
        OutputNo: Integer;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        ChargesAmount: Decimal;
        OtherTaxesAmount: Decimal;
        SupplementaryText: Text[30];
        // ServiceTaxEntry: Record UnknownRecord16473;
        ServiceTaxAmt: Decimal;
        ServiceTaxECessAmt: Decimal;
        AppliedServiceTaxAmt: Decimal;
        AppliedServiceTaxECessAmt: Decimal;
        ServiceTaxSHECessAmt: Decimal;
        AppliedServiceTaxSHECessAmt: Decimal;
        TotalTaxAmt: Decimal;
        TotalExciseAmt: Decimal;
        TotalTCSAmount: Decimal;
        ServiceTaxAmount: Decimal;
        ServiceTaxeCessAmount: Decimal;
        ServiceTaxSHECessAmount: Decimal;
        LogInteractionEnable: Boolean;
        BillTo: Record Vendor;
        // PSOLDet: Record UnknownRecord13798;
        // PSOLDet1: Record UnknownRecord13798;
        FreightAmt: Decimal;
        ForAmt: Decimal;
        Check: Report Check;
        NoInText: array[2] of Text[250];
        ExInText: array[2] of Text[250];
        SrNo: Integer;
        DespLine: Record "Purchase Header";
        // ExciseSetup: Record UnknownRecord13711;
        BED1: Text[100];
        Ecess: Text[100];
        SHE: Text[100];
        PurchCrLine: Record "Purch. Cr. Memo Line";
        TaxText: Text[100];
        SalesScheduleBuffer: Record "SSD Sales Schedule Buffer";
        PackDesc: array[100] of Text[100];
        PackDescQty: array[100] of Text[100];
        PackCounter: Integer;
        TotalPack: Integer;
        TotalWeight: Decimal;
        ExciseTarrifNos: array[10] of Text[30];
        RecCrossReference: Record "Item Reference";
        Comments: array[2] of Text[150];
        PurchCommentLine: Record "Purch. Comment Line";
        ShippingAgent: Record "Shipping Agent";
        PackingSlipNo: Text[100];
        ReturnOrderNo: Text[100];
        Text000: label 'Salesperson';
        Text001: label 'Total %1';
        Text002: label 'Total %1 Incl. VAT';
        Text003: label 'COPY';
        Text004: label 'Sales - Invoice %1';
        Text005: label 'Page %1';
        Text006: label 'Total %1 Excl. VAT';
        Text007: label 'VAT Amount Specification in ';
        Text008: label 'Local Currency';
        Text009: label 'Exchange rate: %1/%2';
        Text010: label 'Sales - Prepayment Invoice %1';
        Text13700: label 'Total %1 Incl. Taxes';
        Text13701: label 'Total %1 Excl. Taxes';
        Text16500: label 'Supplementary Invoice';
        Taxable_AmountCaptionLbl: label 'Taxable Amount';
        FreightCaptionLbl: label 'Freight';
        ForwardingCaptionLbl: label 'Forwarding';
        Grand_TotalCaptionLbl: label 'Grand Total';
        TransportCaptionLbl: label 'Transport';
        Vehicle_NoCaptionLbl: label 'Vehicle No';
        Frt_BasisCaptionLbl: label 'Frt Basis';
        Total_DutyCaptionLbl: label 'Total Duty';
        Inv_ValueCaptionLbl: label 'Inv Value';
        RoundingCaptionLbl: label 'Rounding';
        Invoice_No_CaptionLbl: label 'Invoice No.';
        Sales_Invoice_Header___Posting_Date_CaptionLbl: label 'Date';
        Removal_Date_TimeCaptionLbl: label 'Removal Date/Time';
        Excise_Tarrif_No_CaptionLbl: label 'Excise Tarrif No.';
        WO_No____DateCaptionLbl: label 'WO No. / Date';
        DestinationCaptionLbl: label 'Destination';
        Payment_TermsCaptionLbl: label 'Payment Terms';
        Goods_insured_under_O_I_C_Marine_Cargo_CaptionLbl: label 'Goods insured under O.I.C Marine(Cargo)';
        Insurance_Policy_No_CaptionLbl: label 'Insurance Policy No.';
        CTC_CaptionLbl: label 'CTC:';
        Phone_NoCaptionLbl: label 'Phone No';
        ST_NoCaptionLbl: label 'ST No';
        ECC_No_CaptionLbl: label 'ECC No.';
        P_O__No_CaptionLbl: label 'P.O. No.';
        TIN_No_CaptionLbl: label 'TIN No.';
        V__CodeCaptionLbl: label 'V. Code';
        DateCaptionLbl: label 'Date';
        Header_DimensionsCaptionLbl: label 'Header Dimensions';
        Sales_Invoice_Line__No__CaptionLbl: label 'Sr. No.';
        Sales_Invoice_Line_Description_Control65CaptionLbl: label 'Description of Goods';
        Sales_Invoice_Line_QuantityCaptionLbl: label 'Total Qty';
        Unit_PriceCaptionLbl: label 'Unit Price';
        AmountCaptionLbl: label 'Amount';
        No___Description_of_PackagesCaptionLbl: label 'No & Description of Packages';
        ContinuedCaptionLbl: label 'Continued';
        ContinuedCaption_Control85Lbl: label 'Continued';
        Inv__Discount_Amount_CaptionLbl: label 'Inv. Discount Amount';
        SubtotalCaptionLbl: label 'Subtotal';
        Sales_Invoice_Line__Excise_Amount_CaptionLbl: label 'Excise Amount';
        Sales_Invoice_Line__Tax_Amount_CaptionLbl: label 'Tax Amount';
        Service_Tax_AmountCaptionLbl: label 'Service Tax Amount';
        ChargesAmountCaptionLbl: label 'Charges Amount';
        OtherTaxesAmountCaptionLbl: label 'Other Taxes Amount';
        Service_Tax_eCess_AmountCaptionLbl: label 'Service Tax eCess Amount';
        TCS_AmountCaptionLbl: label 'TCS Amount';
        Svc_Tax_Amt__Applied_CaptionLbl: label 'Svc Tax Amt (Applied)';
        Svc_Tax_eCess_Amt__Applied_CaptionLbl: label 'Svc Tax eCess Amt (Applied)';
        Service_Tax_SHE_Cess_AmountCaptionLbl: label 'Service Tax SHE Cess Amount';
        Svc_Tax_SHECess_Amt_Applied_CaptionLbl: label 'Svc Tax SHECess Amt(Applied)';
        Line_Amount_____Inv__Discount_Amount_____Amount_Including_VAT__CaptionLbl: label 'Payment Discount on VAT';
        ShipmentCaptionLbl: label 'Shipment';
        Line_DimensionsCaptionLbl: label 'Line Dimensions';
        VATAmountLine__VAT___CaptionLbl: label 'VAT %';
        VATAmountLine__VAT_Base__Control108CaptionLbl: label 'VAT Base';
        VATAmountLine__VAT_Amount__Control109CaptionLbl: label 'VAT Amount';
        VAT_Amount_SpecificationCaptionLbl: label 'VAT Amount Specification';
        VATAmountLine__VAT_Identifier_CaptionLbl: label 'VAT Identifier';
        VATAmountLine__Inv__Disc__Base_Amount__Control141CaptionLbl: label 'Inv. Disc. Base Amount';
        VATAmountLine__Line_Amount__Control140CaptionLbl: label 'Line Amount';
        VATAmountLine__Invoice_Discount_Amount__Control142CaptionLbl: label 'Invoice Discount Amount';
        VATAmountLine__VAT_Base_CaptionLbl: label 'Continued';
        VATAmountLine__VAT_Base__Control112CaptionLbl: label 'Continued';
        VATAmountLine__VAT_Base__Control116CaptionLbl: label 'Total';
        VATAmountLine__VAT____Control164CaptionLbl: label 'VAT %';
        VATAmountLine__VAT_Identifier__Control165CaptionLbl: label 'VAT Identifier';
        VALVATBaseLCY_Control169CaptionLbl: label 'VAT Base';
        VALVATAmountLCY_Control170CaptionLbl: label 'VAT Amount';
        VALVATBaseLCYCaptionLbl: label 'Continued';
        VALVATBaseLCY_Control175CaptionLbl: label 'Continued';
        VALVATBaseLCY_Control180CaptionLbl: label 'Total';
        PaymentTerms_DescriptionCaptionLbl: label 'Payment Terms';
        ShipmentMethod_DescriptionCaptionLbl: label 'Shipment Method';
        Ship_to_AddressCaptionLbl: label 'Ship-to Address';
        GTotal: Decimal;
        CountInt: label 'CountIntLoop';
        XX: Integer;
        RoundValue: Decimal;
        LineCount_Num: label 'LineCount_Number';
        recVend: Record Vendor;
        recItem: Record Item;
        GSTGroup: Record "GST Group";
        // GSTText: Text;
        GSTSetup: Record "GST Setup";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CGSTAMT: Decimal;
        bool: Boolean;
        TotalGstAMount: Decimal;
        TotalGstAMountintext: array[5] of Text[250];
        PCML: Record "Purch. Cr. Memo Line";
        "-----------CS-------------": Integer;
        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        SGST_Amt: Decimal;
        IGST_Amt: Decimal;
        CGST_Amt: Decimal;
        Per_IGST: Decimal;
        Per_CGST: Decimal;
        Per_SGST: Decimal;
        QRCodeMgt: Codeunit "QR Code Mgt.";
        QRCodeStr: Record "SSD QR Code Str";

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(4) <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        /*
            NextEntryNo := 1;
            IF "Sales Invoice Line"."Shipment No." <> '' THEN
              IF SalesShipmentHeader.GET("Sales Invoice Line"."Shipment No.") THEN
                EXIT(SalesShipmentHeader."Posting Date");

            IF "Sales Invoice Header"."Order No."='' THEN
              EXIT("Sales Invoice Header"."Posting Date");

            CASE "Sales Invoice Line".Type OF
              "Sales Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Invoice Line");
              "Sales Invoice Line".Type::"G/L Account","Sales Invoice Line".Type::Resource,
              "Sales Invoice Line".Type::"Charge (Item)","Sales Invoice Line".Type::"Fixed Asset":
                 GenerateBufferFromShipment("Sales Invoice Line");
              "Sales Invoice Line".Type::" ":
                  EXIT(0D);
            END;

            SalesShipmentBuffer.RESET;
            SalesShipmentBuffer.SETRANGE("Document No.","Sales Invoice Line"."Document No.");
            SalesShipmentBuffer.SETRANGE("Line No." ,"Sales Invoice Line"."Line No.");
            IF SalesShipmentBuffer.FIND('-') THEN BEGIN
              SalesShipmentBuffer2 := SalesShipmentBuffer;
                IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
                  SalesShipmentBuffer.GET(
                    SalesShipmentBuffer2."Document No.",SalesShipmentBuffer2."Line No.",SalesShipmentBuffer2."Entry No.");
                  SalesShipmentBuffer.DELETE;
                  EXIT(SalesShipmentBuffer2."Posting Date");
                END ;
               SalesShipmentBuffer.CALCSUMS(Quantity);
               IF SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity THEN BEGIN
                 SalesShipmentBuffer.DELETEALL;
                 EXIT("Sales Invoice Header"."Posting Date");
               END;
            END ELSE
              EXIT("Sales Invoice Header"."Posting Date");
            */
    end;

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        /*
            TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
            ValueEntry.SETCURRENTKEY("Document No.");
            ValueEntry.SETRANGE("Document No.",SalesInvoiceLine2."Document No.");
            ValueEntry.SETRANGE("Posting Date","Sales Invoice Header"."Posting Date");
            ValueEntry.SETRANGE("Item Charge No.",'');
            ValueEntry.SETFILTER("Entry No.",'%1..',FirstValueEntryNo);
            IF ValueEntry.FIND('-') THEN
              REPEAT
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                  IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN
                    Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                  ELSE
                    Quantity := ValueEntry."Invoiced Quantity";
                  AddBufferEntry(
                    SalesInvoiceLine2,
                    -Quantity,
                    ItemLedgerEntry."Posting Date");
                  TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
              UNTIL (ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
            */
    end;

    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        /*
            TotalQuantity := 0;
            SalesInvoiceHeader.SETCURRENTKEY("Order No.");
            SalesInvoiceHeader.SETFILTER("No.",'..%1',"Sales Invoice Header"."No.");
            SalesInvoiceHeader.SETRANGE("Order No.","Sales Invoice Header"."Order No.");
            IF SalesInvoiceHeader.FIND('-') THEN
              REPEAT
                SalesInvoiceLine2.SETRANGE("Document No.",SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SETRANGE("Line No.",SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SETRANGE(Type,SalesInvoiceLine.Type);
                SalesInvoiceLine2.SETRANGE("No.",SalesInvoiceLine."No.");
                SalesInvoiceLine2.SETRANGE("Unit of Measure Code",SalesInvoiceLine."Unit of Measure Code");
                IF SalesInvoiceLine2.FIND('-') THEN
                  REPEAT
                    TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                  UNTIL SalesInvoiceLine2.NEXT = 0;
              UNTIL SalesInvoiceHeader.NEXT = 0;

            SalesShipmentLine.SETCURRENTKEY("Order No.","Order Line No.");
            SalesShipmentLine.SETRANGE("Order No.","Sales Invoice Header"."Order No.");
            SalesShipmentLine.SETRANGE("Order Line No.",SalesInvoiceLine."Line No.");
            SalesShipmentLine.SETRANGE("Line No.",SalesInvoiceLine."Line No.");
            SalesShipmentLine.SETRANGE(Type,SalesInvoiceLine.Type);
            SalesShipmentLine.SETRANGE("No.",SalesInvoiceLine."No.");
            SalesShipmentLine.SETRANGE("Unit of Measure Code",SalesInvoiceLine."Unit of Measure Code");
            SalesShipmentLine.SETFILTER(Quantity,'<>%1',0);

            IF SalesShipmentLine.FIND('-') THEN
              REPEAT
                IF "Sales Invoice Header"."Get Shipment Used" THEN
                  CorrectShipment(SalesShipmentLine);
                IF ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) THEN
                  TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                ELSE BEGIN
                  IF ABS(SalesShipmentLine.Quantity)  > ABS(TotalQuantity) THEN
                    SalesShipmentLine.Quantity := TotalQuantity;
                  Quantity :=
                    SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                  TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                  SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                  IF SalesShipmentHeader.GET(SalesShipmentLine."Document No.") THEN
                    BEGIN
                      AddBufferEntry(
                        SalesInvoiceLine,
                        Quantity,
                        SalesShipmentHeader."Posting Date");
                    END;
                END;
              UNTIL (SalesShipmentLine.NEXT = 0) OR (TotalQuantity = 0);
            */
    end;

    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        /*
            SalesInvoiceLine.SETCURRENTKEY("Shipment No.","Shipment Line No.");
            SalesInvoiceLine.SETRANGE("Shipment No.",SalesShipmentLine."Document No.");
            SalesInvoiceLine.SETRANGE("Shipment Line No.",SalesShipmentLine."Line No.");
            IF SalesInvoiceLine.FIND('-') THEN
               REPEAT
                  SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
               UNTIL SalesInvoiceLine.NEXT = 0;
            */
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        /*
            SalesShipmentBuffer.SETRANGE("Document No.",SalesInvoiceLine."Document No.");
            SalesShipmentBuffer.SETRANGE("Line No.",SalesInvoiceLine."Line No.");
            SalesShipmentBuffer.SETRANGE("Posting Date",PostingDate);
            IF SalesShipmentBuffer.FIND('-') THEN BEGIN
              SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
              SalesShipmentBuffer.MODIFY;
              EXIT;
            END;

            WITH SalesShipmentBuffer DO BEGIN
              "Document No." := SalesInvoiceLine."Document No.";
              "Line No." := SalesInvoiceLine."Line No.";
              "Entry No." := NextEntryNo;
              Type := SalesInvoiceLine.Type;
              "No." := SalesInvoiceLine."No.";
              Quantity := QtyOnShipment;
             "Posting Date" := PostingDate;
              INSERT;
              NextEntryNo := NextEntryNo + 1
            END;
            */
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        /*
            IF "Sales Invoice Header"."Prepayment Invoice" THEN
              EXIT(Text010);
            EXIT(Text004);
            */
    end;
}
