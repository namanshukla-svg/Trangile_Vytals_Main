Page 50120 "Man. Quality Order Subform"
{
    Caption = 'Manufacturing Quality Order Subform';
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "SSD Quality Order Line";
    SourceTableView = sorting("Document No.", "Line No.")order(ascending)where("Template Type"=const(Manufacturing));
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
                field("Meas. Value Type"; Rec."Meas. Value Type")
                {
                    ApplicationArea = All;
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
                    Editable = false;
                }
                field("Minimum Value"; Rec."Minimum Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(PASS; Rec."Quality Pass")
                {
                    ApplicationArea = All;
                    Enabled = PASSEnable;
                }
                field("Test 1"; Rec."Test 1")
                {
                    ApplicationArea = All;
                }
                field("Test 2"; Rec."Test 2")
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
                field("1"; Rec."Initial Sample Value1")
                {
                    ApplicationArea = All;
                    Caption = '1';
                    Editable = "1Editable";

                    trigger OnValidate()
                    begin
                        if rec."Initial Sample Value1" < rec."Minimum Value" then if Confirm('Average Value is less than Min Value.Do you want to continue', false)then exit;
                        if rec."Maximum Value" <> 0 then begin
                            if rec."Inspection Value2" > rec."Maximum Value" then if Confirm('Average Value is more than Max Value than.Do you want to continue', false)then exit;
                        end;
                    end;
                }
                field("2"; Rec."Initial Sample Value2")
                {
                    ApplicationArea = All;
                    Caption = '2';
                    Editable = "2Editable";
                }
                field("3"; Rec."Initial Sample Value3")
                {
                    ApplicationArea = All;
                    Caption = '3';
                    Editable = "3Editable";
                }
                field("4"; Rec."Initial Sample Value4")
                {
                    ApplicationArea = All;
                    Caption = '4';
                    Editable = "4Editable";
                }
                field("5"; Rec."Initial Sample Value5")
                {
                    ApplicationArea = All;
                    Caption = '5';
                    Editable = "5Editable";
                }
                field("6"; Rec."Inspection Value1")
                {
                    ApplicationArea = All;
                    Caption = '6';
                    Editable = "6Editable";
                }
                field("Inspection Value2"; Rec."Inspection Value2")
                {
                    ApplicationArea = All;
                    Caption = 'Average Value';
                }
                field("Actual Test Results Data"; Rec."Actual Test Results Data")
                {
                    ApplicationArea = All;
                }
                field("Value to be Print"; Rec."Value to be Print")
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
                        //This functionality was copied from page #50119. Unsupported part was commented. Please check it.
                        /*CurrPage.SubForm.PAGE.*/
                        ShowLineComment;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        //<<<<<<< alle[5.51]
        if Rec."Meas. Value Type" = Rec."meas. value type"::Value then begin
            "1Editable":=true;
            "2Editable":=true;
            "3Editable":=true;
            "4Editable":=true;
            "5Editable":=true;
            "6Editable":=true;
            PASSEnable:=false;
        end
        else
        begin
            "1Editable":=false;
            "2Editable":=false;
            "3Editable":=false;
            "4Editable":=false;
            "5Editable":=false;
            "6Editable":=false;
            PASSEnable:=true;
        end;
    //>>>>>>> alle[5.51]
    end;
    trigger OnDeleteRecord(): Boolean begin
        DeleteQualitySubLines(Rec);
    end;
    trigger OnInit()
    begin
        PASSEnable:=true;
        "6Editable":=true;
        "5Editable":=true;
        "4Editable":=true;
        "3Editable":=true;
        "2Editable":=true;
        "1Editable":=true;
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
    QualityMgt: Codeunit "Quality Management";
    Text001: label 'Deletion not possible\Hour wise records found for line no %1';
    QOrderSampleLine: Record "SSD Quality Order Sample Line";
    "1Editable": Boolean;
    "2Editable": Boolean;
    "3Editable": Boolean;
    "4Editable": Boolean;
    "5Editable": Boolean;
    "6Editable": Boolean;
    PASSEnable: Boolean;
    Text19005008: label 'Initial Sample Observation 5 Nos.';
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
    procedure DeleteQualitySubLines(RecQualityOrderLine: Record "SSD Quality Order Line")
    var
        QOrderSampleLineLocal: Record "SSD Quality Order Sample Line";
        QualityOrderHeaderLocal: Record "SSD Quality Order Header";
        QualityOrderLineLocal: Record "SSD Quality Order Line";
    begin
        QOrderSampleLineLocal.Reset;
        QOrderSampleLineLocal.SetCurrentkey("Ref. Quality Order No.", "Quality Order Line No.", "Document Type", "Line No.");
        QOrderSampleLineLocal.SetRange("Ref. Quality Order No.", RecQualityOrderLine."Document No.");
        QOrderSampleLineLocal.SetRange("Quality Order Line No.", RecQualityOrderLine."Line No.");
        QOrderSampleLineLocal.SetRange("Document Type", QOrderSampleLineLocal."document type"::Hour);
        if QOrderSampleLineLocal.Find('-')then Error(Text001, RecQualityOrderLine."Line No.");
        QualityOrderHeaderLocal.Reset;
        QualityOrderHeaderLocal.SetCurrentkey("Template Type", "Entry Source Type", "Order No.");
        QualityOrderHeaderLocal.SetRange("Template Type", QualityOrderHeaderLocal."template type"::Routing);
        QualityOrderHeaderLocal.SetRange("Entry Source Type", QualityOrderHeaderLocal."entry source type"::"Manufac.");
        QualityOrderHeaderLocal.SetRange("Order No.", RecQualityOrderLine."Document No.");
        if QualityOrderHeaderLocal.Find('-')then repeat QualityOrderLineLocal.Reset;
                QualityOrderLineLocal.SetRange("Document No.", QualityOrderHeaderLocal."No.");
                if QualityOrderLineLocal.Find('-')then repeat QualityOrderLineLocal.Delete(true);
                    until QualityOrderLineLocal.Next = 0;
            until QualityOrderHeaderLocal.Next = 0;
    end;
}
