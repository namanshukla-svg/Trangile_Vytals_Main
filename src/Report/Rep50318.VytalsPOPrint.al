Report 50318 "Vytals PO Print"
{ // FieldFilter
    // Document Type
    // No.BPOIMP/10-11/00014
    // Comment
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Vytals PO Print.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") order(ascending);
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Posting Date";
            RequestFilterHeading = 'Purchase Order';

            column(ReportForNavId_4458; 4458)
            {
            }
            column(CompInfoogo1; CompInfo."New Logo1")
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(ReportHeaderTxt; ReportHeaderTxt)
            {
            }
            column(DataItem1000000048; '57Th KM STONE, DELHI - JAIPUR HIGHWAY, BINOLA, DISTRICT GURGRAM - 122 413, HARYANA, INDIA\ PHONE ++91 124 4981000, FAX: ++91 124 4981002')
            {
            }
            column(UPPERCASE__Purchase_Header___Buy_from_Vendor_No_____________Purchase_Header___Buy_from_Vendor_Name__; UpperCase("Purchase Header"."Buy-from Vendor No." + '  ' + "Purchase Header"."Buy-from Vendor Name"))
            {
            }
            column(Purchase_Header__No__; "No.")
            {
            }
            column(ORDER_NO__; 'ORDER NO.')
            {
            }
            column(DATE_; 'DATE')
            {
            }
            column(Purchase_Header__Purchase_Header___Order_Date_; "Purchase Header"."Order Date")
            {
            }
            column(UPPERCASE__Purchase_Header___Buy_from_Address__; UpperCase("Purchase Header"."Buy-from Address"))
            {
            }
            column(UPPERCASE__Purchase_Header___Buy_from_Address_2__; UpperCase("Purchase Header"."Buy-from Address 2"))
            {
            }
            column(UPPERCASE__Purchase_Header___Buy_from_City_____________Purchase_Header___Buy_from_Post_Code__; UpperCase("Purchase Header"."Buy-from City" + ' - ' + "Purchase Header"."Buy-from Post Code"))
            {
            }
            column(UPPERCASE_StateRec_Description_; UpperCase(StateRec.Description))
            {
            }
            column(UPPERCASE__Email_____Vendor__E_Mail__; UpperCase('Email ' + Vendor."E-Mail"))
            {
            }
            column(UPPERCASE__Phone_____Vendor__Phone_No___; UpperCase('Phone ' + Vendor."Phone No."))
            {
            }
            column(UPPERCASE__Fax_____Vendor__Fax_No___; UpperCase('Fax ' + Vendor."Fax No."))
            {
            }
            column(UPPERCASE_CompInfo_Name_; UpperCase(CompInfo.Name))
            {
            }
            column(UPPERCASE_CompInfo_Name__Control1000000079; UpperCase(CompInfo.Name))
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Purchase Header"."Payment Terms Code")
            {
            }
            column(RespCent_Address; BilltoAddressText[1])
            {
            }
            column(RespCent__Address_2_; BilltoAddressText[2])
            {
            }
            column(RespCent_City_______RespCent__Post_Code_; BilltoAddressText[3])
            {
            }
            column(RespCent_Address_Control1000000085; RespCent.Address)
            {
            }
            column(RespCent__Address_2__Control1000000086; RespCent."Address 2")
            {
            }
            column(RespCent_City_______RespCent__Post_Code__Control1000000087; RespCent.City + ' - ' + RespCent."Post Code")
            {
            }
            column(ShipAdd1; AddressText[1])
            {
            }
            column(ShipAdd2; AddressText[2])
            {
            }
            column(ShipAdd3; AddressText[3])
            {
            }
            column(Purchaser_Name; Purchaser.Name)
            {
            }
            column(Purchaser__E_Mail_; Purchaser."E-Mail")
            {
            }
            column(RespCent__C_E__Registration_No__; RespCent."C.E. Registration No.")
            {
            }
            column(RespCent__E_C_C__No__; CompInfo."GST Registration No.")
            {
            }
            column(RespCent__C_E__Range_____Div___RespCent__C_E__Division_____Comm____RespCent__C_E__Commissionerate_; RespCent."C.E. Range" + ', Div-' + RespCent."C.E. Division" + ' ,Comm.-' + RespCent."C.E. Commissionerate")
            {
            }
            column(RespCent__L_S_T__No__; RespCent."L.S.T. No.")
            {
            }
            column(RespCent__T_I_N__No__; RespCent."T.I.N. No.")
            {
            }
            column(AmendmentNoTxt; AmendmentNoTxt)
            {
            }
            column(AmendmentDtTxt; AmendmentDtTxt)
            {
            }
            column(Purchase_Header__Vendor_Order_No__; "Vendor Order No.")
            {
            }
            column(Purchase_Header__Purchase_Header___Blanket_Order_Date_; "Purchase Header"."Blanket Order Date")
            {
            }
            column(BlanketOrdDateTxt; BlanketOrdDateTxt)
            {
            }
            column(Purchase_Header__Blanket_Order_No__; "Blanket Order No.")
            {
            }
            column(BlanketOrdTxt; BlanketOrdTxt)
            {
            }
            column(Purchase_Header__Schedule_No__; "Schedule No.")
            {
            }
            column(ScheduleTxt; ScheduleTxt)
            {
            }
            column(CompInfo__New_Logo1_; CompInfo."New Logo1")
            {
            }
            column(S_NO__; 'S#')
            {
            }
            column(ITEM_CODE_; 'ITEM CODE')
            {
            }
            column(ITEM_DESCRIPTION_; 'ITEM DESCRIPTION')
            {
            }
            column(UOM_; 'UOM')
            {
            }
            column(UnitPriceTxt; UnitPriceTxt)
            {
            }
            column(QTY_; 'QTY')
            {
            }
            column(OTHERS_; 'OTHERS')
            {
            }
            column(LineTotalTxt; LineTotalTxt)
            {
            }
            column(Req__Date_; 'REQ. DATE')
            {
            }
            column(S_NO___Control1000000163; 'S.NO.')
            {
            }
            column(ITEM_CODE__Control1000000164; 'ITEM CODE')
            {
            }
            column(ITEM_DESCRIPTION__Control1000000165; 'ITEM DESCRIPTION')
            {
            }
            column(UOM__Control1000000166; 'UOM')
            {
            }
            column(UnitPriceTxt_Control1000000167; UnitPriceTxt)
            {
            }
            column(QTY__Control1000000168; 'QTY')
            {
            }
            column(ShipmentMethod_Description; ShipmentMethod.Description)
            {
            }
            column(TransportMethod_Description; TransportMethod.Description)
            {
            }
            column(Purchase_Header_Insurance; Insurance)
            {
            }
            column(RemarksTxt; RemarksTxt)
            {
            }
            column(PaymentTerms_Description; PaymentTerms.Description)
            {
            }
            column(DataItem1000000115; 'ZAVENIR RESERVES THE RIGHT TO CANCEL EITHER ENTIRE OR PART OF THE ORDER WITHOUT ASSIGNING ANY REASONS. ANY REJECTIONS WILL BE TO YOUR ACCOUNT INCLUDING ALL COSTS.')
            {
            }
            column(for____CompInfo_Name; 'for  ' + CompInfo.Name)
            {
            }
            column(Registered_Office___Correspondence_Address_; 'Registered Office & Correspondence Address')
            {
            }
            column(Purchaser_Name____; '(' + Purchaser.Name + ')')
            {
            }
            column(Approvar____; '(' + Approvar + ')')
            {
            }
            column(FormatNoTxt; FormatNoTxt)
            {
            }
            column(BILL_TOCaption; BILL_TOCaptionLbl)
            {
            }
            column(SHIP_TOCaption; SHIP_TOCaptionLbl)
            {
            }
            column(CEX_REGN_NOCaption; CEX_REGN_NOCaptionLbl)
            {
            }
            column(ECC_NOCaption; ECC_NOCaptionLbl)
            {
            }
            column(RANGECaption; RANGECaptionLbl)
            {
            }
            column(LST___CST_No_Caption; LST___CST_No_CaptionLbl)
            {
            }
            column(TINCaption; TINCaptionLbl)
            {
            }
            column(PLEASE_SUPPLY_THE_FOLLOWING_MATERIALS_AS_PER_TERMS_AND_CONDITIONS_MENTIONED_BELOW_AND_ATTACHEDCaption; PLEASE_SUPPLY_THE_FOLLOWING_MATERIALS_AS_PER_TERMS_AND_CONDITIONS_MENTIONED_BELOW_AND_ATTACHEDCaptionLbl)
            {
            }
            column(YOUR_REF_Caption; YOUR_REF_CaptionLbl)
            {
            }
            column(CONTACT_PERSONCaption; CONTACT_PERSONCaptionLbl)
            {
            }
            column(EMAIL_ADDRESSCaption; EMAIL_ADDRESSCaptionLbl)
            {
            }
            column(Please_quote_Order_No__in_all_correspondenceCaption; Please_quote_Order_No__in_all_correspondenceCaptionLbl)
            {
            }
            column(PRICE_BASISCaption; PRICE_BASISCaptionLbl)
            {
            }
            column(MODE_OF_SHIPMENTCaption; MODE_OF_SHIPMENTCaptionLbl)
            {
            }
            column(SHIPMENT_DATECaption; SHIPMENT_DATECaptionLbl)
            {
            }
            column(INSURANCECaption; INSURANCECaptionLbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(Payment_TermsCaption; Payment_TermsCaptionLbl)
            {
            }
            column(Special_InstructionsCaption; Special_InstructionsCaptionLbl)
            {
            }
            column(PLEASE_SEND_THE_MATERIAL_ALONG_WITH_TEST_CERTIFICATE_Caption; PLEASE_SEND_THE_MATERIAL_ALONG_WITH_TEST_CERTIFICATE_CaptionLbl)
            {
            }
            column(Authorized_SignatoryCaption; Authorized_SignatoryCaptionLbl)
            {
            }
            column(Prepared_ByCaption; Prepared_ByCaptionLbl)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(CurrencyCode_PurchaseHeader; "Purchase Header"."Currency Code")
            {
            }
            column(HeaderReport1; HeaderReport1)
            {
            }
            column(HeaderReport2; HeaderReport2)
            {
            }
            column(countt; countt)
            {
            }
            column(DateSent_PurchaseHeader; "Purchase Header"."Date Sent")
            {
            }
            column(UserEmail; UserEmail)
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") order(ascending) where(Quantity = filter(> 0));

                column(ReportForNavId_6547; 6547)
                {
                }
                column(HSNSACCode_PurchaseLine; "Purchase Line"."HSN/SAC Code")
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(Purchase_Line__Purchase_Line___No__; "Purchase Line"."No.")
                {
                }
                column(Purchase_Line__Purchase_Line___Unit_of_Measure_Code_; "Purchase Line"."Unit of Measure Code")
                {
                }
                column(Purchase_Line__Purchase_Line___Direct_Unit_Cost_; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(Purchase_Line_Quantity; Quantity)
                {
                    DecimalPlaces = 2 : 5;
                }
                column(Purchase_Line__Purchase_Line___Line_Amount_; "Purchase Line"."Line Amount")
                {
                }
                column(Description_______Description_2_; Description + '  ' + "Description 2")
                {
                }
                column(EmptyString; '')
                {
                }
                column(GSTGroupCode_PurchaseLine; CopyStr(GSTGroup.Description, 4, StrLen(GSTGroup.Description)))
                {
                }
                column(GST_PurchaseLine; '') //"Purchase Line"."GST %"
                {
                }
                column(RequestedRcptDate; RequestedRcptDate)
                {
                }
                column(QtyTxt; QtyTxt)
                {
                    // DecimalPlaces = 2 : 5;
                }
                column(Purchase_Line__Purchase_Line___Unit_Cost__LCY__; "Purchase Line"."Unit Cost (LCY)")
                {
                }
                column(Purchase_Line__Purchase_Line___Unit_of_Measure_Code__Control1000000178; "Purchase Line"."Unit of Measure Code")
                {
                }
                column(Description_______Description_2__Control1000000180; Description + '  ' + "Description 2")
                {
                }
                column(Purchase_Line__Purchase_Line___No___Control1000000183; "Purchase Line"."No.")
                {
                }
                column(SrNo_Control1000000185; SrNo)
                {
                }
                column(Purchase_Line__Purchase_Line___Line_Amount__Control1000000136; "Purchase Line"."Line Amount")
                {
                }
                column(TOTAL_; 'TOTAL')
                {
                }
                column(Purchase_Line___Amount_To_Vendor_____Purchase_Line___Line_Amount_; "Purchase Line".Amount + CGST_Amt + IGST_Amt + SGST_Amt + TDSAmt - "Purchase Line"."Line Amount")
                {
                }
                column(PO_TOTAL_; 'PO TOTAL')
                {
                }
                column(Purchase_Line__Purchase_Line___Amount_To_Vendor_; "Purchase Line".Amount)
                {
                }
                column(Purchase_Line_Document_Type; "Document Type")
                {
                }
                column(Purchase_Line_Document_No_; "Document No.")
                {
                }
                column(Purchase_Line_Line_No_; "Line No.")
                {
                }
                column(SpeInstructionText1; SpeInstructionText1)
                {
                }
                column(SpeInstructionText2; SpeInstructionText2)
                {
                }
                column(ReportFooter1; SpeInstructionText2)
                {
                }
                column(ReportFooter2; ReportFooter2 + CompInfo."Company Registration  No." + ' | ' + CompInfo."P.A.N. No.")
                {
                }
                column(POFlag; POFlag)
                {
                }
                column(sds; CompInfo."Company Registration  No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    SrNo += 1;
                    if GSTGroup.Get("Purchase Line"."GST Group Code") then;
                    RequestedRcptDate := Format("Purchase Line"."Requested Receipt Date");
                    if "Document Type" = "document type"::"Blanket Order" then RequestedRcptDate := 'As per Sch. Order';
                    QtyTxt := Format(Quantity);
                    if Quantity = 999999999.99 then QtyTxt := 'Open';
                    POFlag := true;
                    StrFlag := false;
                    //
                    // //ALLE Code.Begin[US]
                    // IGST_Perc:=0;
                    // IGST_Amt:=0;
                    // CGST_Perc:=0;
                    // CGST_Amt:=0;
                    // SGST_Perc:=0;
                    // SGST_Amt:=0;
                    // DetailedGSTEntryBuffer.RESET;
                    // DetailedGSTEntryBuffer.SETRANGE("Transaction Type",DetailedGSTEntryBuffer."Transaction Type"::Purchase);
                    // DetailedGSTEntryBuffer.SETRANGE("Document No.","Document No.");
                    // DetailedGSTEntryBuffer.SETRANGE("No.","No.");
                    // IF DetailedGSTEntryBuffer.FINDSET THEN REPEAT
                    //   IF DetailedGSTEntryBuffer."GST Component Code"='IGST' THEN BEGIN
                    //      IGST_Perc:=DetailedGSTEntryBuffer."GST %";
                    //      IGST_Amt:=DetailedGSTEntryBuffer."GST Amount";
                    //   END;
                    //   IF DetailedGSTEntryBuffer."GST Component Code"='SGST' THEN BEGIN
                    //      SGST_Perc:=DetailedGSTEntryBuffer."GST %";
                    //      SGST_Amt:=DetailedGSTEntryBuffer."GST Amount";
                    //   END;
                    //   IF DetailedGSTEntryBuffer."GST Component Code"='CGST' THEN BEGIN
                    //      CGST_Perc:=DetailedGSTEntryBuffer."GST %";
                    //      CGST_Amt:=DetailedGSTEntryBuffer."GST Amount";
                    //   END;
                    // UNTIL DetailedGSTEntryBuffer.NEXT=0;
                    // //ALLE Code.End[US]
                end;

                trigger OnPreDataItem()
                begin
                    POFlag := false;
                end;
            }
            dataitem("Purch. Comment Line"; "Purch. Comment Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("Document Type", "No.", "Document Line No.", "Line No.") where("Document Type" = const(Order), "Document Line No." = const(0));

                column(ReportForNavId_1000000040; 1000000040)
                {
                }
            }
            dataitem(Structure; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.") order(ascending) where(Quantity = filter(> 0));

                column(ReportForNavId_4380; 4380)
                {
                }
                column(StrFlag; StrFlag)
                {
                }
                column(B_E_D____; 'B.E.D(%)')
                {
                }
                column(E__CESS____; 'E. CESS(%)')
                {
                }
                column(HR__CESS____; 'HR. CESS(%)')
                {
                }
                column(TAX_FORM_CODE_; 'TAX FORM CODE')
                {
                }
                column(OTHERS__INR__; 'OTHERS (INR)')
                {
                }
                column(LINE_TOTAL__INR__; 'LINE TOTAL (INR)')
                {
                }
                column(SALES_TAX____; 'SALES TAX(%)')
                {
                }
                column(ROUND_Structure__Tax____0_1_; '') //ROUND(Structure."Tax %", 0.1)
                {
                }
                column(Structure_Structure__Amount_Including_Tax_; '') //Structure."Amount Including Tax"
                {
                }
                column(EmptyString_Control1000000012; '')
                {
                }
                column(Structure_Structure__Form_Code_; '') //Structure."Form Code"
                {
                }
                column(ExciseSetup__SHE_Cess___; '') //ExciseSetup."SHE Cess %"
                {
                }
                column(ExciseSetup__eCess___; '') // ExciseSetup."eCess %"
                {
                }
                column(ExciseSetup__BED___; '') //ExciseSetup."BED %"
                {
                }
                column(SrNo1; SrNo1)
                {
                }
                column(Structure_Structure__Amount_Including_Tax__Control1000000041; Structure.Amount) //Structure."Amount Including Tax" + Structure."Total GST Amount"
                {
                }
                column(TotalGSTAmount_Structure; '') //Structure."Total GST Amount"
                {
                }
                column(PO_TOTAL__Control1000000039; 'PO TOTAL')
                {
                }
                column(TOTAL__Control1000000032; 'TOTAL')
                {
                }
                column(Structure__Amount_To_Vendor____Structure__Amount_Including_Tax_; Structure.Amount)
                {
                }
                column(Structure_Structure__Amount_To_Vendor_; Structure.Amount + CGST_Amt + SGST_Amt + IGST_Amt - TDSAmt)
                {
                }
                column(Structure_Document_Type; "Document Type")
                {
                }
                column(Structure_Document_No_; "Document No.")
                {
                }
                column(Structure_Line_No_; "Line No.")
                {
                }
                column(DocumentNo_Structure; Structure."Document No.")
                {
                }
                column(GST_Structure; '') //Structure."GST %"
                {
                }
                column(LineAmount_Structure; Structure."Line Amount")
                {
                }
                column(HSNSACCode_Structure; Structure."HSN/SAC Code")
                {
                }
                column(Comment_PurchCommentLine; "Purch. Comment Line".Comment)
                {
                }
                column(LineNo_PurchCommentLine; "Purch. Comment Line"."Line No.")
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
                column(TDSAmt; TDSAmt)
                {
                }
                column(TDSPer; TDSPer)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SrNo1 += 1;
                    countt += 1;
                    //MESSAGE('%1----%2----%3',"Excise Bus. Posting Group","Excise Prod. Posting Group","Posting Date");
                    //Excise % Calculation
                    // gurmeet
                    // ExciseSetup.Reset;
                    // ExciseSetup.SetCurrentkey("Excise Bus. Posting Group","Excise Prod. Posting Group","From Date",SSI);
                    // ExciseSetup.SetRange("Excise Bus. Posting Group",Structure."Excise Bus. Posting Group");
                    // ExciseSetup.SetRange("Excise Prod. Posting Group",Structure."Excise Prod. Posting Group");
                    // ExciseSetup.SetFilter("From Date",'<=%1',Structure."Posting Date");
                    // if ExciseSetup.FindLast then ;
                    // if "BED Amount" = 0 then
                    //   ExciseSetup.Init;
                    // "Amount To Vendor" := ROUND("Amount To Vendor");
                    // "Amount Including Tax" := ROUND("Amount Including Tax");
                    // gurmeet
                    StrFlag := true;
                    POFlag := false;
                    //ALLE Code.Begin[US]
                    IGST_Perc := 0;
                    IGST_Amt := 0;
                    CGST_Perc := 0;
                    CGST_Amt := 0;
                    SGST_Perc := 0;
                    SGST_Amt := 0;
                    TDSAmt := 0;
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", Structure.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", 'GST');
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    IF TaxTransactionValue.FindSet() then
                        repeat
                            if TaxTransactionValue."Value ID" = 2 then begin
                                CGST_Amt := TaxTransactionValue.Amount;
                                CGST_Perc := TaxTransactionValue.Percent;
                            end;
                            IF TaxTransactionValue."Value ID" = 3 then begin
                                IGST_Amt := TaxTransactionValue.Amount;
                                IGST_Perc := TaxTransactionValue.Percent;
                            end;
                            IF TaxTransactionValue."Value ID" = 6 then begin
                                SGST_Amt := TaxTransactionValue.Amount;
                                SGST_Perc := TaxTransactionValue.Percent;
                            end;
                        until TaxTransactionValue.Next() = 0;
                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", Structure.RecordId);
                    TaxTransactionValue.SetRange("Tax Type", 'TDS');
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    IF TaxTransactionValue.FindSet() then
                        repeat
                            if TaxTransactionValue."Value ID" = 1 then begin
                                TDSAmt := TaxTransactionValue.Amount;
                            end;
                        until TaxTransactionValue.Next() = 0;
                    //MESSAGE('%1--%2',SGST_Perc,CGST_Perc)
                end;

                trigger OnPreDataItem()
                begin
                    if "Purchase Header"."Currency Code" <> '' then CurrReport.Break;
                    StrFlag := false;
                end;
            }
            trigger OnAfterGetRecord()
            var
                States: Record State;
            begin
                SrNo := 0;
                SrNo1 := 0;
                countt := 0;
                Vendor.Get("Purchase Header"."Buy-from Vendor No.");
                FormatNoTxt := 'FM-PUR-03, REV NO.: 01, EFFECTIVE DATE 01/04/2010';
                if "Purchase Header"."Document Subtype" = "Purchase Header"."document subtype"::Schedule then begin
                    ReportHeaderTxt := 'SCHEDULE PURCHASE ORDER';
                end
                else if "Purchase Header"."Currency Code" <> '' then begin
                    ReportHeaderTxt := 'IMPORT PURCHASE ORDER';
                    FormatNoTxt := 'FM-PUR-05, REV NO.: 01, EFFECTIVE DATE 01/04/2010';
                end
                else
                    ReportHeaderTxt := 'PURCHASE ORDER';
                if "Purchase Header"."Document Type" = "Purchase Header"."document type"::"Blanket Order" then ReportHeaderTxt := 'BLANKET PURCHASE ORDER';
                //<<<< ALLE[5.51]
                if "Purchase Header".Subcontracting then ReportHeaderTxt := 'SUBCONTRACTING ORDER';
                //>>>> ALLE[5.51]
                if not StateRec.Get(State) then StateRec.Init;
                if PaymentTerms.Get("Payment Terms Code") then;
                PurchHeaderArc.Reset;
                PurchHeaderArc.SetRange("Document Type", "Document Type");
                PurchHeaderArc.SetRange("No.", "No.");
                if PurchHeaderArc.FindLast then begin
                    AmendmentNoTxt := 'AMENDMENT NO.  ' + Format(PurchHeaderArc."Version No.");
                    AmendmentDtTxt := 'AMENDMENT DATE ' + Format(PurchHeaderArc."Date Archived");
                end;
                if "Purchase Header"."Document Subtype" = "Purchase Header"."document subtype"::Schedule then begin
                    ReportHeaderTxt := 'SCHEDULE PURCHASE ORDER';
                    BlanketOrdTxt := 'Blanket Order No.';
                    BlanketOrdDateTxt := 'DATE';
                    ScheduleTxt := 'SCHEDULE NO.';
                    AmendmentNoTxt := '';
                    AmendmentDtTxt := '';
                end;
                if not Purchaser.Get("Purchaser Code") then Purchaser.Init;
                UnitPriceTxt := 'UNIT PRICE (INR)';
                LineTotalTxt := 'LINE TOTAL (INR)';
                if "Purchase Header"."Currency Code" <> '' then begin
                    UnitPriceTxt := 'UNIT PRICE (' + "Purchase Header"."Currency Code" + ')';
                    LineTotalTxt := 'LINE TOTAL (' + "Purchase Header"."Currency Code" + ')';
                end;
                if not ShipmentMethod.Get("Purchase Header"."Shipment Method Code") then ShipmentMethod.Init;
                if not TransportMethod.Get("Purchase Header"."Transport Method") then TransportMethod.Init;
                RemarksTxt := '';
                PurchCommentLine.Reset;
                PurchCommentLine.SetRange("Document Type", PurchCommentLine."document type"::Order);
                PurchCommentLine.SetRange("No.", "No.");
                PurchCommentLine.SetRange("Document Line No.", 0);
                if PurchCommentLine.FindSet then
                    repeat
                        RemarksTxt += PurchCommentLine.Comment + '\';
                    until PurchCommentLine.Next = 0;
                // IF PurchCommentLine.NEXT <> 0 THEN
                //  RemarksTxt := RemarksTxt + '\' + PurchCommentLine.Comment;
                // IF PurchCommentLine.NEXT <> 0 THEN
                //  RemarksTxt := RemarksTxt + '\' + PurchCommentLine.Comment;
                // IF PurchCommentLine.NEXT <> 0 THEN
                //  RemarksTxt := RemarksTxt + '\' + PurchCommentLine.Comment;
                Approvar := '';
                ApprovalEntry.Reset;
                ApprovalEntry.SetCurrentkey("Table ID", "Document Type", "Document No.");
                ApprovalEntry.SetRange("Table ID", Database::"Purchase Header");
                ApprovalEntry.SetRange("Document Type", "Document Type");
                ApprovalEntry.SetRange("Document No.", "No.");
                if ApprovalEntry.FindLast then begin
                    UserSetup.Get(ApprovalEntry."Approver ID");
                    Approvar := UserSetup.Name;
                end;
                //SSD
                Clear(AddressText);
                Clear(BilltoAddressText);
                Clear(BillToGSTIN);
                Clear(ShipToGSTIN);
                if Location.Get("Purchase Header"."Location Code") then begin
                    if Location."Temp JW Location" then begin
                        AddressText[1] := Location.Address;
                        AddressText[2] := Location."Address 2";
                        if Location."Temp State Code" <> '' then
                            States.Get(Location."Temp State Code")
                        else
                            States.Get(Location."State Code");
                        AddressText[3] := Location.City + ', ' + Location."Post Code" + ', ' + States.Description;
                    end;
                    AddressText[1] := Location.Address;
                    AddressText[2] := Location."Address 2";
                    if States.Get(Location."State Code") then;
                    AddressText[3] := Location.City + ', ' + Location."Post Code" + ', ' + States.Description;
                end;
                //AllE SB28112022 +
                if Location.Get("Purchase Header"."Location Code") then begin
                    if Location."Temp JW Location" then begin
                        BilltoAddressText[1] := RespCent.Address;
                        BilltoAddressText[2] := RespCent."Address 2";
                        BilltoAddressText[3] := RespCent.City + ', ' + RespCent."Post Code" + ', HARYANA';
                        BillToGSTIN := CompInfo."GST Registration No.";
                        ShipToGSTIN := Location."Temp GST Registration No.";
                    end
                    else begin
                        BilltoAddressText[1] := Location.Address;
                        BilltoAddressText[2] := Location."Address 2";
                        if States.Get(Location."State Code") then;
                        BilltoAddressText[3] := Location.City + ', ' + Location."Post Code" + ', ' + States.Description;
                        BillToGSTIN := Location."GST Registration No.";
                        ShipToGSTIN := Location."GST Registration No.";
                    end;
                end;



                //AllE SB28112022 -
                //SSD

                //ANI::251125
                UserEmail := '';
                RecUserSetup.Reset();
                RecUserSetup.SetRange("User ID", "Created By User Id");
                IF RecUserSetup.FindFirst() THEN BEGIN
                    UserEmail := RecUserSetup."E-Mail";
                END;
                //ANI::251125
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
        if UserSet.Get(UserId) then if RespCent.Get(UserSet."Responsibility Center") then;
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        CompInfo.CalcFields("New Logo1");
    end;

    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSAmt: Decimal;
        TDSPer: Decimal;
        SrNo: Integer;
        SrNo1: Integer;
        // ExciseSetup: Record UnknownRecord13711;
        countt: Integer;
        RespCent: Record "Responsibility Center";
        UserSet: Record "User Setup";
        CompInfo: Record "Company Information";
        Vendor: Record Vendor;
        PaymentTerms: Record "Payment Terms";
        ReportHeaderTxt: Text[100];
        StateRec: Record State;
        PurchHeaderArc: Record "Purchase Header Archive";
        AmendmentNoTxt: Text[100];
        AmendmentDtTxt: Text[100];
        Purchaser: Record "Salesperson/Purchaser";
        UnitPriceTxt: Text[30];
        LineTotalTxt: Text[30];
        ShipmentMethod: Record "Shipment Method";
        TransportMethod: Record "Transport Method";
        RemarksTxt: Text[650];
        PurchCommentLine: Record "Purch. Comment Line";
        RequestedRcptDate: Text[30];
        QtyTxt: Text[30];
        BlanketOrdTxt: Text[30];
        BlanketOrdDateTxt: Text[30];
        ScheduleTxt: Text[30];
        ApprovalEntry: Record "Approval Entry";
        Approvar: Text[100];
        UserSetup: Record "User Setup";
        FormatNoTxt: Text[100];
        BILL_TOCaptionLbl: label 'BILL TO';
        SHIP_TOCaptionLbl: label 'SHIP TO';
        CEX_REGN_NOCaptionLbl: label 'CEX REGN NO';
        ECC_NOCaptionLbl: label 'GSTIN';
        RANGECaptionLbl: label 'RANGE';
        LST___CST_No_CaptionLbl: label 'LST & CST No.';
        TINCaptionLbl: label 'TIN';
        PLEASE_SUPPLY_THE_FOLLOWING_MATERIALS_AS_PER_TERMS_AND_CONDITIONS_MENTIONED_BELOW_AND_ATTACHEDCaptionLbl: label 'PLEASE SUPPLY THE FOLLOWING MATERIALS AS PER TERMS AND CONDITIONS MENTIONED BELOW AND ATTACHED';
        YOUR_REF_CaptionLbl: label 'YOUR REF.';
        CONTACT_PERSONCaptionLbl: label 'CONTACT PERSON';
        EMAIL_ADDRESSCaptionLbl: label 'EMAIL ADDRESS';
        Please_quote_Order_No__in_all_correspondenceCaptionLbl: label 'Please quote Order No. in all correspondence';
        PRICE_BASISCaptionLbl: label 'PRICE BASIS (AS PER INCOTERMS 2020)';
        MODE_OF_SHIPMENTCaptionLbl: label 'MODE OF SHIPMENT';
        SHIPMENT_DATECaptionLbl: label 'SHIPMENT DATE';
        INSURANCECaptionLbl: label 'INSURANCE';
        RemarksCaptionLbl: label 'Remarks';
        Payment_TermsCaptionLbl: label 'Payment Terms';
        Special_InstructionsCaptionLbl: label 'Special Instructions';
        PLEASE_SEND_THE_MATERIAL_ALONG_WITH_TEST_CERTIFICATE_CaptionLbl: label 'PLEASE SEND THE MATERIAL ALONG WITH TEST CERTIFICATE.';
        Authorized_SignatoryCaptionLbl: label 'Authorized Signatory';
        Prepared_ByCaptionLbl: label 'Prepared By';
        ReportFooter1: label 'Regus Rectangle | Level-4 | Rectangle 1 | D-4, Saket District Centre | New Delhi 110017 | Phone +91 11 66544255 ';
        ReportFooter2: label 'Fax +91 11 66544052 | Email contacts@vytals.com | www.vytals.com | ';
        SpeInstructionText1: label 'VYTALS RESERVES THE RIGHT TO CANCEL EITHER ENTIRE OR PART OF THE ORDER WITHOUT ASSIGNING ANY REASONS. ANY REJECTIONS WILL BE TO YOUR ACCOUNT INCLUDING ALL COSTS.';
        SpeInstructionText2: label 'PLEASE SEND THE MATERIAL ALONG WITH SUPPORTING DOCUMENTS.';
        HeaderReport1: label 'Block A, Building 5, 16th Floor, DLF Cyber City, Gurugram, Gurugram, Haryana, 122002';
        HeaderReport2: label 'PHONE +91 124 4331000';
        POFlag: Boolean;
        StrFlag: Boolean;
        IGST_Perc: Decimal;
        IGST_Amt: Decimal;
        CGST_Perc: Decimal;
        CGST_Amt: Decimal;
        SGST_Perc: Decimal;
        SGST_Amt: Decimal;
        Total_GSTAmt: Decimal;
        TotCGST: Decimal;
        TotIGST: Decimal;
        TotSGST: Decimal;
        DetailedGSTEntryBuffer: Record "Detailed GST Entry Buffer";
        GSTGroup: Record "GST Group";
        AddressText: array[3] of Text;
        Location: Record Location;
        BilltoAddressText: array[3] of Text;
        BillToGSTIN: Code[15];
        ShipToGSTIN: Code[15];
        RecUserSetup: Record "User Setup";
        UserEmail: Text[100];
}
