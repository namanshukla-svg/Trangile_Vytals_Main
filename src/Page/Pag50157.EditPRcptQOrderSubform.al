Page 50157 "Edit P. Rcpt. Q.Order Subform"
{
    Caption = 'Posted Rcpt. Quality Order Subform';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "SSD Posted Quality Order Line";
    SourceTableView = sorting("Document No.", "Line No.")order(ascending)where("Template Type"=const(Receipt));
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
                    Visible = false;
                }
                field("Meas. Code"; Rec."Meas. Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field("Meas. Tool Code"; Rec."Meas. Tool Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Test 1"; Rec."Test 1")
                {
                    ApplicationArea = All;
                }
                field("Test 2"; Rec."Test 2")
                {
                    ApplicationArea = All;
                }
                field("Initial Sample Value1"; Rec."Initial Sample Value1")
                {
                    ApplicationArea = All;
                    Caption = '1';
                }
                field("Initial Sample Value2"; Rec."Initial Sample Value2")
                {
                    ApplicationArea = All;
                    Caption = '2';
                }
                field("Initial Sample Value3"; Rec."Initial Sample Value3")
                {
                    ApplicationArea = All;
                    Caption = '3';
                }
                field("Initial Sample Value4"; Rec."Initial Sample Value4")
                {
                    ApplicationArea = All;
                    Caption = '4';
                }
                field("Initial Sample Value5"; Rec."Initial Sample Value5")
                {
                    ApplicationArea = All;
                    Caption = '5';
                }
                field("Inspection Value1"; Rec."Inspection Value1")
                {
                    ApplicationArea = All;
                    Caption = '6';
                }
                field("Inspection Value2"; Rec."Inspection Value2")
                {
                    ApplicationArea = All;
                    Caption = 'Average Value';
                }
                field("Meas. Tool Description"; Rec."Meas. Tool Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Meas. Value Type"; Rec."Meas. Value Type")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Observations; Rec.Observations)
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
                field("Qty. to be Inspected"; Rec."Qty. to be Inspected")
                {
                    ApplicationArea = All;
                }
                field("Accepted Qty."; Rec."Accepted Qty.")
                {
                    ApplicationArea = All;
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ApplicationArea = All;
                }
                field("Value to be Print"; Rec."Value to be Print")
                {
                    ApplicationArea = All;
                }
                field("Quality Pass"; Rec."Quality Pass")
                {
                    ApplicationArea = All;
                }
                field("Defect Code"; Rec."Defect Code")
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
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Order")
            {
                Caption = '&Order';

                action("Line Comments")
                {
                    ApplicationArea = All;
                    Caption = 'Line Comments';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50156. Unsupported part was commented. Please check it.
                        /*CurrPage.SubForm.PAGE.*/
                        ShowLineComment;
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
    var UserMgt: Codeunit "SSD User Setup Management";
    QualityMgt: Codeunit "Quality Management";
    procedure ShowLineComment()
    begin
        Rec.ShowComent;
    end;
}
