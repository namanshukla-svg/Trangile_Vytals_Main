Report 50256 "Sales Invoice Export"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sales Invoice Export.rdl';
    UseSystemPrinter = true;
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Sales Invoice Export';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            // CalcFields = "Amount to Customer";
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(IGST_Amt; IGST_Amt)
            {
            }
            column(CGST_Amt; CGST_Amt)
            {
            }
            column(SGST_Amt; SGST_Amt)
            {
            }
            column(ReportForNavId_1000000257; 1000000257)
            {
            }
            // column(Structure_;"Sales Invoice Header".Structure)
            // {
            // }
            column(Remarks_ALL; Remarks_ALL)
            {
            }
            column(ShipToCode1; "Ship-to Code")
            {
            }
            column(SellTo_GSTReg; reccust."GST Registration No.")
            {
            }
            column(TaxPayableonOnReverseCharge; TaxPayableonOnReverseCharge)
            {
            }
            column(InvNoNew; InvNoNew)
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
            column(ShipToAddr_5_; ShipToAddr[5])
            {
            }
            column(PlaceOfSupply; PlaceOfSupply)
            {
            }
            column(PlaceOfDelivery; PlaceOfDelivery)
            {
            }
            column(ShipToGST; ShipToGST)
            {
            }
            column(AppliedtoInsurancePolicy_SalesInvoiceHeader; "Sales Invoice Header"."Applied to Insurance Policy")
            {
            }
            column(Sales_Invoice_Line__Amount; "Sales Invoice Line".Amount)
            {
            }
            // column(Sales_Invoice_Line___BED_Amount_;"Sales Invoice Line"."BED Amount")
            // {
            // }
            // column(Sales_Invoice_Line___SHE_Cess_Amount_;"Sales Invoice Line"."SHE Cess Amount")
            // {
            // }
            // column(Sales_Invoice_Line___eCess_Amount_;"Sales Invoice Line"."eCess Amount")
            // {
            // }
            // column(Sales_Invoice_Line__Amount__Sales_Invoice_Line___Excise_Amount_; "Sales Invoice Line".Amount + "Sales Invoice Line"."Excise Amount")
            // {
            // }
            column(FreightAmt; FreightAmt)
            {
            }
            // column(Sales_Invoice_Line___Tax_Amount_;"Sales Invoice Line"."Tax Amount")
            // {
            //     DecimalPlaces = 2:2;
            // }
            column(ForAmt; ForAmt)
            {
            }
            column(PaymentDescr_; PaymentTerms.Description)
            {
            }
            // column(Sales_Invoice_Line___Amount_To_Customer__SaleInvLine__Line_Amount_;"Sales Invoice Line"."Amount To Customer"+SaleInvLine."Line Amount")
            // {
            // }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Vehicle_No__; "Sales Invoice Header"."Vehicle No.")
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
            column(TotalGstAMountintext; TotalGstAMountintext[1])
            {
            }
            column(bool; bool)
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
            column(BedAmt; BedAmt)
            {
            }
            column(ECessAmount; ECessAmount)
            {
            }
            column(SheCessAmount; SheCessAmount)
            {
            }
            column(TaxableAmount_1; TaxableAmount)
            {
            }
            column(SaleInvLine__Line_Amount_; SaleInvLine."Line Amount" * ExchangeRate)
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
            column(Sales_Invoice_Header__ST38_No_; "ST38 No")
            {
            }
            column(Sales_Invoice_Header__Customer_Road_Permit_No__; "Customer Road Permit No.")
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
            column(Sales_Invoice_Header__ST38_No_Caption; FieldCaption("ST38 No"))
            {
            }
            column(Customer_Road_Permit_No_Caption; Customer_Road_Permit_No_CaptionLbl)
            {
            }
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            column(CrossRefValue; CrossRefValue)
            {
            }
            column(PackingTotalDes_; 'Packing : TOTAL ' + Format(TotalPack) + ' PKGS ( GWT ' + Format(TotalWeight) + ' KGS ) ' + '     PKG Slip No.: ' + PackingSlipNo)
            {
            }
            column(Sales_Invoice_Header___Sell_to_Customer_No__; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(ShipToAddr_1__Control126; ShipToAddr[1])
            {
            }
            column(ShipToAddr_2__Control127; ShipToAddr[2])
            {
            }
            column(ShipToAddr_3__Control128; ShipToAddr[3])
            {
            }
            column(ShipToAddr_4__Control129; ShipToAddr[4])
            {
            }
            column(ShipToAddr_5__Control130; ShipToAddr[5])
            {
            }
            column(ShipToAddr_6_; ShipToAddr[6])
            {
            }
            column(ShipToAddr_7_; ShipToAddr[7])
            {
            }
            column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
            {
            }
            column(Sales_Invoice_Header___Sell_to_Customer_No__Caption; "Sales Invoice Header".FieldCaption("Sell-to Customer No."))
            {
            }
            column(GrandInvValue; GrandInvValue)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_1000000212; 1000000212)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));

                    column(ReportForNavId_1000000211; 1000000211)
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
                    column(Sales_Invoice_Header___Posting_Date_; Format("Sales Invoice Header"."Posting Date"))
                    {
                    }
                    column(CompanyInfo2Picture; Cust3."QR Code")
                    {
                    }
                    column(CompanyInfo3Picture; Cust3."QR Code")
                    {
                    }
                    column(CompanyInfo1Picture; Cust3."QR Code")
                    {
                    }
                    column(Sales_Invoice_Header___No__; InvNoNew)
                    {
                    }
                    column(DataItem1000000202; Format("Sales Invoice Header"."Gate Out Date"))
                    {
                    }
                    column(ExciseTarrifNos_1_________ExciseTarrifNos_2_; ExciseTarrifNos[1] + '/' + ExciseTarrifNos[2])
                    {
                    }
                    column(OrderNoNew_______FORMAT__Sales_Invoice_Header___Order_Date__; OrderNoNew + '/ ' + Format("Sales Invoice Header"."Order Date"))
                    {
                    }
                    column(Sales_Invoice_Header___Ship_to_City_; "Sales Invoice Header"."Ship-to City" + ' (' + reccust."State Code" + '-' + RecState."State Code (GST Reg. No.)" + ')')
                    {
                    }
                    column(PaymentTerms_Description_Control1000000009; PaymentTerms.Description)
                    {
                    }
                    column(Sales_Invoice_Header___Applied_to_Insurance_Policy_; "Sales Invoice Header"."Applied to Insurance Policy")
                    {
                    }
                    column(Cust_Contact; Cust.Contact)
                    {
                    }
                    column(Cust__Phone_No__; Cust."Phone No.")
                    {
                    }
                    // column(Cust__C_S_T__No__;Cust."C.S.T. No.")
                    // {
                    // }
                    column(CustPANNo; Cust."P.A.N. No.")
                    {
                    }
                    // column(BillTo__T_I_N__No__;BillTo."T.I.N. No.")
                    // {
                    // }
                    column(BillTo__E_C_C__No__; reccust1."GST Registration No.")
                    {
                    }
                    column(Cust__Our_Account_No__; Cust."Our Account No.")
                    {
                    }
                    column(Sales_Invoice_Header___External_Document_No__; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(Sales_Invoice_Header___External_Doc__Date_; "Sales Invoice Header"."External Doc. Date")
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
                    column(Goods_insured_under_BAGICL_Marine_Cargo_Caption; Goods_insured_under_BAGICL_Marine_Cargo_CaptionLbl)
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
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                        column(ReportForNavId_1000000169; 1000000169)
                        {
                        }
                        column(DimText; DimText)
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
                            if Number = 1 then begin
                                //IF NOT PostedDocDim1.FIND('-') THEN // BIS 1145
                                CurrReport.Break;
                            end
                            else if not Continue then CurrReport.Break;
                            Clear(DimText);
                            Continue := false;
                            /* // BIS 1145 <<
                                REPEAT
                                  OldDimText := DimText;
                                  IF DimText = '' THEN
                                    MESSAGE(' // BIS 1145') // BIS 1145
                                    //DimText := STRSUBSTNO(
                                      //'%1 %2',PostedDocDim1."Dimension Code",PostedDocDim1."Dimension Value Code") // BIS 1145
                                  ELSE
                                    MESSAGE(' // BIS 1145'); // BIS 1145
                                    //DimText :=  // BIS 1145
                                      //STRSUBSTNO(  // BIS 1145
                                        //'%1, %2 %3',DimText,  // BIS 1145
                                        //PostedDocDim1."Dimension Code",PostedDocDim1."Dimension Value Code");// BIS 1145
                                  IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                  END;
                                UNTIL (PostedDocDim1.NEXT = 0);
                                */
                            // BIS 1145 >>
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then CurrReport.Break;
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document No.", "Line No.") where(Quantity = filter(<> 0));

                        column(ReportForNavId_1000000164; 1000000164)
                        {
                        }
                        // column(GrandAmount;"Sales Invoice Line"."Amount To Customer" * ExchangeRate)
                        // {
                        // }
                        column(desc1; desc1)
                        {
                        }
                        column(LineNo_SalesInvoiceLine; "Sales Invoice Line"."Line No.")
                        {
                        }
                        column(AmountInWords; AmountInWords[1])
                        {
                        }
                        column(ShipmentDate_SalesInvoiceLine; "Sales Invoice Line"."Shipment Date")
                        {
                        }
                        column(Sales_Invoice_Line__Line_Amount_; "Line Amount" * ExchangeRate)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(HSN; "HSN/SAC Code")
                        {
                        }
                        column(Sales_Invoice_Line_Description; desc)
                        {
                        }
                        // column(GSTBaseAmount_SalesInvoiceLine;"Sales Invoice Line"."GST Base Amount")
                        // {
                        // }
                        column(Sales_Invoice_Line__No__; SrNo)
                        {
                        }
                        // column(CGSTAMT;"Total GST Amount")
                        // {
                        // }
                        column(Sales_Invoice_Line_Description_Control65; "No." + '-' + desc)
                        {
                        }
                        column(Type_SalesInvoiceLine; "Sales Invoice Line".Type)
                        {
                        }
                        column(GSTText; GSTText2 + GSTText3 + ' ' + GSTText1)
                        {
                        }
                        column(Sales_Invoice_Line_Quantity; Quantity)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(Sales_Invoice_Line__Unit_of_Measure_; "Unit of Measure Code")
                        {
                        }
                        column(Sales_Invoice_Line__Unit_Price_; "Unit Price" * ExchangeRate)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control70; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Description_2_; "Description 2")
                        {
                        }
                        // column(TaxableAmount;Amount+"Excise Amount")
                        // {
                        // }
                        // column(TaxAmount;"Tax Amount")
                        // {
                        // }
                        column(PackDesc_1_; PackDesc[1])
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
                        column(PackDescQty_3_; PackDescQty[3])
                        {
                        }
                        column(PackDesc_3_; PackDesc[3])
                        {
                        }
                        column(PackDescQty_4_; PackDescQty[4])
                        {
                        }
                        column(PackDesc_4_; PackDesc[4])
                        {
                        }
                        column(FORMAT_DespLine__Actual_Wt_____KGS___; '( ' + Format(DespLine."Actual Wt") + ' KGS )')
                        {
                        }
                        column(RecCrossReference__Cross_Reference_No__; RecCrossReference."Reference No.")
                        {
                        }
                        column(FORMAT_ROUND_Item2__Net_Weight___Sales_Invoice_Line__Quantity_0_01_________KGS___; '( ' + Format(ROUND(Item2."Net Weight" * "Sales Invoice Line".Quantity, 0.01, '=')) + ' KGS )')
                        {
                        }
                        // column(Ref_____FORMAT__Source_Document_Type__0_;'Ref: '+ Format("Source Document Type",0))
                        // {
                        // }
                        // column(Sales_Invoice_Line__Source_Document_No__;"Source Document No.")
                        // {
                        // }
                        // column(Supplementary;Supplementary)
                        // {
                        // }
                        column(Sales_Invoice_Line__Line_Amount__Control86; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Inv__Discount_Amount_; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control99; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(FixedRows; FixedRows)
                        {
                        }
                        column(RowsCount; RowsCount)
                        {
                        }
                        column(Sales_Invoice_Line_Amount; Amount * ExchangeRate)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        // column(Sales_Invoice_Line__Amount_Including_VAT_;"Amount To Customer")
                        // {
                        //     AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        //     AutoFormatType = 1;
                        // }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        // column(Sales_Invoice_Line__Excise_Amount_;"Excise Amount")
                        // {
                        //     AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        //     AutoFormatType = 1;
                        // }
                        // column(Sales_Invoice_Line__Tax_Amount_;"Tax Amount")
                        // {
                        //     AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        //     AutoFormatType = 1;
                        // }
                        column(ServiceTaxAmt; ServiceTaxAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ChargesAmount; ChargesAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(OtherTaxesAmount; OtherTaxesAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ServiceTaxECessAmt; ServiceTaxECessAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Sales_Invoice_Line___Total_TDS_TCS_Incl__SHE_CESS_; TotalTCSAmount)
                        {
                        }
                        column(AppliedServiceTaxAmt; AppliedServiceTaxAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxECessAmt; AppliedServiceTaxECessAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ServiceTaxSHECessAmt; ServiceTaxSHECessAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxSHECessAmt; AppliedServiceTaxSHECessAmt)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
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
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Header___VAT_Base_Discount___; "Sales Invoice Header"."VAT Base Discount %")
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
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line_Amount_Control63; Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Amount_Including_VAT__Control71; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
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
                        column(Sales_Invoice_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Invoice_Line_Line_No_; "Line No.")
                        {
                        }
                        column(DespLine_Actual_Wt; DespLine."Actual Wt")
                        {
                        }
                        column(GrandTotal_Rounded; GrandTotal_Rounded)
                        {
                        }
                        trigger OnAfterGetRecord()
                        var
                        // StructureLineDetails: Record UnknownRecord13798;
                        begin
                            GSTText1 := '';
                            GSTText2 := '';
                            GSTText3 := '';
                            Per_CGST := 0;
                            CGST_Amt := 0;
                            Per_SGST := 0;
                            SGST_Amt := 0;
                            Per_IGST := 0;
                            IGST_Amt := 0;
                            DetailedGSTLedgerEntry1.Reset();
                            DetailedGSTLedgerEntry1.SetRange("Transaction Type", DetailedGSTLedgerEntry1."Transaction Type"::Sales);
                            DetailedGSTLedgerEntry1.SetRange("Document Type", DetailedGSTLedgerEntry1."Document Type"::Invoice);
                            DetailedGSTLedgerEntry1.SetRange("Document No.", "Sales Invoice Header"."No.");
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
                            ChargesAmount := 0;
                            SrNo += 1;
                            XX := XX - 1;
                            desc := '';
                            //Alle_190419-begin
                            desc := "Sales Invoice Line".Description;
                            if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" then begin
                                desc1 := CopyStr("Sales Invoice Line".Description, 1, 5);
                                if desc1 <> 'Round' then
                                    desc := "Sales Invoice Line".Description
                                else
                                    desc := 'Freight';
                                if desc <> '' then
                                    desc := 'Freight'
                                else
                                    desc := "Sales Invoice Line".Description;
                            end;
                            //Alle_190419-end
                            // ALLE1.01 Sk Start
                            // GSTText := '';
                            // .........
                            // .........
                            // if "Sales Invoice Line"."GST Jurisdiction Type" = "Sales Invoice Line"."gst jurisdiction type"::Intrastate then begin
                            //     DetailedGSTLedgerEntry.Reset;
                            //     DetailedGSTLedgerEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
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
                            //     if GSTGroup.Get("Sales Invoice Line"."GST Group Code") then
                            //         GSTText := 'I' + GSTGroup.Description + ' Rs. ' + Format("Total GST Amount");
                            // end;
                            TotalGstAMount := ((CGST_Amt + SGST_Amt + IGST_Amt) * ExchangeRate);
                            Check.InitTextVariable();
                            //Check.FormatNoText(NoInText,"Sales Invoice Line"."Excise Amount",'');
                            Check.FormatNoText(TotalGstAMountintext, ROUND(TotalGstAMount), ''); //Alle[Z]- Added-01-06-2015
                            //message('%1',TotalGstAMountintext[1]);
                            // "Sales Invoice Header".CalcFields("Sales Invoice Header"."Amount to Customer");
                            Check.InitTextVariable();
                            Check.FormatNoText(AmountInWords, ROUND((("Sales Invoice Header".Amount + CGST_Amt + IGST_Amt + SGST_Amt) * ExchangeRate)), '');
                            // ALLE1.01 Sk Start
                            FixedRows += 1;
                            if FixedRows > 4 then begin
                                RowsCount := RowsCount + 1;
                                FixedRows := 0;
                            end;
                            if "System-Created Entry" then begin
                                SrNo := 0;
                                "Unit Price" := 0;
                                Quantity := 0;
                            end;
                            if "System-Created Entry" then CurrReport.Skip;
                            PostedShipmentDate := 0D;
                            if Quantity <> 0 then PostedShipmentDate := FindPostedShipmentDate;
                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then "No." := '';
                            if DespLine.Get(DespLine."document type"::Order, "Sales Invoice Line"."Despatch Slip No.", "Sales Invoice Line"."Despatch Slip Line No.") then begin
                                DespLine.CalcFields("No of Pack");
                                DespLine.CalcFields("Actual Wt");
                                DespLine.CalcFields("Gross Wt");
                                TotalPack += DespLine."No of Pack";
                                TotalWeight += DespLine."Gross Wt";
                            end;
                            //<<<< ALLE[551]
                            CrossRefValue := '';
                            if Item2.Get("Sales Invoice Line"."No.") then;
                            CrossRefValue := '( ' + Format(ROUND(Item2."Net Weight" * "Sales Invoice Line".Quantity, 0.01, '=')) + ' KGS )';
                            //TotalWeight += Item2."Net Weight"*"Sales Invoice Line".Quantity;
                            //<<<< ALLE[551]
                            //>>Alle VPB
                            Clear(PackDesc);
                            Clear(PackDescQty);
                            PackCounter := 1;
                            SalesScheduleBuffer.Reset;
                            SalesScheduleBuffer.SetRange("Document Type", SalesScheduleBuffer."document type"::Order);
                            SalesScheduleBuffer.SetRange("Document No.", "Sales Invoice Line"."Despatch Slip No.");
                            SalesScheduleBuffer.SetRange("Order Line No.", "Sales Invoice Line"."Despatch Slip Line No.");
                            if SalesScheduleBuffer.FindFirst then
                                repeat
                                    PackDesc[PackCounter] := Format(SalesScheduleBuffer."No. of Box") + ' ' + Format(SalesScheduleBuffer.Packing);
                                    PackDescQty[PackCounter] := Format(SalesScheduleBuffer."Qty per Box") + ' ' + SalesScheduleBuffer."Unit of Measure Code";
                                    //SalesScheduleBuffer."Gross Weight"
                                    PackCounter += 1;
                                    PackingSlipNo := "Sales Invoice Line"."Despatch Slip No.";
                                until SalesScheduleBuffer.Next = 0;
                            //<<Alle VPB
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
                            // TotalTCSAmount += "Total TDS/TCS Incl. SHE CESS";
                            // if ISSERVICETIER then begin
                            //     TotalSubTotal += "Line Amount";
                            //     TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            //     TotalAmount += Amount;
                            //     TotalAmountVAT += "Amount Including VAT" - Amount;
                            //     // TotalAmountInclVAT += "Amount Including VAT";
                            //     TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                            //     TotalAmountInclVAT += "Amount To Customer";
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
                            // //StructureLineDetails.SETRANGE("Item No.","No.");
                            // //StructureLineDetails.SETRANGE("Line No.","Line No.");
                            // if StructureLineDetails.Find('-') then
                            //     repeat
                            //         if not StructureLineDetails."Payable to Third Party" then begin
                            //             if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::Charges then
                            //                 ChargesAmount := ChargesAmount + Abs(StructureLineDetails.Amount);
                            //             if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::"Other Taxes" then
                            //                 OtherTaxesAmount := OtherTaxesAmount + Abs(StructureLineDetails.Amount);
                            //         end;
                            //     until StructureLineDetails.Next = 0;
                            // if ISSERVICETIER then begin
                            //     if "Sales Invoice Header"."Transaction No. Serv. Tax" <> 0 then begin
                            //         ServiceTaxEntry.Reset;
                            //         ServiceTaxEntry.SetRange(Type, ServiceTaxEntry.Type::Sale);
                            //         ServiceTaxEntry.SetRange("Document Type", ServiceTaxEntry."document type"::Invoice);
                            //         ServiceTaxEntry.SetRange("Document No.", "Document No.");
                            //         if ServiceTaxEntry.FindFirst then begin
                            //             if "Sales Invoice Header"."Currency Code" <> '' then begin
                            //                 ServiceTaxEntry."Service Tax Amount" :=
                            //                   ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //                     "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                            //                     ServiceTaxEntry."Service Tax Amount", "Sales Invoice Header"."Currency Factor"));
                            //                 ServiceTaxEntry."eCess Amount" :=
                            //                   ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //                     "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                            //                     ServiceTaxEntry."eCess Amount", "Sales Invoice Header"."Currency Factor"));
                            //                 ServiceTaxEntry."SHE Cess Amount" :=
                            //                   ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //                     "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                            //                     ServiceTaxEntry."SHE Cess Amount", "Sales Invoice Header"."Currency Factor"));
                            //             end;
                            //             ServiceTaxAmt := Abs(ServiceTaxEntry."Service Tax Amount");
                            //             ServiceTaxECessAmt := Abs(ServiceTaxEntry."eCess Amount");
                            //             ServiceTaxSHECessAmt := Abs(ServiceTaxEntry."SHE Cess Amount");
                            //             AppliedServiceTaxAmt := ServiceTaxAmount - Abs(ServiceTaxEntry."Service Tax Amount");
                            //             AppliedServiceTaxECessAmt := ServiceTaxeCessAmount - Abs(ServiceTaxEntry."eCess Amount");
                            //             AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount - Abs(ServiceTaxEntry."SHE Cess Amount");
                            //         end else begin
                            //             AppliedServiceTaxAmt := ServiceTaxAmount;
                            //             AppliedServiceTaxECessAmt := ServiceTaxeCessAmount;
                            //             AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
                            //         end;
                            //     end else begin
                            //         ServiceTaxAmt := ServiceTaxAmount;
                            //         ServiceTaxECessAmt := ServiceTaxeCessAmount;
                            //         ServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
                            //     end;
                            // end;
                            //>>Alle VPB
                            RecCrossReference.Init;
                            if Type = Type::Item then begin
                                RecCrossReference.Reset;
                                RecCrossReference.SetRange("Item No.", "No.");
                                RecCrossReference.SetRange("Reference Type", RecCrossReference."Reference Type"::Customer);
                                RecCrossReference.SetRange(RecCrossReference."Reference Type No.", "Sell-to Customer No.");
                                if not RecCrossReference.FindFirst then RecCrossReference."Reference No." := '';
                            end;
                            //<<Alle VPB
                            // if "Sales Invoice Header"."Transaction No. Serv. Tax" <> 0 then begin
                            //     ServiceTaxEntry.Reset;
                            //     ServiceTaxEntry.SetRange(Type, ServiceTaxEntry.Type::Sale);
                            //     ServiceTaxEntry.SetRange("Document Type", ServiceTaxEntry."document type"::Invoice);
                            //     ServiceTaxEntry.SetRange("Document No.", "Document No.");
                            //     if ServiceTaxEntry.FindFirst then begin
                            //         if "Sales Invoice Header"."Currency Code" <> '' then begin
                            //             ServiceTaxEntry."Service Tax Amount" :=
                            //               ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //                 "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                            //                 ServiceTaxEntry."Service Tax Amount", "Sales Invoice Header"."Currency Factor"));
                            //             ServiceTaxEntry."eCess Amount" :=
                            //               ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //                 "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                            //                 ServiceTaxEntry."eCess Amount", "Sales Invoice Header"."Currency Factor"));
                            //             ServiceTaxEntry."SHE Cess Amount" :=
                            //               ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //                 "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                            //                 ServiceTaxEntry."SHE Cess Amount", "Sales Invoice Header"."Currency Factor"));
                            //         end;
                            //         ServiceTaxAmt := Abs(ServiceTaxEntry."Service Tax Amount");
                            //         ServiceTaxECessAmt := Abs(ServiceTaxEntry."eCess Amount");
                            //         ServiceTaxSHECessAmt := Abs(ServiceTaxEntry."SHE Cess Amount");
                            //         AppliedServiceTaxAmt := "Service Tax Amount" - Abs(ServiceTaxEntry."Service Tax Amount");
                            //         AppliedServiceTaxECessAmt := "Service Tax eCess Amount" - Abs(ServiceTaxEntry."eCess Amount");
                            //         AppliedServiceTaxSHECessAmt := "Service Tax SHE Cess Amount" - Abs(ServiceTaxEntry."SHE Cess Amount");
                            //     end else begin
                            //         AppliedServiceTaxAmt := "Service Tax Amount";
                            //         AppliedServiceTaxECessAmt := "Service Tax eCess Amount";
                            //         AppliedServiceTaxSHECessAmt := "Service Tax SHE Cess Amount";
                            //     end;
                            // end else begin
                            //     ServiceTaxAmt := "Service Tax Amount";
                            //     ServiceTaxECessAmt := "Service Tax eCess Amount";
                            //     ServiceTaxSHECessAmt := "Service Tax SHE Cess Amount";
                            // end;
                            // if "Sales Invoice Header".Structure = 'GST-P&F-SA' then
                            //     Gtotal += "Sales Invoice Line"."Amount To Customer"
                            // else
                            //     Gtotal := "Total GST Amount" + FreightAmt + ForAmt + SaleInvLine."Line Amount";
                            // GrandTotal_Rounded := ROUND(Gtotal, 1, '=');
                            Check.InitTextVariable();
                            //Check.FormatNoText(NoInText,"Sales Invoice Line"."Excise Amount",'');
                            Check.FormatNoText(NoInText, ROUND(TotalExciseAmt), ''); //Alle[Z]- Added-01-06-2015
                            //Check.FormatNoText(ExInText,ROUND(Gtotal,0.01,'='),'');  //ALLE-SS
                            Check.FormatNoText(ExInText, ROUND(Gtotal, 1, '='), '');
                            //MESSAGE('%1',ExInText[1]);
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
                            //   "Service Tax Amount", "Service Tax eCess Amount", "Amount To Customer");
                            // CurrReport.CreateTotals("Service Tax SHE Cess Amount", DespLine."Actual Wt");
                            SrNo := 0;
                            Gtotal := 0;
                            XX := 6;
                            GrandTotal_Rounded := 0;
                            FixedRows := 0;
                            CGSTAMT := 0;
                        end;
                    }
                    dataitem(LineCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_1000000000; 1000000000)
                        {
                        }
                        column(LineCount_Number; LineCount_Num)
                        {
                        }
                        column(XX; XX)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            XX := XX - 1;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, XX);
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_1000000073; 1000000073)
                        {
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Base__Control108; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control109; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control140; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control141; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control142; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control112; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control113; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control110; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control114; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control118; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control116; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control117; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control132; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control133; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control134; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control108Caption; VATAmountLine__VAT_Base__Control108CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control109Caption; VATAmountLine__VAT_Amount__Control109CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control141Caption; VATAmountLine__Inv__Disc__Base_Amount__Control141CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control140Caption; VATAmountLine__Line_Amount__Control140CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control142Caption; VATAmountLine__Invoice_Discount_Amount__Control142CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control112Caption; VATAmountLine__VAT_Base__Control112CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control116Caption; VATAmountLine__VAT_Base__Control116CaptionLbl)
                        {
                        }
                        column(VATCounter_Number; Number)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmountLine.GetTotalVATAmount = 0 then CurrReport.Break;
                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount", VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := Text003;
                        if ISSERVICETIER then OutputNo += 1;
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
                    // ChargesAmount :=0;
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
                    SalesInvCountPrinted.Run("Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then NoOfLoops := 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    if ISSERVICETIER then OutputNo := 1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                SalesInvLine: Record "Sales Invoice Line";
                StateRec: Record state;
                ExcTarrifCounter: Integer;
                CustLocal: Record Customer;
                ItemLocal: Record Item;
                SHL: Record "Sales Header";
                TaxAreaLine: Record "Tax Area Line";
                TaxJurisdiction: Record "Tax Jurisdiction";
                TaxDetail: Record "Tax Detail";
                PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
            begin
                Clear(ExchangeRate);
                if "Sales Invoice Header"."Currency Factor" <> 0 then
                    ExchangeRate := ROUND(1 / "Sales Invoice Header"."Currency Factor", 0.0001)
                else
                    ExchangeRate := 1;
                Clear(GrandInvValue);
                GrandInvValue := (("Sales Invoice Header".Amount + CGST_Amt + SGST_Amt + IGST_Amt) * ExchangeRate);
                if LanguageCode.Get("Language Code") then CurrReport.Language := LanguageCode."Windows Language ID";
                //<<< ALLE[551]
                InvNoNew := DelStr("Sales Invoice Header"."No.", 1, StrLen("Sales Invoice Header"."No.") - 5);
                if StrLen("Sales Invoice Header"."Order/Scd. No.") > 5 then
                    OrderNoNew := DelStr("Sales Invoice Header"."Order/Scd. No.", 1, StrLen("Sales Invoice Header"."Order/Scd. No.") - 5)
                else
                    OrderNoNew := "Sales Invoice Header"."Order/Scd. No.";
                //>>> ALLE[551]
                if BillTo.Get("Sales Invoice Header"."Bill-to Customer No.") then;
                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end
                else begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                end;
                if reccust.Get("Sales Invoice Header"."Sell-to Customer No.") then;
                if RecState.Get(reccust."State Code") then;
                if reccust1.Get("Sales Invoice Header"."Bill-to Customer No.") then;
                RecSIL.Reset;
                RecSIL.SetRange("Document No.", "No.");
                RecSIL.SetRange(Type, RecSIL.Type::Item);
                if RecSIL.FindLast then begin
                    if RecSIL."GST Jurisdiction Type" = RecSIL."gst jurisdiction type"::Intrastate then
                        bool := false
                    else
                        bool := true;
                end;
                //PostedDocDim1.SETRANGE("Table ID",DATABASE::"Sales Invoice Header"); // BIS 1145
                //PostedDocDim1.SETRANGE("Document No.","Sales Invoice Header"."No."); // BIS 1145
                if "Order No." = '' then
                    OrderNoText := ''
                else
                    OrderNoText := FieldCaption("Order No.");
                if "Salesperson Code" = '' then begin
                    SalesPurchPerson.Init;
                    SalesPersonText := '';
                end
                else begin
                    SalesPurchPerson.Get("Salesperson Code");
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
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                //>> Alle VPB
                Clear(CustAddr);
                if not StateRec.Get("Sales Invoice Header".State) then StateRec.Init;
                CustAddr[1] := "Sales Invoice Header"."Bill-to Name" + '  (' + "Sales Invoice Header"."Bill-to Customer No." + ')';
                CustAddr[2] := "Sales Invoice Header"."Bill-to Address";
                CustAddr[3] := "Sales Invoice Header"."Bill-to Address 2";
                CustAddr[4] := "Sales Invoice Header"."Bill-to City" + ', ' + StateRec.Description + ', ' + "Sales Invoice Header"."Bill-to Post Code";
                //<<Alle VPB
                if not Cust.Get("Bill-to Customer No.") then Clear(Cust);
                QRMng.SaleInv(true, "Sales Invoice Header", false, PurchCrMemoHdr);
                QRMng.Run(ILE);
                Cust3.Get("Sales Invoice Header"."Sell-to Customer No.");
                Cust3.CalcFields("QR Code");
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
                // FormatAddr.SalesInvShipTo(ShipToAddr,"Sales Invoice Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                for i := 1 to ArrayLen(ShipToAddr) do if ShipToAddr[i] <> CustAddr[i] then ShowShippingAddr := true;
                //>> Alle VPB
                Clear(ShipToAddr);
                CustLocal.Get("Sell-to Customer No.");
                if CustLocal."Print Ship to Addr. on Inv." then begin
                    if not StateRec.Get("Sales Invoice Header"."GST Bill-to State Code") then StateRec.Init;
                    ShipToAddr[1] := "Sales Invoice Header"."Ship-to Name";
                    ShipToAddr[2] := "Sales Invoice Header"."Ship-to Address";
                    ShipToAddr[3] := "Sales Invoice Header"."Ship-to Address 2";
                    ShipToAddr[4] := "Sales Invoice Header"."Ship-to City" + ', ' + StateRec.Description + ', ' + "Sales Invoice Header"."Ship-to Post Code";
                    //ShipToAddr[5] :=  'CST No.: ' + CustLocal."C.S.T. No."; Alle 01082017 comented
                    //ShipToAddr[6] :=  'ECC No.: ' + CustLocal."E.C.C. No."; Alle 01082017 comented
                    ShipToAddr[5] := 'GSTIN : ' + CustLocal."GST Registration No.";
                end
                else
                    ShipToAddr[1] := 'SAME AS CONSIGNEE';
                //<<Alle VPB
                //Alle 310717<<
                Clear(PlaceOfSupply);
                Clear(PlaceOfDelivery);
                Clear(ShipToGST);
                //IF ShipToAddr[1] =  'SAME AS CONSIGNEE' THEN BEGIN
                if "Ship-to Code" = '' then begin
                    PlaceOfDelivery := "Sales Invoice Header"."Ship-to City" + ' (' + reccust."State Code" + '-' + RecState."State Code (GST Reg. No.)" + ')';
                    PlaceOfSupply := "Sales Invoice Header"."Bill-to City" + ' (' + reccust."State Code" + '-' + RecState."State Code (GST Reg. No.)" + ')';
                end
                else begin
                    if ShipToAdd.Get("Sell-to Customer No.", "Ship-to Code") then begin
                        if ShipToAdd."GST Registration No." = '' then
                            ShipToGST := reccust1."GST Registration No."
                        else
                            ShipToGST := ShipToAdd."GST Registration No.";
                        if RecState1.Get(ShipToAdd.State) then PlaceOfDelivery := "Sales Invoice Header"."Ship-to City" + ' (' + ShipToAdd.State + '-' + RecState1."State Code (GST Reg. No.)" + ')';
                        PlaceOfSupply := "Sales Invoice Header"."Bill-to City" + ' (' + reccust."State Code" + '-' + RecState."State Code (GST Reg. No.)" + ')';
                    end;
                end;
                //Alle 310717>>
                if LogInteraction then
                    if not CurrReport.Preview then begin
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(4, "No.", 0, 0, Database::Contact, "Bill-to Contact No.", "Salesperson Code", "Campaign No.", "Posting Description", '')
                        else
                            SegManagement.LogDocument(4, "No.", 0, 0, Database::Customer, "Bill-to Customer No.", "Salesperson Code", "Campaign No.", "Posting Description", '');
                    end;
                // SupplementaryText := '';
                // SalesInvLine.SetRange("Document No.","No.");
                // SalesInvLine.SetRange(Supplementary, true);
                // if SalesInvLine.Find('-') then
                //   SupplementaryText := Text16500;
                if PaymentTerms.Get("Payment Terms Code") then;
                // PSOLDet.Reset;
                // PSOLDet.SetCurrentkey(Type,"Calculation Order","Document Type","Invoice No.",
                //                       "Item No.","Line No.","Tax/Charge Type","Tax/Charge Group","Tax/Charge Code");
                // PSOLDet.SetRange(Type,PSOLDet.Type::Sale);
                // PSOLDet.SetRange("Document Type",PSOLDet."document type"::Invoice);
                // PSOLDet.SetRange("Invoice No.","No.");
                // PSOLDet.SetRange("Tax/Charge Type",PSOLDet."tax/charge type"::Charges);
                // PSOLDet.SetFilter("Tax/Charge Group",'%1','FREIGHT');
                // if PSOLDet.FindFirst then
                // FreightAmt:=0;
                // repeat
                //   FreightAmt += PSOLDet.Amount;
                // until PSOLDet.Next=0;
                // PSOLDet1.Reset;
                // PSOLDet1.SetCurrentkey(Type,"Calculation Order","Document Type","Invoice No.",
                //                       "Item No.","Line No.","Tax/Charge Type","Tax/Charge Group","Tax/Charge Code");
                // PSOLDet1.SetRange(Type,PSOLDet1.Type::Sale);
                // PSOLDet1.SetRange("Document Type",PSOLDet1."document type"::Invoice);
                // PSOLDet1.SetRange("Invoice No.","No.");
                // PSOLDet1.SetRange("Tax/Charge Type",PSOLDet1."tax/charge type"::Charges);
                // PSOLDet1.SetFilter("Tax/Charge Group",'%1','FORWARDING');
                // if PSOLDet1.FindFirst then
                // ForAmt:=0;
                // repeat
                //   ForAmt += PSOLDet1.Amount;
                // until PSOLDet1.Next=0;
                BedAmt := 0;
                ECessAmount := 0;
                SheCessAmount := 0;
                TaxableAmount := 0;
                //>>Alle VPB
                // Clear(ExciseTarrifNos);
                // ExcTarrifCounter := 1;
                // SalesInvLine.Reset;
                // SalesInvLine.SetRange("Document No.","No.");
                // SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                // if SalesInvLine.Find('-') then repeat
                //   ExciseTarrifNos[ExcTarrifCounter] := SalesInvLine."Excise Prod. Posting Group";
                //   if ItemLocal.Get(SalesInvLine."No.") then
                //     ExciseTarrifNos[ExcTarrifCounter] := ItemLocal."Excise Prod. Posting Group";
                //   ExcTarrifCounter += 1;
                // BedAmt+=SalesInvLine."BED Amount";
                // ECessAmount+=SalesInvLine."eCess Amount";
                // SheCessAmount+=SalesInvLine."SHE Cess Amount";
                // TaxableAmount+=SalesInvLine.Amount+SalesInvLine."Excise Amount"
                //SalesInvLine."Tax Amount"
                // until SalesInvLine.Next = 0;
                /*
                MESSAGE('%1 CENAVT',BedAmt);
                MESSAGE('%1 ECess',ECessAmount);
                MESSAGE('%1 SheCess',SheCessAmount);
                MESSAGE('%1 Taxable Amount',TaxableAmount);
                */
                TotalPack := 0;
                TotalWeight := 0;
                OrderDate := "Order Date";
                if SHL.Get(SHL."document type"::Order, "Order/Scd. No.") then OrderDate := SHL."Order Date";
                //<<Alle VPB
                if "Tax Area Code" <> '' then TaxText := "Tax Area Code";
                if "Tax Area Code" = '' then begin
                    SaleInvLine.Reset;
                    SaleInvLine.SetRange("Document No.", "No.");
                    SaleInvLine.SetRange(Type, SaleInvLine.Type::Item);
                    if SaleInvLine.FindFirst then TaxText := SaleInvLine."Tax Area Code";
                end;
                // if "Form Code" <> '' then
                //     TaxText := TaxText + ' (Form ' + "Form Code" + ')';
                // SaleInvLine.Reset;
                // SaleInvLine.SetRange("Document No.", "No.");
                // SaleInvLine.SetRange(Type, SaleInvLine.Type::Item);
                // if SaleInvLine.FindFirst then begin
                //   if SaleInvLine."Tax %" <> 0 then begin
                //     TaxAreaLine.SetCurrentkey("Tax Area","Calculation Order");
                //     TaxAreaLine.SetRange("Tax Area",SaleInvLine."Tax Area Code");
                //     if TaxAreaLine.Find('-') then begin
                //       TaxJurisdiction.Get(TaxAreaLine."Tax Jurisdiction Code");
                //       TaxDetail.Reset;
                //       TaxDetail.SetRange("Tax Jurisdiction Code",TaxAreaLine."Tax Jurisdiction Code");
                //       TaxDetail.SetFilter("Tax Group Code",'%1',SaleInvLine."Tax Group Code");
                //       TaxDetail.SetRange("Form Code",SaleInvLine."Form Code");
                //       TaxDetail.SetFilter("Effective Date",'<=%1',"Posting Date");
                //       if TaxDetail.Find('+') then
                //         TaxText := TaxText + ' ' + Format(TaxDetail."Tax Below Maximum") + '%';
                //     end;
                //    end else begin
                //      TaxText := TaxText + ' ' + '0' + '%';
                //   end;
                // end;
                /*
                IF ("Tax Amount" <> 0) AND (taxPercent = 0) THEN BEGIN
                  TaxAreaLine.SETCURRENTKEY("Tax Area","Calculation Order");
                  TaxAreaLine.SETRANGE("Tax Area","Tax Area Code");
                  IF TaxAreaLine.FIND('-') THEN BEGIN
                    TaxJurisdiction.GET(TaxAreaLine."Tax Jurisdiction Code");
                    TaxDetail.RESET;
                    TaxDetail.SETRANGE("Tax Jurisdiction Code",TaxAreaLine."Tax Jurisdiction Code");
                    TaxDetail.SETFILTER("Tax Group Code",'%1',"Tax Group Code");
                    TaxDetail.SETRANGE("Form Code","Form Code");
                    TaxDetail.SETFILTER("Effective Date",'<=%1',"Sales Header"."Posting Date");
                    IF TaxDetail.FIND('+') THEN
                      taxPercent := TaxDetail."Tax Below Maximum";
                  END;
                END;
                
                */
                SaleInvLine.Reset;
                SaleInvLine.SetRange("Document No.", "No.");
                SaleInvLine.SetRange("System-Created Entry", true);
                if not SaleInvLine.FindFirst then SaleInvLine.Init;
                if "CT2 Form" <> '' then Comments[1] += 'CT2 Form: ' + "CT2 Form";
                if "CT3 Form" <> '' then Comments[1] += 'CT3 Form: ' + "CT3 Form";
                AREDetails.Reset;
                AREDetails.SetRange("Sales Inv No.", "No.");
                AREDetails.SetRange("Sales Inv Date", "Posting Date");
                if AREDetails.FindFirst then begin
                    Comments[1] += '  ' + Format(AREDetails."ARE1 Type") + ' No.: ' + AREDetails."ARE1 No.";
                end;
                SaleCommentLine.Reset;
                SaleCommentLine.SetRange("Document Type", SaleCommentLine."document type"::"Posted Invoice");
                SaleCommentLine.SetRange("No.", "No.");
                SaleCommentLine.SetRange("Document Line No.", 0);
                if SaleCommentLine.Find('-') then Comments[1] += SaleCommentLine.Comment;
                if SaleCommentLine.Next <> 0 then Comments[2] := SaleCommentLine.Comment;
                Remarks_ALL := '';
                SaleCommentLine.Reset;
                SaleCommentLine.SetRange("Document Type", SaleCommentLine."document type"::"Posted Invoice");
                SaleCommentLine.SetRange("No.", "No.");
                SaleCommentLine.SetRange("Document Line No.", 0);
                if SaleCommentLine.FindSet then
                    repeat
                        Remarks_ALL += SaleCommentLine.Comment;
                    until SaleCommentLine.Next = 0;
                if not ShippingAgent.Get("Shipping Agent Code") then ShippingAgent.Init;
                if not ShipmentMethod.Get("Shipment Method Code") then ShipmentMethod.Init;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(TaxPayableonOnReverseCharge; TaxPayableonOnReverseCharge)
                {
                    ApplicationArea = Basic;
                    Caption = 'Tax Payable On Reverse Charge';
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
        GLSetup.Get;
        CompanyInfo.Get;
        SalesSetup.Get;
        case SalesSetup."Logo Position on Documents" of
            SalesSetup."logo position on documents"::"No Logo":
                ;
            SalesSetup."logo position on documents"::Left:
                begin
                    CompanyInfo.CalcFields(Picture);
                end;
            SalesSetup."logo position on documents"::Center:
                begin
                    CompanyInfo1.Get;
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."logo position on documents"::Right:
                begin
                    CompanyInfo2.Get;
                    CompanyInfo2.CalcFields(Picture);
                end;
        end;
    end;

    var
        DetailedGSTLedgerEntry1: Record "Detailed GST Ledger Entry";
        SGST_Amt: Decimal;
        IGST_Amt: Decimal;
        CGST_Amt: Decimal;
        Per_IGST: Decimal;
        Per_CGST: Decimal;
        Per_SGST: Decimal;
        desc: Text;
        desc1: Text;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        RespCenter: Record "Responsibility Center";
        //Language: Record Language; //IG_DS_before
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
        BillTo: Record Customer;
        // PSOLDet: Record UnknownRecord13798;
        // PSOLDet1: Record UnknownRecord13798;
        FreightAmt: Decimal;
        ForAmt: Decimal;
        Check: Report Check;
        NoInText: array[2] of Text[250];
        ExInText: array[2] of Text[250];
        SrNo: Integer;
        DespLine: Record "Sales Line";
        // ExciseSetup: Record UnknownRecord13711;
        BED1: Text[100];
        Ecess: Text[100];
        SHE: Text[100];
        SaleInvLine: Record "Sales Invoice Line";
        TaxText: Text[100];
        SalesScheduleBuffer: Record "SSD Sales Schedule Buffer";
        PackDesc: array[100] of Text[100];
        PackDescQty: array[100] of Text[100];
        PackCounter: Integer;
        TotalPack: Integer;
        TotalWeight: Decimal;
        ExciseTarrifNos: array[15] of Text[30];
        RecCrossReference: Record "Item Reference";
        Comments: array[2] of Text[150];
        SaleCommentLine: Record "Sales Comment Line";
        ShippingAgent: Record "Shipping Agent";
        PackingSlipNo: Text[100];
        AREDetails: Record "SSD ARE1 Details";
        OrderDate: Date;
        Item2: Record Item;
        InvNoNew: Code[10];
        OrderNoNew: Code[10];
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
        Customer_Road_Permit_No_CaptionLbl: label 'Customer Road Permit No.';
        Invoice_No_CaptionLbl: label 'Invoice No.';
        Sales_Invoice_Header___Posting_Date_CaptionLbl: label 'Date';
        Removal_Date_TimeCaptionLbl: label 'Removal Date/Time';
        Excise_Tarrif_No_CaptionLbl: label 'Excise Tarrif No.';
        WO_No____DateCaptionLbl: label 'WO No. / Date';
        DestinationCaptionLbl: label 'Destination';
        Payment_TermsCaptionLbl: label 'Payment Terms';
        Goods_insured_under_BAGICL_Marine_Cargo_CaptionLbl: label 'Goods insured under BAGICL Marine Cargo';
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
        Gtotal: Decimal;
        CrossRefValue: Text;
        BedAmt: Decimal;
        LineCount_Num: label 'LineCount_Number';
        XX: Integer;
        ECessAmount: Decimal;
        SheCessAmount: Decimal;
        TaxableAmount: Decimal;
        SIL: Record "Sales Invoice Line";
        GrandTotal_Rounded: Decimal;
        FixedRows: Integer;
        RowsCount: Integer;
        ILE: Record "Item Ledger Entry";
        QRMng: Codeunit "QR Code Management";
        Cust3: Record Customer;
        reccust: Record Customer;
        recItem: Record Item;
        GSTGroup: Record "GST Group";
        // GSTText: Text;
        GSTText1: Text;
        GSTText2: Text;
        GSTText3: Text;
        GSTSetup: Record "GST Setup";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        CGSTAMT: Decimal;
        bool: Boolean;
        TotalGstAMount: Decimal;
        TotalGstAMountintext: array[5] of Text[250];
        RecSIL: Record "Sales Invoice Line";
        RecState: Record State;
        PlaceOfDelivery: Text[100];
        PlaceOfSupply: Text[100];
        ShipToAdd: Record "Ship-to Address";
        RecState1: Record State;
        TaxPayableonOnReverseCharge: Boolean;
        reccust1: Record Customer;
        ShipToGST: Text;
        Remarks_ALL: Text;
        AmountInWords: array[2] of Text;
        TotAmt: Decimal;
        TotAmt2: Decimal;
        SalesInvoiceLine2: Record "Sales Invoice Line";
        ExchangeRate: Decimal;
        GrandInvValue: Decimal;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(4) <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        if "Sales Invoice Line"."Shipment No." <> '' then if SalesShipmentHeader.Get("Sales Invoice Line"."Shipment No.") then exit(SalesShipmentHeader."Posting Date");
        if "Sales Invoice Header"."Order No." = '' then exit("Sales Invoice Header"."Posting Date");
        case "Sales Invoice Line".Type of
            "Sales Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Invoice Line");
            "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource, "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Invoice Line");
            "Sales Invoice Line".Type::" ":
                exit(0D);
        end;
        SalesShipmentBuffer.Reset;
        SalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
        SalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
        if SalesShipmentBuffer.Find('-') then begin
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            if SalesShipmentBuffer.Next = 0 then begin
                SalesShipmentBuffer.Get(SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.Delete;
                exit(SalesShipmentBuffer2."Posting Date");
            end;
            SalesShipmentBuffer.CalcSums(Quantity);
            if SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity then begin
                SalesShipmentBuffer.DeleteAll;
                exit("Sales Invoice Header"."Posting Date");
            end;
        end
        else
            exit("Sales Invoice Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SetCurrentkey("Document No.");
        ValueEntry.SetRange("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SetRange("Item Charge No.", '');
        ValueEntry.SetFilter("Entry No.", '%1..', FirstValueEntryNo);
        if ValueEntry.Find('-') then
            repeat
                if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                    if SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 then
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    else
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(SalesInvoiceLine2, -Quantity, ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            until (ValueEntry.Next = 0) or (TotalQuantity = 0);
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
        TotalQuantity := 0;
        SalesInvoiceHeader.SetCurrentkey("Order No.");
        SalesInvoiceHeader.SetFilter("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        if SalesInvoiceHeader.Find('-') then
            repeat
                SalesInvoiceLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SetRange("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SetRange("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                if SalesInvoiceLine2.Find('-') then
                    repeat
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    until SalesInvoiceLine2.Next = 0;
            until SalesInvoiceHeader.Next = 0;
        SalesShipmentLine.SetCurrentkey("Order No.", "Order Line No.");
        SalesShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SetRange("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SetRange("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SetFilter(Quantity, '<>%1', 0);
        if SalesShipmentLine.Find('-') then
            repeat
                if "Sales Invoice Header"."Get Shipment Used" then CorrectShipment(SalesShipmentLine);
                if Abs(SalesShipmentLine.Quantity) <= Abs(TotalQuantity - SalesInvoiceLine.Quantity) then
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                else begin
                    if Abs(SalesShipmentLine.Quantity) > Abs(TotalQuantity) then SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity := SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;
                    if SalesShipmentHeader.Get(SalesShipmentLine."Document No.") then begin
                        AddBufferEntry(SalesInvoiceLine, Quantity, SalesShipmentHeader."Posting Date");
                    end;
                end;
            until (SalesShipmentLine.Next = 0) or (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetCurrentkey("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SetRange("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SetRange("Shipment Line No.", SalesShipmentLine."Line No.");
        if SalesInvoiceLine.Find('-') then
            repeat
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            until SalesInvoiceLine.Next = 0;
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SetRange("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SetRange("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SetRange("Posting Date", PostingDate);
        if SalesShipmentBuffer.Find('-') then begin
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
            SalesShipmentBuffer.Modify;
            exit;
        end;
        with SalesShipmentBuffer do begin
            "Document No." := SalesInvoiceLine."Document No.";
            "Line No." := SalesInvoiceLine."Line No.";
            "Entry No." := NextEntryNo;
            Type := SalesInvoiceLine.Type;
            "No." := SalesInvoiceLine."No.";
            Quantity := QtyOnShipment;
            "Posting Date" := PostingDate;
            Insert;
            NextEntryNo := NextEntryNo + 1
        end;
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        if "Sales Invoice Header"."Prepayment Invoice" then exit(Text010);
        exit(Text004);
    end;
}
