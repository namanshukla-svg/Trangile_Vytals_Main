page 50043 "SSD QR Display"
{
    ApplicationArea = All;
    Caption = 'SSD QR Display';
    PageType = CardPart;
    SourceTable = "SSD E-Invoicing Requests";

    layout
    {
        area(Content)
        {
            field("QR Code"; Rec."QR Image")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the QR Code assigned by e-invoice portal for sales document.';
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.CalcFields("QR Image");
    end;
}
