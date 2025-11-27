Report 50095 "Vendor Item Purchase"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Vendor Item Purchase.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter";

            column(ReportForNavId_3182;3182)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(UserId; UserId)
            {
            }
            column(No_____________Name; "No." + ' - ' + Name)
            {
            }
            column(Vendor_Item_PurchaseCaption; Vendor_Item_PurchaseCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Item_No___Control1102152014Caption; "Item Ledger Entry".FieldCaption("Item No."))
            {
            }
            column(Vendor_Caption; Vendor_CaptionLbl)
            {
            }
            column(Item_Description_________Item__Description_2_Caption; Item_Description_________Item__Description_2_CaptionLbl)
            {
            }
            column(Vendor_No_; "No.")
            {
            }
            column(Vendor_Date_Filter; "Date Filter")
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Source No."=field("No."), "Posting Date"=field("Date Filter");
                DataItemTableView = sorting("Item No.", "Posting Date")order(ascending)where("Entry Type"=const(Purchase));
                RequestFilterFields = "Item No.", "Posting Date", "Location Code";

                column(ReportForNavId_7209;7209)
                {
                }
                column(Item_Ledger_Entry__Item_No__; "Item No.")
                {
                }
                column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Item_Ledger_Entry__Item_No___Control1102152014; "Item No.")
                {
                }
                column(Item_Ledger_Entry__Source_No__; "Source No.")
                {
                }
                column(Item_Ledger_Entry__Location_Code_; "Location Code")
                {
                }
                column(Item_Ledger_Entry_Quantity; Quantity)
                {
                }
                column(Item_Ledger_Entry__Document_No__; "Document No.")
                {
                }
                column(Item_Description_________Item__Description_2_; Item.Description + ' ' + Item."Description 2")
                {
                }
                column(TotalFor___FIELDCAPTION__Item_No___; TotalFor + FieldCaption("Item No."))
                {
                }
                column(Item_Ledger_Entry_Quantity_Control1102152032; Quantity)
                {
                }
                column(Item_Ledger_Entry__Posting_Date_Caption; FieldCaption("Posting Date"))
                {
                }
                column(Item_Ledger_Entry__Source_No__Caption; FieldCaption("Source No."))
                {
                }
                column(Item_Ledger_Entry__Location_Code_Caption; FieldCaption("Location Code"))
                {
                }
                column(Item_Ledger_Entry_QuantityCaption; FieldCaption(Quantity))
                {
                }
                column(Item_Ledger_Entry__Document_No__Caption; FieldCaption("Document No."))
                {
                }
                column(Item_Ledger_Entry__Item_No__Caption; FieldCaption("Item No."))
                {
                }
                column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Item.Get("Item No.");
                end;
            }
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
        CompInfo.Get;
    end;
    var TotalFor: label 'Total for ';
    Item: Record Item;
    CompInfo: Record "Company Information";
    Vendor_Item_PurchaseCaptionLbl: label 'Vendor Item Purchase';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Vendor_CaptionLbl: label 'Vendor ';
    Item_Description_________Item__Description_2_CaptionLbl: label 'Item Name';
}
