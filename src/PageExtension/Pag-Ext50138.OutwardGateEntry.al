pageextension 50138 "Outward Gate Entry" extends "Outward Gate Entry"
{
    layout
    {
    }

    actions
    {
        modify("Po&st")
        {
            Visible = false;
        }
        addfirst("P&osting")
        {
            action("Po&st_Custom")
            {
                ApplicationArea = All;
                Caption = 'Po&st';
                Image = Post;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books (F9).';

                trigger OnAction()
                var
                    GateEntryPostYesNo: Codeunit "Gate Entry- Post (Yes/No)";
                    GateEntryHeader: Record "Gate Entry Header";
                begin
                    CurrPage.SetSelectionFilter(GateEntryHeader);
                    if GateEntryHeader."Posting Date" <> WorkDate then
                        if not Confirm('Posting date is not equal to WorkDate. Do you still want to post?', false) then
                            exit;
                    GateEntryPostYesNo.Run(GateEntryHeader);
                end;
            }
        }
    }
}
