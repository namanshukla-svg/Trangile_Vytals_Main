Report 50121 "Lot wise Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Lot wise Report.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Lot No.")order(ascending)where(Positive=const(true), "Lot No."=filter(<>''));
            RequestFilterFields = "Posting Date", "Item Tracking", "Lot No.", "Item No.", "Item Category Code";

            column(ReportForNavId_7209;7209)
            {
            }
            column(Item_Ledger_Entry__Lot_No__; "Lot No.")
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(Desc1; Desc1)
            {
            }
            column(Desc2; Desc2)
            {
            }
            column(Uom; Uom)
            {
            }
            column(Item_Ledger_Entry__Expiration_Date_; "Expiration Date")
            {
            }
            column(Item_Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Item_Ledger_Entry__Document_Date_; "Document Date")
            {
            }
            column(QualityOrder; QualityOrder)
            {
            }
            column(Item_Ledger_Entry_Quantity; Quantity)
            {
            }
            column(Lot_Wise_ReportCaption; Lot_Wise_ReportCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Lot_No__Caption; FieldCaption("Lot No."))
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; FieldCaption("Item No."))
            {
            }
            column(Description_1Caption; Description_1CaptionLbl)
            {
            }
            column(Description_2Caption; Description_2CaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Expiration_Date_Caption; FieldCaption("Expiration Date"))
            {
            }
            column(Item_Ledger_Entry__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(Item_Ledger_Entry__Document_Date_Caption; FieldCaption("Document Date"))
            {
            }
            column(Quality_Order_No_Caption; Quality_Order_No_CaptionLbl)
            {
            }
            column(Item_Ledger_Entry_QuantityCaption; FieldCaption(Quantity))
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                PostQualiOrdHead.SetRange(PostQualiOrdHead."Lot No.", "Lot No.");
                if PostQualiOrdHead.FindFirst then QualityOrder:=PostQualiOrdHead."No.";
                ItemRec.Get("Item No.");
                Desc1:=ItemRec.Description;
                Desc2:=ItemRec."Description 2";
                Uom:=ItemRec."Base Unit of Measure";
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
    var Desc1: Text[30];
    Desc2: Text[30];
    Uom: Code[10];
    PostQualiOrdHead: Record "SSD Posted Quality Order Hdr";
    QualityOrder: Code[20];
    ItemRec: Record Item;
    Lot_Wise_ReportCaptionLbl: label 'Lot Wise Report';
    Description_1CaptionLbl: label 'Description 1';
    Description_2CaptionLbl: label 'Description 2';
    UOMCaptionLbl: label 'UOM';
    Quality_Order_No_CaptionLbl: label 'Quality Order No.';
}
