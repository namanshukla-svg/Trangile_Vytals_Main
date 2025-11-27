PageExtension 50035 "SSD G/L Account Card" extends "G/L Account Card"
{
    layout
    {
        addafter("Omit Default Descr. in Jnl.")
        {
            field("G/L Group Code"; Rec."G/L Group Code")
            {
                ApplicationArea = All;
            }
            field("Budget Grouping"; Rec."Budget Grouping")
            {
                ApplicationArea = All;
            }
            field("BS Grouping"; Rec."BS Grouping")
            {
                ApplicationArea = All;
            }
            field("Fixed/Var."; Rec."Fixed/Var.")
            {
                ApplicationArea = All;
            }
            field("Manufacturing Expenses"; Rec."Manufacturing Expenses")
            {
                ApplicationArea = All;
            }
            field("Ignore Budget"; Rec."Ignore Budget")
            {
                ApplicationArea = all;
                Caption = 'Ignore For Incurred Budget';
            }
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
    }
    var
        UserSetup: Record "User Setup";

    trigger OnOpenPage()
    begin
        UserSetup.RESET;
        IF UserSetup.GET(USERID) THEN
            IF UserSetup."G/L UnBlock Rights" THEN
                CurrPage.EDITABLE := TRUE
            ELSE
                CurrPage.EDITABLE := FALSE;
    end;
}
