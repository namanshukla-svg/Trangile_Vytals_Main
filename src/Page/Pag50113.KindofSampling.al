Page 50113 "Kind of Sampling"
{
    ApplicationArea = All;
    Caption = 'Kind of Sampling';
    PageType = List;
    SourceTable = "SSD Kind of Sampling";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Kind")
            {
                Caption = '&Kind';

                action("Inspection Type")
                {
                    ApplicationArea = All;
                    Caption = 'Inspection Type';
                    RunObject = Page "Inspection Type";
                    RunPageLink = "Kind of Sampling"=field(Code);
                    RunPageView = sorting("Kind of Sampling", Code)order(ascending);
                }
                action("Sample Size")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Size';
                    RunObject = Page "E-Invoice Requests";
                    RunPageLink = "Request ID"=field(Code);
                    RunPageView = sorting("Request ID", "Entry No.")order(ascending);
                }
            }
        }
    }
    var UserMgt: Codeunit "SSD User Setup Management";
}
