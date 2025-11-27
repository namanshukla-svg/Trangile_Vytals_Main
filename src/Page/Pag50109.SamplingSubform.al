Page 50109 "Sampling Subform"
{
    AutoSplitKey = true;
    Caption = 'Sampling Subform';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD Sampling Temp. Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Test No."; Rec."Test No.")
                {
                    ApplicationArea = All;
                }
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
                field("Meas. Tool Description"; Rec."Meas. Tool Description")
                {
                    ApplicationArea = All;
                }
                field("To be Print"; Rec."To be Print")
                {
                    ApplicationArea = All;
                }
                field("Test 1"; Rec."Test 1")
                {
                    ApplicationArea = All;
                }
                field("Test 2"; Rec."Test 2")
                {
                    ApplicationArea = All;
                }
                field("Test 3"; Rec."Test 3")
                {
                    ApplicationArea = All;
                }
                field("Test 4"; Rec."Test 4")
                {
                    ApplicationArea = All;
                }
                field("Test 5"; Rec."Test 5")
                {
                    ApplicationArea = All;
                }
                field("Test 6"; Rec."Test 6")
                {
                    ApplicationArea = All;
                }
                field("Test 7"; Rec."Test 7")
                {
                    ApplicationArea = All;
                }
                field("Test 8"; Rec."Test 8")
                {
                    ApplicationArea = All;
                }
                field("Test 9"; Rec."Test 9")
                {
                    ApplicationArea = All;
                }
                field("Test 10"; Rec."Test 10")
                {
                    ApplicationArea = All;
                }
                field("Meas. Value Type"; Rec."Meas. Value Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Normal Value"; Rec."Normal Value")
                {
                    ApplicationArea = All;
                    Caption = '<Normal Value>';
                    Visible = false;
                }
                field("Maximum Value"; Rec."Maximum Value")
                {
                    ApplicationArea = All;
                    Caption = '<Maximum Value>';
                    DecimalPlaces = 2: 2;
                    Visible = false;
                }
                field("Minimum Value"; Rec."Minimum Value")
                {
                    ApplicationArea = All;
                    Caption = '<Minimum Value>';
                    DecimalPlaces = 2: 2;
                    Visible = false;
                }
                field("Medium Tolerance"; Rec."Medium Tolerance")
                {
                    ApplicationArea = All;
                    Caption = '<Medium Tolerance>';
                    Visible = false;
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
                field(LCL; Rec.LCL)
                {
                    ApplicationArea = All;
                }
                field(UCL; Rec.UCL)
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
            group("&Template")
            {
                Caption = '&Template';

                action("Line Comments")
                {
                    ApplicationArea = All;
                    Caption = 'Line Comments';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50108. Unsupported part was commented. Please check it.
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
