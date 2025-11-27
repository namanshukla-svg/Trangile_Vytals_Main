Report 50451 "Export Invoice-GST"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Export Invoice-GST.rdl';
    Caption = 'Export Invoice-GST';
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(ReportForNavId_5581; 5581)
            {
            }
            column(No_SalesInvHdr; "No.")
            {
            }
            column(InvDiscountAmountCaption; InvDiscountAmountCaptionLbl)
            {
            }
            column(VATPercentageCaption; VATPercentageCaptionLbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(ShiptoName_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Name")
            {
            }
            column(ShiptoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Address")
            {
            }
            column(ShiptoCity_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to City")
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(PaymentTermsCaption; PaymentTermsCaptionLbl)
            {
            }
            column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
            {
            }
            column(PaymentMethodCode_SalesInvoiceHeader; "Sales Invoice Header"."Payment Method Code")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(BilltoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Address")
            {
            }
            column(BilltoCity_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to City")
            {
            }
            column(Frieght; Frieght)
            {
            }
            column(PACKING; PACKING)
            {
            }
            column(INSURANCE; INSURANCE)
            {
            }
            column(TRANSPORT; TRANSPORT)
            {
            }
            column(GST_Bill_to_State_Code; "Sales Invoice Header"."GST Bill-to State Code")
            {
            }
            column(GST_Ship_to_State_Code; "Sales Invoice Header"."GST Ship-to State Code")
            {
            }
            column(COMP_PIC; CompanyInfo.Picture)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_5701; 5701)
                {
                }
                column(CopyString; CopyString)
                {
                }
                column(Number_CopyLoop; CopyLoop.Number)
                {
                }
                column(OutputNoy; OutputNo)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));

                    column(ReportForNavId_6455; 6455)
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(DocumentCaptionCopyText; StrSubstNo(DocumentCaption, CopyText))
                    {
                    }
                    column(CompanyRegistrationLbl; CompanyRegistrationLbl)
                    {
                    }
                    column(CompanyInfo_GST_RegistrationNo; CompanyInfo."GST Registration No.")
                    {
                    }
                    column(CustomerRegistrationLbl; CustomerRegistrationLbl)
                    {
                    }
                    column(Customer_GST_RegistrationNo; Customer."GST Registration No.")
                    {
                    }
                    column(GSTComponentCode1; GSTComponentCode[1] + ' Amount')
                    {
                    }
                    column(GSTComponentCode2; GSTComponentCode[2] + ' Amount')
                    {
                    }
                    column(GSTComponentCode3; GSTComponentCode[3] + ' Amount')
                    {
                    }
                    column(GSTComponentCode4; GSTComponentCode[4] + 'Amount')
                    {
                    }
                    column(GSTCompAmount1; Abs(GSTCompAmount[1]))
                    {
                    }
                    column(GSTCompAmount2; Abs(GSTCompAmount[2]))
                    {
                    }
                    column(GSTCompAmount3; Abs(GSTCompAmount[3]))
                    {
                    }
                    column(GSTCompAmount4; Abs(GSTCompAmount[4]))
                    {
                    }
                    column(IsGSTApplicable; IsGSTApplicable)
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BillToCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr; Format("Sales Invoice Header"."Posting Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesInvHdr; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvoiceHdr; Format("Sales Invoice Header"."Due Date", 0, 4))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourReference_SalesInvHdr; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OrderNo_SalesInvoiceHdr; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(DocDate_SalesInvHeader; Format("Sales Invoice Header"."Document Date", 0, 4))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(PricesInclVATYesNo; Format("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    // column(PLAEntryNo_SalesInvHdr; "Sales Invoice Header"."PLA Entry No.")
                    // {
                    // }
                    column(SupplementaryText; SupplementaryText)
                    {
                    }
                    // column(RG23AEntryNo_SalesInvHdr; "Sales Invoice Header"."RG 23 A Entry No.")
                    // {
                    // }
                    // column(RG23CEntryNo_SalesInvHdr; "Sales Invoice Header"."RG 23 C Entry No.")
                    // {
                    // }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionCap)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(DueDateCaption; DueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(PostingDateCaption; PostingDateCaptionLbl)
                    {
                    }
                    column(PLAEntryNoCaption; PLAEntryNoCaptionLbl)
                    {
                    }
                    column(RG23AEntryNoCaption; RG23AEntryNoCaptionLbl)
                    {
                    }
                    column(RG23CEntryNoCaption; RG23CEntryNoCaptionLbl)
                    {
                    }
                    column(ServiceTaxRegistrationNoCaption; ServiceTaxRegistrationNoLbl)
                    {
                    }
                    column(ServiceTaxRegistrationNo; ServiceTaxRegistrationNo)
                    {
                    }
                    column(BillToCustNo_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    column(CompanyInfoName; CompanyInfo.Name)
                    {
                    }
                    column(CompanyInfoCity; CompanyInfo.City)
                    {
                    }
                    column(CompanyInfoState; StateName)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                        column(ReportForNavId_7574; 7574)
                        {
                        }
                        column(DimText; DimText)
                        {
                        }
                        column(Number_Integer; Number)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FindSet then CurrReport.Break;
                            end
                            else if not Continue then CurrReport.Break;
                            Clear(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText := StrSubstNo('%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.Next = 0;
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
                        DataItemTableView = sorting("Document No.", "Line No.");

                        column(ReportForNavId_1570; 1570)
                        {
                        }
                        column(LineNo_SalesInvoiceLine; "Sales Invoice Line"."Line No.")
                        {
                        }
                        column(Desc_SalesInvLine; Description)
                        {
                        }
                        column(No_SalesInvLine; "No.")
                        {
                        }
                        column(Qty_SalesInvLine; Quantity)
                        {
                        }
                        column(UOM_SalesInvoiceLine; "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_SalesInvLine; "Line Discount %")
                        {
                        }
                        column(LineDiscount_SalesInvLineAmount; "Line Discount Amount")
                        {
                        }
                        column(PostedShipmentDate; Format(PostedShipmentDate))
                        {
                        }
                        column(SalesLineType; Format("Sales Invoice Line".Type))
                        {
                        }
                        // column(DirectDebitPLARG_SalesInvLine; "Direct Debit To PLA / RG")
                        // {
                        // }
                        // column(SourceDocNo_SalesInvLine; "Source Document No.")
                        // {
                        // }
                        // column(Supplementary; Supplementary)
                        // {
                        // }
                        column(InvDiscountAmount; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalesInvoiceLineAmount; Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        // column(AmtInclVAT_SalesInvLine; "Amount To Customer")
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
                        // column(TaxAmount_SalesInvLine; "Tax Amount")
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
                        column(SalesInvLineTotalTDSTCSInclSHECESS; TotalTCSAmount)
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
                        column(AppliedServTaxSHECessAmt; AppliedServiceTaxSHECessAmt)
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
                        column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscountOnVAT; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalAmountVAT; TotalAmountVAT)
                        {
                        }
                        column(LineNo_SalesInvLine; "Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscountCaption; DiscountCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(LineDiscountCaption; LineDiscountCaptionLbl)
                        {
                        }
                        column(PostedShipmentDateCaption; PostedShipmentDateCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(ExciseAmountCaption; ExciseAmountCaptionLbl)
                        {
                        }
                        column(TaxAmountCaption; TaxAmountCaptionLbl)
                        {
                        }
                        column(ServiceTaxAmountCaption; ServiceTaxAmountCaptionLbl)
                        {
                        }
                        column(ChargesAmountCaption; ChargesAmountCaptionLbl)
                        {
                        }
                        column(OtherTaxesAmountCaption; OtherTaxesAmountCaptionLbl)
                        {
                        }
                        column(ServTaxeCessAmtCaption; ServTaxeCessAmtCaptionLbl)
                        {
                        }
                        column(TCSAmountCaption; TCSAmountCaptionLbl)
                        {
                        }
                        column(SvcTaxAmtAppliedCaption; SvcTaxAmtAppliedCaptionLbl)
                        {
                        }
                        column(SvcTaxeCessAmtAppliedCaption; SvcTaxeCessAmtAppliedCaptionLbl)
                        {
                        }
                        column(ServTaxSHECessAmtCaption; ServTaxSHECessAmtCaptionLbl)
                        {
                        }
                        column(SvcTaxSHECessAmtAppliedCaption; SvcTaxSHECessAmtAppliedCaptionLbl)
                        {
                        }
                        column(PaymentDiscVATCaption; PaymentDiscVATCaptionLbl)
                        {
                        }
                        column(Description_SalesInvLineCaption; FieldCaption(Description))
                        {
                        }
                        column(No_SalesInvoiceLineCaption; FieldCaption("No."))
                        {
                        }
                        column(Quantity_SalesInvoiceLineCaption; FieldCaption(Quantity))
                        {
                        }
                        column(UOM_SalesInvoiceLineCaption; FieldCaption("Unit of Measure"))
                        {
                        }
                        // column(DirectDebitPLARG_SalesInvLineCaption;FieldCaption("Direct Debit To PLA / RG"))
                        // {
                        // }
                        column(ServiceTaxSBCAmt; ServiceTaxSBCAmt)
                        {
                        }
                        column(AppliedServiceTaxSBCAmt; AppliedServiceTaxSBCAmt)
                        {
                        }
                        column(ServTaxSBCAmtCaption; ServTaxSBCAmtCaptionLbl)
                        {
                        }
                        column(SvcTaxSBCAmtAppliedCaption; SvcTaxSBCAmtAppliedCaptionLbl)
                        {
                        }
                        column(KKCessAmt; KKCessAmt)
                        {
                        }
                        column(AppliedKKCessAmt; AppliedKKCessAmt)
                        {
                        }
                        column(KKCessAmtCaption; KKCessAmtCaptionLbl)
                        {
                        }
                        column(KKCessAmtAppliedCaption; KKCessAmtAppliedCaptionLbl)
                        {
                        }
                        // column(GSTBaseAmount_SalesInvoiceLine; "Sales Invoice Line"."GST Base Amount")
                        // {
                        // }
                        column(GstAmt; GstAmt)
                        {
                        }
                        column(Sno; Sno)
                        {
                        }
                        column(cgstamt; CGST_Amt)
                        {
                        }
                        column(sgstamt; SGST_Amt)
                        {
                        }
                        column(igstamt; IGST_Amt)
                        {
                        }
                        column(HSNSACCode_SalesInvoiceLine; "Sales Invoice Line"."HSN/SAC Code")
                        {
                        }
                        column(Tot; Tot)
                        {
                        }
                        column(TotAmt1; TotAmt1)
                        {
                        }
                        column(TotAmt2; TotAmt2)
                        {
                        }
                        column(AmtInwords; CurrCode + '' + AmtInWords[1] + '' + AmtInWords[2])
                        {
                        }
                        column(Disc; Disc)
                        {
                        }
                        dataitem("Sales Shipment Buffer"; "Integer")
                        {
                            DataItemTableView = sorting(Number);

                            column(ReportForNavId_1484; 1484)
                            {
                            }
                            column(SalesShpBufferPostingDate; Format(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShipmentBufferQty; SalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShipmentCaption; ShipmentCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then
                                    SalesShipmentBuffer.Find('-')
                                else
                                    SalesShipmentBuffer.Next;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                SalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
                                SetRange(Number, 1, SalesShipmentBuffer.Count);
                            end;
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                            column(ReportForNavId_3591; 3591)
                            {
                            }
                            column(DimText_DimensionLoop2; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FindSet then CurrReport.Break;
                                end
                                else if not Continue then CurrReport.Break;
                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText := StrSubstNo('%1, %2 %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then CurrReport.Break;
                                DimSetEntry2.SetRange("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = sorting(Number);

                            column(ReportForNavId_9462; 9462)
                            {
                            }
                            column(TempPostedAsmLineNo; BlanksForIndent + TempPostedAsmLine."No.")
                            {
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineVariantCode; BlanksForIndent + TempPostedAsmLine."Variant Code")
                            {
                                // DecimalPlaces = 0:5;
                            }
                            column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                                // DecimalPlaces = 0:5;
                            }
                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record "Item Translation";
                            begin
                                if Number = 1 then
                                    TempPostedAsmLine.FindSet
                                else
                                    TempPostedAsmLine.Next;
                                if ItemTranslation.Get(TempPostedAsmLine."No.", TempPostedAsmLine."Variant Code", "Sales Invoice Header"."Language Code") then TempPostedAsmLine.Description := ItemTranslation.Description;
                            end;

                            trigger OnPreDataItem()
                            begin
                                Clear(TempPostedAsmLine);
                                if not DisplayAssemblyInformation then CurrReport.Break;
                                CollectAsmInformation;
                                Clear(TempPostedAsmLine);
                                SetRange(Number, 1, TempPostedAsmLine.Count);
                            end;
                        }
                        trigger OnAfterGetRecord()
                        var
                        // StructureLineDetails: Record UnknownRecord13798;
                        begin
                            cgstamt := 0;
                            igstamt := 0;
                            sgstamt := 0;
                            TotAmt2 := 0;
                            Tot := 0;
                            Sno := Sno + 1;
                            PostedShipmentDate := 0D;
                            if Quantity <> 0 then PostedShipmentDate := FindPostedShipmentDate;
                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then "No." := '';
                            VATAmountLine.Init;
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            if "Allow Invoice Disc." then VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine;
                            // TotalTCSAmount += "Total TDS/TCS Incl. SHE CESS";
                            // TotalSubTotal += "Line Amount";
                            // TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            // TotalAmount += Amount;
                            // TotalAmountVAT += "Amount Including VAT" - Amount;
                            // // TotalAmountInclVAT += "Amount Including VAT";
                            // TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                            // TotalAmountInclVAT += "Amount To Customer";
                            // TotalExciseAmt +=  "Excise Amount";
                            // TotalTaxAmt +=  "Tax Amount";
                            // ServiceTaxAmount += "Service Tax Amount";
                            // ServiceTaxeCessAmount += "Service Tax eCess Amount";
                            // ServiceTaxSHECessAmount += "Service Tax SHE Cess Amount";
                            // ServiceTaxSBCAmount += "Service Tax SBC Amount";
                            // KKCessAmount += "KK Cess Amount";
                            // if IsGSTApplicable and (Type <> Type::" ") then begin
                            //   J := 1;
                            //   GSTComponent.Reset;
                            //   GSTComponent.SetRange("GST Jurisdiction Type","GST Jurisdiction Type");
                            //   if GSTComponent.FindSet then
                            //     repeat
                            //       GSTComponentCode[J] := GSTComponent.Code;
                            //       DetailedGSTLedgerEntry.Reset;
                            //       DetailedGSTLedgerEntry.SetCurrentkey("Transaction Type","Document Type","Document No.","Document Line No.");
                            //       DetailedGSTLedgerEntry.SetRange("Transaction Type",DetailedGSTLedgerEntry."transaction type"::Sales);
                            //       DetailedGSTLedgerEntry.SetRange("Document No.","Document No.");
                            //       DetailedGSTLedgerEntry.SetRange("Document Line No.","Line No.");
                            //       DetailedGSTLedgerEntry.SetRange("GST Component Code",GSTComponentCode[J]);
                            //       if DetailedGSTLedgerEntry.FindSet then begin
                            //         repeat
                            //           GSTCompAmount[J] += DetailedGSTLedgerEntry."GST Amount";
                            //         until DetailedGSTLedgerEntry.Next = 0;
                            //         J += 1;
                            //       end;
                            //     until GSTComponent.Next = 0;
                            // end;
                            // StructureLineDetails.Reset;
                            // StructureLineDetails.SetRange(Type,StructureLineDetails.Type::Sale);
                            // StructureLineDetails.SetRange("Document Type",StructureLineDetails."document type"::Invoice);
                            // StructureLineDetails.SetRange("Invoice No.","Document No.");
                            // StructureLineDetails.SetRange("Item No.","No.");
                            // StructureLineDetails.SetRange("Line No.","Line No.");
                            // if StructureLineDetails.Find('-') then
                            //   repeat
                            //     if not StructureLineDetails."Payable to Third Party" then begin
                            //       if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::Charges then
                            //         ChargesAmount := ChargesAmount + Abs(StructureLineDetails.Amount);
                            //       if StructureLineDetails."Tax/Charge Type" = StructureLineDetails."tax/charge type"::"Other Taxes" then
                            //         OtherTaxesAmount := OtherTaxesAmount + Abs(StructureLineDetails.Amount);
                            //     end;
                            //   until StructureLineDetails.Next = 0;
                            // if "Sales Invoice Header"."Transaction No. Serv. Tax" <> 0 then begin
                            //   ServiceTaxEntry.Reset;
                            //   ServiceTaxEntry.SetRange(Type,ServiceTaxEntry.Type::Sale);
                            //   ServiceTaxEntry.SetRange("Document Type",ServiceTaxEntry."document type"::Invoice);
                            //   ServiceTaxEntry.SetRange("Document No.","Document No.");
                            //   if ServiceTaxEntry.FindFirst then begin
                            //     if "Sales Invoice Header"."Currency Code" <> '' then begin
                            //       ServiceTaxEntry."Service Tax Amount" :=
                            //         ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //         "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                            //         ServiceTaxEntry."Service Tax Amount","Sales Invoice Header"."Currency Factor"));
                            //       ServiceTaxEntry."eCess Amount" :=
                            //         ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //         "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                            //         ServiceTaxEntry."eCess Amount","Sales Invoice Header"."Currency Factor"));
                            //       ServiceTaxEntry."SHE Cess Amount" :=
                            //         ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //         "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                            //         ServiceTaxEntry."SHE Cess Amount","Sales Invoice Header"."Currency Factor"));
                            //       ServiceTaxEntry."Service Tax SBC Amount" :=
                            //         ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //         "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                            //         ServiceTaxEntry."Service Tax SBC Amount","Sales Invoice Header"."Currency Factor"));
                            //       ServiceTaxEntry."KK Cess Amount" :=
                            //         ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //         "Sales Invoice Header"."Posting Date","Sales Invoice Header"."Currency Code",
                            //         ServiceTaxEntry."KK Cess Amount","Sales Invoice Header"."Currency Factor"));
                            //     end;
                            // ServiceTaxAmt := Abs(ServiceTaxEntry."Service Tax Amount");
                            // ServiceTaxECessAmt := Abs(ServiceTaxEntry."eCess Amount");
                            // ServiceTaxSHECessAmt := Abs(ServiceTaxEntry."SHE Cess Amount");
                            // ServiceTaxSBCAmt := Abs(ServiceTaxEntry."Service Tax SBC Amount");
                            // KKCessAmt := Abs(ServiceTaxEntry."KK Cess Amount");
                            // AppliedServiceTaxAmt := ServiceTaxAmount - Abs(ServiceTaxEntry."Service Tax Amount");
                            // AppliedServiceTaxECessAmt := ServiceTaxeCessAmount - Abs(ServiceTaxEntry."eCess Amount");
                            // AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount - Abs(ServiceTaxEntry."SHE Cess Amount");
                            // AppliedServiceTaxSBCAmt := ServiceTaxSBCAmount - Abs(ServiceTaxEntry."Service Tax SBC Amount");
                            // AppliedKKCessAmt := KKCessAmount - Abs(ServiceTaxEntry."KK Cess Amount");
                            //   end else begin
                            //     AppliedServiceTaxAmt := ServiceTaxAmount;
                            //     AppliedServiceTaxECessAmt := ServiceTaxeCessAmount;
                            //     AppliedServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
                            //     AppliedServiceTaxSBCAmt := ServiceTaxSBCAmount;
                            //     AppliedKKCessAmt := KKCessAmount;
                            //   end;
                            // end else begin
                            //       ServiceTaxAmt := ServiceTaxAmount;
                            //       ServiceTaxECessAmt := ServiceTaxeCessAmount;
                            //       ServiceTaxSHECessAmt := ServiceTaxSHECessAmount;
                            //       ServiceTaxSBCAmt := ServiceTaxSBCAmount;
                            //       KKCessAmt := KKCessAmount
                            //     end;
                            //Alle[NJ]
                            DetailedGSTLedgerEntry.Reset;
                            DetailedGSTLedgerEntry.SetRange("Document No.", "Document No.");
                            DetailedGSTLedgerEntry.SetRange("Document Line No.", "Line No.");
                            if DetailedGSTLedgerEntry.FindSet then
                                repeat
                                    if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then
                                        cgstamt := Abs(DetailedGSTLedgerEntry."GST Amount")
                                    else if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then
                                        sgstamt := Abs(DetailedGSTLedgerEntry."GST Amount")
                                    else if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then igstamt := Abs(DetailedGSTLedgerEntry."GST Amount");
                                until DetailedGSTLedgerEntry.Next = 0;
                            //Alle[NJ]
                            RecSalesInvoiceLine.Reset;
                            RecSalesInvoiceLine.SetRange("Document No.", "Document No.");
                            RecSalesInvoiceLine.SetRange("Line No.", "Line No.");
                            if RecSalesInvoiceLine.FindFirst then begin
                                Tot := (Quantity) * ("Unit Price");
                            end;
                            Tot1 += (Quantity) * ("Unit Price");
                            TotAmt1 := Tot1 + cgstamt + sgstamt + igstamt;
                            Disc += "Inv. Discount Amount";
                            //Alle Shivam++
                            TotAmt2 := TotAmt1 + Frieght + INSURANCE + TRANSPORT + PACKING - Disc;
                            CheckReport.InitTextVariable;
                            CurrCode := "Sales Invoice Header"."Currency Code";
                            CheckReport.FormatNoText(AmtInWords, TotAmt2, CurrCode);
                            //Alle Shivam--
                        end;

                        trigger OnPreDataItem()
                        begin
                            //TotAmt1:=0;
                            VATAmountLine.DeleteAll;
                            SalesShipmentBuffer.Reset;
                            SalesShipmentBuffer.DeleteAll;
                            FirstValueEntryNo := 0;
                            MoreLines := Find('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do MoreLines := Next(-1) <> 0;
                            if not MoreLines then CurrReport.Break;
                            SetRange("Line No.", 0, "Line No.");
                            // CurrReport.CreateTotals("Line Amount",Amount,"Amount Including VAT","Inv. Discount Amount","Excise Amount","Tax Amount",
                            //   "Service Tax Amount","Service Tax eCess Amount","Amount To Customer","Service Tax SBC Amount");
                            // CurrReport.CreateTotals("KK Cess Amount");
                            // CurrReport.CreateTotals("Service Tax SHE Cess Amount");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_6558; 6558)
                        {
                        }
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineVATAmount; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLineLineAmount; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT_VATCounter; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier_VATCounter; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountSpecificationCaption; VATAmountSpecificationCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmountCaption; LineAmountCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount", VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VatCounterLCY; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_9347; 9347)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT_VatCounterLCY; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier_VatCounterLCY; VATAmountLine."VAT Identifier")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY := VATAmountLine.GetBaseLCY("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY := VATAmountLine.GetAmountLCY("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or ("Sales Invoice Header"."Currency Code" = '') then CurrReport.Break;
                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY, VALVATAmountLCY);
                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");
                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := StrSubstNo(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));

                        column(ReportForNavId_3476; 3476)
                        {
                        }
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));

                        column(ReportForNavId_3363; 3363)
                        {
                        }
                        column(SellToCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShipToAddressCaption; ShipToAddressCaptionLbl)
                        {
                        }
                        column(SellToCustNo_SalesInvHdrCaption; "Sales Invoice Header".FieldCaption("Sell-to Customer No."))
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then CurrReport.Break;
                        end;
                    }
                    dataitem(LineFee; "Integer")
                    {
                        DataItemTableView = sorting(Number) order(ascending) where(Number = filter(1 ..));

                        column(ReportForNavId_300; 300)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if not DisplayAdditionalFeeNote then CurrReport.Break;
                            /*
                                //commented.biba
                                IF Number = 1 THEN BEGIN
                                  IF NOT TempLineFeeNoteOnReportHist.FINDSET THEN
                                    CurrReport.BREAK
                                END ELSE
                                  IF TempLineFeeNoteOnReportHist.NEXT = 0 THEN
                                    CurrReport.BREAK;
                                */
                            //commented.biba
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    if state.Get(CompanyInfo."State Code") then StateName := State.Description;
                    if Number > 1 then begin
                        CopyText := Text003;
                        OutputNo += 1;
                    end;
                    case CopyLoop.Number of
                        1:
                            CopyString := 'ORIGINAL';
                        2:
                            CopyString := 'DUPLICATE';
                        3:
                            CopyString := 'ASSESSEE';
                        4:
                            CopyString := 'TRIPLICATE';
                        else
                            CopyString := 'EXTRA COPY';
                    end;
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
                    ServiceTaxSBCAmount := 0;
                    KKCessAmount := 0;
                    OtherTaxesAmount := 0;
                    ChargesAmount := 0;
                    AppliedServiceTaxSHECessAmt := 0;
                    AppliedServiceTaxECessAmt := 0;
                    AppliedServiceTaxAmt := 0;
                    AppliedServiceTaxSBCAmt := 0;
                    AppliedKKCessAmt := 0;
                    ServiceTaxSHECessAmt := 0;
                    ServiceTaxECessAmt := 0;
                    ServiceTaxAmt := 0;
                    ServiceTaxSBCAmt := 0;
                    KKCessAmt := 0;
                    TotalTCSAmount := 0;
                    IGST_Perc := 0;
                    IGST_Amt := 0;
                    CGST_Perc := 0;
                    CGST_Amt := 0;
                    SGST_Perc := 0;
                    SGST_Amt := 0;
                    DetailedGSTLedgerEntry2.Reset;
                    DetailedGSTLedgerEntry2.SetRange("Transaction Type", DetailedGSTLedgerEntry2."transaction type"::Sales);
                    DetailedGSTLedgerEntry2.SetRange("Document No.", "Sales Invoice Header"."No.");
                    //DetailedGSTEntryBuffer.SETRANGE("No.","No.");
                    if DetailedGSTLedgerEntry2.FindSet then
                        repeat
                            if DetailedGSTLedgerEntry2."GST Component Code" = 'IGST' then begin
                                IGST_Perc := DetailedGSTLedgerEntry2."GST %";
                                IGST_Amt += (Abs(DetailedGSTLedgerEntry2."GST Amount"));
                            end;
                            if DetailedGSTLedgerEntry2."GST Component Code" = 'SGST' then begin
                                SGST_Perc := DetailedGSTLedgerEntry2."GST %";
                                SGST_Amt += (Abs(DetailedGSTLedgerEntry2."GST Amount"));
                            end;
                            if DetailedGSTLedgerEntry2."GST Component Code" = 'CGST' then begin
                                CGST_Perc := DetailedGSTLedgerEntry2."GST %";
                                //CGST_Amt+=ROUND((ABS(DetailedGSTEntryBuffer."GST Amount")),0.1,'>');
                                CGST_Amt += (Abs(DetailedGSTLedgerEntry2."GST Amount"));
                            end;
                        until DetailedGSTLedgerEntry2.Next = 0;
                end;

                trigger OnPostDataItem()
                begin
                    /*IF NOT CurrReport.PREVIEW THEN
                          SalesInvCountPrinted.RUN("Sales Invoice Header");*/
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then NoOfLoops := 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                SalesInvLine: Record "Sales Invoice Line";
                Location: Record Location;
            begin
                // CurrReport.Language := Language.GetLanguageID("Language Code");
                // IsGSTApplicable := GSTManagement.IsGSTApplicable(Structure);
                Customer.Get("Bill-to Customer No.");
                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end
                else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");
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
                if not Cust.Get("Bill-to Customer No.") then Clear(Cust);
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
                // FormatAddr.sales(ShipToAddr, "Sales Invoice Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                for i := 1 to ArrayLen(ShipToAddr) do if ShipToAddr[i] <> CustAddr[i] then ShowShippingAddr := true;
                GetLineFeeNoteOnReportHist("No.");
                //commented.biba
                /*IF LogInteraction THEN BEGIN
                    //  IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Bill-to Contact No." <> '' THEN
                          SegManagement.LogDocument(
                            SegManagement.SalesInvoiceInterDocType,"No.",0,0,DATABASE::Contact,"Bill-to Contact No.","Salesperson Code",
                            "Campaign No.","Posting Description",'')
                        ELSE
                          SegManagement.LogDocument(
                            SegManagement.SalesInvoiceInterDocType,"No.",0,0,DATABASE::Customer,"Bill-to Customer No.","Salesperson Code",
                            "Campaign No.","Posting Description",'');
                      END;
                     */
                //commrnted.biba
                // SupplementaryText := '';
                // SalesInvLine.SetRange("Document No.","No.");
                // SalesInvLine.SetRange(Supplementary, true);
                // if SalesInvLine.FindFirst then
                //   SupplementaryText := Text16500;
                // if Location.Get("Location Code") then
                //   ServiceTaxRegistrationNo := Location."Service Tax Registration No."
                // else
                //   ServiceTaxRegistrationNo := CompanyInfo."Service Tax Registration No.";
                // Frieght :=0;
                // PostedStrOrderLineDetails.Reset;
                // PostedStrOrderLineDetails.SetRange("Invoice No.","No.");
                // PostedStrOrderLineDetails.SetRange("Tax/Charge Type",PostedStrOrderLineDetails."tax/charge type"::Charges);
                // if PostedStrOrderLineDetails.FindSet then repeat
                // if PostedStrOrderLineDetails."Tax/Charge Group" = 'FREIGHT' then
                //   Frieght += PostedStrOrderLineDetails.Amount
                // else if PostedStrOrderLineDetails."Tax/Charge Group" = 'PACKING' then
                //   PACKING += PostedStrOrderLineDetails.Amount
                // else if PostedStrOrderLineDetails."Tax/Charge Group" = 'INSURANCE' then
                //   INSURANCE += PostedStrOrderLineDetails.Amount
                // else if PostedStrOrderLineDetails."Tax/Charge Group" = 'TRANSPORT' then
                //   TRANSPORT += PostedStrOrderLineDetails.Amount;
                // until PostedStrOrderLineDetails.Next = 0;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic;
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Assembly Components';
                    }
                    field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Additional Fee Note';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        CompanyInfo1.Get;
        //CompanyInfo1.CALCFIELDS(Picture);
        SalesSetup.Get;
        //CompanyInfo.VerifyAndSetPaymentInfo;
        case SalesSetup."Logo Position on Documents" of
            SalesSetup."logo position on documents"::Left:
                begin
                    CompanyInfo3.Get;
                    CompanyInfo3.CalcFields(Picture);
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

    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then InitLogInteraction;
        Sno := 0;
    end;

    var
        State: Record State;
        StateName: Text;
        IGST_Perc: Decimal;
        IGST_Amt: Decimal;
        CGST_Perc: Decimal;
        CGST_Amt: Decimal;
        SGST_Perc: Decimal;
        SGST_Amt: Decimal;
        DetailedGSTLedgerEntry2: Record "Detailed GST Ledger Entry";
        Text000: label 'Salesperson';
        Text001: label 'Total %1';
        Text003: label ' COPY';
        Text004: label 'Sales - Invoice%1';
        PageCaptionCap: label 'Page %1 of %2';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        // GSTComponent: Record UnknownRecord16405;
        Customer: Record Customer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        //  Language: Record Language; //IG_DS_before
        CurrExchRate: Record "Currency Exchange Rate";
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        // GSTManagement: Codeunit UnknownCodeunit16401;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        GSTCompAmount: array[20] of Decimal;
        GSTComponentCode: array[20] of Code[10];
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
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
        Text007: label 'VAT Amount Specification in ';
        Text008: label 'Local Currency';
        VALExchRate: Text[50];
        Text009: label 'Exchange rate: %1/%2';
        CalculatedExchRate: Decimal;
        Text010: label 'Sales - Prepayment Invoice %1';
        OutputNo: Integer;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        ChargesAmount: Decimal;
        OtherTaxesAmount: Decimal;
        Text13700: label 'Total %1 Incl. Taxes';
        Text13701: label 'Total %1 Excl. Taxes';
        SupplementaryText: Text[30];
        Text16500: label 'Supplementary Invoice';
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
        DisplayAssemblyInformation: Boolean;
        PhoneNoCaptionLbl: label 'Phone No.';
        HomePageCaptionCap: label 'Home Page';
        VATRegNoCaptionLbl: label 'VAT Registration No.';
        GiroNoCaptionLbl: label 'Giro No.';
        BankNameCaptionLbl: label 'Bank';
        BankAccNoCaptionLbl: label 'Account No.';
        DueDateCaptionLbl: label 'Due Date';
        InvoiceNoCaptionLbl: label 'Invoice No.';
        PostingDateCaptionLbl: label 'Posting Date';
        PLAEntryNoCaptionLbl: label 'PLA Entry No.';
        RG23AEntryNoCaptionLbl: label 'RG23A Entry No.';
        RG23CEntryNoCaptionLbl: label 'RG23C Entry No.';
        HeaderDimensionsCaptionLbl: label 'Header Dimensions';
        UnitPriceCaptionLbl: label 'Unit Price';
        DiscountCaptionLbl: label 'Discount %';
        AmountCaptionLbl: label 'Amount';
        LineDiscountCaptionLbl: label 'Line Discount Amount';
        PostedShipmentDateCaptionLbl: label 'Posted Shipment Date';
        SubtotalCaptionLbl: label 'Subtotal';
        ExciseAmountCaptionLbl: label 'Excise Amount';
        TaxAmountCaptionLbl: label 'Tax Amount';
        ServiceTaxAmountCaptionLbl: label 'Service Tax Amount';
        ChargesAmountCaptionLbl: label 'Charges Amount';
        OtherTaxesAmountCaptionLbl: label 'Other Taxes Amount';
        ServTaxeCessAmtCaptionLbl: label 'Service Tax eCess Amount';
        TCSAmountCaptionLbl: label 'TCS Amount';
        SvcTaxAmtAppliedCaptionLbl: label 'Svc Tax Amt (Applied)';
        SvcTaxeCessAmtAppliedCaptionLbl: label 'Svc Tax eCess Amt (Applied)';
        ServTaxSHECessAmtCaptionLbl: label 'Service Tax SHE Cess Amount';
        SvcTaxSHECessAmtAppliedCaptionLbl: label 'Svc Tax SHECess Amt(Applied)';
        PaymentDiscVATCaptionLbl: label 'Payment Discount on VAT';
        ShipmentCaptionLbl: label 'Shipment';
        LineDimensionsCaptionLbl: label 'Line Dimensions';
        VATAmountSpecificationCaptionLbl: label 'VAT Amount Specification';
        InvDiscBaseAmtCaptionLbl: label 'Invoice Discount Base Amount';
        LineAmountCaptionLbl: label 'Line Amount';
        ShipToAddressCaptionLbl: label 'Ship-to Address';
        ServiceTaxRegistrationNo: Code[20];
        ServiceTaxRegistrationNoLbl: label 'Service Tax Registration No.';
        InvDiscountAmountCaptionLbl: label 'Invoice Discount Amount';
        VATPercentageCaptionLbl: label 'VAT %';
        VATAmountCaptionLbl: label 'VAT Amount';
        VATIdentifierCaptionLbl: label 'VAT Identifier';
        TotalCaptionLbl: label 'Total';
        VATBaseCaptionLbl: label 'VAT Base';
        PaymentTermsCaptionLbl: label 'Payment Terms';
        ShipmentMethodCaptionLbl: label 'Shipment Method';
        EMailCaptionLbl: label 'E-Mail';
        DocumentDateCaptionLbl: label 'Document Date';
        DisplayAdditionalFeeNote: Boolean;
        ServTaxSBCAmtCaptionLbl: label 'SBC Amount';
        SvcTaxSBCAmtAppliedCaptionLbl: label 'SBC Amt (Applied)';
        ServiceTaxSBCAmount: Decimal;
        ServiceTaxSBCAmt: Decimal;
        AppliedServiceTaxSBCAmt: Decimal;
        KKCessAmount: Decimal;
        KKCessAmt: Decimal;
        AppliedKKCessAmt: Decimal;
        KKCessAmtCaptionLbl: label 'KKC Amount';
        KKCessAmtAppliedCaptionLbl: label 'KKC Amt (Applied)';
        IsGSTApplicable: Boolean;
        J: Integer;
        CompanyRegistrationLbl: label 'Company Registration No.';
        CustomerRegistrationLbl: label 'Customer GST Reg No.';
        GstAmt: Decimal;
        Sno: Integer;
        cgstamt: Decimal;
        sgstamt: Decimal;
        igstamt: Decimal;
        CopyString: Text[30];
        TotAmt1: Decimal;
        // PostedStrOrderLineDetails: Record UnknownRecord13798;
        Frieght: Decimal;
        PACKING: Decimal;
        INSURANCE: Decimal;
        TRANSPORT: Decimal;
        TotAmt2: Decimal;
        CheckReport: Report Check;
        CurrCode: Code[20];
        AmtInWords: array[2] of Text[100];
        RecSalesInvoiceLine: Record "Sales Invoice Line";
        Tot: Decimal;
        Tot1: Decimal;
        Disc: Decimal;

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
                    if SalesShipmentHeader.Get(SalesShipmentLine."Document No.") then AddBufferEntry(SalesInvoiceLine, Quantity, SalesShipmentHeader."Posting Date");
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

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    procedure CollectAsmInformation()
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        TempPostedAsmLine.DeleteAll;
        if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item then exit;
        with ValueEntry do begin
            SetCurrentkey("Document No.");
            SetRange("Document No.", "Sales Invoice Line"."Document No.");
            SetRange("Document Type", "document type"::"Sales Invoice");
            SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
            SetRange(Adjustment, false);
            if not FindSet then exit;
        end;
        repeat
            if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.") then
                if ItemLedgerEntry."Document Type" = ItemLedgerEntry."document type"::"Sales Shipment" then begin
                    SalesShipmentLine.Get(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) then begin
                        PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
                        if PostedAsmLine.FindSet then
                            repeat
                                TreatAsmLineBuffer(PostedAsmLine);
                            until PostedAsmLine.Next = 0;
                    end;
                end;
        until ValueEntry.Next = 0;
    end;

    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        Clear(TempPostedAsmLine);
        TempPostedAsmLine.SetRange(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SetRange("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SetRange("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SetRange(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SetRange("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        if TempPostedAsmLine.FindFirst then begin
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.Modify;
        end
        else begin
            Clear(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.Insert;
        end;
    end;

    procedure GetUOMText(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PadStr('', 2, ' '));
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        /*TempLineFeeNoteOnReportHist.DELETEALL;
            CustLedgerEntry.SETRANGE("Document Type",CustLedgerEntry."Document Type"::Invoice);
            CustLedgerEntry.SETRANGE("Document No.",SalesInvoiceHeaderNo);
            IF NOT CustLedgerEntry.FINDFIRST THEN
              EXIT;

            IF NOT Customer.GET(CustLedgerEntry."Customer No.") THEN
              EXIT;

            LineFeeNoteOnReportHist.SETRANGE("Cust. Ledger Entry No",CustLedgerEntry."Entry No.");
            LineFeeNoteOnReportHist.SETRANGE("Language Code",Customer."Language Code");
            IF LineFeeNoteOnReportHist.FINDSET THEN BEGIN
              REPEAT
                TempLineFeeNoteOnReportHist.INIT;
                TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.INSERT;
              UNTIL LineFeeNoteOnReportHist.NEXT = 0;
            END ELSE BEGIN
              LineFeeNoteOnReportHist.SETRANGE("Language Code",Language.GetUserLanguage);
              IF LineFeeNoteOnReportHist.FINDSET THEN
                REPEAT
                  TempLineFeeNoteOnReportHist.INIT;
                  TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                  TempLineFeeNoteOnReportHist.INSERT;
                UNTIL LineFeeNoteOnReportHist.NEXT = 0;
            END;
             */
    end;
}
