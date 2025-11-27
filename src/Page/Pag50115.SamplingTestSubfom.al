Page 50115 "Sampling Test Subfom"
{
    AutoSplitKey = true;
    Caption = 'Sampling Test Subfom';
    PageType = ListPart;
    SourceTable = "SSD Sampling Test Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Meas. Code"; Rec."Meas. Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Meas. Tool Code"; Rec."Meas. Tool Code")
                {
                    ApplicationArea = All;
                }
                field("Meas. Tool Descr."; Rec."Meas. Tool Descr.")
                {
                    ApplicationArea = All;
                }
                field("Meas. Value Type"; Rec."Meas. Value Type")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Normal Value"; Rec."Normal Value")
                {
                    ApplicationArea = All;
                }
                field("Minimum Value"; Rec."Minimum Value")
                {
                    ApplicationArea = All;
                }
                field("Maximum Value"; Rec."Maximum Value")
                {
                    ApplicationArea = All;
                }
                field("Medium Tolerance"; Rec."Medium Tolerance")
                {
                    ApplicationArea = All;
                }
                field(Discipline; Rec.Discipline)
                {
                    ApplicationArea = All;
                }
                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                    OptionCaption = ' ,Plastic+,Paper+,Lubricants,Petroleum,Misc.,Plastic & Paper+';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field(UCL; Rec.UCL)
                {
                    ApplicationArea = All;
                }
                field(LCL; Rec.LCL)
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
            group("&Tests")
            {
                Caption = '&Tests';

                action("Line Comments")
                {
                    ApplicationArea = All;
                    Caption = 'Line Comments';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50114. Unsupported part was commented. Please check it.
                        /*CurrPage.SubForm.PAGE.*/
                        fShowComent;
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
    procedure fShowComent()
    begin
        Rec.ShowComent;
    end;
}
