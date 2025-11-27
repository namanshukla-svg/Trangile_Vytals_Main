Page 50140 "Quality Comments"
{
    AutoSplitKey = true;
    Caption = 'Quality Comments';
    PageType = List;
    SourceTable = "SSD Quality Comments";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Comment; Rec.Comment)
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
