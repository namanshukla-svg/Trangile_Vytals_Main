Page 50086 "Gate Entry Register"
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "SSD Gate Register";
    SourceTableView = sorting("Gate Entry No.")order(ascending);
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry Type"; Rec."Gate Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry No."; Rec."Gate Entry No.")
                {
                    ApplicationArea = All;
                }
                field("MRN No."; Rec."MRN No.")
                {
                    ApplicationArea = All;
                }
                field("No.2"; Rec."No.2")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry Date"; Rec."Gate Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Gate Entry Time"; Rec."Gate Entry Time")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(NRGP; Rec.NRGP)
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                }
                field("Challan/Bill No."; Rec."Challan/Bill No.")
                {
                    ApplicationArea = All;
                }
                field("Challan/Bill Date"; Rec."Challan/Bill Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Delivery Mode"; Rec."Delivery Mode")
                {
                    ApplicationArea = All;
                }
                field("Transporter No."; Rec."Transporter No.")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Register No."; Rec."Register No.")
                {
                    ApplicationArea = All;
                    Caption = 'Register Entry No.';
                }
                field("Register Entry Date"; Rec."Register Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Vechile No."; Rec."Vechile No.")
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
