PageExtension 50096 "SSD Sales Order List" extends "Sales Order List"
{
    layout
    {
        addafter("Bill-to Name")
        {
            field("Order Confirmation Mail Send"; Rec."Order Confirmation Mail Send")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Date")
        {
            field("MRP No."; Rec."MRP No.")
            {
                ApplicationArea = All;
            }
            //SSDU
            field("Type of Invoice"; Rec."Type of Invoice")
            {
                ApplicationArea = All;
            }
        //SSDU
        }
    }
    actions
    {
        //SSDU
        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndSend)
        {
            Visible = false;
        }
        modify("Post &Batch")
        {
            Visible = false;
        }
        modify("Post &Batch_Promoted")
        {
            Visible = false;
        }
        modify(Post_Promoted)
        {
            Visible = false;
        }
        modify(PostAndSend_Promoted)
        {
            Visible = false;
        }
    }
    trigger OnOpenPage()
    begin
        rec.FILTERGROUP(0);
        Rec.SetRange("Document Subtype", Rec."Document Subtype"::Order);
        rec.FILTERGROUP(1);
    end;
}
