Report 50341 "Purchase - Receipt New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Purchase - Receipt.rdl';
    Caption = 'Purchase - Receipt';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Receipt';

            column(ReportForNavId_2822; 2822)
            {
            }
            column(Purch__Rcpt__Header_No_; "No.")
            {
            }
            column(QCReportReceived; QCReportReceived)
            {
            }
            column(TrnsPCopyReceived; TrnsPCopyReceived)
            {
            }
            column(ITEMDESCRIPTIONCapt; ITEMDESCRIPTIONCapt)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_5701; 5701)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));

                    column(ReportForNavId_6455; 6455)
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3] + ' ' + CompanyAddr[4] + ' ' + CompanyAddr[5] + ' ' + CompanyAddr[6] + ' Tel.No. ' + CompanyInfo."Phone No." + ' Fax No. ' + CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__; "Purch. Rcpt. Header"."No.")
                    {
                    }
                    column(CompanyInfo__Giro_No__; PostesdWhseRcptHeader2."Gate Entry no." + ' ' + Format(PostesdWhseRcptHeader2."Gate Entry Date"))
                    {
                    }
                    column(CompanyInfo__Bank_Name_; "Purch. Rcpt. Header"."Bill Entry No." + ' ' + Format("Purch. Rcpt. Header"."Bill Date"))
                    {
                    }
                    column(CompanyInfo__Bank_Account_No__; "Purch. Rcpt. Header"."Order No." + ' ' + Format("Purch. Rcpt. Header"."Order Date"))
                    {
                    }
                    column(FORMAT__Purch__Rcpt__Header___Document_Date__0_4_; Format("Purch. Rcpt. Header"."Document Date", 0, 4))
                    {
                    }
                    column(Purch__Rcpt__Header___No__; '')
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(POSTED_PURCHASE_RECEIPT_NOTE_; 'POSTED PURCHASE RECEIPT NOTE')
                    {
                    }
                    column(CompanyInfo__New_Logo1_; CompanyInfo."New Logo1")
                    {
                    }
                    column(CurrReport_PAGENO; CurrReport.PageNo)
                    {
                    }
                    column(Purch__Rcpt__Header___Pay_to_Vendor_No__; "Purch. Rcpt. Header"."Pay-to Vendor No.")
                    {
                    }
                    column(VendAddr_1_; VendAddr[1])
                    {
                    }
                    column(VendAddr_2_; VendAddr[2])
                    {
                    }
                    column(VendAddr_3_; VendAddr[3])
                    {
                    }
                    column(VendAddr_4_; VendAddr[4])
                    {
                    }
                    column(VendAddr_5_; VendAddr[5])
                    {
                    }
                    column(VendAddr_6_; VendAddr[6])
                    {
                    }
                    column(VendAddr_7_; VendAddr[7])
                    {
                    }
                    column(VendAddr_8_; VendAddr[8])
                    {
                    }
                    column(Purch__Rcpt__Header___Transporter_Name_; "Purch. Rcpt. Header"."Transporter Name")
                    {
                    }
                    column(Purch__Rcpt__Header___Transporter_Bill_No_______FORMAT__Purch__Rcpt__Header___Transporter_Bill_Date__; "Purch. Rcpt. Header"."Transporter Bill No." + ' ' + Format("Purch. Rcpt. Header"."Transporter Bill Date"))
                    {
                    }
                    column(DeliveryChallanHeader1__No__; DeliveryChallanHeader1."No.")
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__Caption; CompanyInfo__VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Giro_No__Caption; CompanyInfo__Giro_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Bank_Name_Caption; CompanyInfo__Bank_Name_CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Bank_Account_No__Caption; CompanyInfo__Bank_Account_No__CaptionLbl)
                    {
                    }
                    column(Purch__Rcpt__Header___No__Caption; Purch__Rcpt__Header___No__CaptionLbl)
                    {
                    }
                    column(DateCaption; DateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(Pay_to_AddressCaption; Pay_to_AddressCaptionLbl)
                    {
                    }
                    column(Purch__Rcpt__Header___Pay_to_Vendor_No__Caption; "Purch. Rcpt. Header".FieldCaption("Pay-to Vendor No."))
                    {
                    }
                    column(Transporter_NameCaption; Transporter_NameCaptionLbl)
                    {
                    }
                    column(Transporter_Bill_No____DateCaption; Transporter_Bill_No____DateCaptionLbl)
                    {
                    }
                    column(Delivery_Challan_No_Caption; Delivery_Challan_No_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                        column(ReportForNavId_7574; 7574)
                        {
                        }
                        column(DimText; DimText)
                        {
                        }
                        column(DimText_Control47; DimText)
                        {
                        }
                        column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                        {
                        }
                        column(DimensionLoop1_Number; Number)
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
                                      '%1 - %2',PostedDocDim1."Dimension Code",PostedDocDim1."Dimension Value Code")
                                  ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3',DimText,
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
                    dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = sorting("Document No.", "Line No.");

                        column(Vendor_Item_Description; "Vendor Item Description")
                        {
                        }
                        column(ReportForNavId_3042; 3042)
                        {
                        }
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(ShowCorrectionLines; ShowCorrectionLines)
                        {
                        }
                        column(LogInteraction; LogInteraction)
                        {
                        }
                        column(PurchRcptLineType; Format("Purch. Rcpt. Line".Type, 0, 2))
                        {
                        }
                        column(Purch__Rcpt__Line_Description; VendItemDesc)
                        {
                        }
                        column(Purch__Rcpt__Line_Description_Control38; Description)
                        {
                        }
                        column(Purch__Rcpt__Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Purch__Rcpt__Line__Quantity_Invoiced_; "Quantity Invoiced")
                        {
                        }
                        column(Purch__Rcpt__Line_Quantity; Quantity)
                        {
                        }
                        column(Purch__Rcpt__Line__Accepted_Qty__; "Accepted Qty.")
                        {
                        }
                        column(Purch__Rcpt__Line__Purch__Rcpt__Line___Rejected_Qty__; "Purch. Rcpt. Line"."Rejected Qty.")
                        {
                        }
                        column(Quantity__Quantity_Invoiced_; Quantity - "Quantity Invoiced")
                        {
                        }
                        column(Purch__Rcpt__Line__No__; "No.")
                        {
                        }
                        column(Purch__Rcpt__Line_Description_Control42; Description)
                        {
                        }
                        column(Purch__Rcpt__Line__Unit_of_Measure__Control44; "Unit of Measure")
                        {
                        }
                        column(SrNo; SrNo)
                        {
                        }
                        column(Purch__Rcpt__Line_Quantity_Control39; Quantity)
                        {
                        }
                        column(Purch__Rcpt__Line__Quantity_Invoiced__Control1000000010; "Quantity Invoiced")
                        {
                        }
                        column(Purch__Rcpt__Line__Accepted_Qty___Control1000000008; "Accepted Qty.")
                        {
                        }
                        column(Purch__Rcpt__Line__Purch__Rcpt__Line___Rejected_Qty___Control1000000012; "Purch. Rcpt. Line"."Rejected Qty.")
                        {
                        }
                        column(Quantity__Quantity_Invoiced__Control1000000014; Quantity - "Quantity Invoiced")
                        {
                        }
                        column(Purch__Rcpt__Line__Unit_of_Measure__Control44Caption; Purch__Rcpt__Line__Unit_of_Measure__Control44CaptionLbl)
                        {
                        }
                        column(Purch__Rcpt__Line_Description_Control42Caption; Purch__Rcpt__Line_Description_Control42CaptionLbl)
                        {
                        }
                        column(Purch__Rcpt__Line__No__Caption; ITEMDESCRIPTIONCapt)
                        {
                        }
                        column(Sr__No_Caption; Sr__No_CaptionLbl)
                        {
                        }
                        column(Accepted_Qty_Caption; Accepted_Qty_CaptionLbl)
                        {
                        }
                        column(Invoice_Qty_Caption; Invoice_Qty_CaptionLbl)
                        {
                        }
                        column(Rejected_Qty_Caption; Rejected_Qty_CaptionLbl)
                        {
                        }
                        column(Shortage_Qty_Caption; Shortage_Qty_CaptionLbl)
                        {
                        }
                        column(Purch__Rcpt__Line_Quantity_Control43Caption; Purch__Rcpt__Line_Quantity_Control43CaptionLbl)
                        {
                        }
                        column(Purch__Rcpt__Line_Document_No_; "Document No.")
                        {
                        }
                        column(Purch__Rcpt__Line_Line_No_; "Line No.")
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                            column(ReportForNavId_3591; 3591)
                            {
                            }
                            column(DimText_Control65; DimText)
                            {
                            }
                            column(DimText_Control67; DimText)
                            {
                            }
                            column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
                            {
                            }
                            column(DimensionLoop2_Number; Number)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                /* // BIS 1145
                                    IF Number = 1 THEN BEGIN
                                      IF NOT PostedDocDim2.FIND('-') THEN
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
                                          '%1 - %2',PostedDocDim2."Dimension Code",PostedDocDim2."Dimension Value Code")
                                      ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1; %2 - %3',DimText,
                                            PostedDocDim2."Dimension Code",PostedDocDim2."Dimension Value Code");
                                      IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                      END;
                                    UNTIL (PostedDocDim2.NEXT = 0);
                                    */
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then CurrReport.Break;
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if (not ShowCorrectionLines) and Correction then CurrReport.Skip;
                            SrNo += 1;
                            if "Vendor Item Description" <> '' then begin
                                GeneralLedgerSetup.Reset();
                                GeneralLedgerSetup.Get();
                                if GeneralLedgerSetup."SSD Activate Item Vendor" then VendItemDesc := Description + '  ' + "Description 2" + '(' + "Vendor Item Description" + ')'
                            end
                            else
                                VendItemDesc := Description + '  ' + "Description 2";
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := Find('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) do MoreLines := Next(-1) <> 0;
                            if not MoreLines then CurrReport.Break;
                            SetRange("Line No.", 0, "Line No.");
                            //<<<< ALLE[5.51]
                            PostesdWhseRcptHeader1.Reset;
                            if PostesdWhseRcptHeader1.Get("Purch. Rcpt. Line"."Posted Whse. Rcpt No.") then;
                            //>>> ALLE[5.51]
                            SrNo := 0;
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));

                        column(ReportForNavId_3476; 3476)
                        {
                        }
                        column(Purch__Rcpt__Header___Buy_from_Vendor_No__; "Purch. Rcpt. Header"."Buy-from Vendor No.")
                        {
                        }
                        column(Purch__Rcpt__Header___Buy_from_Vendor_No__Caption; "Purch. Rcpt. Header".FieldCaption("Buy-from Vendor No."))
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            if "Purch. Rcpt. Header"."Buy-from Vendor No." = "Purch. Rcpt. Header"."Pay-to Vendor No." then CurrReport.Break;
                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));

                        column(ReportForNavId_3363; 3363)
                        {
                        }
                        column(PostesdWhseRcptHeader1__QC_Report_Received_; PostesdWhseRcptHeader1."QC Report Received")
                        {
                        }
                        column(PostesdWhseRcptHeader1__Transporter_Copy_Received_; PostesdWhseRcptHeader1."Transporter Copy Received")
                        {
                        }
                        column(SD_____FORMAT_UserSetup_Name_; 'SD/- ' + Format(UserSetup.Name))
                        {
                        }
                        column(PostedQualityOrderHeader_Remarks; PostedQualityOrderHeader.Remarks)
                        {
                        }
                        column(RemarksCaption; RemarksCaptionLbl)
                        {
                        }
                        column(QC_Report_ReceivedCaption; QC_Report_ReceivedCaptionLbl)
                        {
                        }
                        column(Transporter_Copy_ReceivedCaption; Transporter_Copy_ReceivedCaptionLbl)
                        {
                        }
                        column(Prepared_ByCaption; Prepared_ByCaptionLbl)
                        {
                        }
                        column(Checked_ByCaption; Checked_ByCaptionLbl)
                        {
                        }
                        column(Inspected_ByCaption; Inspected_ByCaptionLbl)
                        {
                        }
                        column(Approved_ByCaption; Approved_ByCaptionLbl)
                        {
                        }
                        column(For_A_C_DepartmentCaption; For_A_C_DepartmentCaptionLbl)
                        {
                        }
                        column(PI_No_____________________________________Date_____________________________Caption; PI_No_____________________________________Date_____________________________CaptionLbl)
                        {
                        }
                        column(A_C_DepartmentCaption; A_C_DepartmentCaptionLbl)
                        {
                        }
                        column(Store_Caption; Store_CaptionLbl)
                        {
                        }
                        column(Store_Caption_Control1000000035; Store_Caption_Control1000000035Lbl)
                        {
                        }
                        column(QC_Caption; QC_CaptionLbl)
                        {
                        }
                        column(Authorised_Caption; Authorised_CaptionLbl)
                        {
                        }
                        column(Total2_Number; Number)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            PostedQualityOrderHeader.Reset;
                            if PostedQualityOrderHeader.Get("Purch. Rcpt. Line"."Posted Quality Order No.") then if UserSetup.Get(PostedQualityOrderHeader."Posted By") then;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := Text001;
                        if ISSERVICETIER then OutputNo += 1;
                    end;
                    CurrReport.PageNo := 1;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then RcptCountPrinted.Run("Purch. Rcpt. Header");
                end;

                trigger OnPreDataItem()
                begin
                    if ISSERVICETIER then OutputNo := 1;
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if LanguageCode.Get("Location Code") then CurrReport.Language := LanguageCode."Windows Language ID";
                CompanyInfo.Get;
                CompanyInfo.CalcFields(CompanyInfo."New Logo1");
                PurchRcptLine1.Reset;
                PurchRcptLine1.SetRange(PurchRcptLine1."Document No.", "Purch. Rcpt. Header"."No.");
                if PurchRcptLine1.FindFirst then if PostesdWhseRcptHeader2.Get(PurchRcptLine1."Posted Whse. Rcpt No.") then;
                if PostesdWhseRcptHeader2."QC Report Received" then QCReportReceived := 'YES';
                if PostesdWhseRcptHeader1."Transporter Copy Received" then TrnsPCopyReceived := 'YES';
                DeliveryChallanHeader1.Reset;
                DeliveryChallanHeader1.SetCurrentkey(DeliveryChallanHeader1."Sub. order No.", DeliveryChallanHeader1."Sub. Order Line No.");
                DeliveryChallanHeader1.SetRange(DeliveryChallanHeader1."Sub. order No.", "Purch. Rcpt. Header"."Order No.");
                if DeliveryChallanHeader1.FindFirst then;
                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end
                else begin
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                end;
                //PostedDocDim1.SETRANGE("Table ID",DATABASE::"Purch. Rcpt. Header"); // BIS 1145
                //PostedDocDim1.SETRANGE("Document No.","Purch. Rcpt. Header"."No."); // BIS 1145
                if "Purchaser Code" = '' then begin
                    SalesPurchPerson.Init;
                    PurchaserText := '';
                end
                else begin
                    SalesPurchPerson.Get("Purchaser Code");
                    PurchaserText := Text000
                end;
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FieldCaption("Your Reference");
                FormatAddr.PurchRcptShipTo(ShipToAddr, "Purch. Rcpt. Header");
                FormatAddr.PurchRcptPayTo(VendAddr, "Purch. Rcpt. Header");
                if LogInteraction then if not CurrReport.Preview then SegManagement.LogDocument(15, "No.", 0, 0, Database::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
                ;
                GeneralLedgerSetup.Reset();
                GeneralLedgerSetup.Get();
                if GeneralLedgerSetup."SSD Activate Item Vendor" then begin
                    PurchRcptLine.Reset();
                    PurchRcptLine.SetRange("Document No.", "No.");
                    PurchRcptLine.SetFilter("Vendor Item Description", '<>%1', '');
                    if PurchRcptLine.FindFirst() then begin
                        ITEMDESCRIPTIONCapt := 'Item Code (Vendor Item Description)';
                    end;
                end
                else
                    ITEMDESCRIPTIONCapt := 'Item Code';
            end;

            trigger OnPreDataItem()
            begin
                QCReportReceived := 'NO';
                TrnsPCopyReceived := 'NO';
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
                    field(ShowCorrectionLines; ShowCorrectionLines)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Correction Lines';
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
            LogInteraction := SegManagement.FindInteractionTemplateCode(15) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        SrNo := 0; //5.51
    end;

    var
        VendItemDesc: Text;
        ITEMDESCRIPTIONCapt: Text;
        IVD: Integer;
        PurchRcptLine: Record "Purch. Rcpt. Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Text000: label 'Purchaser';
        Text001: label 'COPY';
        Text002: label 'Purchase - Receipt %1';
        Text003: label 'Page %1';
        CompanyInfo: Record "Company Information";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        // Language: Record Language; //IG_DS_before
        LanguageCode: Record Language;
        RespCenter: Record "Responsibility Center";
        RcptCountPrinted: Codeunit "Purch.Rcpt.-Printed";
        SegManagement: Codeunit SegManagement;
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        ReferenceText: Text[80];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        FormatAddr: Codeunit "Format Address";
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        OutputNo: Integer;
        LogInteractionEnable: Boolean;
        SrNo: Integer;
        PostesdWhseRcptHeader2: Record "Posted Whse. Receipt Header";
        PostesdWhseRcptHeader1: Record "Posted Whse. Receipt Header";
        PurchRcptLine1: Record "Purch. Rcpt. Line";
        DeliveryChallanHeader1: Record "Delivery Challan Header";
        PostedQualityOrderHeader: Record "SSD Posted Quality Order Hdr";
        UserSetup: Record "User Setup";
        CompanyInfo__VAT_Registration_No__CaptionLbl: label 'MRN No. & Date';
        CompanyInfo__Giro_No__CaptionLbl: label 'Gate Entry No. & Date';
        CompanyInfo__Bank_Name_CaptionLbl: label 'Party Invoice No. & Date';
        CompanyInfo__Bank_Account_No__CaptionLbl: label 'Purchase Order No. & Date';
        Purch__Rcpt__Header___No__CaptionLbl: label 'Road Permit No.';
        DateCaptionLbl: label 'Date';
        PageCaptionLbl: label 'Page';
        Pay_to_AddressCaptionLbl: label 'Vendor Name and Address';
        Transporter_NameCaptionLbl: label 'Transporter Name';
        Transporter_Bill_No____DateCaptionLbl: label 'Transporter Bill No. & Date';
        Delivery_Challan_No_CaptionLbl: label 'Delivery Challan No.';
        Header_DimensionsCaptionLbl: label 'Header Dimensions';
        Purch__Rcpt__Line__Unit_of_Measure__Control44CaptionLbl: label 'UOM';
        Purch__Rcpt__Line_Description_Control42CaptionLbl: label 'Item Name';
        Purch__Rcpt__Line__No__CaptionLbl: Text;
        Sr__No_CaptionLbl: label 'Sr. No.';
        Accepted_Qty_CaptionLbl: label 'Accepted Qty.';
        Invoice_Qty_CaptionLbl: label 'Invoice Qty.';
        Rejected_Qty_CaptionLbl: label 'Rejected Qty.';
        Shortage_Qty_CaptionLbl: label 'Shortage Qty.';
        Purch__Rcpt__Line_Quantity_Control43CaptionLbl: label 'Actual Qty.';
        Line_DimensionsCaptionLbl: label 'Line Dimensions';
        RemarksCaptionLbl: label 'Remarks';
        QC_Report_ReceivedCaptionLbl: label 'QC Report Received';
        Transporter_Copy_ReceivedCaptionLbl: label 'Transporter Copy Received';
        Prepared_ByCaptionLbl: label 'Prepared By';
        Checked_ByCaptionLbl: label 'Checked By';
        Inspected_ByCaptionLbl: label 'Inspected By';
        Approved_ByCaptionLbl: label 'Approved By';
        For_A_C_DepartmentCaptionLbl: label 'For A/C Department';
        PI_No_____________________________________Date_____________________________CaptionLbl: label 'PI No.___________________________________ Date_____________________________';
        A_C_DepartmentCaptionLbl: label 'A/C Department';
        Store_CaptionLbl: label '(Store)';
        Store_Caption_Control1000000035Lbl: label '(Store)';
        QC_CaptionLbl: label '(QC)';
        Authorised_CaptionLbl: label '(Authorised)';
        QCReportReceived: Text;
        TrnsPCopyReceived: Text;
}
