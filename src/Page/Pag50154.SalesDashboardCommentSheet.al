Page 50154 "Sales Dashboard Comment Sheet"
{
    AutoSplitKey = true;
    Caption = 'Comment Sheet';
    DataCaptionFields = "Document Type", "No.";
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "SSD SalesDashBoardCommentLine";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Comment Date"; Rec."Comment Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Comment Time"; Rec."Comment Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.Code:=DeptGlobal;
                    end;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        if not Confirm('Do you want to save the record, Once it get saved it can not be edit or delete', false)then Error('');
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine;
        Rec.Code:=DeptGlobal;
    end;
    var DeptGlobal: Code[10];
    procedure CommentsDept(Dept: Code[10])
    begin
        DeptGlobal:=Dept;
    end;
}
