Page 50136 "Posted Vendors Eval."
{
    Caption = 'Posted Vendors Eval.';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "SSD Vendor Eval. Header";
    SourceTableView = sorting(Status)order(ascending)where(Status=filter(Locked|Canceled));
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
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Eval. Template No."; Rec."Eval. Template No.")
                {
                    ApplicationArea = All;
                }
                field("Template Name"; Rec."Template Name")
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
            }
            part(SubForm; "Vendor Eval. Subform")
            {
                SubPageLink = "Document No."=field("No.");
                SubPageView = sorting("Document No.", "Line No.")order(ascending);
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Template)
            {
                Caption = '&Evaluation Doc.';

                separator(Action46)
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
                separator(Action47)
                {
                Caption = '';
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
    trigger OnOpenPage()
    begin
        VendEvalHeader.Copy(Rec);
        VendEvalHeader.FilterGroup(3);
        Filters:=VendEvalHeader.GetFilter(Status);
        if Filters <> '' then if StrPos(Filters, '|') <> 0 then CurrPage.Caption:=CurrPage.Caption + ' ' + CopyStr(Filters, 1, StrPos(Filters, '|') - 1) + ' o ' + CopyStr(Filters, StrPos(Filters, '|') + 1, 50)
            else
                CurrPage.Caption:=CurrPage.Caption + ' ' + Filters;
    end;
    var VendEvalHeader: Record "SSD Vendor Eval. Header";
    Filters: Text[260];
}
