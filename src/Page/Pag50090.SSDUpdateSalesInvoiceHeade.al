page 50090 "SSD Update Sales Invoice Heade"
{
    ApplicationArea = All;
    Caption = 'Update Sales Invoice Header';
    PageType = List;
    SourceTable = "SSD Update Sales Invoice Heade";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Calculated Freight Amount"; Rec."Calculated Freight Amount")
                {
                    ToolTip = 'Specifies the value of the Calculated Freight Amount field.';
                }
                field("Dispatch Mail Send"; Rec."Dispatch Mail Send")
                {
                    ToolTip = 'Specifies the value of the Dispatch Mail Send field.';
                }
                field("Firm Freight"; Rec."Firm Freight")
                {
                    ToolTip = 'Specifies the value of the Firm Freight field.';
                }
                field("Fright Amount"; Rec."Fright Amount")
                {
                    ToolTip = 'Specifies the value of the Fright Amount field.';
                }
                field("LR/RR Date"; Rec."LR/RR Date")
                {
                    ToolTip = 'Specifies the value of the LR/RR Date field.';
                }
                field("LR/RR No."; Rec."LR/RR No.")
                {
                    ToolTip = 'Specifies the value of the LR/RR No. field.';
                }
                field("Mail Send Dispatch Detail"; Rec."Mail Send Dispatch Detail")
                {
                    ToolTip = 'Specifies the value of the Mail Send Dispatch Detail field.';
                }
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                    ToolTip = 'Specifies the value of the Sales Person Code field.';
                }
                field("Send Mail Again with COA"; Rec."Send Mail Again with COA")
                {
                    ToolTip = 'Specifies the value of the Send Mail Again with COA field.';
                }
                field("Send Mail Again without COA"; Rec."Send Mail Again without COA")
                {
                    ToolTip = 'Specifies the value of the Send Mail Again without COA field.';
                }
                field("Send Mail with COA"; Rec."Send Mail with COA")
                {
                    ToolTip = 'Specifies the value of the Send Mail with COA field.';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ToolTip = 'Specifies the value of the Shipping Agent Code field.';
                }
                field("Actual Delivery Date"; Rec."Actual Delivery Date")
                {
                    ApplicationArea = all;
                }
                field(Remarks; Rec.Remarks1)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update Data")
            {
                ApplicationArea = All;
                Caption = 'Update Data';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateShipment;

                trigger OnAction()
                var
                    UpdateValidation: Codeunit Validation;
                begin
                    UpdateValidation.UpdateSalesInvoice();
                end;
            }
            action("Delete All")
            {
                ApplicationArea = All;
                Caption = 'Delete All';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Delete;

                trigger OnAction()
                var
                    UpdateSalesInvoice: Record "SSD Update Sales Invoice Heade";
                begin
                    if UpdateSalesInvoice.FindSet() then UpdateSalesInvoice.DeleteAll();
                end;
            }
        }
    }
}
