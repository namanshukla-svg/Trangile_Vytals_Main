Report 50030 "Posted MRN"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Posted MRN.rdl';
    Caption = 'MRN 1';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Whse. Receipt Header"; "Posted Whse. Receipt Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(ReportForNavId_4701;4701)
            {
            }
            column(QCReportRecieved; QCReportRecieved)
            {
            }
            column(TrnsptCopyReport; TrnsptCopyReport)
            {
            }
            column(Posted_Whse__Receipt_Header_No_; "No.")
            {
            }
            column(Item_Code___NameCaption; Item_Code___NameCaptionLbl)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_5444;5444)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PageNo)
                {
                }
                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(RespCent_Name; RespCent.Name)
                {
                }
                column(DataItem1000000001; LocationName)
                {
                }
                column(companyInfoRec_Picture; companyInfoRec.Picture)
                {
                }
                column(Vendor_Name; Vendor.Name)
                {
                }
                column(Vendor_Address; Vendor.Address)
                {
                }
                column(Vendor__Address_2_; Vendor."Address 2")
                {
                }
                column(Vendor_City___________Vendor__Post_Code_; Vendor.City + ' - ' + Vendor."Post Code")
                {
                }
                column(PurchaseHeader__No__; PurchaseHeader."No.")
                {
                }
                column(PostedGateHdr__Bill_No__; PostedGateHdr."Bill No.")
                {
                }
                column(Posted_Whse__Receipt_Header___Gate_Entry_no__; "Posted Whse. Receipt Header"."Gate Entry no.")
                {
                }
                column(Posted_Whse__Receipt_Header___No__; "Posted Whse. Receipt Header"."No.")
                {
                }
                column(STATENAME; STATENAME)
                {
                }
                column(Vendor__No__; Vendor."No.")
                {
                }
                column(FormNo; FormNo)
                {
                }
                column(Posted_Whse__Receipt_Header___Gate_Entry_Date_; "Posted Whse. Receipt Header"."Gate Entry Date")
                {
                }
                column(Posted_Whse__Receipt_Header___Posting_Date_; "Posted Whse. Receipt Header"."Posting Date")
                {
                }
                column(PostedGateHdr__Bill_Date_; PostedGateHdr."Bill Date")
                {
                }
                column(PurchaseHeader__Order_Date_; PurchaseHeader."Order Date")
                {
                }
                column(PostedGateHeader__Transporter_Name_; PostedGateHeader."Transporter Name")
                {
                }
                column(PostedGateHeader__Transporter_Bill_No__; PostedGateHeader."Transporter Bill No.")
                {
                }
                column(PostedGateHeader__Transporter_Bill_Date_; PostedGateHeader."Transporter Bill Date")
                {
                }
                column(PostedGateHeader__Delivery_Challan_Date_; PostedGateHeader."Delivery Challan Date")
                {
                }
                column(PostedGateHeader__Delivery_Challan_No__; PostedGateHeader."Delivery Challan No.")
                {
                }
                column(PostedWhseRcptLine__Posted_Source_No__; PostedWhseRcptLine."Posted Source No.")
                {
                }
                column(Posted_Whse__Receipt_Header___Posting_Date__Control1000000072; "Posted Whse. Receipt Header"."Posting Date")
                {
                }
                column(Customer_City___________Customer__Post_Code_; Customer.City + ' - ' + Customer."Post Code")
                {
                }
                column(Customer__Address_2_; Customer."Address 2")
                {
                }
                column(Customer_Address; Customer.Address)
                {
                }
                column(Customer_Name; Customer.Name)
                {
                }
                column(Customer__No__; Customer."No.")
                {
                }
                column(PartyNameTxt; PartyNameTxt)
                {
                }
                column(RemarksTxt; RemarksTxt)
                {
                }
                column(Posted_Whse__Receipt_Header___QC_Report_Received_; "Posted Whse. Receipt Header"."QC Report Received")
                {
                }
                column(Posted_Whse__Receipt_Header___Transporter_Copy_Received_; "Posted Whse. Receipt Header"."Transporter Copy Received")
                {
                }
                column(SD_____FORMAT_UserSetup_Name_;'SD/- ' + Format(UserSetup.Name))
                {
                }
                column(PostedQualityOrderHeader_Remarks; Remark1)
                {
                }
                column(Remarks; PostedQualityOrderHeader.Remarks)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Date_Caption; Date_CaptionLbl)
                {
                }
                column(POSTED_MATERIAL__RECEIPT__NOTECaption; POSTED_MATERIAL__RECEIPT__NOTECaptionLbl)
                {
                }
                column(Gate_Entry_No____DateCaption; Gate_Entry_No____DateCaptionLbl)
                {
                }
                column(P_O_No____DateCaption; P_O_No____DateCaptionLbl)
                {
                }
                column(Party_Invoice_No____DateCaption; Party_Invoice_No____DateCaptionLbl)
                {
                }
                column(Whse__Rcpt__No____DateCaption; Whse__Rcpt__No____DateCaptionLbl)
                {
                }
                column(Road_Permit_No_Caption; Road_Permit_No_CaptionLbl)
                {
                }
                column(PostedGateHeader__Transporter_Name_Caption; PostedGateHeader__Transporter_Name_CaptionLbl)
                {
                }
                column(Transporter_Bill_No____DateCaption; Transporter_Bill_No____DateCaptionLbl)
                {
                }
                column(Delivery_Challan_No____DateCaption; Delivery_Challan_No____DateCaptionLbl)
                {
                }
                column(MRN_No____DateCaption; MRN_No____DateCaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(Sr__No_Caption; Sr__No_CaptionLbl)
                {
                }
                column(Posted_Whse__Receipt_Line__Qty__On_Invoice_Caption; Posted_Whse__Receipt_Line__Qty__On_Invoice_CaptionLbl)
                {
                }
                column(Posted_Whse__Receipt_Line__Actual_Qty__to_Receive_Caption; Posted_Whse__Receipt_Line__Actual_Qty__to_Receive_CaptionLbl)
                {
                }
                column(Accepted__Qty_Caption; Accepted__Qty_CaptionLbl)
                {
                }
                column(Rejected__Qty_Caption; Rejected__Qty_CaptionLbl)
                {
                }
                column(Posted_Whse__Receipt_Line__Shortage_Qty__Caption; "Posted Whse. Receipt Line".FieldCaption("Shortage Qty."))
                {
                }
                column(RemarksTxtCaption; RemarksTxtCaptionLbl)
                {
                }
                column(Posted_Whse__Receipt_Header___Transporter_Copy_Received_Caption; Posted_Whse__Receipt_Header___Transporter_Copy_Received_CaptionLbl)
                {
                }
                column(Posted_Whse__Receipt_Header___QC_Report_Received_Caption; Posted_Whse__Receipt_Header___QC_Report_Received_CaptionLbl)
                {
                }
                column(Store__Caption; Store__CaptionLbl)
                {
                }
                column(Prepared_ByCaption; Prepared_ByCaptionLbl)
                {
                }
                column(INSPECTED_BYCaption; INSPECTED_BYCaptionLbl)
                {
                }
                column(CHECKED_BYCaption; CHECKED_BYCaptionLbl)
                {
                }
                column(APPROVED_BYCaption; APPROVED_BYCaptionLbl)
                {
                }
                column(Store__Caption_Control1000000041; Store__Caption_Control1000000041Lbl)
                {
                }
                column(AUTHORISED__Caption; AUTHORISED__CaptionLbl)
                {
                }
                column(QC__Caption; QC__CaptionLbl)
                {
                }
                column(For_A_C_DepartmentCaption; For_A_C_DepartmentCaptionLbl)
                {
                }
                column(A_C_DepartmentCaption; A_C_DepartmentCaptionLbl)
                {
                }
                column(DateCaption; DateCaptionLbl)
                {
                }
                column(PI_No_Caption; PI_No_CaptionLbl)
                {
                }
                column(FM_ST_01__Rev_NO__01__Effective_date_13_01_2012_Caption; FM_ST_01__Rev_NO__01__Effective_date_13_01_2012_CaptionLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }
                dataitem("Posted Whse. Receipt Line"; "Posted Whse. Receipt Line")
                {
                    DataItemLink = "No."=field("No.");
                    DataItemLinkReference = "Posted Whse. Receipt Header";
                    DataItemTableView = sorting("No.", "Line No.");

                    column(ReportForNavId_7072;7072)
                    {
                    }
                    column(Vendor_Item_Description; "Vendor Item Description")
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                    {
                    }
                    column(Item_No____________Description; VendItemDesc)
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Qty__On_Invoice_; "Qty. On Invoice")
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Actual_Qty__to_Receive_; "Actual Qty. to Receive")
                    {
                    }
                    column(SrNo; SrNo)
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Accepted_Qty__; "Accepted Qty.")
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Rejected_Qty__; "Rejected Qty.")
                    {
                    }
                    column(Posted_Whse__Receipt_Line__Shortage_Qty__; "Shortage Qty.")
                    {
                    }
                    column(description2; description2)
                    {
                    }
                    column(Posted_Whse__Receipt_Line_No_; "No.")
                    {
                    }
                    column(Posted_Whse__Receipt_Line_Line_No_; "Line No.")
                    {
                    }
                    column(Posted_Whse__Receipt_Line_Posted_Source_No_; "Posted Source No.")
                    {
                    }
                    column(Posted_Whse__Receipt_Line_Item_No_; "Item No.")
                    {
                    }
                    dataitem("Item Ledger Entry"; "Item Ledger Entry")
                    {
                        DataItemLink = "Document No."=field("Posted Source No."), "Item No."=field("Item No.");

                        column(ReportForNavId_1000000003;1000000003)
                        {
                        }
                        column(Quantity_ItemLedgerEntry; "Item Ledger Entry".Quantity)
                        {
                        }
                        column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
                        {
                        }
                    }
                    trigger OnAfterGetRecord()
                    begin
                        GetLocation("Location Code");
                        SrNo:=SrNo + 1;
                        if ItemRec.Get("Item No.")then begin
                            PartNo:=ItemRec."No. 2";
                            description2:=ItemRec."Description 2";
                            Grade1:=ItemRec.Grade;
                        end;
                        PostedQualityOrderHeader.Reset;
                        if PostedQualityOrderHeader.Get("Posted Whse. Receipt Line"."Posted Quality Order No.")then;
                        if UserSetup.Get(PostedQualityOrderHeader."Posted By")then;
                        if Remark1 = '' then Remark1:=PostedQualityOrderHeader.Remarks;
                        if "Vendor Item Description" <> '' then begin
                            GeneralLedgerSetup.Reset();
                            GeneralLedgerSetup.Get();
                            if GeneralLedgerSetup."SSD Activate Item Vendor" then VendItemDesc:="Item No." + '  ' + Description + '(' + "Vendor Item Description" + ')' end
                        else
                            VendItemDesc:="Item No." + '  ' + Description;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    SrNo:=0;
                    if STATES1.Get(Vendor."State Code")then STATENAME:=STATES1.Description;
                    if STATES.Get(Customer."State Code")then STATENAME:=STATES.Description;
                    if PostedGateHeader.Get("Posted Whse. Receipt Header"."Gate Entry no.")then FormNo:=PostedGateHeader."ST38 No.";
                    if not PostedGateHeader.Get("Posted Whse. Receipt Header"."Gate Entry no.")then PostedGateHeader.Init;
                //PostedQualityOrderHeader.RESET;
                //IF PostedQualityOrderHeader.GET("Posted Whse. Receipt Line"."Posted Quality Order No.") THEN;
                //   IF UserSetup.GET(PostedQualityOrderHeader."Posted By")THEN;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                stateName1:='';
                if Location.Get("Location Code")then if STATES1.Get(Location."State Code")then stateName1:=STATES1.Description
                    else
                        stateName1:='';
                LocationName:=Location.Address + ',' + Location."Address 2" + ',' + Location.City + '-' + Location."Post Code" + ',' + stateName1 + 'TEL No. ' + Location."Phone No." + ' FAX No. ' + Location."Fax No.";
                GetLocation("Location Code");
                if PostedGateHdr.Get("Posted Whse. Receipt Header"."Gate Entry no.")then if PostedGateHdr."Ref. Document Type" in[PostedGateHdr."ref. document type"::"Purchase Order", PostedGateHdr."ref. document type"::"Purchase Schedule"]then if PurchaseHeader.Get(PurchaseHeader."document type"::Order, PostedGateHdr."Ref. Document No.")then;
                if not Vendor.Get(PostedGateHdr."Party No.")then begin
                    Clear(Vendor);
                    PartyNameTxt:='Customer Name and Address';
                end;
                if not Customer.Get(PostedGateHdr."Party No.")then begin
                    Clear(Customer);
                    PartyNameTxt:='Vendor Name and Address';
                end;
                QCReportRecieved:='NO';
                TrnsptCopyReport:='NO';
                if "Posted Whse. Receipt Header"."QC Report Received" then QCReportRecieved:='YES';
                if "Posted Whse. Receipt Header"."Transporter Copy Received" then TrnsptCopyReport:='YES';
                WhseCommentLine.Reset;
                WhseCommentLine.SetRange("Table Name", WhseCommentLine."table name"::"Posted Whse. Receipt");
                WhseCommentLine.SetRange(Type, WhseCommentLine.Type::" ");
                WhseCommentLine.SetRange("No.", "No.");
                if WhseCommentLine.Find('-')then RemarksTxt:=WhseCommentLine.Comment;
                if WhseCommentLine.Next <> 0 then RemarksTxt:=RemarksTxt + '\' + WhseCommentLine.Comment;
                if WhseCommentLine.Next <> 0 then RemarksTxt:=RemarksTxt + '\' + WhseCommentLine.Comment;
                if WhseCommentLine.Next <> 0 then RemarksTxt:=RemarksTxt + '\' + WhseCommentLine.Comment;
                PostedWhseRcptLine.Reset;
                PostedWhseRcptLine.SetRange("No.", "Posted Whse. Receipt Header"."No.");
                if not PostedWhseRcptLine.FindFirst then PostedWhseRcptLine.Init;
                GeneralLedgerSetup.Reset();
                GeneralLedgerSetup.Get();
                if GeneralLedgerSetup."SSD Activate Item Vendor" then begin
                    PostedWhseReceiptLine.Reset();
                    PostedWhseReceiptLine.SetRange("No.", "No.");
                    PostedWhseReceiptLine.SetFilter("Vendor Item Description", '<>%1', '');
                    if PostedWhseReceiptLine.FindFirst()then begin
                        ITEMDESCRIPTIONCapt:='Item Code & Name (Vendor Item Description)';
                    end;
                end
                else
                    ITEMDESCRIPTIONCapt:='Item Code & Name';
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
        companyInfoRec.Get;
        companyInfoRec.CalcFields(Picture);
    // RespCent.Get(UserMgt.GetRespCenterFilter);
    end;
    var VendItemDesc: Text;
    ITEMDESCRIPTIONCapt: Text;
    IVD: Integer;
    PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
    GeneralLedgerSetup: Record "General Ledger Setup";
    stateName1: Text;
    Location: Record Location;
    LocationName: Text;
    companyInfoRec: Record "Company Information";
    RespCent: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    PostedGateHdr: Record "SSD Posted Gate Header";
    PurchaseHeader: Record "Purchase Header";
    SrNo: Integer;
    ItemRec: Record Item;
    description2: Text[50];
    Grade1: Text[50];
    PartNo: Code[20];
    STATES1: Record State;
    STATENAME: Text[50];
    PostedGateHeader: Record "SSD Posted Gate Header";
    FormNo: Code[20];
    Vendor: Record Vendor;
    WhseCommentLine: Record "Warehouse Comment Line";
    RemarksTxt: Text[1024];
    PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
    STATES: Record State;
    Customer: Record Customer;
    PartyNameTxt: Text[30];
    PostedQualityOrderHeader: Record "SSD Posted Quality Order Hdr";
    UserSetup: Record "User Setup";
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Date_CaptionLbl: label 'Date:';
    POSTED_MATERIAL__RECEIPT__NOTECaptionLbl: label 'POSTED MATERIAL  RECEIPT  NOTE';
    Gate_Entry_No____DateCaptionLbl: label 'Gate Entry No. & Date';
    P_O_No____DateCaptionLbl: label 'P.O No. & Date';
    Party_Invoice_No____DateCaptionLbl: label 'Party Invoice No. & Date';
    Whse__Rcpt__No____DateCaptionLbl: label 'Whse. Rcpt. No. & Date';
    Road_Permit_No_CaptionLbl: label 'Road Permit No.';
    PostedGateHeader__Transporter_Name_CaptionLbl: label 'Transporter Name';
    Transporter_Bill_No____DateCaptionLbl: label 'Transporter Bill No. & Date';
    Delivery_Challan_No____DateCaptionLbl: label 'Delivery Challan No. & Date';
    MRN_No____DateCaptionLbl: label 'MRN No. & Date';
    UOMCaptionLbl: label 'UOM';
    Item_Code___NameCaptionLbl: Text;
    Sr__No_CaptionLbl: label 'Sr. No.';
    Posted_Whse__Receipt_Line__Qty__On_Invoice_CaptionLbl: label 'Invoice Qty.';
    Posted_Whse__Receipt_Line__Actual_Qty__to_Receive_CaptionLbl: label 'Actual Qty.';
    Accepted__Qty_CaptionLbl: label 'Accepted. Qty.';
    Rejected__Qty_CaptionLbl: label 'Rejected. Qty.';
    RemarksTxtCaptionLbl: label 'Remarks';
    Posted_Whse__Receipt_Header___Transporter_Copy_Received_CaptionLbl: label 'Transporter Copy Received';
    Posted_Whse__Receipt_Header___QC_Report_Received_CaptionLbl: label 'QC Report Received';
    Store__CaptionLbl: label '( Store )';
    Prepared_ByCaptionLbl: label 'Prepared By';
    INSPECTED_BYCaptionLbl: label 'INSPECTED BY';
    CHECKED_BYCaptionLbl: label 'CHECKED BY';
    APPROVED_BYCaptionLbl: label 'APPROVED BY';
    Store__Caption_Control1000000041Lbl: label '( Store )';
    AUTHORISED__CaptionLbl: label '( AUTHORISED )';
    QC__CaptionLbl: label '( QC )';
    For_A_C_DepartmentCaptionLbl: label 'For A/C Department';
    A_C_DepartmentCaptionLbl: label 'A/C Department';
    DateCaptionLbl: label 'Date';
    PI_No_CaptionLbl: label 'PI No.';
    FM_ST_01__Rev_NO__01__Effective_date_13_01_2012_CaptionLbl: label '<FM-ST-01, Rev NO. 01, Effective date 13-01-2012>';
    CountLoop: label 'CountLoopLbl';
    QCReportRecieved: Text;
    TrnsptCopyReport: Text;
    Remark1: Text;
    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then Location.Init
        else if Location.Code <> LocationCode then Location.Get(LocationCode);
    end;
}
