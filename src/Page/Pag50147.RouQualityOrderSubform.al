Page 50147 "Rou. Quality Order Subform"
{
    PageType = ListPart;
    SourceTable = "SSD Quality Order Line";
    SourceTableView = sorting("Document No.", "Line No.")order(ascending)where("Template Type"=const(Routing));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Control Parameter';
                    Editable = false;
                }
                field("Meas. Tool Code"; Rec."Meas. Tool Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Meas. Tool Description"; Rec."Meas. Tool Description")
                {
                    ApplicationArea = All;
                    Caption = 'Evaluation / Measurement Tech.';
                    Editable = false;
                }
                field("Minimum Value"; Rec."Minimum Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maximum Value"; Rec."Maximum Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Initial Sample Value1"; Rec."Initial Sample Value1")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Initial Sample Value2"; Rec."Initial Sample Value2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Initial Sample Value3"; Rec."Initial Sample Value3")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Initial Sample Value4"; Rec."Initial Sample Value4")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Initial Sample Value5"; Rec."Initial Sample Value5")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Inspection Value1"; Rec."Inspection Value1")
                {
                    ApplicationArea = All;
                }
                field("Inspection Value2"; Rec."Inspection Value2")
                {
                    ApplicationArea = All;
                }
                field("Inspection Value3"; Rec."Inspection Value3")
                {
                    ApplicationArea = All;
                }
                field("Inspection Value4"; Rec."Inspection Value4")
                {
                    ApplicationArea = All;
                }
                field("Inspection Value5"; Rec."Inspection Value5")
                {
                    ApplicationArea = All;
                }
                field("Inspection Value6"; Rec."Inspection Value6")
                {
                    ApplicationArea = All;
                }
                field("Inspection Value7"; Rec."Inspection Value7")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
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
}
