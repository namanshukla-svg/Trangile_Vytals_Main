PageExtension 50089 "SSD Reservation Entries" extends "Reservation Entries"
{
    actions
    {
        addafter(CancelReservation)
        {
            action("Show Quality Order")
            {
                ApplicationArea = All;
                Caption = 'Show Quality Order';

                trigger OnAction()
                var
                    FormPosteQualityOrderList1: Page "Posted Quality Order List";
                    PostedQualityOrderHeader1: Record "SSD Posted Quality Order Hdr";
                begin
                    PostedQualityOrderHeader1.Reset;
                    PostedQualityOrderHeader1.SetRange(PostedQualityOrderHeader1."Lot No.", Rec."Lot No.");
                    if PostedQualityOrderHeader1.FindFirst then begin
                        Clear(FormPosteQualityOrderList1);
                        FormPosteQualityOrderList1.SetTableview(PostedQualityOrderHeader1);
                        FormPosteQualityOrderList1.RunModal;
                    end;
                end;
            }
        }
    }
}
