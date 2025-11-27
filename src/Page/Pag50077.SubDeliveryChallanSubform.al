Page 50077 "Sub Delivery Challan  Subform"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Delivery Challan Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1280000)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("No.2"; Rec."No.2")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Company Location"; Rec."Company Location")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Company Bin Code"; Rec."Company Bin Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Vendor Location"; Rec."Vendor Location")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Vendor Bin Code"; Rec."Vendor Bin Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Quantity at Vendor Location"; Rec."Quantity at Vendor Location")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Process Description"; Rec."Process Description")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
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
