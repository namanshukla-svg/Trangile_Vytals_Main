Report 50248 "Sales Invoice-Commercial1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sales Invoice-Commercial1.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Sales Invoice-Commercial New';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(ReportForNavId_5581;5581)
            {
            }
            column(Coments; Coments)
            {
            }
            column(AmtRound2; AmtRound2)
            {
            }
            column(StateCode1; StateCode1)
            {
            }
            column(RespCent_Name; CmpInfo.Name)
            {
            }
            column(Page_No____FORMAT_CurrReport_PAGENO_;'Page No. ' + Format(CurrReport.PageNo))
            {
            }
            column(CmpInfo_Picture; CmpInfo.Picture)
            {
            }
            // column(AmounttoCustomer_SalesInvoiceHeader;"Sales Invoice Header"."Amount to Customer")
            // {
            // }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Sell_to_Customer_Name_; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(DataItem1000000001; "Sales Invoice Header"."Sell-to Address" + ' ' + "Sales Invoice Header"."Sell-to Address 2" + ' ' + "Sales Invoice Header"."Sell-to City")
            {
            }
            column(VendGSTIN; Customer."GST Registration No.")
            {
            }
            column("Code"; "Sales Invoice Line"."GST Group Code")
            {
            }
            column(City; Customer.City)
            {
            }
            column(SC; Customer."State Code")
            {
            }
            column(Customer__Phone_No__; Customer."Phone No.")
            {
            }
            // column(Customer__C_S_T__No__;Customer."C.S.T. No.")
            // {
            // }
            // column(Customer__E_C_C__No__;Customer."E.C.C. No.")
            // {
            // }
            // column(Customer__T_I_N__No__;Customer."T.I.N. No.")
            // {
            // }
            column(CustomerPANNo; Customer."P.A.N. No.")
            {
            }
            column(ReportText; ReportText)
            {
            }
            column(Sales_Invoice_Header__No__; "No.")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___External_Document_No__; "Sales Invoice Header"."External Document No.")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___External_Doc__Date_; "Sales Invoice Header"."External Doc. Date")
            {
            }
            column(FORMAT__Sales_Invoice_Header___Posting_Date__; Format("Sales Invoice Header"."Posting Date"))
            {
            }
            column(TIN_NO____RespCent__T_I_N__No_____SERVICE_TAX_NO____RespCent__Service_Tax_Registration_No____PAN_No___RespCentPANNo;' GSTIN. ' + CmpInfo."GST Registration No." + ' PAN No. ' + RespCent."P.A.N. No.")
            {
            }
            column(PAYTERM_Description; PAYTERM.Description)
            {
            }
            column(Sales_Invoice_Line__Quantity; "Sales Invoice Line".Quantity)
            {
            }
            column(Sales_Invoice_Line__Amount; "Sales Invoice Line".Amount)
            {
            }
            column(Inv_Value__In_Words____;'Inv Value (In Words) :')
            {
            }
            column(Service_Tax___ServTaxText;'Service Tax ' + ServTaxText)
            {
            }
            // column(DataItem1000000040;"Sales Invoice Line"."Service Tax Amount"+"Sales Invoice Line"."Service Tax eCess Amount"+"Sales Invoice Line"."Service Tax SHE Cess Amount")
            // {
            // }
            column(TaxAmount; TaxAmount)
            {
            }
            column(SalesTaxPer_____formInfo; SalesTaxPer + ' ' + formInfo)
            {
            }
            column(Freight_;'Freight')
            {
            }
            column(FreightAmt; FreightAmt)
            {
            }
            column(Sales_Invoice_Line___Amount_To_Customer_;0.00)
            {
            }
            column(GRAND_TOTAL__;'GRAND TOTAL ')
            {
            }
            column(Place_of_Delivery___;'Place of Delivery :')
            {
            }
            column(For_Zavenir_Daubert_India_Private_Limited_;'For ' + CmpInfo.Name)
            {
            }
            column(Taxable_Amount_;'Taxable Amount')
            {
            }
            column(Transporter__;'Transporter:')
            {
            }
            column(Vehicle_No__;'Vehicle No.')
            {
            }
            column(Freight_Basic_;'Price Basic INCOTERM 2020')
            {
            }
            column(Remark_;'Remark')
            {
            }
            column(ST38_No__;'E-Way Bill No.')
            {
            }
            column(Customer_Road_Permit_No__;'Customer Road Permit No.')
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Mode_of_Transport_; "Sales Invoice Header"."Mode of Transport")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Vehicle_No_; "Sales Invoice Header"."Vehicle No1")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header__Freight; "Sales Invoice Header".Freight)
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header__Remarks; "Sales Invoice Header".Remarks)
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___ST38_No_; "Sales Invoice Header"."ST38 No")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Customer_Road_Permit_No__; "Sales Invoice Header"."Customer Road Permit No.")
            {
            }
            column(Forwarding__;'Forwarding ')
            {
            }
            column(V0_0;0.0)
            {
            }
            column(DataItem1000000087;'Certified that particulars given above are true and the amount indicated represents the price actually charged and that there is no flow of any additional consideration directly or indirectly from the buyer. ')
            {
            }
            column(Rounding_;'Rounding')
            {
            }
            column(AmtRounded; AmtRounded)
            {
            }
            column(Sales_Invoice_Header__Ship_to_Name_; "Ship-to Name")
            {
            }
            column(Sales_Invoice_Header__Ship_to_Name_2_; "Ship-to Name 2")
            {
            }
            column(Sales_Invoice_Header__Ship_to_Address_; "Ship-to Address")
            {
            }
            column(Sales_Invoice_Header__Ship_to_Address_2_; "Ship-to Address 2")
            {
            }
            column(Sales_Invoice_Header__Ship_to_City_; "Ship-to City")
            {
            }
            column(Subject_to_Gurgaon__Haryana__Jurisdiction_;'Subject to Gurgaon (Haryana) Jurisdiction')
            {
            }
            column(SERVICE_CATEGORY__IES__;'SERVICE CATEGORY (IES)')
            {
            }
            column(V1__Packaging_Services_;'1. Packaging Services')
            {
            }
            column(V2__Business_Auxiliary_Services_;'2. Business Auxiliary Services')
            {
            }
            column(COMMERCIAL__TAX_INVOICECaption; COMMERCIAL__TAX_INVOICECaptionLbl)
            {
            }
            column(Buyer__Caption; Buyer__CaptionLbl)
            {
            }
            column(Phone__Caption; Phone__CaptionLbl)
            {
            }
            column(CST_VAT_No___Caption; CST_VAT_No___CaptionLbl)
            {
            }
            column(ECC_No___Caption; ECC_No___CaptionLbl)
            {
            }
            column(INVOICE_NO_______________Caption; INVOICE_NO_______________CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(PURCHASE_ORDER_Caption; PURCHASE_ORDER_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000093; EmptyStringCaption_Control1000000093Lbl)
            {
            }
            column(EmptyStringCaption_Control1000000094; EmptyStringCaption_Control1000000094Lbl)
            {
            }
            column(P_O__DATE__________________Caption; P_O__DATE__________________CaptionLbl)
            {
            }
            column(INVOICE_DATE__Caption; INVOICE_DATE__CaptionLbl)
            {
            }
            column(TIN_No___Caption; TIN_No___CaptionLbl)
            {
            }
            column(PAYMENT_TERMSCaption; PAYMENT_TERMSCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1000000039; EmptyStringCaption_Control1000000039Lbl)
            {
            }
            column(Description_of_Goods__ServicesCaption; Description_of_Goods__ServicesCaptionLbl)
            {
            }
            column(Qty_Caption; Qty_CaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(RATE__In_Rupees_Caption; RATE__In_Rupees_CaptionLbl)
            {
            }
            column(Amount___In_Rupees_Caption; Amount___In_Rupees_CaptionLbl)
            {
            }
            column(S__No_Caption; S__No_CaptionLbl)
            {
            }
            column(Packing_Caption; Packing_CaptionLbl)
            {
            }
            column(Authorized_SignatoryCaption; Authorized_SignatoryCaptionLbl)
            {
            }
            column(Checked_ByCaption; Checked_ByCaptionLbl)
            {
            }
            column(Ship_To_Caption; Ship_To_CaptionLbl)
            {
            }
            column(Fax__91_11_66544052___Email_ccare_zavenir_com___www_zavenir_com___CIN_No__U74899DL1995PTC069625Caption; Fax__91_11_66544052___Email_ccare_zavenir_com___www_zavenir_com___CIN_No__U74899DL1995PTC069625CaptionLbl)
            {
            }
            column(Regus_Rectangle___Level_4___Rectangle_1___D_4__Saket_District_Centre___New_Delhi_110017___Phone__91_11_66544255Caption; LocationName)
            {
            }
            column(Registered_Office__Caption; Registered_Office__CaptionLbl)
            {
            }
            column(LineAmount; LineAmount)
            {
            }
            column(IRN_; EInvoicingRequest."IRN No.")
            {
            }
            column(QRImage; EInvoicingRequest."QR Image")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.")where(Quantity=filter(<>0), "System-Created Entry"=filter(false));

                column(ReportForNavId_1570;1570)
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
                column(SystemCreatedEntry_SalesInvoiceLine; "Sales Invoice Line"."System-Created Entry")
                {
                }
                column(Type_SalesInvoiceLine; "Sales Invoice Line".Type)
                {
                }
                column(Sales_Invoice_Line__Description______Sales_Invoice_Line___Description_2_; "Sales Invoice Line".Description + ' ' + "Sales Invoice Line"."Description 2")
                {
                }
                column(FORMAT__Sales_Invoice_Line__Quantity_; Format("Sales Invoice Line".Quantity))
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Unit_Price_; "Sales Invoice Line"."Unit Price")
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line__Amount; "Sales Invoice Line".Amount)
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Unit_of_Measure_Code_; "Sales Invoice Line"."Unit of Measure Code")
                {
                }
                column(GrandTotal; GrandTotal)
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(Item_Description______Description_2_; Item.Description + ' ' + "Description 2")
                {
                }
                column(FORMAT__Sales_Invoice_Line__Quantity__Control1000000019; Format("Sales Invoice Line".Quantity))
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Unit_Price__Control1000000020; "Sales Invoice Line"."Unit Price")
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line__Amount_Control1000000025; "Sales Invoice Line".Amount)
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Unit_of_Measure_Code__Control1000000027; "Sales Invoice Line"."Unit of Measure Code")
                {
                }
                column(SrNo_Control1000000026; SrNo)
                {
                }
                column(Sales_Invoice_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Invoice_Line_Line_No_; "Line No.")
                {
                }
                column(KKCessAmount_SalesInvoiceLine; KKC)
                {
                }
                column(ServiceTaxSBCAmount_SalesInvoiceLine; SBCess)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //Alle
                    GSTText1:='';
                    GSTText2:='';
                    GSTText3:='';
                    IGST_Perc:=0;
                    IGST_Amt:=0;
                    CGST_Perc:=0;
                    CGST_Amt:=0;
                    SGST_Perc:=0;
                    SGST_Amt:=0;
                    DetailedGSTEntryBuffer.Reset;
                    DetailedGSTEntryBuffer.SetRange("Transaction Type", DetailedGSTEntryBuffer."transaction type"::Sales);
                    DetailedGSTEntryBuffer.SetRange("Document No.", "Sales Invoice Header"."No.");
                    DetailedGSTEntryBuffer.SetRange("Document Type", DetailedGSTEntryBuffer."Document Type"::Invoice);
                    DetailedGSTEntryBuffer.SetRange("Document Line No.", "Line No.");
                    // DetailedGSTEntryBuffer.SetRange()
                    if DetailedGSTEntryBuffer.FindSet then repeat if DetailedGSTEntryBuffer."GST Component Code" = 'IGST' then begin
                                IGST_Perc:=DetailedGSTEntryBuffer."GST %";
                                IGST_Amt:=(Abs(DetailedGSTEntryBuffer."GST Amount"));
                                GSTText1:='IGST ' + FORMAT(IGST_Perc) + '% Rs.' + Format(IGST_Amt);
                            end;
                            if DetailedGSTEntryBuffer."GST Component Code" = 'SGST' then begin
                                SGST_Perc:=DetailedGSTEntryBuffer."GST %";
                                SGST_Amt:=(Abs(DetailedGSTEntryBuffer."GST Amount"));
                                GSTText2:='SGST ' + FORMAT(SGST_Perc) + '% Rs.' + Format(SGST_Amt);
                            end;
                            if DetailedGSTEntryBuffer."GST Component Code" = 'CGST' then begin
                                CGST_Perc:=DetailedGSTEntryBuffer."GST %";
                                //CGST_Amt+=ROUND((ABS(DetailedGSTEntryBuffer."GST Amount")),0.1,'>');
                                CGST_Amt:=(Abs(DetailedGSTEntryBuffer."GST Amount"));
                                GSTText3:='CGST ' + FORMAT(CGST_Perc) + '% Rs.' + Format(CGST_Amt);
                            end;
                        until DetailedGSTEntryBuffer.Next = 0;
                    //Alle
                    // KKC += "KK Cess Amount";
                    // SBCess += "Service Tax SBC Amount";
                    // //->BIS
                    // if Type = Type::"G/L Account" then begin
                    //   if "Sales Invoice Line"."System-Created Entry" then
                    //       AmtRounded+="Sales Invoice Line".Amount;
                    //   if not "Sales Invoice Line"."System-Created Entry" then begin
                    //       TotalAssValue += "Sales Invoice Line".Amount;
                    //       AmtInclExcise += "Sales Invoice Line".Amount+"Sales Invoice Line"."Excise Amount";
                    //   end;
                    SrNo+=1;
                // end;
                // LineAmount+="Line Amount";
                // if Type = Type::Item then begin
                //   TotalAssValue +="Sales Invoice Line".Amount;
                //   AmtInclExcise +="Sales Invoice Line".Amount+"Sales Invoice Line"."Excise Amount";
                //   SrNo+=1;
                //   Item.Reset;
                //   if Item.Get("Sales Invoice Line"."No.") then;
                // end;
                // //<-BIS
                // if "Service Tax Group" <> '' then begin
                //   SerVTaxGroup.Reset;
                //   SerVTaxGroup.SetCurrentkey(Code,"From Date");
                //   SerVTaxGroup.SetRange(Code,"Service Tax Group");
                //   SerVTaxGroup.SetFilter("From Date",'<=%1',"Posting Date");
                //   if SerVTaxGroup.FindLast then begin
                //     if SerVTaxGroup."Service Tax %" <> 0 then begin
                //       if SerVTaxGroup."eCess %" > 0 then
                //         EcessCalc := (SerVTaxGroup."eCess %"/100) * SerVTaxGroup."Service Tax %";
                //       if SerVTaxGroup."SHE Cess %" > 0 then
                //         SHEcessCalc := (SerVTaxGroup."SHE Cess %"/100) * SerVTaxGroup."Service Tax %";
                //       ServiceTaxCalc := SerVTaxGroup."Service Tax %" + SHEcessCalc + EcessCalc;
                //     end;
                //   end;
                // end;
                // if "Service Tax Amount" <> 0 then begin
                //   if ServiceTaxCalc > 0 then
                //     ServTaxText := Format(ServiceTaxCalc) + ' %'
                //   else
                //     ServTaxText := '';
                // end else
                // ServTaxText := '';
                // if "Tax %" <> 0 then begin
                //   SalesTaxPer := "Tax Area Code"+' '+ Format("Tax %") + ' % ';
                //   TaxAmount += "Sales Invoice Line"."Tax Amount";
                // end else begin
                //   SalesTaxPer := '';
                //   TaxAmount := 0;
                //   SalesTaxText := '';
                // end;
                // TotalTCSAmount+="Sales Invoice Line"."Total TDS/TCS Incl. SHE CESS";
                // GrandTotal += "Amount To Customer";
                // Countt := 0;
                // //IF SrNo=SILCount THEN BEGIN
                //   Check.InitTextVariable;
                //   Check.FormatNoText(ExciseAmtInWords,AmtInclExcise,'');
                //   "Sales Invoice Header".CalcFields("Amount to Customer");
                //   Check.FormatNoText(AmtInWords,"Sales Invoice Header"."Amount to Customer",'');
                // //END;
                // NumPage:=NumPage-1;
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemLinkReference = "Sales Invoice Line";
                DataItemTableView = sorting(Number);

                column(ReportForNavId_1000000068;1000000068)
                {
                }
                column(IntegerOccurces; IntegerOccurcesCaptionLbl)
                {
                }
                column(AmountInWords1; AmtInWords[1])
                {
                }
                // dataitem(UnknownTable16522; UnknownTable16522)
                // {
                //     DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No.");
                //     DataItemLinkReference = "Sales Invoice Line";
                //     DataItemTableView = sorting("Entry No.");
                //     column(ReportForNavId_2256; 2256)
                //     {
                //     }
                //     column(DocumentNo_DetailedTaxEntry; "Detailed Tax Entry"."Document No.")
                //     {
                //     }
                //     trigger OnAfterGetRecord()
                //     begin
                //         Countt += 1;
                //         if Countt = 1 then begin
                //             //SalesTaxPer :="Detailed Tax Entry"."Tax Area Code"+' '+ FORMAT("Tax %") + ' % ';
                //             //TaxAmount += ABS("Tax Amount");
                //             //SalesTaxText1 := '';
                //         end;
                //         if Countt = 2 then begin
                //             SalesTaxPer1 := Format("Tax %") + ' % ';
                //             TaxAmount1 += Abs("Tax Amount");
                //             SalesTaxText1 := SalesTaxText;
                //         end
                //     end;
                // }
                trigger OnAfterGetRecord()
                begin
                    NumPage:=NumPage - 1;
                end;
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, NumPage);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                // Alle-[E-INV] <<
                //EInvoicingPublishers.CheckEInvoiceStatusForReportPrinting(1,"No."); //Alle-[E-INV]
                Clear(EInvoicingRequest);
                EInvoicingRequest.Reset;
                EInvoicingRequest.SetCurrentkey("Document Type", "Document No.", "E-Invoice Generated");
                EInvoicingRequest.SetRange("Document Type", 4);
                EInvoicingRequest.SetRange("Document No.", "Sales Invoice Header"."No.");
                EInvoicingRequest.SetRange("E-Invoice Generated", true);
                if EInvoicingRequest.FindFirst then begin
                    GenerateQRCode(EInvoicingRequest);
                    EInvoicingRequest.CalcFields("QR Image");
                end;
                if Customer.Get("Sales Invoice Header"."Sell-to Customer No.")then;
                if location.Get("Location Code")then begin
                    if stateNameRec.get(location."State Code")then stateName:=stateNameRec.Description;
                    ReportText:=location.Address + ' ' + location."Address 2" + ' ' + location.City + ' ' + location."Post Code" + stateName + location.County + ' PHONE NO.' + location."Phone No." + ' ' + 'FAX NO.  ' + location."Fax No.";
                end;
                if "Tax Area Code" <> '' then begin
                    TaxAreaCode:=StrLen("Tax Area Code");
                    SalesTaxText:=CopyStr("Tax Area Code", TaxAreaCode - 2, TaxAreaCode);
                end;
                //<<<<< ALLE[551]
                FreightAmt:=0;
                // PostedStructure.Reset;
                // PostedStructure.SetRange(PostedStructure.Type, PostedStructure.Type::Sale);
                // PostedStructure.SetRange(PostedStructure."No.", "Sales Invoice Header"."No.");
                // PostedStructure.SetRange(PostedStructure."Tax/Charge Type", PostedStructure."tax/charge type"::Charges);
                // PostedStructure.SetRange(PostedStructure."Tax/Charge Group", 'FREIGHT');
                // if PostedStructure.FindFirst then
                //     FreightAmt := PostedStructure."Calculation Value";
                Clear(Coments);
                SalesComment.Reset;
                SalesComment.SetRange("Document Type", SalesComment."document type"::"Posted Invoice");
                SalesComment.SetRange("No.", "Sales Invoice Header"."No.");
                if SalesComment.FindFirst then repeat if Coments = '' then Coments:=SalesComment.Comment
                        else
                            Coments:=Coments + ', ' + SalesComment.Comment;
                    until SalesComment.Next = 0;
                //>>>>> ALLE[551]
                SIL.Reset;
                SIL.SetRange("Document No.", "No.");
                SILCount:=SIL.Count;
                //-> From Section
                if Customer.Get("Sales Invoice Header"."Bill-to Customer No.")then;
                // SinvLine.Reset;
                // SinvLine.SetCurrentkey("Document No.","Line No.");
                // SinvLine.SetRange("Document No.","No.");
                // SinvLine.SetFilter("Excise Prod. Posting Group",'<>%1','');
                // if SinvLine.FindFirst then
                //   TariffHeading := SinvLine."Excise Prod. Posting Group"
                // else
                //   TariffHeading := '';
                // SinvLine.Reset;
                // SinvLine.SetCurrentkey("Document No.","Line No.");
                // SinvLine.SetRange("Document No.","No.");
                // SinvLine.SetFilter("Excise Prod. Posting Group",'<>%1','');
                // if SinvLine.FindFirst then begin
                //   ExcisePostingSetup.Reset;
                //   ExcisePostingSetup.SetCurrentkey("Excise Bus. Posting Group","Excise Prod. Posting Group","From Date",SSI);
                //   ExcisePostingSetup.SetRange("Excise Bus. Posting Group",SinvLine."Excise Bus. Posting Group");
                //   ExcisePostingSetup.SetRange("Excise Prod. Posting Group",SinvLine."Excise Prod. Posting Group");
                //   ExcisePostingSetup.SetFilter("From Date",'<=%1',"Posting Date");
                //   if ExcisePostingSetup.FindLast then;
                // end;
                // SinvLine.Reset;
                // SinvLine.SetCurrentkey("Document No.","Line No.");
                // SinvLine.SetRange("Document No.","No.");
                // if SinvLine.FindFirst then
                //   TaxPer := "Sales Invoice Line"."Tax %"
                // else
                //   TaxPer := 0;
                PAYTERM.Reset;
                if PAYTERM.Get("Payment Terms Code")then;
                STATE1.Reset;
                STATE1.SetRange(STATE1.Code, Customer."State Code");
                if STATE1.FindFirst then StateCode1:=STATE1."State Code (GST Reg. No.)";
                SalesInvoiceLine2.Reset;
                SalesInvoiceLine2.SetRange("Document No.", "No.");
                SalesInvoiceLine2.SetRange(SalesInvoiceLine2."System-Created Entry", true);
                if SalesInvoiceLine2.FindFirst then AmtRound2:=SalesInvoiceLine2.Amount;
            end;
            trigger OnPreDataItem()
            begin
                CmpInfo.Reset;
                if CmpInfo.Get then;
                CmpInfo.CalcFields(CmpInfo.Picture);
                CmpInfo.CalcFields(CmpInfo."New Logo2");
                NumPage:=15;
                TaxAmount:=0;
                // if Location.Get("Location Code") then
                LocationName:=CmpInfo.Name + '|' + CmpInfo.Address + '|' + CmpInfo."Address 2" + '|' + CmpInfo.City + CmpInfo."Post Code" + CmpInfo.County + '| Phone' + CmpInfo."Phone No.";
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
    var GSTText1: Text;
    GSTText2: Text;
    GSTText3: Text;
    stateNameRec: Record State;
    StateName: Text[50];
    Location: Record Location;
    LocationName: Text;
    StateCode1: Code[10];
    STATE1: Record State;
    Vendor1: Record Vendor;
    Customer: Record Customer;
    RespCent: Record "Responsibility Center";
    SinvLine: Record "Sales Invoice Line";
    TariffHeading: Code[20];
    TotalAssValue: Decimal;
    AmtInclExcise: Decimal;
    // ExcisePostingSetup: Record UnknownRecord13711;
    Check: Report Check;
    ExciseAmtInWords: array[2]of Text[250];
    TaxPer: Decimal;
    AmtInWords: array[2]of Text[250];
    // SerVTaxGroup: Record UnknownRecord16472;
    ServTaxText: Text[30];
    SHEcessCalc: Decimal;
    EcessCalc: Decimal;
    ServiceTaxCalc: Decimal;
    SalesTaxPer: Text[30];
    TaxAmount: Decimal;
    TaxAreaCode: Integer;
    SalesTaxText: Text[30];
    GrandTotal: Decimal;
    Countt: Integer;
    SalesTaxPer1: Text[30];
    TaxAmount1: Decimal;
    SalesTaxText1: Text[30];
    ComercialInvforImportExport: Boolean;
    TotalTCSAmount: Decimal;
    CmpInfo: Record "Company Information";
    ReportText: Text[400];
    SrNo: Integer;
    AmtRounded: Decimal;
    Item: Record Item;
    FreightAmt: Decimal;
    // PostedStructure: Record UnknownRecord13760;
    formInfo: Text[30];
    SalesComment: Record "Sales Comment Line";
    Coments: Text[250];
    PAYTERM: Record "Payment Terms";
    COMMERCIAL__TAX_INVOICECaptionLbl: label 'COMMERCIAL/ TAX INVOICE';
    Buyer__CaptionLbl: label 'Buyer :';
    Phone__CaptionLbl: label 'Phone';
    CST_VAT_No___CaptionLbl: label 'CST/VAT No. :';
    ECC_No___CaptionLbl: label 'ECC No. :';
    INVOICE_NO_______________CaptionLbl: label 'INVOICE NO.              ';
    EmptyStringCaptionLbl: label ':';
    PURCHASE_ORDER_CaptionLbl: label 'PURCHASE ORDER ';
    EmptyStringCaption_Control1000000093Lbl: label ':';
    EmptyStringCaption_Control1000000094Lbl: label ':';
    P_O__DATE__________________CaptionLbl: label 'P.O. DATE                  ';
    INVOICE_DATE__CaptionLbl: label 'INVOICE DATE :';
    TIN_No___CaptionLbl: label 'TIN No. :';
    PAYMENT_TERMSCaptionLbl: label 'PAYMENT TERMS';
    EmptyStringCaption_Control1000000039Lbl: label ':';
    Description_of_Goods__ServicesCaptionLbl: label 'Description of Goods/ Services';
    Qty_CaptionLbl: label 'Qty.';
    UOMCaptionLbl: label 'UOM';
    RATE__In_Rupees_CaptionLbl: label 'RATE (In Rupees)';
    Amount___In_Rupees_CaptionLbl: label 'Amount  (In Rupees)';
    S__No_CaptionLbl: label 'S. No.';
    Packing_CaptionLbl: label 'Packing:';
    Authorized_SignatoryCaptionLbl: label 'Authorized Signatory';
    Checked_ByCaptionLbl: label 'Checked By';
    Ship_To_CaptionLbl: label 'Ship To:';
    Fax__91_11_66544052___Email_ccare_zavenir_com___www_zavenir_com___CIN_No__U74899DL1995PTC069625CaptionLbl: label 'Fax +91 11 66544052 | Email ccare@zavenir.com | www.zavenir.com | CIN No. U74899DL1995PTC069625';
    // Regus_Rectangle___Level_4___Rectangle_1___D_4__Saket_District_Centre___New_Delhi_110017___Phone__91_11_66544255CaptionLbl: label 'Regus Rectangle | Level-4 | Rectangle 1 | D-4, Saket District Centre | New Delhi 110017 | Phone +91 11 66544255';
    Registered_Office__CaptionLbl: label 'Registered Office :';
    SIL: Record "Sales Invoice Line";
    SILCount: Integer;
    IntegerOccurcesCaptionLbl: label 'IntegerOccurces';
    NumPage: Integer;
    LineAmount: Decimal;
    KKC: Decimal;
    SBCess: Decimal;
    DetailedGSTEntryBuffer: Record "Detailed GST Ledger Entry";
    IGST_Perc: Decimal;
    IGST_Amt: Decimal;
    CGST_Perc: Decimal;
    CGST_Amt: Decimal;
    SGST_Perc: Decimal;
    SGST_Amt: Decimal;
    SalesInvoiceLine2: Record "Sales Invoice Line";
    EInvoicingRequest: Record "SSD E-Invoicing Requests";
    FileManagement: Codeunit "File Management";
    TempBlob: Codeunit "Temp Blob";
    AmtRound2: Decimal;
    procedure GenerateQRCode(var EInvoicingRequests: Record "SSD E-Invoicing Requests")
    var
        QRCodeInput: Text[1024];
        QRCodeFileName: Text[1024];
        Text50000: label 'QR Code doesn''t exist for Document No %1, as its E-Invoice is not processed.';
    begin
    // QRCodeInput := EInvoicingRequests."Signed QR Code"+EInvoicingRequests."Signed QR Code2"+EInvoicingRequests."Signed QR Code3"+EInvoicingRequests."Signed QR Code4";
    // QRCodeFileName := GetQRCode(QRCodeInput);
    // QRCodeFileName := MoveToMagicPath(QRCodeFileName); // To avoid confirmation dialogue on RTC
    // // Load the image from file into the BLOB field
    // Clear(TempBlob);
    // FileManagement.BLOBImport(TempBlob,QRCodeFileName);
    // //TempBlob.CALCFIELDS(Blob);
    // if TempBlob.Blob.Hasvalue then begin
    //   EInvoicingRequests."QR Image" := TempBlob.Blob;
    //   EInvoicingRequests.Modify;
    // end;
    // // Erase the temporary file
    // if not ISSERVICETIER then
    //   if Exists(QRCodeFileName) then
    //     Erase(QRCodeFileName);
    end;
// local procedure GetQRCode(QRCodeInput: Text[1024]) QRCodeFileName: Text[1024]
// var
//     [RunOnClient]
//     IBarCodeProvider: dotnet IBarcodeProvider;
// begin
//     GetBarCodeProvider(IBarCodeProvider);
//     QRCodeFileName := IBarCodeProvider.GetBarcode(QRCodeInput);
// end;
// procedure MoveToMagicPath(SourceFileName: Text[1024]) DestinationFileName: Text[1024]
// var
//     FileSystemObject: Automation FileSystemObject;
// begin
//     // User Temp Path
//     DestinationFileName := FileManagement.ClientTempFileName('');
//     if ISCLEAR(FileSystemObject) then
//       Create(FileSystemObject,true,true);
//     FileSystemObject.MoveFile(SourceFileName,DestinationFileName);
// end;
// procedure GetBarCodeProvider(var IBarCodeProvider: dotnet IBarcodeProvider)
// var
//     [RunOnClient]
//     QRCodeProvider: dotnet QRCodeProvider;
// begin
//     QRCodeProvider := QRCodeProvider.QRCodeProvider;
//     IBarCodeProvider := QRCodeProvider;
// end;
}
