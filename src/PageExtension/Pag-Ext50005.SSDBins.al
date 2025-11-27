PageExtension 50005 "SSD Bins" extends Bins
{
    actions
    {
        addafter("&Contents")
        {
            action("QR Code")
            {
                ApplicationArea = All;
                Caption = 'QR Code';

                trigger OnAction()
                begin
                    QRCodeMgt.BarcodeForLocation(Rec."Location Code", Rec.Code);
                end;
            }
        }
    }
    var QRCodeMgt: Codeunit "QR Code Mgt.";
}
