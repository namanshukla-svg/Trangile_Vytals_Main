PageExtension 50054 "SSD Planning Worksheet" extends "Planning Worksheet"
{
    layout
    {
        addafter("No.")
        {
            field("Item Procurement Category"; Rec."Item Procurement Category")
            {
                ApplicationArea = All;
            }
        }
        addafter("Accept Action Message")
        {
            field("No. of Archived Versions"; Rec."No. of Archived Versions")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Vendor No.")
        {
            field("Vendor Name1"; Rec."Vendor Name1")
            {
                ApplicationArea = All;
                Caption = 'Vendor Name';
            }
        }
        addafter(Quantity)
        {
            field("MRP Qty."; Rec."MRP Qty.")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("MRP Remark"; Rec."MRP Remark")
            {
                ApplicationArea = All;
            }
        }
        addafter("Gen. Business Posting Group")
        {
            field("Item Category Code"; Rec."Item Category Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(OrderTracking)
        {
            action("Archived List")
            {
                ApplicationArea = All;
                Caption = 'Archived List';
                RunObject = Page "Requisition Line Archive";
            }
        }
    }
    var I: Integer;
    J: Integer;
}
