tableextension 50121 "SSD Document Attachment" extends "Document Attachment"
{
    fields
    {
        field(50000; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(50001; "Variant No."; Code[20])
        {
            Caption = 'Variant No.';
            DataClassification = ToBeClassified;
        }
        field(50002; "SSD Attachment Type"; Code[20])
        {
            Caption = 'Attachment Type';
            DataClassification = CustomerContent;
            TableRelation = "SSD Attachment Type";

            trigger OnValidate()
            var
                AttachmentType: Record "SSD Attachment Type";
            begin
                if(AttachmentType.Get("SSD Attachment Type")) and (AttachmentType."Is Annexure")then "SSD Is Annexure":=true
                else
                    "SSD Is Annexure":=false;
            end;
        }
        field(50003; "SSD Is Annexure"; Boolean)
        {
            Caption = 'Is Annexure';
            Editable = true;
        }
        field(50004; "SSD Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(50005; "Merged Attachment"; Boolean)
        {
            Caption = 'Merged Attachment';
            Editable = false;
        }
    }
    trigger OnDelete()
    begin
        IF "Table ID" IN[120, 122, 124]THEN BEGIN
            ERROR('You Can''not delete attachments.');
        END;
    end;
}
