pageextension 55003 ChartOfAccount extends "Chart of Accounts"
{
    layout
    {
        // Add changes to page layout here
        modify("Balance at Date")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}