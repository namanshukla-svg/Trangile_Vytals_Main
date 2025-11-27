Page 50272 "Posted Requision Slip List"
{
    ApplicationArea = All;
    CardPageID = "Posted Requision Slip Form";
    Editable = false;
    PageType = List;
    SourceTable = "SSD Posted Req. Slip Header";
    SourceTableView = where("Document Type"=filter("Material Issue"));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("Req. Slip No."; Rec."Req. Slip No.")
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
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Req. Date"; Rec."Req. Date")
                {
                    ApplicationArea = All;
                }
                field("Req. Time"; Rec."Req. Time")
                {
                    ApplicationArea = All;
                }
                field("Transfer-From Location"; Rec."Transfer-From Location")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Source Description"; Rec."Source Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var //SSDU  GetMatReq: Report "PO Print";
    DocumentTypeGlb: Option " ", "Material Issue", "Material Return", "Line Rejection", "Floor Rejection", Offer, ReOffer;
    DepartmentValueGlb: Option " ", PPC, AWP, WIP, Conveyor, ED, Store;
    UserMgt: Codeunit "SSD User Setup Management";
}
