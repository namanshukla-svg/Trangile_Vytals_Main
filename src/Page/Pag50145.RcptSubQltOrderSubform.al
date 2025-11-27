Page 50145 "Rcpt. Sub Qlt Order Subform"
{
    Caption = 'Quality Order Subform';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "SSD Quality Order Line";
    SourceTableView = sorting("Document No.", "Line No.")order(ascending)where("Template Type"=const(RcvdCoil));
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
                field("Meas. Tool Code"; Rec."Meas. Tool Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Meas. Tool Description"; Rec."Meas. Tool Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Meas. Value Type"; Rec."Meas. Value Type")
                {
                    ApplicationArea = All;
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
                field("Defect Code"; Rec."Defect Code")
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
                        //This functionality was copied from page #50129. Unsupported part was commented. Please check it.
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
    procedure CreateQualityOrderLine(RecQOrderHeader: Record "SSD Quality Order Header")
    begin
        QualityMgt.CreateQualityOrderLine(RecQOrderHeader, Rec);
        CurrPage.Update(false);
    end;
    procedure RefreshForm()
    begin
        CurrPage.Update(false);
    end;
}
