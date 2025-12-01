PageExtension 50045 pageextension70000016 extends "Item List"
{
    layout
    {
        modify("Item Category Code")
        {
            Visible = true;
        }
        modify("Routing No.")
        {
            Visible = false;
        }
        addafter("Substitutes Exist")
        {
            field("Procurement Type"; Rec."Procurement Type")
            {
                ApplicationArea = All;
            }
            field("Description 3"; Rec."Description 3")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Maximum Order Quantity"; Rec."Maximum Order Quantity")
            {
                ApplicationArea = All;
                Caption = 'ROL-Maximum Order Quantity';
            }
            field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
            {
                ApplicationArea = All;
                Caption = 'CL-Minimum Order Quantity';
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
            {
                ApplicationArea = All;
            }
            field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
            {
                ApplicationArea = All;
            }
            field("Expiration Calculation"; Rec."Expiration Calculation")
            {
                ApplicationArea = All;
            }
            field("SSD Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
            {
                ApplicationArea = All;
                Caption = 'MSL-Safety Stock Quantity';
            }
            field("Lot Nos."; Rec."Lot Nos.")
            {
                ApplicationArea = All;
            }
            field("Serial Nos."; Rec."Serial Nos.")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = All;
            }
            field("Lead Time Dispatch"; Rec."Lead Time Dispatch")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shelf No.")
        {
            //Atul::01122025
            // field("SQ. Meter"; Rec."SQ. Meter")
            // {
            //     ApplicationArea = All;
            // }
            //Atul::01122025
            field("Quality Required"; Rec."Quality Required")
            {
                ApplicationArea = All;
            }
        }
        addafter("Tariff No.")
        {
            field("Purchase Group 1"; Rec."Purchase Group 1")
            {
                ApplicationArea = All;
            }
            field("Purchase Group 2"; Rec."Purchase Group 2")
            {
                ApplicationArea = All;
            }
            field("Purchase Group 3"; Rec."Purchase Group 3")
            {
                ApplicationArea = All;
            }
        }
        addafter("Manufacturing Policy")
        {
            field(MOQ; Rec.MOQ)
            {
                ApplicationArea = All;
                Caption = 'MOQ for Sales';
            }
        }
        addafter("Item Tracking Code")
        {
            field("Inventory Taging Person"; Rec."Inventory Taging Person")
            {
                ApplicationArea = All;
            }
            field("Pack Size"; Rec."Pack Size")
            {
                ApplicationArea = All;
            }
            field("Temp Product ID"; Rec."Temp Product ID")
            {
                ApplicationArea = All;
            }
            field("Procurement Category"; Rec."Procurement Category")
            {
                ApplicationArea = All;
            }
        }
        addafter("Default Deferral Template Code")
        {
            field("GST Group Code"; Rec."GST Group Code")
            {
                ApplicationArea = All;
            }
            field("Rounding Precision"; Rec."Rounding Precision")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Co&mments")
        {
            group("Change Quality Control")
            {
                Caption = 'Change Quality Control';

                action("Mark Quality Required")
                {
                    ApplicationArea = All;
                    Caption = 'Mark Quality Required';

                    trigger OnAction()
                    var
                        QualityManagement: Codeunit "Quality Management";
                    begin
                        CurrPage.SetSelectionFilter(Rec);
                        QualityManagement.ActivateQualityRequired(Rec, true);
                    end;
                }
                action("Unmark Quality Required")
                {
                    ApplicationArea = All;
                    Caption = 'Unmark Quality Required';

                    trigger OnAction()
                    var
                        QualityManagement: Codeunit "Quality Management";
                    begin
                        CurrPage.SetSelectionFilter(Rec);
                        QualityManagement.ActivateQualityRequired(Rec, true);
                    end;
                }
            }
        }
    }
    var
        ItemCostMgt: Codeunit ItemCostManagement;

    var
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        UserMgt: Codeunit "SSD User Setup Management";
}
