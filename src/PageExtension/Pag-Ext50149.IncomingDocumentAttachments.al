pageextension 50149 "Incoming Document Attachments" extends "Incoming Document Attachments"
{
    trigger OnDeleteRecord(): Boolean var
        IncomingDocument: Record "Incoming Document";
    begin
        if IncomingDocument.Get(Rec."Incoming Document Entry No.")then begin
            if IncomingDocument.Posted then Error('You cannot delete the attachment when the incoming document is posted.');
        end;
    end;
}
