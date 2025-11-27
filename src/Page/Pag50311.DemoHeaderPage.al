Page 50311 "Demo Header Page"
{
    PageType = List;
    Permissions = TableData "Production Order"=rimd;
    SourceTable = "Production Order";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Replan Ref. No."; Rec."Replan Ref. No.")
                {
                    ApplicationArea = All;
                }
                field("Replan Ref. Status"; Rec."Replan Ref. Status")
                {
                    ApplicationArea = All;
                }
                field("Low-Level Code"; Rec."Low-Level Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    ApplicationArea = All;
                }
                field("Work Center Filter"; Rec."Work Center Filter")
                {
                    ApplicationArea = All;
                }
                field("Capacity Type Filter"; Rec."Capacity Type Filter")
                {
                    ApplicationArea = All;
                }
                field("Capacity No. Filter"; Rec."Capacity No. Filter")
                {
                    ApplicationArea = All;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = All;
                }
                field("Expected Operation Cost Amt."; Rec."Expected Operation Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("Expected Component Cost Amt."; Rec."Expected Component Cost Amt.")
                {
                    ApplicationArea = All;
                }
                field("Actual Time Used"; Rec."Actual Time Used")
                {
                    ApplicationArea = All;
                }
                field("Allocated Capacity Need"; Rec."Allocated Capacity Need")
                {
                    ApplicationArea = All;
                }
                field("Expected Capacity Need"; Rec."Expected Capacity Need")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Planned Order No."; Rec."Planned Order No.")
                {
                    ApplicationArea = All;
                }
                field("Firm Planned Order No."; Rec."Firm Planned Order No.")
                {
                    ApplicationArea = All;
                }
                field("Simulated Order No."; Rec."Simulated Order No.")
                {
                    ApplicationArea = All;
                }
                field("Expected Material Ovhd. Cost"; Rec."Expected Material Ovhd. Cost")
                {
                    ApplicationArea = All;
                }
                field("Expected Capacity Ovhd. Cost"; Rec."Expected Capacity Ovhd. Cost")
                {
                    ApplicationArea = All;
                }
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Ending Date-Time"; Rec."Ending Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Completely Picked"; Rec."Completely Picked")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field(Reprocess; Rec.Reprocess)
                {
                    ApplicationArea = All;
                }
                field("Source Doc. No."; Rec."Source Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Item Entry Source No."; Rec."Item Entry Source No.")
                {
                    ApplicationArea = All;
                }
                field("Req Generated"; Rec."Req Generated")
                {
                    ApplicationArea = All;
                }
                field("Finished Qty."; Rec."Finished Qty.")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Version"; Rec."No. of Archived Version")
                {
                    ApplicationArea = All;
                }
                field("Order Created from MRP"; Rec."Order Created from MRP")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
