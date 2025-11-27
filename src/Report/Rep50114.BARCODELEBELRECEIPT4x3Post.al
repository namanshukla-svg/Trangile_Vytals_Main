Report 50114 "BARCODE LEBEL RECEIPT 4x3-Post"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BARCODE LEBEL RECEIPT 4x3-Post.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;
    UseSystemPrinter = false;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Location Code", "Posting Date", "Document No.", "Item No.");
            RequestFilterFields = "Document No.";

            column(ReportForNavId_7209;7209)
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            dataitem("Barcode Labelpp"; "SSD Barcode Labelpp")
            {
                DataItemTableView = sorting(SrNo);

                column(ReportForNavId_2279;2279)
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(PRODUCT_FOR_INDUSTRIAL_USE_ONLY_;'PRODUCT FOR INDUSTRIAL USE ONLY')
                {
                }
                column(Visit_us_at_www_zavenir_com_;'Visit us at www.zavenir.com')
                {
                }
                column(V000000000000000000_____;'*' + '000000000000000000' + '*')
                {
                }
                column(Consult_product_MSDS_for_safety_guidelines__;'Consult product MSDS for safety guidelines.')
                {
                }
                column(QUANTITY______________________FORMAT_Qty_______Item1__Base_Unit_of_Measure_;'QUANTITY                    ' + Format(Qty) + '  ' + Item1."Base Unit of Measure")
                {
                }
                column(MFG__DATE________;'MFG. DATE                   ')
                {
                }
                column(PostingDate; "Item Ledger Entry"."Posting Date")
                {
                }
                column(NET_WT__GR__WT_____________FORMAT_WT______FORMAT_GWT____KGS_;'NET WT./GR. WT.          ' + Format(WT) + '/' + Format(GWT) + ' KGS')
                {
                }
                column(Item_Ledger_Entry___Item_No_________Item1_Description_____Item1__Description_2_; "Item Ledger Entry"."Item No." + ' - ' + Item1.Description + ' ' + Item1."Description 2")
                {
                }
                column(LOT_NO_________________________FORMAT__Item_Ledger_Entry___Lot_No___;'LOT NO.                        ' + Format("Item Ledger Entry"."Lot No."))
                {
                }
                column(BEST_USED_BEFORE_____;'BEST USED BEFORE    ')
                {
                }
                column(CompanyInfo_Name_Control1000000026; CompanyInfo.Name)
                {
                }
                column(QUANTITY_______________________FORMAT_Qty_______Item1__Base_Unit_of_Measure_;'QUANTITY                     ' + Format(Qty) + '  ' + Item1."Base Unit of Measure")
                {
                }
                column(Item_Ledger_Entry___Item_No_________Item1_Description_____Item1__Description_2__Control1000000029; "Item Ledger Entry"."Item No." + ' - ' + Item1.Description + ' ' + Item1."Description 2")
                {
                }
                column(LOT_NO__________________________FORMAT__Item_Ledger_Entry___Lot_No___;'LOT NO.                        ' + Format("Item Ledger Entry"."Lot No."))
                {
                }
                column(MFG__DATE______________________FORMAT__Item_Ledger_Entry___Posting_Date__;'MFG. DATE                    ' + Format("Item Ledger Entry"."Posting Date"))
                {
                }
                column(NET_WT__GR__WT______________FORMAT_WT______FORMAT_GWT____KGS_;'NET WT./GR. WT.          ' + Format(WT) + '/' + Format(GWT) + ' KGS')
                {
                }
                column(BEST_USED_BEFORE_______FORMAT__Item_Ledger_Entry___Expiration_Date__;'BEST USED BEFORE     ' + Format("Item Ledger Entry"."Expiration Date"))
                {
                }
                column(V000000000000000000______Control1000000034;'*' + '000000000000000000' + '*')
                {
                }
                column(PRODUCT_FOR_INDUSTRIAL_USE_ONLY__Control1000000035;'PRODUCT FOR INDUSTRIAL USE ONLY')
                {
                }
                column(Consult_product_MSDS_for_safety_guidelines___Control1000000037;'Consult product MSDS for safety guidelines.')
                {
                }
                column(Visit_us_at_www_zavenir_com__Control1000000038;'Visit us at www.zavenir.com')
                {
                }
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(CompanyInfo_Picture_Control1000000009; CompanyInfo.Picture)
                {
                }
                column(Barcode_Labelpp_SrNo; SrNo)
                {
                }
                column(ExpirationDate; "Item Ledger Entry"."Expiration Date")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Item1.Reset;
                    if Item1.Get("Item Ledger Entry"."Item No.")then;
                    Qty:="Barcode Labelpp".Quantity;
                    WT:="Barcode Labelpp"."Net Weight";
                    GWT:="Barcode Labelpp"."Gross Weight";
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture, CompanyInfo."New Logo1", CompanyInfo."New Logo2");
    end;
    var CompanyInfo: Record "Company Information";
    Qty: Decimal;
    Item1: Record Item;
    WT: Decimal;
    GWT: Decimal;
    UOM: Code[20];
}
