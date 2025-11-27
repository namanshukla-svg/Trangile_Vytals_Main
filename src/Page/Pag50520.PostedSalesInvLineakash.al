Page 50520 "Posted Sales Inv Line-akash"
{
    PageType = List;
    Permissions = TableData "Sales Invoice Line"=rm;
    SourceTable = "Sales Invoice Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(crminsertflag; Rec.crminsertflag)
                {
                    ApplicationArea = All;
                }
                field(crmupdateflag; Rec.crmupdateflag)
                {
                    ApplicationArea = All;
                }
                field(isCRMexception; Rec.isCRMexception)
                {
                    ApplicationArea = All;
                }
                field(exceptiondetail; Rec.exceptiondetail)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
