page 50039 "SSD QR Code Str"
{
    ApplicationArea = All;
    Caption = 'SSD QR Code Str';
    PageType = List;
    SourceTable = "SSD QR Code Str";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bin No."; Rec."Bin No.")
                {
                    ToolTip = 'Specifies the value of the Bin No. field.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ToolTip = 'Specifies the value of the Expiration Date field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field("QR Code No."; Rec."QR Code No.")
                {
                    ToolTip = 'Specifies the value of the QR Code No. field.';
                }
                field("QR No Integer"; Rec."QR No Integer")
                {
                    ToolTip = 'Specifies the value of the QR No Integer field.';
                }
                field(QRCode; Rec.QRCode)
                {
                    ToolTip = 'Specifies the value of the QRCode field.';
                }
                field("Qty."; Rec."Qty.")
                {
                    ToolTip = 'Specifies the value of the Qty. field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }
}
