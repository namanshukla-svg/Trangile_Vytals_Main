Page 50221 "Requision Slip Line SubForm"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD Requision Slip Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Req. Slip Document No."; Rec."Req. Slip Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prod.Order Source No."; Rec."Prod.Order Source No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("To Location Stock"; Rec."To Location Stock")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("From-Location Inventory"; Rec."From-Location Inventory")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Routing Link Code"; Rec."Routing Link Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Due Date-Time"; Rec."Due Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
    var ReqSlipHead: Record "SSD Requision Slip Header";
    local procedure ItemNoOnBeforeInput()
    begin
    /* // BIS 1145
        IF ReqSlipHead.GET("Document Type","Document No.") THEN
          IF ReqSlipHead."Manual Requisition" THEN
            CurrPage."Item No.".UPDATEEDITABLE(TRUE)
          ELSE
            CurrPage."Item No.".UPDATEEDITABLE(FALSE);
        */
    // BIS 1145
    end;
}
