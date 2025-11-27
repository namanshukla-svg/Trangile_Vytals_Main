Report 50036 "New Sales Register"
{
    // AlleZav1.07/240815   - NEW OBJECT CREATED
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/New Sales Register.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Sales Register New';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("Posting Date", "No.");
            RequestFilterFields = "No.", "Posting Date";

            column(ReportForNavId_5581;5581)
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
            column(SALE_REGISTER_FOR_THE_PERIOD______FORMAT_MinDate_____FORMAT_MaxDate_;'SALE REGISTER FOR THE PERIOD :' + Format(MinDate) + '' + Format(MaxDate))
            {
            }
            column(BEDAmount; BEDAmount)
            {
            }
            column(ScessAmount; ScessAmount)
            {
            }
            column(EcessAmount; EcessAmount)
            {
            }
            column(LineAmountt; LineAmountt)
            {
            }
            // column(Sales_Invoice_Line___Tax_Amount_; "Sales Invoice Line"."Tax Amount")
            // {
            // }
            column(OtherCharges; OtherCharges)
            {
            }
            column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            // column(Sales_Invoice_Line___AED_GSI__Amount_; "Sales Invoice Line"."AED(GSI) Amount")
            // {
            // }
            // column(LineAmountt_BEDAmount_EcessAmount_ScessAmount__Sales_Invoice_Line___AED_GSI__Amount_; LineAmountt + BEDAmount + EcessAmount + ScessAmount + "Sales Invoice Line"."AED(GSI) Amount")
            // {
            // }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(ParticularsCaption; ParticularsCaptionLbl)
            {
            }
            column(INV_NOCaption; INV_NOCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Gross_AmountCaption; Gross_AmountCaptionLbl)
            {
            }
            column(Duty_PayableCaption; Duty_PayableCaptionLbl)
            {
            }
            column(Ed__Cess_PayableCaption; Ed__Cess_PayableCaptionLbl)
            {
            }
            column(Spl__Ed__Cess_PayableCaption; Spl__Ed__Cess_PayableCaptionLbl)
            {
            }
            column(Tax_AmountCaption; Tax_AmountCaptionLbl)
            {
            }
            column(Basic_AmountCaption; Basic_AmountCaptionLbl)
            {
            }
            column(Other_ChargesCaption; Other_ChargesCaptionLbl)
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
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            column(GVAT4Amount; GVAT4Amt)
            {
            }
            column(GVAT5Amount; GVAT5Amount)
            {
            }
            column(GVat12_5Amount; "GVat12.5Amount")
            {
            }
            column(GCST2Amount; GCST2Amount)
            {
            }
            column(GCST5Amount; GCST5Amount)
            {
            }
            column(GCST12_5Amount; "GCST12.5Amount")
            {
            }
            // column(GTotalTDSTCSIncl_SHECESS; "Sales Invoice Line"."Total TDS/TCS Incl. SHE CESS")
            // {
            // }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Posting Date", "Document No.")where(Quantity=filter(>0));

                column(ReportForNavId_1570;1570)
                {
                }
                column(AmounttoCust; AmounttoCust)
                {
                }
                column(LineAmount_SalesInvoiceLine; ROUND("Line Amount", 0.01, '='))
                {
                }
                column(AmounttoCust3; AmounttoCust3)
                {
                }
                column(Sales_Invoice_Line__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Invoice_Line_Quantity; Quantity)
                {
                }
                column(Sales_Invoice_Line__Document_No__; "Document No.")
                {
                }
                column(Sales_Invoice_Header___Sell_to_Customer_Name_; "Sales Invoice Header"."Sell-to Customer Name")
                {
                }
                column(BEDAmount_Control1000000003; BEDAmount)
                {
                }
                column(EcessAmount_Control1000000037; EcessAmount)
                {
                }
                column(ScessAmount_Control1000000040; ScessAmount)
                {
                }
                column(LineAmountt_Control1000000006; LineAmountt)
                {
                }
                // column(Sales_Invoice_Line__Tax_Amount_; "Tax Amount")
                // {
                // }
                column(OtherCharges_Control1000000119; OtherCharges)
                {
                }
                column(TaxRate; TaxRate)
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Tax_Area_Code_; "Sales Invoice Line"."Tax Area Code")
                {
                }
                // column(LineAmountt_BEDAmount_EcessAmount_ScessAmount__Sales_Invoice_Line___AED_GSI__Amount__Control1000000020; LineAmountt + BEDAmount + EcessAmount + ScessAmount + "Sales Invoice Line"."AED(GSI) Amount")
                // {
                // }
                // column(Sales_Invoice_Line__Sales_Invoice_Line___AED_GSI__Amount_; "Sales Invoice Line"."AED(GSI) Amount")
                // {
                // }
                column(Sales_Invoice_Line_Line_No_; "Line No.")
                {
                }
                column(VAT4Amt; VAT4amount)
                {
                }
                column(VAT5amount; VAT5amount)
                {
                }
                column(VAT12_5Amount; "Vat12.5Amount")
                {
                }
                column(CST5Amt; CST5Amt)
                {
                }
                column(CST2Amount; CST2Amount)
                {
                }
                column(CST12_5Amount; "CST12.5Amount")
                {
                }
                // column(TotalTDSTCSInclSHECESS_SalesInvoiceLine; "Sales Invoice Line"."Total TDS/TCS Incl. SHE CESS")
                // {
                // }
                // column(AmountToCustomer_SalesInvoiceLine; "Sales Invoice Line"."Amount To Customer")
                // {
                // }
                // dataitem("TCS Entry"; "TCS Entry")
                // {
                //     DataItemLinkReference = "Sales Invoice Line";
                //     DataItemLink = "Document No." = field("Document No.");
                //     column(eCESS__; "eCESS %") { }
                //     column(eCESS_Amount; "eCESS Amount") { }
                //     trigger OnAfterGetRecord()
                //     begin
                //         EcessAmount := 0;
                //         SetRange("Document Type", "Document Type");
                //         SetRange("Document No.", "Document No.");
                //         SetRange("Posting Date", "Posting Date");
                //         if FindFirst() then begin
                //             EcessAmount := "TCS Entry"."eCESS Amount";
                //         end;
                //     end;
                // }
                trigger OnAfterGetRecord()
                begin
                    EcessAmount:=0;
                    TaxRate:=0;
                    Sn+=1;
                    if "Sales Invoice Header"."Currency Code" <> '' then begin
                        if "Sales Invoice Header"."Currency Factor" <> 0 then begin
                            LineAmountt:="Sales Invoice Line"."Line Amount" / "Sales Invoice Header"."Currency Factor";
                            // BEDAmount := "Sales Invoice Line"."BED Amount" / "Sales Invoice Header"."Currency Factor";
                            // EcessAmount := "Sales Invoice Line"."eCess Amount" / "Sales Invoice Header"."Currency Factor";
                            // ScessAmount := "Sales Invoice Line"."SHE Cess Amount" / "Sales Invoice Header"."Currency Factor";
                            // AdcVatAmount := "Sales Invoice Line"."ADC VAT Amount" / "Sales Invoice Header"."Currency Factor";
                            VAT4amount:=VAT4amount / "Sales Invoice Header"."Currency Factor";
                            "Vat12.5Amount":="Vat12.5Amount" / "Sales Invoice Header"."Currency Factor";
                            VAT5amount:=VAT5amount / "Sales Invoice Header"."Currency Factor";
                            CST2Amount:=CST2Amount / "Sales Invoice Header"."Currency Factor";
                            CST5Amount:=CST5Amount / "Sales Invoice Header"."Currency Factor";
                            "CST12.5Amount":="CST12.5Amount" / "Sales Invoice Header"."Currency Factor";
                            AmounttoCust+=LineAmountt + BEDAmount + EcessAmount + ScessAmount + AdcVatAmount + VAT4amount + "Vat12.5Amount" + VAT5amount + CST2Amount + CST5Amount + "CST12.5Amount";
                        // AmounttoCust +="Amount To Customer"
                        end;
                    end
                    else
                    begin
                        LineAmountt:="Sales Invoice Line"."Line Amount";
                        // BEDAmount := "Sales Invoice Line"."BED Amount";
                        // EcessAmount := "Sales Invoice Line"."eCess Amount";
                        // ScessAmount := "Sales Invoice Line"."SHE Cess Amount";
                        // AdcVatAmount := "Sales Invoice Line"."ADC VAT Amount";
                        AmounttoCust+=LineAmountt + BEDAmount + EcessAmount + ScessAmount + AdcVatAmount + VAT4amount + "Vat12.5Amount" + VAT5amount + CST2Amount + CST5Amount + "CST12.5Amount";
                    // AmounttoCust +="Amount To Customer"
                    end;
                    GVAT4amount+=VAT4amount;
                    "GVat12.5Amount"+="Vat12.5Amount";
                    GCST2Amount+=CST2Amount;
                    "GCST12.5Amount"+="CST12.5Amount";
                    GVAT5Amount+=VAT5amount;
                    GCST5Amount+=CST5Amount;
                    // PostStrOrdDetail.Reset;
                    // PostStrOrdDetail.SetRange(PostStrOrdDetail.Type, PostStrOrdDetail.Type::Sale);
                    // PostStrOrdDetail.SetRange(PostStrOrdDetail."Document Type", PostStrOrdDetail."document type"::Invoice);
                    // PostStrOrdDetail.SetRange(PostStrOrdDetail."Invoice No.", "Sales Invoice Line"."Document No.");
                    // PostStrOrdDetail.SetRange(PostStrOrdDetail."Tax/Charge Type", PostStrOrdDetail."tax/charge type"::Charges);
                    // if PostStrOrdDetail.Find('-') then
                    //     repeat
                    //         OtherCharges += PostStrOrdDetail."Amount (LCY)";
                    //     until PostStrOrdDetail.Next = 0;
                    AmounttoCust+=OtherCharges;
                    TOtherCharges+=OtherCharges;
                    //BIS
                    if Sn = ItemCounter then begin
                        AmounttoCust3:=TOtherCharges;
                    end;
                    SIL.Reset;
                    SIL.SetRange("Document No.", "Document No.");
                    SIL.SetFilter(Quantity, '>%1', 0);
                    //SIL.SETRANGE(Type,SIL.Type::Item);
                    if SIL.FindSet then repeat LineQty+=SIL.Quantity;
                            Basicamt+=SIL."Line Amount";
                            // DutyPay += SIL."BED Amount";
                            // EDCessPay += SIL."eCess Amount";
                            // SpEDCessPay += SIL."SHE Cess Amount";
                            // tcs += SIL."Total TDS/TCS Incl. SHE CESS";
                            // Gross += SIL."Amount To Customer";
                            // if SIL.Type = SIL.Type::Item then begin
                            //     if SIL."Tax %" <> 0 then
                            //         TaxRate := ROUND(SIL."Tax %", 1, '>');
                            //     if SIL."Tax Area Code" = 'VAT' then begin
                            //         if (SIL."Tax %" >= 3.5) and (SIL."Tax %" <= 4.5) then
                            //             VAT4amount := SIL."Tax Amount"
                            //         else
                            //             if (SIL."Tax %" >= 11) and (SIL."Tax %" <= 13.5) then
                            //                 "Vat12.5Amount" := SIL."Tax Amount"
                            //             else
                            //                 if (SIL."Tax %" >= 4.75) and (SIL."Tax %" <= 5.5) then
                            //                     VAT5amount := SIL."Tax Amount";
                            //     end else
                            //         if SIL."Tax Area Code" = 'CST' then begin
                            //             if (SIL."Tax %" >= 1.5) and (SIL."Tax %" <= 2.5) then
                            //                 CST2Amount := SIL."Tax Amount"
                            //             else
                            //                 if (SIL."Tax %" >= 11) and (SIL."Tax %" <= 13.5) then
                            //                     "CST12.5Amount" := SIL."Tax Amount"
                            //                 else
                            //                     if (SIL."Tax %" >= 4.75) and (SIL."Tax %" <= 5.5) then
                            //                         CST5Amount := SIL."Tax Amount";
                            //         end;
                            if(DocNo <> "Document No.") or (LineNo <> "Line No.")then begin
                                VAt4+=VAT4amount;
                                Vat5+=VAT5amount;
                                Vat125+="Vat12.5Amount";
                                Cst2+=CST2Amount;
                                Cst5+=CST5Amount;
                                Cst125+="CST12.5Amount";
                                OtherChar+=OtherCharges;
                            end;
                        // end;
                        until SIL.Next = 0;
                    if DocNo <> "Document No." then begin
                        if(ExportToExcel)then begin
                            Entercell(RowNo, 1, Format("Posting Date"), false, false, true, 2);
                            Entercell(RowNo, 2, Format("Sales Invoice Header"."Sell-to Customer Name"), false, false, true, 0);
                            Entercell(RowNo, 3, Format("Document No."), false, false, true, 0);
                            Entercell(RowNo, 4, Format(LineQty), false, false, true, 0);
                            Entercell(RowNo, 5, Format(Basicamt), false, false, true, 0);
                            Entercell(RowNo, 6, Format(DutyPay), false, false, true, 0);
                            Entercell(RowNo, 7, Format(EDCessPay), false, false, true, 0);
                            Entercell(RowNo, 8, Format(SpEDCessPay), false, false, true, 0);
                            Entercell(RowNo, 9, Format(VAt4), false, false, true, 0);
                            Entercell(RowNo, 10, Format(Vat5), false, false, true, 0);
                            Entercell(RowNo, 11, Format(Vat125), false, false, true, 0);
                            Entercell(RowNo, 12, Format(Cst2), false, false, true, 0);
                            Entercell(RowNo, 13, Format(Cst5), false, false, true, 0);
                            Entercell(RowNo, 14, Format(Cst125), false, false, true, 0);
                            Entercell(RowNo, 15, Format(tcs), false, false, true, 0);
                            Entercell(RowNo, 16, Format(OtherChar), false, false, true, 0);
                            Entercell(RowNo, 17, Format(Gross), false, false, true, 0);
                            RowNo+=1;
                        end;
                    end;
                    LineAmtTot+="Line Amount";
                    // DutyPayTot += "BED Amount";
                    // EcessPayTot += "eCess Amount";
                    // SHEcessPayTot += "SHE Cess Amount";
                    if(DocNo <> "Document No.")then begin
                        VAT4amountTot+=VAt4;
                        VAT5amountTot+=Vat5;
                        "Vat12.5AmountTot"+=Vat125;
                        CST2AmountTot+=Cst2;
                        CST5AmountTot+=Cst5;
                        "CST12.5AmountTot"+=Cst125;
                        OtherChargesTot+=OtherChar;
                    end;
                    "Total TDS/TCS Incl. SHE CESSTot"+=tcs;
                    // AmountToCustomerTot += "Amount To Customer";
                    DocNo:="Document No.";
                    LineNo:="Line No.";
                end;
                trigger OnPostDataItem()
                begin
                //Commented to remove the invoice wise Total
                /*IF ExportToExcel THEN BEGIN                                                          //Alle
                      Entercell(RowNo,1,FORMAT('TOTAL'),FALSE,FALSE,TRUE,2);
                      Entercell(RowNo,5,FORMAT("Sales Invoice Line"."Line Amount"),FALSE,FALSE,TRUE,0);
                      Entercell(RowNo,6,FORMAT("Sales Invoice Line"."BED Amount"),FALSE,FALSE,TRUE,0);
                      Entercell(RowNo,7,FORMAT("Sales Invoice Line"."eCess Amount"),FALSE,FALSE,TRUE,0);
                      Entercell(RowNo,8,FORMAT("Sales Invoice Line"."SHE Cess Amount"),FALSE,FALSE,TRUE,0);
                      Entercell(RowNo,9,FORMAT(GVAT4amount),FALSE,FALSE,TRUE,0); //Alle
                      Entercell(RowNo,10,FORMAT(GVAT5Amount),FALSE,FALSE,TRUE,0);
                      Entercell(RowNo,11,FORMAT("GVat12.5Amount"),FALSE,FALSE,TRUE,0);
                      Entercell(RowNo,12,FORMAT(GCST2Amount),FALSE,FALSE,TRUE,0);     //Alle
                      Entercell(RowNo,13,FORMAT(GCST5Amount),FALSE,FALSE,TRUE,0);
                      Entercell(RowNo,14,FORMAT("GCST12.5Amount"),FALSE,FALSE,TRUE,0);
                      Entercell(RowNo,15,FORMAT("Sales Invoice Line"."Total TDS/TCS Incl. SHE CESS"),FALSE,FALSE,TRUE,0);
                      Entercell(RowNo,16,FORMAT(TOtherCharges),FALSE,FALSE,TRUE,0);
                      Entercell(RowNo,17,FORMAT("Sales Invoice Line"."Amount To Customer"),FALSE,FALSE,TRUE,0);
                      RowNo += 1;                                                                               //Alle
                    END;
                     */
                end;
                trigger OnPreDataItem()
                begin
                    VAT4amount:=0;
                    "Vat12.5Amount":=0;
                    CST2Amount:=0;
                    "CST12.5Amount":=0;
                    VAT5amount:=0;
                    CST5Amount:=0;
                    OtherCharges:=0;
                    // CurrReport.CreateTotals("Line Amount", "BED Amount", "eCess Amount", "SHE Cess Amount", "ADC VAT Amount",
                    //                         LineAmountt, BEDAmount, EcessAmount, ScessAmount, AdcVatAmount);
                    // CurrReport.CreateTotals(VAT4amount, "Vat12.5Amount", VAT5amount, CST2Amount, CST5Amount, "CST12.5Amount", AmounttoCust,
                    //                         OtherCharges, "Tax Amount");
                    AmounttoCust3:=0; //
                    Sn:=0; //
                    DocNo:='';
                    LineQty:=0;
                    Basicamt:=0;
                    DutyPay:=0;
                    EDCessPay:=0;
                    SpEDCessPay:=0;
                    VAt4:=0;
                    Vat5:=0;
                    Vat125:=0;
                    Cst2:=0;
                    Cst5:=0;
                    Cst125:=0;
                    tcs:=0;
                    OtherChar:=0;
                    Gross:=0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                // ........
                // TaxTransactionValue.Reset();
                //     TaxTransactionValue.SetRange("Tax Record ID", "Sales Invoice Line".RecordId);
                //     TaxTransactionValue.SetRange("Tax Type", 'TCS');
                //     TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                //     IF TaxTransactionValue.FindSet() then
                //         repeat
                //             if TaxTransactionValue."Value ID" = 1 then begin
                //                 EcessAmount := TaxTransactionValue.Amount;
                //             end;
                //         until TaxTransactionValue.Next() = 0;
                // ..................
                //AmounttoCust:=0;
                ItemCounter:=0; //
                SIL.Reset;
                SIL.SetRange("Document No.", "No.");
                SIL.SetFilter(Quantity, '<>%1', 0);
                ItemCounter:=SIL.Count;
            end;
            trigger OnPostDataItem()
            begin
                TOtherCharges:=OtherCharges;
                if ExportToExcel then begin
                    Entercell(RowNo, 1, Format('TOTAL'), true, false, false, 0);
                    Entercell(RowNo, 5, Format(LineAmtTot), true, false, true, 0);
                    Entercell(RowNo, 6, Format(DutyPayTot), true, false, true, 0);
                    Entercell(RowNo, 7, Format(EcessPayTot), true, false, true, 0);
                    Entercell(RowNo, 8, Format(SHEcessPayTot), true, false, true, 0);
                    Entercell(RowNo, 9, Format(VAT4amountTot), true, false, true, 0);
                    Entercell(RowNo, 10, Format(VAT5amountTot), true, false, true, 0);
                    Entercell(RowNo, 11, Format("Vat12.5AmountTot"), true, false, true, 0);
                    Entercell(RowNo, 12, Format(CST2AmountTot), true, false, true, 0);
                    Entercell(RowNo, 13, Format(CST5AmountTot), true, false, true, 0);
                    Entercell(RowNo, 14, Format("CST12.5AmountTot"), true, false, true, 0);
                    Entercell(RowNo, 15, Format("Total TDS/TCS Incl. SHE CESSTot"), true, false, true, 0);
                    Entercell(RowNo, 16, Format(OtherChargesTot), true, false, true, 0);
                    Entercell(RowNo, 17, Format(AmountToCustomerTot), true, false, true, 0);
                    RowNo+=1;
                end;
            end;
            trigger OnPreDataItem()
            begin
                CompInfo.Get;
                if UserSetup.Get(UserId)then;
                // CurrReport.CreateTotals("Sales Invoice Line"."Amount To Customer", "Sales Invoice Line"."eCess Amount",
                //     "Sales Invoice Line"."SHE Cess Amount", "Sales Invoice Line"."Line Amount", "Sales Invoice Line"."BED Amount",
                //     "Sales Invoice Line"."Tax Amount", "Sales Invoice Line"."Total TDS/TCS Incl. SHE CESS");
                // CurrReport.CreateTotals(OtherCharges);
                // CurrReport.CreateTotals(LineAmountt, BEDAmount, EcessAmount, ScessAmount, "Sales Invoice Line"."AED(GSI) Amount",
                //                           AdcVatAmount, OtherCharges, AmounttoCust);
                ComapnyAddr[1]:=CompInfo.Address;
                ComapnyAddr[2]:=CompInfo."Address 2";
                ComapnyAddr[3]:=CompInfo.City + '-' + CompInfo."Post Code";
                ComapnyAddr[4]:='Phone No. : ' + CompInfo."Phone No." + ', Fax No. : ' + CompInfo."Fax No.";
                CompressArray(ComapnyAddr);
                if ExportToExcel then begin
                    RowNo+=1;
                    Entercell(RowNo, 1, Format(CompInfo.Name), true, false, true, 1);
                    RowNo+=1;
                    Entercell(RowNo, 1, Format(ComapnyAddr[1]), true, false, true, 1);
                    RowNo+=1;
                    Entercell(RowNo, 1, Format(ComapnyAddr[2]), true, false, true, 1);
                    RowNo+=1;
                    Entercell(RowNo, 1, Format(ComapnyAddr[3]), true, false, true, 1);
                    RowNo+=1;
                    Entercell(RowNo, 1, Format(ComapnyAddr[4]), true, false, true, 1);
                    RowNo+=1;
                    Entercell(RowNo, 1, Format('SALE REGISTER FOR THE PERIOD :' + Format(MinDate) + '' + Format(MaxDate)), true, false, true, 1);
                    RowNo+=1;
                end;
                CreateHeader;
            end;
        }
        dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
        {
            DataItemTableView = sorting("Document No.", "Line No.")where("Document No."=filter('EPR*'));

            column(ReportForNavId_7507;7507)
            {
            }
            column(LineAmount_PurchCrMemoLine; "Line Amount")
            {
            }
            column(Purch__Cr__Memo_Line__Posting_Date_; "Posting Date")
            {
            }
            column(Vend_Name; Vend.Name)
            {
            }
            column(Purch__Cr__Memo_Line__Document_No__; "Document No.")
            {
            }
            column(Purch__Cr__Memo_Line__Purch__Cr__Memo_Line__Quantity; "Purch. Cr. Memo Line".Quantity)
            {
            }
            column(BEDAmount1; BEDAmount1)
            {
            }
            column(EcessAmount1; EcessAmount1)
            {
            }
            column(ScessAmount1; ScessAmount1)
            {
            }
            column(LineAmountt1; LineAmountt1)
            {
            }
            column(AmounttoCust1; AmounttoCust1)
            {
            }
            column(OtherCharges1; OtherCharges1)
            {
            }
            // column(Purch__Cr__Memo_Line__Tax_Amount_; "Tax Amount")
            // {
            // }
            // column(Purch__Cr__Memo_Line__AED_GSI__Amount_; "AED(GSI) Amount")
            // {
            // }
            // column(LineAmountt1_BEDAmount1_EcessAmount1_ScessAmount1__AED_GSI__Amount_; LineAmountt1 + BEDAmount1 + EcessAmount1 + ScessAmount1 + "AED(GSI) Amount")
            // {
            // }
            column(Purch__Cr__Memo_Line__Tax_Area_Code_; "Tax Area Code")
            {
            }
            column(TaxRate_Control1000000065; TaxRate)
            {
            }
            column(ScessAmount1_Control1000000071; ScessAmount1)
            {
            }
            column(EcessAmount1_Control1000000072; EcessAmount1)
            {
            }
            column(BEDAmount1_Control1000000073; BEDAmount1)
            {
            }
            column(LineAmountt1_Control1000000091; LineAmountt1)
            {
            }
            column(GCST2Amt____GCST12_5Amt___GVat12_5Amt__GVAT4Amt_LineAmountt1___BEDAmount1___EcessAmount1___ScessAmount1___AdcVatAmount1; GCST2Amt + "GCST12.5Amt" + "GVat12.5Amt" + GVAT4Amt + LineAmountt1 + BEDAmount1 + EcessAmount1 + ScessAmount1 + AdcVatAmount1)
            {
            }
            column(TOtherCharges1; TOtherCharges1)
            {
            }
            // column(Purch__Cr__Memo_Line__Tax_Amount__Control1000000132; "Tax Amount")
            // {
            // }
            // column(LineAmountt1_BEDAmount1_EcessAmount1_ScessAmount1__AED_GSI__Amount__Control1000000067; LineAmountt1 + BEDAmount1 + EcessAmount1 + ScessAmount1 + "AED(GSI) Amount")
            // {
            // }
            // column(Purch__Cr__Memo_Line__AED_GSI__Amount__Control1000000068; "AED(GSI) Amount")
            // {
            // }
            column(Purchase_Return_Details___Caption; Purchase_Return_Details___CaptionLbl)
            {
            }
            column(DateCaption_Control1000000058; DateCaption_Control1000000058Lbl)
            {
            }
            column(ParticularsCaption_Control1000000061; ParticularsCaption_Control1000000061Lbl)
            {
            }
            column(INV_NOCaption_Control1000000066; INV_NOCaption_Control1000000066Lbl)
            {
            }
            column(QuantityCaption_Control1000000074; QuantityCaption_Control1000000074Lbl)
            {
            }
            column(Gross_AmountCaption_Control1000000075; Gross_AmountCaption_Control1000000075Lbl)
            {
            }
            column(Duty_PayableCaption_Control1000000077; Duty_PayableCaption_Control1000000077Lbl)
            {
            }
            column(Ed__Cess_PayableCaption_Control1000000092; Ed__Cess_PayableCaption_Control1000000092Lbl)
            {
            }
            column(Spl__Ed__Cess_PayableCaption_Control1000000095; Spl__Ed__Cess_PayableCaption_Control1000000095Lbl)
            {
            }
            column(TCSCaption; TCSCaptionLbl)
            {
            }
            column(Basic_AmountCaption_Control1000000100; Basic_AmountCaption_Control1000000100Lbl)
            {
            }
            column(Other_ChargesCaption_Control1000000123; Other_ChargesCaption_Control1000000123Lbl)
            {
            }
            column(AEDCaption_Control1000000035; AEDCaption_Control1000000035Lbl)
            {
            }
            column(Taxable_Amt_Caption_Control1000000039; Taxable_Amt_Caption_Control1000000039Lbl)
            {
            }
            column(Tax_TypeCaption_Control1000000041; Tax_TypeCaption_Control1000000041Lbl)
            {
            }
            column(Tax_RateCaption_Control1000000044; Tax_RateCaption_Control1000000044Lbl)
            {
            }
            column(TotalCaption_Control1000000048; TotalCaption_Control1000000048Lbl)
            {
            }
            column(Purch__Cr__Memo_Line_Line_No_; "Line No.")
            {
            }
            column(VAT4amount1; VAT4Amt)
            {
            }
            column(VAT5Amt1; VAT5Amt)
            {
            }
            column(Vat12_5Amt1; "Vat12.5Amt")
            {
            }
            column(CST2Amt1; CST2Amt)
            {
            }
            column(CST5Amt1; CST5Amt)
            {
            }
            column(CST12_5Amt1; "CST12.5Amt")
            {
            }
            trigger OnAfterGetRecord()
            begin
                LineAmount+="Purch. Cr. Memo Line".Quantity * "Purch. Cr. Memo Line"."Direct Unit Cost";
                TaxRate:=0;
                // if "Tax %" <> 0 then
                //     TaxRate := ROUND("Tax %", 1, '>');
                if Vend.Get("Purch. Cr. Memo Line"."Buy-from Vendor No.")then;
                VAT4Amt:=0;
                "Vat12.5Amt":=0;
                CST2Amt:=0;
                "CST12.5Amt":=0;
                VAT5Amt:=0;
                CST5Amt:=0;
                PCreditMemoLine.Reset;
                PCreditMemoLine.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
                PCreditMemoLine.SetRange(Type, PCreditMemoLine.Type::Item);
                if PCreditMemoLine.Find('-')then begin
                // if PCreditMemoLine."Tax Area Code" = 'VAT' then begin
                //     if (PCreditMemoLine."Tax %" >= 3.5) and (PCreditMemoLine."Tax %" <= 4.5) then
                //         VAT4Amt := "Tax Amount"
                //     else
                //         if (PCreditMemoLine."Tax %" >= 11) and (PCreditMemoLine."Tax %" <= 13.5) then
                //             "Vat12.5Amt" := "Tax Amount"
                //         else
                //             if (PCreditMemoLine."Tax %" >= 4.75) and (PCreditMemoLine."Tax %" <= 5.5) then
                //                 VAT5Amt := "Tax Amount";
                // end else
                //     if PCreditMemoLine."Tax Area Code" = 'CST' then begin
                //         if (PCreditMemoLine."Tax %" >= 1.5) and (PCreditMemoLine."Tax %" <= 2.5) then
                //             CST2Amt := "Tax Amount"
                //         else
                //             if (PCreditMemoLine."Tax %" >= 11) and (PCreditMemoLine."Tax %" <= 13.5) then
                //                 "CST12.5Amt" := "Tax Amount"
                //             else
                //                 if (PCreditMemoLine."Tax %" >= 4.75) and (PCreditMemoLine."Tax %" <= 5.5) then
                //                     CST5Amt := "Tax Amount"
                //     end;
                end;
                if PCreditMemoHead.Get("Purch. Cr. Memo Line"."Document No.")then;
                if PCreditMemoHead."Currency Code" <> '' then begin
                    if PCreditMemoHead."Currency Factor" <> 0 then begin
                        LineAmountt1:="Purch. Cr. Memo Line"."Line Amount" / PCreditMemoHead."Currency Factor";
                        // BEDAmount1 := "Purch. Cr. Memo Line"."BED Amount" / PCreditMemoHead."Currency Factor";
                        // EcessAmount1 := "Purch. Cr. Memo Line"."eCess Amount" / PCreditMemoHead."Currency Factor";
                        // ScessAmount1 := "Purch. Cr. Memo Line"."SHE Cess Amount" / PCreditMemoHead."Currency Factor";
                        // AdcVatAmount1 := "Purch. Cr. Memo Line"."ADC VAT Amount" / PCreditMemoHead."Currency Factor";
                        VAT4Amt:=VAT4Amt / PCreditMemoHead."Currency Factor";
                        "Vat12.5Amt":="Vat12.5Amt" / PCreditMemoHead."Currency Factor";
                        VAT5Amt:=VAT5Amt / PCreditMemoHead."Currency Factor";
                        CST2Amt:=CST2Amt / PCreditMemoHead."Currency Factor";
                        CST5Amt:=CST5Amt / PCreditMemoHead."Currency Factor";
                        "CST12.5Amt":="CST12.5Amt" / PCreditMemoHead."Currency Factor";
                        AmounttoCust1:=LineAmountt1 + BEDAmount1 + EcessAmount1 + ScessAmount1 + AdcVatAmount1 + VAT4Amt + "Vat12.5Amt" + VAT5Amt + CST2Amt + CST5Amt + "CST12.5Amt";
                    end;
                end
                else
                begin
                    LineAmountt1:="Purch. Cr. Memo Line"."Line Amount";
                    // BEDAmount1 := "Purch. Cr. Memo Line"."BED Amount";
                    // EcessAmount1 := "Purch. Cr. Memo Line"."eCess Amount";
                    // ScessAmount1 := "Purch. Cr. Memo Line"."SHE Cess Amount";
                    // AdcVatAmount1 := "Purch. Cr. Memo Line"."ADC VAT Amount";
                    AmounttoCust1:=LineAmountt1 + BEDAmount1 + EcessAmount1 + ScessAmount1 + AdcVatAmount1 + VAT4Amt + "Vat12.5Amt" + VAT5Amt + CST2Amt + CST5Amt + "CST12.5Amt";
                end;
                GVAT4Amt+=VAT4Amt;
                ;
                "GVat12.5Amt"+="Vat12.5Amt";
                GCST2Amt+=CST2Amt;
                "GCST12.5Amt"+="CST12.5Amt";
                GVAT5Amt+=VAT5Amt;
                GCST5Amt+=CST5Amt;
                // PostStrOrdDetail.Reset;
                // PostStrOrdDetail.SetRange(PostStrOrdDetail.Type, PostStrOrdDetail.Type::Sale);
                // PostStrOrdDetail.SetRange(PostStrOrdDetail."Document Type", PostStrOrdDetail."document type"::"Credit Memo");
                // PostStrOrdDetail.SetRange(PostStrOrdDetail."Invoice No.", "Purch. Cr. Memo Line"."Document No.");
                // PostStrOrdDetail.SetRange(PostStrOrdDetail."Tax/Charge Type", PostStrOrdDetail."tax/charge type"::Charges);
                // if PostStrOrdDetail.Find('-') then
                //     repeat
                //         OtherCharges1 := PostStrOrdDetail."Amount (LCY)";
                //     until PostStrOrdDetail.Next = 0;
                AmounttoCust1+=OtherCharges1;
                TOtherCharges1:=OtherCharges1;
            /*
IF ExportToExcel THEN BEGIN
Entercell(RowNo,1,FORMAT("Posting Date"),TRUE,FALSE,TRUE,2);
Entercell(RowNo,2,FORMAT(Vend.Name),TRUE,FALSE,TRUE,0);
Entercell(RowNo,3,FORMAT("Document No."),TRUE,FALSE,TRUE,0);
Entercell(RowNo,4,FORMAT(Quantity),TRUE,FALSE,TRUE,1);
Entercell(RowNo,5,FORMAT("Line Amount"),TRUE,FALSE,TRUE,0);
LineAmtCrTot += "Line Amount";
Entercell(RowNo,6,FORMAT("BED Amount"),TRUE,FALSE,TRUE,0);
BEDAmtCrTot += "Line Amount";
Entercell(RowNo,7,FORMAT("eCess Amount"),TRUE,FALSE,TRUE,0);
ECessAmtCrTot += "eCess Amount";
Entercell(RowNo,8,FORMAT("SHE Cess Amount"),TRUE,FALSE,TRUE,0);
SHECessAmtCrTot += "eCess Amount";
Entercell(RowNo,9,FORMAT(VAT4Amt),TRUE,FALSE,TRUE,0);
VAT4AmtCrTot += VAT4Amt;
Entercell(RowNo,10,FORMAT(VAT5Amt),TRUE,FALSE,TRUE,0);
VAT5AmtCrTot += VAT5Amt;
Entercell(RowNo,11,FORMAT("Vat12.5Amt"),TRUE,FALSE,TRUE,0);
"Vat12.5AmtCrTot" += "Vat12.5Amt";
Entercell(RowNo,12,FORMAT(CST2Amt),TRUE,FALSE,TRUE,0);
CST2AmtCrTot += CST2Amt;
Entercell(RowNo,13,FORMAT(CST5Amt),TRUE,FALSE,TRUE,0);
CST5AmtCrTot += CST5Amt;
Entercell(RowNo,14,FORMAT("CST12.5Amt"),TRUE,FALSE,TRUE,0);
"CST12.5AmtCrTot" += "CST12.5Amt";
Entercell(RowNo,15,FORMAT(''),TRUE,FALSE,TRUE,0);
Entercell(RowNo,16,FORMAT(OtherCharges1),TRUE,FALSE,TRUE,0);
OtherCharges1CrTot += OtherCharges1;
Entercell(RowNo,17,FORMAT(CST2Amt  + CST5Amt+ "CST12.5Amt"+"Vat12.5Amt"+VAT5Amt+VAT4Amt+"SHE Cess Amount"
+"eCess Amount"+"BED Amount"+LineAmount),TRUE,FALSE,TRUE,0);
TotCr += CST2Amt  + CST5Amt+ "CST12.5Amt"+"Vat12.5Amt"+VAT5Amt+VAT4Amt+"SHE Cess Amount"
    +"eCess Amount"+"BED Amount"+LineAmount;
RowNo += 1;
END;
                 */
            end;
            trigger OnPostDataItem()
            begin
            /*IF ExportToExcel THEN BEGIN
                  Entercell(RowNo,1,FORMAT('TOTAL'),TRUE,FALSE,FALSE,0);
                  Entercell(RowNo,5,FORMAT(LineAmtCrTot),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,6,FORMAT(BEDAmtCrTot),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,7,FORMAT(ECessAmtCrTot),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,8,FORMAT(SHECessAmtCrTot),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,9,FORMAT(VAT4AmtCrTot),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,10,FORMAT(VAT5AmtCrTot),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,11,FORMAT("Vat12.5AmtCrTot"),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,12,FORMAT(CST2AmtCrTot),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,13,FORMAT(CST5AmtCrTot),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,14,FORMAT("CST12.5AmtCrTot"),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,15,FORMAT(''),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,16,FORMAT(OtherCharges1CrTot),TRUE,FALSE,TRUE,0);
                  Entercell(RowNo,17,FORMAT(TotCr),TRUE,FALSE,TRUE,0);
                  RowNo += 1;
                END;
                 */
            end;
            trigger OnPreDataItem()
            begin
                "Purch. Cr. Memo Line".SetRange("Purch. Cr. Memo Line"."Posting Date", MinDate, MaxDate);
                LineAmount:=0;
            /*
IF (ExportToExcel) THEN BEGIN
Entercell(RowNo,1,FORMAT('Purchase Return Details :-'),TRUE,TRUE,TRUE,1);
RowNo += 1;
END;
                 */
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number)where(Number=const(1));

            column(ReportForNavId_5444;5444)
            {
            }
            column(AmounttoCust___AmounttoCust1; AmounttoCust + AmounttoCust1)
            {
            }
            column(BEDAmount___BEDAmount1; BEDAmount + BEDAmount1)
            {
            }
            column(ScessAmount___ScessAmount1; ScessAmount + ScessAmount1)
            {
            }
            column(EcessAmount___EcessAmount1; EcessAmount + EcessAmount1)
            {
            }
            column(LineAmountt___LineAmountt1; LineAmountt + LineAmountt1)
            {
            }
            column(TOtherCharges_TOtherCharges1; TOtherCharges + TOtherCharges1)
            {
            }
            // column(Sales_Invoice_Line___Tax_Amount___Purch__Cr__Memo_Line___Tax_Amount_; "Sales Invoice Line"."Tax Amount" + "Purch. Cr. Memo Line"."Tax Amount")
            // {
            // }
            // column(DataItem1000000069; LineAmountt1 + BEDAmount1 + EcessAmount1 + ScessAmount1 + "Purch. Cr. Memo Line"."AED(GSI) Amount" + LineAmountt + BEDAmount + EcessAmount + ScessAmount + "Sales Invoice Line"."AED(GSI) Amount")
            // {
            // }
            // column(Purch__Cr__Memo_Line___AED_GSI__Amount___Sales_Invoice_Line___AED_GSI__Amount_; "Purch. Cr. Memo Line"."AED(GSI) Amount" + "Sales Invoice Line"."AED(GSI) Amount")
            // {
            // }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(Integer_Number; Number)
            {
            }
            trigger OnPostDataItem()
            begin
                if ExportToExcel then begin
                    Entercell(RowNo, 1, Format('GRAND TOTAL'), true, false, false, 1);
                    Entercell(RowNo, 5, Format(LineAmtTot + LineAmtCrTot), true, false, true, 0);
                    Entercell(RowNo, 6, Format(DutyPayTot + BEDAmtCrTot), true, false, true, 0);
                    Entercell(RowNo, 7, Format(EcessPayTot + ECessAmtCrTot), true, false, true, 0);
                    Entercell(RowNo, 8, Format(SHEcessPayTot + SHECessAmtCrTot), true, false, true, 0);
                    Entercell(RowNo, 9, Format(VAT4amountTot + VAT4AmtCrTot), true, false, true, 0);
                    Entercell(RowNo, 10, Format(VAT5amountTot + VAT5AmtCrTot), true, false, true, 0);
                    Entercell(RowNo, 11, Format("Vat12.5AmountTot" + "Vat12.5AmtCrTot"), true, false, true, 0);
                    Entercell(RowNo, 12, Format(CST2AmountTot + CST2AmtCrTot), true, false, true, 0);
                    Entercell(RowNo, 13, Format(CST5AmountTot + CST5AmtCrTot), true, false, true, 0);
                    Entercell(RowNo, 14, Format("CST12.5AmountTot" + "CST12.5AmtCrTot"), true, false, true, 0);
                    Entercell(RowNo, 15, Format("Total TDS/TCS Incl. SHE CESSTot"), true, false, true, 1);
                    Entercell(RowNo, 16, Format(OtherChargesTot + OtherCharges1CrTot), true, false, true, 0);
                    Entercell(RowNo, 17, Format(AmountToCustomerTot + TotCr), true, false, true, 0);
                    RowNo+=1;
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
                field(ExportToExcel; ExportToExcel)
                {
                    ApplicationArea = Basic;
                    Caption = 'Export to Excel';
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
    // if ExportToExcel then
    //     ExcelBuf.CreateBookAndOpenExcel('Sheet 1', '', 'Report', COMPANYNAME, UserId);
    end;
    trigger OnPreReport()
    begin
        // if ResponsibilityCenter.Get(UserSetupMgt.GetRespCenterFilter) then;
        MinDate:="Sales Invoice Header".GetRangeMin("Posting Date");
        MaxDate:="Sales Invoice Header".GetRangemax("Posting Date");
    end;
    var TaxTransactionValue: Record "Tax Transaction Value";
    CompInfo: Record "Company Information";
    ResponsibilityCenter: Record "Responsibility Center";
    ComapnyAddr: array[5]of Text[100];
    UserSetup: Record "User Setup";
    MinDate: Date;
    MaxDate: Date;
    VAT4amount: Decimal;
    "Vat12.5Amount": Decimal;
    CST2Amount: Decimal;
    "CST12.5Amount": Decimal;
    "GVat12.5Amount": Decimal;
    GCST2Amount: Decimal;
    "GCST12.5Amount": Decimal;
    GVAT4amount: Decimal;
    VAT4Amt: Decimal;
    "Vat12.5Amt": Decimal;
    CST2Amt: Decimal;
    "CST12.5Amt": Decimal;
    "GVat12.5Amt": Decimal;
    GCST2Amt: Decimal;
    "GCST12.5Amt": Decimal;
    GVAT4Amt: Decimal;
    LineAmount: Decimal;
    Vend: Record Vendor;
    "--ALLEAY 280710--": Integer;
    VAT5amount: Decimal;
    CST5Amount: Decimal;
    VAT5Amt: Decimal;
    CST5Amt: Decimal;
    GVAT5Amount: Decimal;
    GCST5Amount: Decimal;
    GVAT5Amt: Decimal;
    GCST5Amt: Decimal;
    // PostStrOrdDetail: Record UnknownRecord13798;
    OtherCharges: Decimal;
    OtherCharges1: Decimal;
    TOtherCharges: Decimal;
    TOtherCharges1: Decimal;
    RowNo: Integer;
    Win: Dialog;
    Text50001: label 'Data';
    Text50002: label 'Sales';
    PCreditMemoLine: Record "Purch. Cr. Memo Line";
    LineAmountt: Decimal;
    BEDAmount: Decimal;
    EcessAmount: Decimal;
    ScessAmount: Decimal;
    AmounttoCust: Decimal;
    AdcVatAmount: Decimal;
    LineAmountt1: Decimal;
    BEDAmount1: Decimal;
    EcessAmount1: Decimal;
    ScessAmount1: Decimal;
    AmounttoCust1: Decimal;
    AdcVatAmount1: Decimal;
    PCreditMemoHead: Record "Purch. Cr. Memo Hdr.";
    UserSetupMgt: Codeunit "User Setup Management";
    TaxRate: Integer;
    DateCaptionLbl: label 'Date';
    ParticularsCaptionLbl: label 'Particulars';
    INV_NOCaptionLbl: label 'INV NO';
    QuantityCaptionLbl: label 'Quantity';
    Gross_AmountCaptionLbl: label 'Gross Amount';
    Duty_PayableCaptionLbl: label 'Duty Payable';
    Ed__Cess_PayableCaptionLbl: label 'Ed. Cess Payable';
    Spl__Ed__Cess_PayableCaptionLbl: label 'Spl. Ed. Cess Payable';
    Tax_AmountCaptionLbl: label 'Tax Amount';
    Basic_AmountCaptionLbl: label 'Basic Amount';
    Other_ChargesCaptionLbl: label 'Other Charges';
    AEDCaptionLbl: label 'AED';
    Taxable_Amt_CaptionLbl: label 'Taxable Amt.';
    Tax_TypeCaptionLbl: label 'Tax Type';
    Tax_RateCaptionLbl: label 'Tax Rate';
    TotalCaptionLbl: label 'Total';
    Purchase_Return_Details___CaptionLbl: label 'Purchase Return Details :-';
    DateCaption_Control1000000058Lbl: label 'Date';
    ParticularsCaption_Control1000000061Lbl: label 'Particulars';
    INV_NOCaption_Control1000000066Lbl: label 'INV NO';
    QuantityCaption_Control1000000074Lbl: label 'Quantity';
    Gross_AmountCaption_Control1000000075Lbl: label 'Gross Amount';
    Duty_PayableCaption_Control1000000077Lbl: label 'Duty Payable';
    Ed__Cess_PayableCaption_Control1000000092Lbl: label 'Ed. Cess Payable';
    Spl__Ed__Cess_PayableCaption_Control1000000095Lbl: label 'Spl. Ed. Cess Payable';
    TCSCaptionLbl: label 'TCS';
    Basic_AmountCaption_Control1000000100Lbl: label 'Basic Amount';
    Other_ChargesCaption_Control1000000123Lbl: label 'Other Charges';
    AEDCaption_Control1000000035Lbl: label 'AED';
    Taxable_Amt_Caption_Control1000000039Lbl: label 'Taxable Amt.';
    Tax_TypeCaption_Control1000000041Lbl: label 'Tax Type';
    Tax_RateCaption_Control1000000044Lbl: label 'Tax Rate';
    TotalCaption_Control1000000048Lbl: label 'Total';
    Grand_TotalCaptionLbl: label 'Grand Total';
    AmounttoCust3: Decimal;
    SIL: Record "Sales Invoice Line";
    ItemCounter: Integer;
    Sn: Integer;
    ExportToExcel: Boolean;
    ExcelBuf: Record "Excel Buffer" temporary;
    TempExcelBuffer: Record "Excel Buffer" temporary;
    VAT4_Caption: label 'VAT 4%';
    VAT5_Caption: label 'VAT 5%';
    "VAT12.5_Caption": label 'VAT 12.5%';
    CST2_Caption: label 'CST 2%';
    CST5_Caption: label 'CST 5%';
    "CST12.5_Caption": label 'CST 12.5%';
    LineAmtTot: Decimal;
    DutyPayTot: Decimal;
    EcessPayTot: Decimal;
    SHEcessPayTot: Decimal;
    VAT4amountTot: Decimal;
    VAT5amountTot: Decimal;
    "Vat12.5AmountTot": Decimal;
    CST5AmountTot: Decimal;
    "CST12.5AmountTot": Decimal;
    "Total TDS/TCS Incl. SHE CESSTot": Decimal;
    OtherChargesTot: Decimal;
    AmountToCustomerTot: Decimal;
    CST2AmountTot: Decimal;
    LineAmtCrTot: Decimal;
    BEDAmtCrTot: Decimal;
    ECessAmtCrTot: Decimal;
    SHECessAmtCrTot: Decimal;
    VAT4AmtCrTot: Decimal;
    VAT5AmtCrTot: Decimal;
    "Vat12.5AmtCrTot": Decimal;
    CST2AmtCrTot: Decimal;
    CST5AmtCrTot: Decimal;
    "CST12.5AmtCrTot": Decimal;
    OtherCharges1CrTot: Decimal;
    TotCr: Decimal;
    DocNo: Code[20];
    LineQty: Decimal;
    Basicamt: Decimal;
    DutyPay: Decimal;
    EDCessPay: Decimal;
    SpEDCessPay: Decimal;
    VAt4: Decimal;
    Vat5: Decimal;
    Vat125: Decimal;
    Cst2: Decimal;
    Cst5: Decimal;
    tcs: Decimal;
    OtherChar: Decimal;
    Gross: Decimal;
    Cst125: Decimal;
    LineNo: Integer;
    procedure CalculateDate()
    begin
    end;
    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; Underline: Boolean; CellType: Option Number, Text, Date, Time)
    begin
        ExcelBuf.Init;
        ExcelBuf.Validate("Row No.", RowNo);
        ExcelBuf.Validate("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text":=CellValue;
        ExcelBuf.Formula:='';
        ExcelBuf.Bold:=Bold;
        ExcelBuf.Italic:=Italic;
        ExcelBuf.Underline:=Underline;
        ExcelBuf."Cell Type":=CellType;
        ExcelBuf.Insert;
    end;
    procedure CreateExcelbook()
    begin
    // ExcelBuf.CreateBookAndOpenExcel('Data', '', 'New Sales Register', COMPANYNAME, UserId);
    end;
    procedure CreateHeader()
    begin
        if ExportToExcel then begin
            Entercell(RowNo, 1, Format('Date'), true, false, true, 1);
            Entercell(RowNo, 2, Format('Particulars'), true, false, true, 1);
            Entercell(RowNo, 3, Format('Invoice No.'), true, false, true, 1);
            //  Entercell(RowNo,4,FORMAT('Item No.'),TRUE,FALSE,TRUE,1);
            Entercell(RowNo, 4, Format('Quantity'), true, false, true, 1);
            Entercell(RowNo, 5, Format('Basic Amount'), true, false, true, 1);
            Entercell(RowNo, 6, Format('Duty Payable'), true, false, true, 1);
            Entercell(RowNo, 7, Format('Ed. Cess Payable'), true, false, true, 1);
            Entercell(RowNo, 8, Format('Spl. Ed. Cess Payable'), true, false, true, 1);
            Entercell(RowNo, 9, Format('VAT 4%'), true, false, true, 1);
            Entercell(RowNo, 10, Format('VAT 5%'), true, false, true, 1);
            Entercell(RowNo, 11, Format('VAT 12.5%'), true, false, true, 1);
            Entercell(RowNo, 12, Format('CST 2%'), true, false, true, 1);
            Entercell(RowNo, 13, Format('CST 5%'), true, false, true, 1);
            Entercell(RowNo, 14, Format('CST 12.5%'), true, false, true, 1);
            Entercell(RowNo, 15, Format('TCS'), true, false, true, 1);
            Entercell(RowNo, 16, Format('Other Charges'), true, false, true, 1);
            Entercell(RowNo, 17, Format('Gross Amount'), true, false, true, 1);
            RowNo+=1;
        end;
    end;
}
