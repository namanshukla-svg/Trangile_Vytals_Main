pageextension 55002 DimValue extends "Dimension Values"
{
    layout
    {
        // Add changes to page layout here
        addafter(Blocked)
        {
            field("Period Start"; Rec."Period Start")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    GLEntry: Record "G/L Entry";
                begin
                    if (Rec."Period Start" <> 0D) and (Rec."Period End" <> 0D) then begin
                        GLEntry.Reset();
                        GLEntry.SetRange("Global Dimension 1 Code", Rec.Code);
                        GLEntry.SetRange(Ignored, false);
                        GLEntry.SetFilter(Amount, '>%1', 0);
                        GLEntry.SetFilter("Document No.", '%1', '@ZDPPDINV*');
                        GLEntry.SetRange("Posting Date", Rec."Period Start", Rec."Period End");
                        if GLEntry.FindFirst() then begin
                            GLEntry.CalcSums(Amount);
                            Rec."Calculated Incurred Amount" := GLEntry.Amount;
                            Rec.Modify(true);
                        end;
                    end;
                end;
            }
            field("Period End"; Rec."Period End")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    GLEntry: Record "G/L Entry";
                begin
                    if (Rec."Period Start" <> 0D) and (Rec."Period End" <> 0D) then begin
                        GLEntry.Reset();
                        GLEntry.SetRange("Global Dimension 1 Code", Rec.Code);
                        GLEntry.SetRange(Ignored, false);
                        GLEntry.SetFilter(Amount, '>%1', 0);
                        GLEntry.SetFilter("Document No.", '%1', '@ZDPPDINV*');
                        GLEntry.SetRange("Posting Date", Rec."Period Start", Rec."Period End");
                        if GLEntry.FindFirst() then begin
                            GLEntry.CalcSums(Amount);
                            Rec."Calculated Incurred Amount" := GLEntry.Amount;
                            Rec.Modify(true);
                        end;
                    end;
                end;
            }
            field("Budgeted Amount"; Rec."Budgeted Amount")
            {
                ApplicationArea = all;
            }
            field("Calculated Incurred Amount"; Rec."Calculated Incurred Amount")
            {
                ApplicationArea = all;
                Caption = 'Incurred Amount';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Where-Used List")
        {
            action("View Incurred Amounts")
            {
                Caption = 'View Incurred Amounts';
                ApplicationArea = all;
                Image = ViewCheck;
                RunObject = Page "Incurred Amount";
                RunPageLink = "Dimension Code" = field("Dimension Code"), Code = field(Code);
                ToolTip = 'View incurred amounts for this dimension.';
            }

        }
    }

    var
        myInt: Page "Customer Card";
}