Report 50225 "Block Item"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = where("Replenishment System"=filter("Prod. Order"), Inventory=filter(0), "Routing No."=filter(''), "Production BOM No."=filter(''));

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                ILEExist:=false;
                ILE.Reset;
                ILE.SetRange("Item No.", "No.");
                ILE.SetRange("Posting Date", FromDate, WorkDate);
                if ILE.FindFirst then ILEExist:=true;
                if(ILEExist = false)then begin
                    Blocked:=true;
                    Modify;
                end;
            end;
            trigger OnPreDataItem()
            begin
                FromDate:=CalcDate('-1Y', WorkDate);
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
    var ILE: Record "Item Ledger Entry";
    FromDate: Date;
    ILEExist: Boolean;
    BOMExist: Boolean;
    ProdBOMExist: Boolean;
}
