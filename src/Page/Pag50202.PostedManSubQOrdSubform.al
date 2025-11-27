Page 50202 "Posted Man. Sub Q.Ord Subform"
{
    Caption = 'Posted Manufacturing Sub Quality Order Subform';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "SSD Posted Quality Order Line";
    SourceTableView = sorting("Document No.", "Line No.")order(ascending)where("Template Type"=const(Routing));
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
                    Caption = 'Control Parameter';
                }
                field("Meas. Tool Code"; Rec."Meas. Tool Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Meas. Tool Description"; Rec."Meas. Tool Description")
                {
                    ApplicationArea = All;
                    Caption = 'Evaluation/ MeasurementTech.';
                    Editable = false;
                }
                field("Maximum Value"; Rec."Maximum Value")
                {
                    ApplicationArea = All;
                }
                field("Minimum Value"; Rec."Minimum Value")
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
            }
            label(Control1000000000)
            {
                ApplicationArea = All;
                CaptionClass = Text19005008;
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
                        //This functionality was copied from page #50201. Unsupported part was commented. Please check it.
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
    Text001: label 'Deletion not possible\Hour wise records found for line no %1';
    QOrderSampleLine: Record "SSD Quality Order Sample Line";
    Text19005008: label 'Initial Sample Observation 5 Nos.';
    procedure ShowLineComment()
    begin
        Rec.ShowComent;
    end;
    procedure RefreshForm()
    begin
        CurrPage.Update(false);
    end;
}
