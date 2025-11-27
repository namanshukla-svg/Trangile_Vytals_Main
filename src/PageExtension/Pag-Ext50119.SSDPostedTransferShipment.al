pageextension 50119 "SSD Posted Transfer Shipment" extends "Posted Transfer Shipment"
{
    actions
    {
        //modify("Generate E-Invoice")
        //{
        //  Visible = false;
        //}
        addafter("&Navigate")
        {
            action("SSD Generate E-Invoice")
            {
                ApplicationArea = All;
                Caption = 'Generate E-Invoice';
                Enabled = true;
                Image = ElectronicDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Generate E-Invoice action.';

                trigger OnAction()
                var
                    TrnsShpHeader: Record "Transfer Shipment Header";
                    //EinvSSD: Codeunit SSDEinvGenerateEinvoice;
                    EInvoiceMgt: Codeunit "SSD EInvoice Management";
                begin
                    //if Rec."IRN Hash" = '' then begin
                    //if GSTManagement.IsGSTApplicable(Structure) then begin
                    TrnsShpHeader.Reset;
                    TrnsShpHeader.SetRange("No.", Rec."No.");
                    if TrnsShpHeader.FindFirst then begin
                        Clear(EInvoiceMgt);
                        TrnsShpHeader.Mark(true);
                        EInvoiceMgt.GenerateTransferShipment(TrnsShpHeader)end;
                // end else
                // Message('IRN Already Generated');
                end;
            }
            action("Generate E-Way Bill")
            {
                ApplicationArea = All;
                Caption = 'Generate E-Way Bill';
                Image = ElectronicCollectedTax;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                ToolTip = 'Executes the Generate E-Way Bill action.';

                trigger OnAction()
                var
                    TrnsShpHeader: Record "Transfer Shipment Header";
                    //EWBSSD: Codeunit "Generate EWB";
                    EInvoiceMgt: Codeunit "SSD EInvoice Management";
                begin
                    if Rec."SSD E-Way Bill No." = '' then begin
                        TrnsShpHeader.Reset;
                        TrnsShpHeader.SetRange("No.", Rec."No.");
                        if TrnsShpHeader.FindFirst then begin
                            Clear(EInvoiceMgt);
                            TrnsShpHeader.Mark(true);
                            EInvoiceMgt.GenerateTransShipEWB(TrnsShpHeader);
                        end
                        else
                            Error('');
                    end
                    else
                    begin
                        Message('E-way Bill No %1 Already Generated', Rec."SSD E-Way Bill No.");
                    end;
                end;
            }
        }
    }
}
