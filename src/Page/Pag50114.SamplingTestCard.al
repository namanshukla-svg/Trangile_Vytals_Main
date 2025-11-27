Page 50114 "Sampling Test Card"
{
    Caption = 'Sampling Test Card';
    PageType = Document;
    PopulateAllFields = true;
    SourceTable = "SSD Sampling Test Header";
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
                    NotBlank = true;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AsistEdic(xRec)then CurrPage.Update;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
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
            part(SubForm; "Sampling Test Subfom")
            {
                SubPageLink = "Test Code"=field("No.");
                SubPageView = sorting("Test Code", "Meas. Code", "Line No.")order(ascending);
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Tests")
            {
                Caption = '&Tests';

                separator(Action25)
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
                separator(Action27)
                {
                Caption = '';
                }
            }
            group("F&unction")
            {
                Caption = 'F&unction';

                group("Change Status to")
                {
                    Caption = 'Change Status to';

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
                    action("Under Developing")
                    {
                        ApplicationArea = All;
                        Caption = 'Under Developing';

                        trigger OnAction()
                        begin
                            Rec.Status:=Rec.Status::"Under Developing";
                            Rec.Modify;
                        end;
                    }
                    action(Bloked)
                    {
                        ApplicationArea = All;
                        Caption = 'Bloked';

                        trigger OnAction()
                        begin
                            Rec.Status:=Rec.Status::Blocked;
                            Rec.Modify;
                        end;
                    }
                }
            }
        }
        area(processing)
        {
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
