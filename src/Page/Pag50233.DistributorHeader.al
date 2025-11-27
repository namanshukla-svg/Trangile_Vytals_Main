Page 50233 "Distributor Header"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "SSD Distributor Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("MRP No."; Rec."MRP No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Error Text"; Rec."Error Text")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control1000000006; "Distributor Subform")
            {
                SubPageLink = "MRP No"=field("MRP No.");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Create Sales Order")
            {
                ApplicationArea = All;
                Caption = 'Create Sales Order';
                Promoted = true;

                trigger OnAction()
                var
                    BatchUpdateSalesHLine: Report "Batch Update Sales H & Line II";
                    DistributorLine: Record "SSD Distributor Line";
                begin
                    DistributorLine.SetRange(DistributorLine."MRP No", Rec."MRP No.");
                    if DistributorLine.FindFirst then begin
                        BatchUpdateSalesHLine.SetTableview(DistributorLine);
                        BatchUpdateSalesHLine.Run;
                    end;
                end;
            }
        }
    }
}
