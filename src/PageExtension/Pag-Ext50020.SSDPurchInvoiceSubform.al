pageextension 50020 "SSD Purch. Invoice Subform" extends "Purch. Invoice Subform"
{
    layout
    {
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            var
                PurchaseHeader: Record "Purchase Header";
                DimValue: Record "Dimension Value";
            begin
                PurchaseHeader.Reset();
                PurchaseHeader.SetRange("Document Type", Rec."Document Type");
                PurchaseHeader.SetRange("No.", Rec."Document No.");
                if PurchaseHeader.FindFirst() then begin
                    DimValue.Reset();
                    DimValue.SetRange(code, PurchaseHeader."Shortcut Dimension 1 Code");
                    DimValue.SetFilter("Dimension Code", '%1', 'COSTCEN');
                    if DimValue.FindFirst() then begin
                        DimValue.CalcFields("Incurred Amount");
                        if (DimValue."Incurred Amount" + TotalPurchaseLine.Amount) > DimValue."Budgeted Amount" then
                            PurchaseHeader."Approval Required" := true
                        else
                            PurchaseHeader."Approval Required" := false;
                        PurchaseHeader.Modify();
                    end;
                end;

            end;

        }
        modify("Description 2")
        {
            Visible = true;
        }
        addafter("Line Amount")
        {
            field("Custom Duty Amount LCY"; Rec."Custom Duty Amount LCY")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Custom Duty Amount LCY field.';
            }
            field("Assessable Value GST"; Rec."Assessable Value GST")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Assessable Value GST field.';
            }
            field("Assessable Value GST LCY"; Rec."Assessable Value GST LCY")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Assessable Value GST LCY field.';
            }
            field("SSD Posting Account"; Rec."SSD Posting Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Account field.';
            }
            field("SSD Posting Acc Name"; Rec."SSD Posting Acc Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Account Name field.';
            }
            field("SSD Deduction Amount"; Rec."SSD Deduction Amount")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Deduction Amount field.';
            }
            field("SSD Deduction Remarks"; Rec."SSD Deduction Remarks")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Deduction Remarks field.';
            }
        }
        addafter("Description 2")
        {
            field("Description 3"; Rec."Description 3")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description 3 field.';
            }
        }
    }
}
