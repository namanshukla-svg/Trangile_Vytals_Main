pageextension 50124 "SSD Doc. Attachment Details" extends "Document Attachment Details"
{
    layout
    {
        addafter("File Extension")
        {
            field("SSD Attachment Type"; Rec."SSD Attachment Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Attachment Type field.';
            }
            field("SSD Is Annexure"; Rec."SSD Is Annexure")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Is Annexure field.';
            }
            field(Description; Rec."SSD Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Description field.';
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean var
        SSDAttachmentManagement: Codeunit "SSD Attachment Management";
    begin
        if Rec."Table ID" = Database::"SSD Purchase Attachment" then SSDAttachmentManagement.CheckDocumentAttachment(Rec);
    end;
    trigger OnOpenPage()
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Attachment Admin" then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Merged Attachment", false);
            Rec.FilterGroup(0);
        end;
    end;
    var UserSetup: Record "User Setup";
}
