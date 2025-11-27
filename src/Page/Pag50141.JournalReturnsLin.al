Page 50141 "Journal Returns Lin."
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = "SSD Journal Returns Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Item Entry No."; Rec."Item Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Type of Return"; Rec."Type of Return")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Return Location Code"; Rec."Return Location Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Primary Order No."; Rec."Primary Order No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Good Qty."; Rec."Good Qty.")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Reclass."; Rec."Qty. to Reclass.")
                {
                    ApplicationArea = All;
                }
                field("Reclassif. Code"; Rec."Reclassif. Code")
                {
                    ApplicationArea = All;
                }
                field("Reclassif. Factor"; Rec."Reclassif. Factor")
                {
                    ApplicationArea = All;
                }
                field("Reclass. Location"; Rec."Reclass. Location")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Return"; Rec."Qty. to Return")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Control59; Rec."Carry Out Action Message")
                {
                    ApplicationArea = All;
                }
                field("Create New Order"; Rec."Create New Order")
                {
                    ApplicationArea = All;
                }
                field("Vendor Claim Code"; Rec."Vendor Claim Code")
                {
                    ApplicationArea = All;
                }
                field("Quality Defect Code"; Rec."Quality Defect Code")
                {
                    ApplicationArea = All;
                }
                field("New Location Code"; Rec."New Location Code")
                {
                    ApplicationArea = All;
                }
                field("New Bin Code"; Rec."New Bin Code")
                {
                    ApplicationArea = All;
                }
                field("New Lot"; Rec."New Lot")
                {
                    ApplicationArea = All;
                }
                field("Group by"; Rec."Group by")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                action("Get Rejects")
                {
                    ApplicationArea = All;
                    Caption = 'Get Rejects';

                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"Get Scrap Mov.");
                        CurrPage.Update(false);
                    end;
                }
                separator(Action49)
                {
                Caption = '';
                }
                action("Carry Out Action Message")
                {
                    ApplicationArea = All;
                    Caption = 'Carry Out Action Message';
                    Image = CarryOutActionMessage;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        JnlReturnsLin.Copy(Rec);
                        Report.RunModal(Report::"Session Variables", true, true, JnlReturnsLin);
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
    // if UserMgt.GetRespCenterFilter() <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    end;
    var JnlReturnsLin: Record "SSD Journal Returns Line";
    UserMgt: Codeunit "SSD User Setup Management";
}
