Page 50000 "ARE1 Details"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = "SSD ARE1 Details";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("ARE1 Type"; Rec."ARE1 Type")
                {
                    ApplicationArea = All;
                }
                field("ARE1 No."; Rec."ARE1 No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Inv No."; Rec."Sales Inv No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Inv Date"; Rec."Sales Inv Date")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field("BED Amount"; Rec."BED Amount")
                {
                    ApplicationArea = All;
                }
                field("Ecess Amount"; Rec."Ecess Amount")
                {
                    ApplicationArea = All;
                }
                field("SHE Cess Amount"; Rec."SHE Cess Amount")
                {
                    ApplicationArea = All;
                }
                field("Tax %"; Rec."Tax %")
                {
                    ApplicationArea = All;
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Amount to Customer"; Rec."Amount to Customer")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
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
