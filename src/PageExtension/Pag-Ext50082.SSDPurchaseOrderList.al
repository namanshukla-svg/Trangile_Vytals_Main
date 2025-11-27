PageExtension 50082 "SSD Purchase Order List" extends "Purchase Order List"
{
    layout
    {
        addfirst(Control1)
        {
            field("SSD Order Type"; Rec."SSD Order Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.';
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Contact")
        {
            field("PO Mail Send"; Rec."PO Mail Send")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Job Queue Status")
        {
            field("Order Created from MRP"; Rec."Order Created from MRP")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            // field("Type of Invoice"; Rec."Type of Invoice") //ANI::251125
            // {
            //     ApplicationArea = All;
            // }
            field("SSD SPO Subject"; Rec."SSD SPO Subject")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPO Subject field.';
            }
        }
    }
    actions
    {
        modify(Post)
        {
            Visible = false;
        }
        modify(Post_Promoted)
        {
            Visible = false;
        }
        modify(PostBatch)
        {
            Visible = false;
        }
        modify(PostBatch_Promoted)
        {
            Visible = false;
        }
        modify(PostAndPrint_Promoted)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
    }
    trigger OnDeleteRecord(): Boolean
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD Delete Administrator" then Error('You are not authorise to delete this record');
    end;

    var
        UserSetup: Record "User Setup";
        I: Integer;
        NavigateVisible: Boolean;
}
