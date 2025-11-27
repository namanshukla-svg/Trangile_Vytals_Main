Page 50168 "Posted Gate Pass"
{
    Editable = false;
    SourceTable = "SSD Gate Pass Header";
    SourceTableView = sorting("No.")order(ascending)where(Posted=const(true));
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
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                field("Transporter Code"; Rec."Transporter Code")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Bilty No."; Rec."Bilty No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = All;
                }
                field("Gate Pass Time"; Rec."Gate Pass Time")
                {
                    ApplicationArea = All;
                    Caption = 'Time';
                }
            }
            part("Gate Pass Sub form"; "Gate Pass Sub form")
            {
                SubPageLink = "No."=field("No.");
                SubPageView = sorting("No.", "Line No.")order(ascending);
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                Image = "Order";

                action(Print)
                {
                    ApplicationArea = All;
                    Caption = 'Print';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    var
                        GatePassHeader1: Record "SSD Gate Pass Header";
                    begin
                        GatePassHeader1.SetRange("No.", Rec."No.");
                        Report.Run(Report::"Gate Pass", true, true, GatePassHeader1);
                    end;
                }
            }
        }
    }
    var GetSalesInvoices: Page "Get Posted Sales Invoices";
    SalesInvoiceHeader: Record "Sales Invoice Header";
}
