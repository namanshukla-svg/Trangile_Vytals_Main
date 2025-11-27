pageextension 50122 "SSD Item Vendor Catalog" extends "Item Vendor Catalog"
{
    layout
    {
        addafter("Vendor No.")
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Name field.';
            }
            field("Validity Period Start Date"; Rec."Validity Period Start Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Validity Period Start Date field.';
            }
            field("Validity Period End Date"; Rec."Validity Period End Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Validity Period End Date field.';
            }
            field("Item Description"; Rec."Item Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Description field.';
                Caption = 'Vendor Item Description';
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
            }
        }
        modify("Variant Code")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        addfirst(factboxes)
        {
            part("Line Documents"; "SSD Item Vendor Factbox")
            {
                ApplicationArea = all;
                //Provider = 
                SubPageLink = "Vendor No."=field("Vendor No."), "Item No."=field("Item No."), "Variant Code"=field("Variant Code");
            }
        }
    }
    actions
    {
        addfirst(Processing)
        {
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
    }
}
