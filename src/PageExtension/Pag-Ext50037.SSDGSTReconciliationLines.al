PageExtension 50037 "SSD GST Reconciliation Lines" extends "GST Reconciliation Lines"
{
    layout
    {
        addafter("Document Date")
        {
            field("Goods/Services"; Rec."Goods/Services")
            {
                ApplicationArea = All;
            }
            field("HSN/SAC"; Rec."HSN/SAC")
            {
                ApplicationArea = All;
            }
        }
        addafter("Taxable Value")
        {
            field("Component 1 Rate"; Rec."Component 1 Rate")
            {
                ApplicationArea = All;
                Caption = 'Component 1 Rate';
            }
        }
        addafter("Component 1 Amount")
        {
            field("Component 2 Rate"; Rec."Component 2 Rate")
            {
                ApplicationArea = All;
                Caption = 'Component 2 Rate';
            }
        }
        addafter("Component 2 Amount")
        {
            field("Component 3 Rate"; Rec."Component 3 Rate")
            {
                ApplicationArea = All;
                Caption = 'Component 3 Rate';
            }
        }
        addafter("Component 3 Amount")
        {
            field("Component 4 Rate"; Rec."Component 4 Rate")
            {
                ApplicationArea = All;
                Caption = 'Component 4 Rate';
            }
        }
        addafter("Component 4 Amount")
        {
            field("Component 5 Rate"; Rec."Component 5 Rate")
            {
                ApplicationArea = All;
                Caption = 'Component 5 Rate';
            }
        }
        addafter("Component 5 Amount")
        {
            field("Component 6 Rate"; Rec."Component 6 Rate")
            {
                ApplicationArea = All;
                Caption = 'Component 6 Rate';
            }
        }
        addafter("Component 6 Amount")
        {
            field("Component 7 Rate"; Rec."Component 7 Rate")
            {
                ApplicationArea = All;
                Caption = 'Component 7 Rate';
            }
        }
        addafter("Component 7 Amount")
        {
            field("Component 8 Rate"; Rec."Component 8 Rate")
            {
                ApplicationArea = All;
                Caption = 'Component 8 Rate';
            }
        }
    }
}
