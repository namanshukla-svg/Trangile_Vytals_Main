PageExtension 50107 "SSD Vendor Ledger Entries" extends "Vendor Ledger Entries"
{
    Editable = true;

    layout
    {
        addafter("External Document No.")
        {
            field("Hold Payment"; Rec."Hold Payment")
            {
                ApplicationArea = All;
            }
            field("PO No."; Rec."PO No.")
            {
                ApplicationArea = All;
            }
            field("MSME Category"; Rec."MSME Category")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MSME Category field.', Comment = '%';
            }
            field("MSME Classification Year"; Rec."MSME Classification Year")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MSME Classification Year field.', Comment = '%';
            }
        }
        addafter("GST Reverse Charge")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }
        }
    }
}
