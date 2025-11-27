Page 50108 "Sampling Template Card"
{
    Caption = 'Sampling Template Card';
    PageType = Document;
    PopulateAllFields = true;
    SourceTable = "SSD Sampling Temp. Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AsistEdic(xRec)then CurrPage.Update;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Kind of Sampling"; Rec."Kind of Sampling")
                {
                    ApplicationArea = All;
                    Visible = "Kind of SamplingVisible";
                }
                field("Sampling Method"; Rec."Sampling Method")
                {
                    ApplicationArea = All;
                    Visible = "Sampling MethodVisible";
                }
                field("Percentage / Fixed Quantity"; Rec."Percentage / Fixed Quantity")
                {
                    ApplicationArea = All;
                    Visible = PercentageFixedQuantityVisible;
                }
                field("Process / Operation No."; Rec."Process / Operation No.")
                {
                    ApplicationArea = All;
                }
                field("Process / Operation"; Rec."Process / Operation")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("Approved by"; Rec."Approved by")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field(Edition; Rec.Edition)
                {
                    ApplicationArea = All;
                }
                field(Review; Rec.Review)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
            part(SubForm; "Sampling Subform")
            {
                SubPageLink = "Document No."=field("No.");
                SubPageView = sorting("Document No.", "Line No.")order(ascending);
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Template")
            {
                Caption = '&Template';

                separator(Action33)
                {
                Caption = '';
                }
                action(Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        Rec.ShowComent;
                    end;
                }
                separator(Action35)
                {
                Caption = '';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                group("Status Change")
                {
                    Caption = 'Status Change';

                    action(Certified)
                    {
                        ApplicationArea = All;
                        Caption = 'Certified';

                        trigger OnAction()
                        begin
                            Rec.Status:=Rec.Status::Certified;
                            Rec.Modify;
                        end;
                    }
                    action("Under Development")
                    {
                        ApplicationArea = All;
                        Caption = 'Under Development';

                        trigger OnAction()
                        begin
                            Rec.Status:=Rec.Status::"Under Developing";
                            Rec.Modify;
                        end;
                    }
                    action(Blocked)
                    {
                        ApplicationArea = All;
                        Caption = 'Blocked';

                        trigger OnAction()
                        begin
                            Rec.Status:=Rec.Status::Blocked;
                            Rec.Modify;
                        end;
                    }
                }
            }
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Print(true);
                end;
            }
        }
    }
    trigger OnInit()
    begin
        PercentageFixedQuantityVisible:=true;
        "Sampling MethodVisible":=true;
        "Kind of SamplingVisible":=true;
    end;
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
        Rec.FilterGroup(2);
        if Rec.GetFilter("Template Type") <> '' then CurrPage.Caption:=Rec.GetFilter("Template Type") + '-' + CurrPage.Caption;
        Rec.FilterGroup(0);
        OnActivateForm;
    end;
    var SamplingHeader: Record "SSD Sampling Temp. Header";
    UserMgt: Codeunit "SSD User Setup Management";
    "Kind of SamplingVisible": Boolean;
    "Sampling MethodVisible": Boolean;
    PercentageFixedQuantityVisible: Boolean;
    procedure CurrFormControl()
    begin
        if Rec."Template Type" = Rec."template type"::Receipt then begin
            "Kind of SamplingVisible":=true;
            "Sampling MethodVisible":=true;
        end
        else if Rec."Template Type" = Rec."template type"::Manufacturing then begin
                "Kind of SamplingVisible":=false;
                "Sampling MethodVisible":=false;
                PercentageFixedQuantityVisible:=false;
            end;
    end;
    local procedure OnActivateForm()
    begin
        CurrFormControl;
    end;
}
