Page 50138 "Vendor Evaluation Journal"
{
    AutoSplitKey = true;
    Caption = 'Vendor Evaluation Journal';
    PageType = Worksheet;
    SourceTable = "SSD Vendor Eval. Journal";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Eval. Template  No."; Rec."Eval. Template  No.")
                {
                    ApplicationArea = All;
                }
                field("Eval. Template Status"; Rec."Eval. Template Status")
                {
                    ApplicationArea = All;
                    Caption = 'Template Eval. Status';
                    OptionCaption = 'New,Certified,Under Developing,Locked';
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

                action("Propose Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Propose Lines';

                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"Propose Vendor Eval.");
                        CurrPage.Update(true);
                    end;
                }
                separator(Action10)
                {
                Caption = '';
                }
                action("Create Evaluation")
                {
                    ApplicationArea = All;
                    Caption = 'Create Evaluation';

                    trigger OnAction()
                    begin
                        Report.RunModal(Report::"Vendor Eval. Creation", true, true, Rec);
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center":=UserMgt.GetRespCenterFilter;
    end;
    trigger OnOpenPage()
    begin
    // if UserMgt.GetRespCenterFilter() <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
}
