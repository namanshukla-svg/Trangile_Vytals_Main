Report 50015 "Material Receipt Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Material Receipt Note.rdl';
    Caption = 'MRN';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Warehouse Receipt Header"; "Warehouse Receipt Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(ReportForNavId_6901;6901)
            {
            }
            column(Warehouse_Receipt_Header_No_; "No.")
            {
            }
            column(HeaderReport1; HeaderReport1)
            {
            }
            column(HeaderReport2; HeaderReport2)
            {
            }
            column(QCReportRecieved; QCReportRecieved)
            {
            }
            column(TransportQCRecieved; TransportQCRecieved)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_5444;5444)
                {
                }
                column(RespCent_Name; RespCent.Name)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PageNo)
                {
                }
                column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
                {
                }
                column(DataItem1000000052; LocationName)
                {
                }
                column(CompanyName; companyInfo.Name)
                {
                }
                column(companyInfo_Picture; companyInfo.Picture)
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
                column(Vendor_State_Code; Vendor."State Code")
                {
                }
                column(PurchaseHeader__No__; PurchaseHeader."No.")
                {
                }
                column(PostedGateHdr__Bill_No__; PostedGateHdr."Bill No.")
                {
                }
                column(Warehouse_Receipt_Header___Gate_Entry_no__; "Warehouse Receipt Header"."Gate Entry no.")
                {
                }
                column(Warehouse_Receipt_Header___No__; "Warehouse Receipt Header"."No.")
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
                column(Warehouse_Receipt_Header___Gate_Entry_Date_; "Warehouse Receipt Header"."Gate Entry Date")
                {
                }
                column(Warehouse_Receipt_Header___Posting_Date_; "Warehouse Receipt Header"."Posting Date")
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
                column(Customer__No__; Customer."No.")
                {
                }
                column(PartyNameTxt; PartyNameTxt)
                {
                }
                column(Customer_Name; Customer.Name)
                {
                }
                column(Customer_Address; Customer.Address)
                {
                }
                column(Customer__Address_2_; Customer."Address 2")
                {
                }
                column(Customer_City___________Customer__Post_Code_; Customer.City + ' - ' + Customer."Post Code")
                {
                }
                column(RemarksTxt; RemarksTxt)
                {
                }
                column(Warehouse_Receipt_Header___Transporter_Copy_Received_; "Warehouse Receipt Header"."Transporter Copy Received")
                {
                }
                column(Warehouse_Receipt_Header___QC_Report_Received_; "Warehouse Receipt Header"."QC Report Received")
                {
                }
                column(CES_STR_F_02Caption; CES_STR_F_02CaptionLbl)
                {
                }
                column(MATERIAL__RECEIPT__NOTECaption; MATERIAL__RECEIPT__NOTECaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Date_Caption; Date_CaptionLbl)
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
                column(Vendor_Name_and_AddressCaption; Vendor_Name_and_AddressCaptionLbl)
                {
                }
                column(Item_Code___NameCaption; ITEMDESCRIPTIONCapt)
                {
                }
                column(Sr__No_Caption; Sr__No_CaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(Warehouse_Receipt_Line__Qty__On_Invoice_Caption; Warehouse_Receipt_Line__Qty__On_Invoice_CaptionLbl)
                {
                }
                column(Warehouse_Receipt_Line__Actual_Qty__to_Receive_Caption; Warehouse_Receipt_Line__Actual_Qty__to_Receive_CaptionLbl)
                {
                }
                column(Accepted__Qty_Caption; Accepted__Qty_CaptionLbl)
                {
                }
                column(Rejected__Qty_Caption; Rejected__Qty_CaptionLbl)
                {
                }
                column(Warehouse_Receipt_Line__Shortage_Qty__Caption; "Warehouse Receipt Line".FieldCaption("Shortage Qty."))
                {
                }
                column(RemarksTxtCaption; RemarksTxtCaptionLbl)
                {
                }
                column(Warehouse_Receipt_Header___Transporter_Copy_Received_Caption; Warehouse_Receipt_Header___Transporter_Copy_Received_CaptionLbl)
                {
                }
                column(Warehouse_Receipt_Header___QC_Report_Received_Caption; Warehouse_Receipt_Header___QC_Report_Received_CaptionLbl)
                {
                }
                column(Prepared_ByCaption; Prepared_ByCaptionLbl)
                {
                }
                column(Store__Caption; Store__CaptionLbl)
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
                column(Store__Caption_Control1000000029; Store__Caption_Control1000000029Lbl)
                {
                }
                column(AUTHORISED__Caption; AUTHORISED__CaptionLbl)
                {
                }
                column(QC__Caption; QC__CaptionLbl)
                {
                }
                column(Integer_Number; Number)
                {
                }
                column(SrNo; SrNo)
                {
                }
                dataitem("Warehouse Receipt Line"; "Warehouse Receipt Line")
                {
                    DataItemLink = "No."=field("No.");
                    DataItemLinkReference = "Warehouse Receipt Header";
                    DataItemTableView = sorting("No.", "Line No.");

                    column(ReportForNavId_7105;7105)
                    {
                    }
                    column(Item_No____________Description; VendItemDesc)
                    {
                    }
                    column(Warehouse_Receipt_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                    {
                    }
                    column(Warehouse_Receipt_Line__Qty__On_Invoice_; "Qty. On Invoice")
                    {
                    }
                    column(Warehouse_Receipt_Line__Actual_Qty__to_Receive_; "Actual Qty. to Receive")
                    {
                    }
                    column(Warehouse_Receipt_Line__Accepted_Qty__; "Accepted Qty.")
                    {
                    }
                    column(Warehouse_Receipt_Line__Rejected_Qty__; "Rejected Qty.")
                    {
                    }
                    column(Warehouse_Receipt_Line__Shortage_Qty__; "Shortage Qty.")
                    {
                    }
                    column(PartNo; PartNo)
                    {
                    }
                    column(description2; description2)
                    {
                    }
                    column(Grade1; Grade1)
                    {
                    }
                    column(Warehouse_Receipt_Line_No_; "No.")
                    {
                    }
                    column(Warehouse_Receipt_Line_Line_No_; "Line No.")
                    {
                    }
                    column(VendorItemDescription_WarehouseReceiptLine; "Vendor Item Description")
                    {
                    }
                    column(VendItemDesc; VendItemDesc)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        GetLocation("Location Code");
                        SrNo+=1;
                        if "Vendor Item Description" <> '' then begin
                            GeneralLedgerSetup.Reset();
                            GeneralLedgerSetup.Get();
                            if GeneralLedgerSetup."SSD Activate Item Vendor" then VendItemDesc:="Item No." + '  ' + Description + '  ' + "Description 2" + '(' + "Vendor Item Description" + ')' end
                        else
                            VendItemDesc:="Item No." + '  ' + Description + '  ' + "Description 2";
                    end;
                }
            }
            trigger OnAfterGetRecord()
            begin
                if Location.Get("Location Code")then begin
                    if STATES1.Get(Location."State Code")then StateName2:=STATES1.Description
                    else
                        StateName2:='';
                    LocationName:=Location.Address + ',' + Location."Address 2" + ',' + Location.City + '-' + Location."Post Code" + ',' + StateName2 + 'TEL No. ' + Location."Phone No." + ' FAX No. ' + Location."Fax No." end;
                GetLocation("Location Code");
                if PostedGateHdr.Get("Warehouse Receipt Header"."Gate Entry no.")then if PostedGateHdr."Ref. Document Type" in[PostedGateHdr."ref. document type"::"Purchase Order", PostedGateHdr."ref. document type"::"Purchase Schedule"]then if PurchaseHeader.Get(PurchaseHeader."document type"::Order, PostedGateHdr."Ref. Document No.")then;
                if not Vendor.Get(PostedGateHdr."Party No.")then begin
                    Clear(Vendor);
                    PartyNameTxt:='Customer Name and Address';
                end;
                if not Customer.Get(PostedGateHdr."Party No.")then begin
                    Clear(Customer);
                    PartyNameTxt:='Vendor Name and Address';
                end;
                WhseCommentLine.Reset;
                WhseCommentLine.SetRange("Table Name", WhseCommentLine."table name"::"Whse. Receipt");
                WhseCommentLine.SetRange(Type, WhseCommentLine.Type::" ");
                WhseCommentLine.SetRange("No.", "No.");
                if WhseCommentLine.Find('-')then RemarksTxt:=WhseCommentLine.Comment;
                if WhseCommentLine.Next <> 0 then RemarksTxt:=RemarksTxt + '\' + WhseCommentLine.Comment;
                if WhseCommentLine.Next <> 0 then RemarksTxt:=RemarksTxt + '\' + WhseCommentLine.Comment;
                if WhseCommentLine.Next <> 0 then RemarksTxt:=RemarksTxt + '\' + WhseCommentLine.Comment;
                SrNo:=0;
                QCReportRecieved:='NO';
                TransportQCRecieved:='NO';
                if "Warehouse Receipt Header"."QC Report Received" then QCReportRecieved:='YES';
                if "Warehouse Receipt Header"."Transporter Copy Received" then TransportQCRecieved:='YES';
                GeneralLedgerSetup.Reset();
                GeneralLedgerSetup.Get();
                if GeneralLedgerSetup."SSD Activate Item Vendor" then begin
                    WarehouseReceiptLine.Reset();
                    WarehouseReceiptLine.SetRange("No.", "No.");
                    WarehouseReceiptLine.SetFilter("Vendor Item Description", '<>%1', '');
                    if WarehouseReceiptLine.FindFirst()then begin
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
        companyInfo.Get;
        companyInfo.CalcFields(Picture);
    // RespCent.Get(UserMgt.GetRespCenterFilter);
    end;
    var ItemVendDescVisible: boolean;
    VendItemDesc: Text;
    ITEMDESCRIPTIONCapt: Text;
    IVD: Integer;
    WarehouseReceiptLine: Record "Warehouse Receipt Line";
    GeneralLedgerSetup: Record "General Ledger Setup";
    Location: Record Location;
    LocationName: Text;
    StateName2: Text[50];
    companyInfo: Record "Company Information";
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
    Customer: Record Customer;
    PartyNameTxt: Text[30];
    States: Record State;
    CES_STR_F_02CaptionLbl: label 'CES/STR/F/02';
    MATERIAL__RECEIPT__NOTECaptionLbl: label 'MATERIAL  RECEIPT  NOTE';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Date_CaptionLbl: label 'Date:';
    Gate_Entry_No____DateCaptionLbl: label 'Gate Entry No. & Date';
    P_O_No____DateCaptionLbl: label 'P.O No. & Date';
    Party_Invoice_No____DateCaptionLbl: label 'Party Invoice No. & Date';
    Whse__Rcpt__No____DateCaptionLbl: label 'Whse. Rcpt. No. & Date';
    Road_Permit_No_CaptionLbl: label 'Road Permit No.';
    PostedGateHeader__Transporter_Name_CaptionLbl: label 'Transporter Name';
    Transporter_Bill_No____DateCaptionLbl: label 'Transporter Bill No. & Date';
    Delivery_Challan_No____DateCaptionLbl: label 'Delivery Challan No. & Date';
    Vendor_Name_and_AddressCaptionLbl: label 'Vendor Name and Address';
    Item_Code___NameCaptionLbl: Text;
    Sr__No_CaptionLbl: label 'Sr. No.';
    UOMCaptionLbl: label 'UOM';
    Warehouse_Receipt_Line__Qty__On_Invoice_CaptionLbl: label 'Invoice Qty.';
    Warehouse_Receipt_Line__Actual_Qty__to_Receive_CaptionLbl: label 'Actual Qty.';
    Accepted__Qty_CaptionLbl: label 'Accepted. Qty.';
    Rejected__Qty_CaptionLbl: label 'Rejected. Qty.';
    RemarksTxtCaptionLbl: label 'Remarks';
    Warehouse_Receipt_Header___Transporter_Copy_Received_CaptionLbl: label 'Transporter Copy Received';
    Warehouse_Receipt_Header___QC_Report_Received_CaptionLbl: label 'QC Report Received';
    Prepared_ByCaptionLbl: label 'Prepared By';
    Store__CaptionLbl: label '( Store )';
    INSPECTED_BYCaptionLbl: label 'INSPECTED BY';
    CHECKED_BYCaptionLbl: label 'CHECKED BY';
    APPROVED_BYCaptionLbl: label 'APPROVED BY';
    Store__Caption_Control1000000029Lbl: label '( Store )';
    AUTHORISED__CaptionLbl: label '( AUTHORISED )';
    QC__CaptionLbl: label '( QC )';
    HeaderReport1: label '57Th KM STONE, DELHI - JAIPUR HIGHWAY, VILLAGE BINOLA, DISTRICT GURGAON - 122 413';
    HeaderReport2: label 'HARYANA, INDIA\ PHONE ++91 124 4981000, FAX: ++91 124 4981002';
    QCReportRecieved: Text;
    TransportQCRecieved: Text;
    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then Location.Init
        else if Location.Code <> LocationCode then Location.Get(LocationCode);
    end;
}
