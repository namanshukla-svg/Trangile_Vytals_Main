Page 50271 "Requision Slip Header List"
{
    ApplicationArea = All;
    CardPageID = "Requision Slip Header Form";
    PageType = List;
    SourceTable = "SSD Requision Slip Header";
    SourceTableView = where("Document Type" = filter("Material Issue"));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer-From Location"; Rec."Transfer-From Location")
                {
                    ApplicationArea = All;
                    Caption = 'Issue-From';
                }
                field("Transfer-To Location"; Rec."Transfer-To Location")
                {
                    ApplicationArea = All;
                    Caption = 'Issue-To';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Branch Code';
                    Editable = true;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Department Code ';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Manual Requisition"; Rec."Manual Requisition")
                {
                    ApplicationArea = All;
                }
                field("Req. Date"; Rec."Req. Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Req. Time"; Rec."Req. Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Description"; Rec."Source Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
    var
        GetMatReq: Report "Requision Slip Line Calculate";
        PReqHead: Record "SSD Posted Req. Slip Header";
        PreqLine: Record "SSD Posted Requision Slip Line";
        ReqLineRec: Record "SSD Requision Slip Line";
        MatIssueSlipHeader: Record "SSD Item Ledger Entry Buffer";
        ProdOrder: Record "Production Order";
        GetNetReq: Report "Requision Slip Net Calculate";
        TransHeader: Record "Transfer Header";
        TransLine: Record "Transfer Line";
        //  NoSeriesMgt: Codeunit NoSeriesManagement;
        RespCenter: Record "Responsibility Center";
        int: Integer;
        DocumentTypeGlb: Option " ","Material Issue","Material Return","Line Rejection","Floor Rejection",Offer,ReOffer;
        DepartmentValueGlb: Option " ",PPC,AWP,WIP,Conveyor,ED,Store;
        UserMgt: Codeunit "SSD User Setup Management";
}
