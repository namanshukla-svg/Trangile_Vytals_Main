Page 50340 "Temp Document Export"
{
    PageType = List;
    SourceTable = "SSD Temp Document Export";
    ApplicationArea = all;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("S. No."; Rec."S. No.")
                {
                    ApplicationArea = Basic;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ExportFiles)
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    ExportAttachment.Run;
                end;
            }
        }
    }
    var ExportAttachment: Codeunit "Export Attachment";
}
