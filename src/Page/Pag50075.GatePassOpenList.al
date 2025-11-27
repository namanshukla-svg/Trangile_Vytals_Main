Page 50075 "Gate Pass Open List"
{
    ApplicationArea = All;
    Caption = 'Gate Pass Open List';
    CardPageID = "Gate Pass";
    Editable = false;
    PageType = List;
    SourceTable = "SSD Gate Pass Header";
    SourceTableView = where(Posted=filter(false));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
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
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Mobile No."; Rec."Mobile No.")
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
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if UserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;
        JobQueueActive:=SalesSetup.JobQueueActive;
    end;
    var DocPrint: Codeunit "Document-Print";
    ReportPrint: Codeunit "Test Report-Print";
    UserMgt: Codeunit "User Setup Management";
    Usage: Option "Order Confirmation", "Work Order", "Pick Instruction";
    JobQueueActive: Boolean;
}
