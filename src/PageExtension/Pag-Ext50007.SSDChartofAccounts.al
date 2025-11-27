pageextension 50007 "SSD Chart of Accounts" extends "Chart of Accounts"
{
    layout
    {
        addafter("Default IC Partner G/L Acc. No")
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
        }
    }
    var UserSetup: Record "User Setup";
    trigger OnOpenPage()
    begin
        UserSetup.RESET();
        if UserSetup.GET(USERID)then if UserSetup."G/L UnBlock Rights" then CurrPage.EDITABLE:=true
            else
                CurrPage.EDITABLE:=false;
    end;
}
