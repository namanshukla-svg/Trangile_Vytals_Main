page 50353 "SSD Terms"
{
    ApplicationArea = All;
    Caption = 'Terms';
    PageType = Card;
    SourceTable = "SSD Terms";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            part(Lines; "SSD Terms Line")
            {
                ApplicationArea = All;
                SubPageLink = "Terms Code"=field(Code);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            Group(Update)
            {
                action(Resequence)
                {
                    ApplicationArea = All;
                    Caption = 'Resequence';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        SSDTermsLine: Record "SSD Terms Line";
                    begin
                        SSDTermsLine.ResequenceLines(Rec.Code);
                    end;
                }
            }
        }
    }
}
