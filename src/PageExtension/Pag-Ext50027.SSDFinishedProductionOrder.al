PageExtension 50027 "SSD Finished Production Order" extends "Finished Production Order"
{
    actions
    {
        //Unsupported feature: Property Modification (Level) on ""<Action2>"(Action 2)".
        addfirst(processing)
        {
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ProductionOrderLine: Record "Prod. Order Line";
                    JobCard: Report "Job Card/Production Card";
                begin
                    ProductionOrderLine.Reset;
                    ProductionOrderLine.SetRange(ProductionOrderLine."Prod. Order No.", Rec."No.");
                    JobCard.SetTableview(ProductionOrderLine);
                    JobCard.Run;
                end;
            }
        }
    }
}
