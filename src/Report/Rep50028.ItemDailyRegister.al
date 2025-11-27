Report 50028 "Item Daily Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Item Daily Register.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Posting Date", "Item No.");
            RequestFilterFields = "Posting Date", "Item No.", "Entry Type";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(DataItem1000000019; respcent.Address + ',' + respcent."Address 2" + ',' + respcent.City + '-' + respcent."Post Code" + ',' + respcent.State + 'TEL No. ' + respcent."Phone No." + ' FAX No. ' + respcent."Fax No.")
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(PostngDate; "Posting Date")
            {
            }
            column(DocNo; "Document No.")
            {
            }
            column(EntryType; "Entry Type")
            {
            }
            column(ProductonDocNo; "Production Doc. No.")
            {
            }
            column(ProductonDocType; "Production Doc. Type")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(Descripton; ItemRec.Description)
            {
            }
            column(Descripton2; ItemRec."Description 2")
            {
            }
            column(LocCode; "Location Code")
            {
            }
            column(Qty; Quantity)
            {
            }
            column(UOM; ItemRec."Base Unit of Measure")
            {
            }
            column(UnitCost; "Cost Amount (Actual)" / Quantity)
            {
            }
            column(CostAmtActual; "Cost Amount (Actual)")
            {
            }
            column(NetWeght; ItemRec."Net Weight")
            {
            }
            column(TotWt; TotWt)
            {
            }
            column(TotalTxt;'TotalFor ' + FieldCaption("Posting Date") + ' : ' + Format("Posting Date"))
            {
            }
            column(ReasonCode_ItemLedgerEntry; Reason.Description)
            {
            }
            trigger OnAfterGetRecord()
            begin
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
                if ItemRec.Get("Item No.")then;
                TotWt:=ItemRec."Net Weight" * Quantity;
                GrTotWt+=TotWt;
                Clear(Reason);
            //if Reason.Get("Item Ledger Entry"."Reason Code") then;
            END;
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
        respcent.Get(UserMgt.GetRespCenterFilter);
    end;
    var ItemRec: Record Item;
    TotWt: Decimal;
    respcent: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    CompInfo: Record "Company Information";
    GrTotWt: Decimal;
    Reason: Record "Reason Code";
}
