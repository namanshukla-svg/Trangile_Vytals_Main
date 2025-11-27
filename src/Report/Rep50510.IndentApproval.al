report 50510 "Indent Approval"
{
    ApplicationArea = All;
    Caption = 'Indent Approval';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Word;
    WordLayout = './Layouts/IndentApproval.docx';

    dataset
    {
        dataitem(SSDIndentHeader; "SSD Indent Header")
        {
            column(CompInfo_NewLogo1; CompInfo."New Logo1")
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(No; "No.")
            {
            }
            column(ApprovalID; ApprovalId)
            {
            }
            column(SenderID; SenderId)
            {
            }
            trigger OnAfterGetRecord()
            begin
                ApprovalEntry.SetRange("Table ID", Database::"SSD Indent Header");
                ApprovalEntry.SetRange("Record ID to Approve", SSDIndentHeader.RecordId);
                ApprovalEntry.SetRange("Related to Change", false);
                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
                if ApprovalEntry.FindLast()then begin
                    UserSetup.Get(ApprovalEntry."Sender ID");
                    SenderId:=UserSetup.Name;
                    UserSetup.Get(ApprovalEntry."Approver ID");
                    ApprovalId:=UserSetup.Name;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        CompInfo.CalcFields("New Logo1");
    end;
    var CompInfo: Record "Company Information";
    ApprovalEntry: Record "Approval Entry";
    UserSetup: Record "User Setup";
    ApprovalId: Text[50];
    SenderId: Text[50];
}
