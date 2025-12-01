report 55015 "Update Inventory"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(SalesLine; "Sales Line")
        {
            DataItemTableView = where("Document Type" = const(Order), "Outstanding Quantity" = filter(<> 0));

            trigger OnAfterGetRecord()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
            begin
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Output);
                ItemLedgerEntry.SetRange("Location Code", SalesLine."Location Code");
                ItemLedgerEntry.SetRange("Item No.", SalesLine."No.");
                ItemLedgerEntry.SetFilter("Remaining Quantity", '>%1', 0);
                ItemLedgerEntry.SetLoadFields("Remaining Quantity");
                if ItemLedgerEntry.FindFirst() then begin
                    ItemLedgerEntry.CalcSums("Remaining Quantity");
                    SalesLine."Inventory Available" := ItemLedgerEntry."Remaining Quantity";
                    //  SalesLine.Modify();
                end;
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Output);
                ItemLedgerEntry.SetRange("Location Code", SalesLine."Location Code");
                ItemLedgerEntry.SetRange("Item No.", SalesLine."No.");
                ItemLedgerEntry.SetFilter("Remaining Quantity", '>%1', 0);
                ItemLedgerEntry.SetLoadFields("Posting Date");
                if ItemLedgerEntry.FindLast() then begin
                    SalesLine."Output Date" := ItemLedgerEntry."Posting Date";
                    SalesLine.Modify();
                end;
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = all;

                }
            }
        }
    }


    var
        myInt: Integer;
}