Report 50023 "Pendings With Stores/Quality"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pendings With StoresQuality.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            column(ReportForNavId_3182;3182)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(UserId; UserId)
            {
            }
            column(ResCen_Name; ResCen.Name)
            {
            }
            column(ResAdd; ResAdd)
            {
            }
            column(Pending_with_stores___QualityCaption; Pending_with_stores___QualityCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bill_No_Caption; Bill_No_CaptionLbl)
            {
            }
            column(Gate_Entry_No_Caption; Gate_Entry_No_CaptionLbl)
            {
            }
            column(GE_DateCaption; GE_DateCaptionLbl)
            {
            }
            column(MRN_No_Caption; MRN_No_CaptionLbl)
            {
            }
            column(Bill_DateCaption; Bill_DateCaptionLbl)
            {
            }
            column(Vendor_No_Caption; Vendor_No_CaptionLbl)
            {
            }
            column(Vendor_nameCaption; Vendor_nameCaptionLbl)
            {
            }
            column(Bill_AmtCaption; Bill_AmtCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(LocationCaption; LocationCaptionLbl)
            {
            }
            column(Vendor_No_; "No.")
            {
            }
            dataitem("Warehouse Receipt Line"; "Warehouse Receipt Line")
            {
                DataItemLink = "Party No."=field("No.");
                DataItemTableView = sorting("Gate Entry no.", "No.", "Line No.")order(ascending);
                RequestFilterFields = "Item No.";

                column(ReportForNavId_7105;7105)
                {
                }
                column(Warehouse_Receipt_Line__Item_No__; "Item No.")
                {
                }
                column(Warehouse_Receipt_Line_Description; Description)
                {
                }
                column(Warehouse_Receipt_Line_Quantity; Quantity)
                {
                }
                column(Remarks; Remarks)
                {
                }
                column(Warehouse_Receipt_Line__Gate_Entry_no__; "Gate Entry no.")
                {
                }
                column(GateEntryDate; GateEntryDate)
                {
                }
                column(VendorBillNo__; "VendorBillNo.")
                {
                }
                column(VendorBillDate; VendorBillDate)
                {
                }
                column(BillAmount; BillAmount)
                {
                }
                column(Vendor__No__; Vendor."No.")
                {
                }
                column(Vendor_Name; Vendor.Name)
                {
                }
                column(Warehouse_Receipt_Line__No__; "No.")
                {
                }
                column(Warehouse_Receipt_Line__Warehouse_Receipt_Line___Quality_Done_; "Warehouse Receipt Line"."Quality Done")
                {
                }
                column(item__No__2_; item."No. 2")
                {
                }
                column(Warehouse_Receipt_Line_Line_No_; "Line No.")
                {
                }
                column(Warehouse_Receipt_Line_Party_No_; "Party No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if item.Get("Warehouse Receipt Line"."Item No.")then;
                end;
            }
            trigger OnPreDataItem()
            begin
                LastFieldNo:=FieldNo("No.");
                ResAdd:=ResCen.Address + ', ' + ResCen."Address 2" + ', ' + ResCen.City + '-' + ResCen."Post Code";
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
        ResCen.Get(UserMgt.GetRespCenterFilter);
    end;
    var LastFieldNo: Integer;
    FooterPrinted: Boolean;
    PostedGateHeader: Record "SSD Posted Gate Header";
    GateEntryDate: Date;
    "VendorBillNo.": Code[20];
    VendorBillDate: Date;
    BillAmount: Decimal;
    Remarks: Text[30];
    VendorTotal: Decimal;
    WarehouseReceiptLine: Record "Warehouse Receipt Line";
    ResCen: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    ResAdd: Text[250];
    Store: Boolean;
    quality: Boolean;
    Both: Boolean;
    item: Record Item;
    Pending_with_stores___QualityCaptionLbl: label 'Pending with stores & Quality';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Bill_No_CaptionLbl: label 'Bill No.';
    Gate_Entry_No_CaptionLbl: label 'Gate Entry No.';
    GE_DateCaptionLbl: label 'GE Date';
    MRN_No_CaptionLbl: label 'MRN No.';
    Bill_DateCaptionLbl: label 'Bill Date';
    Vendor_No_CaptionLbl: label 'Vendor No.';
    Vendor_nameCaptionLbl: label 'Vendor name';
    Bill_AmtCaptionLbl: label 'Bill Amt';
    Item_No_CaptionLbl: label 'Item No.';
    Item_DescriptionCaptionLbl: label 'Item Description';
    QuantityCaptionLbl: label 'Quantity';
    LocationCaptionLbl: label 'Location';
}
