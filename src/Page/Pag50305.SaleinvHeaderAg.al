Page 50305 "Sale inv Header-Ag"
{
    PageType = List;
    Permissions = TableData "Sales Invoice Header"=rimd;
    SourceTable = "Sales Invoice Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1102156001)
            {
                field("Firm Freight"; Rec."Firm Freight")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("exception detail"; Rec."exception detail")
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
                field(crmRelease; Rec.crmRelease)
                {
                    ApplicationArea = All;
                }
                field("Actual Shipping Agent code"; Rec."Actual Shipping Agent code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Supplementary Invoice"; Rec."Supplementary Invoice")
                {
                    ApplicationArea = All;
                }
                field("Nature of Supply"; Rec."Nature of Supply")
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
