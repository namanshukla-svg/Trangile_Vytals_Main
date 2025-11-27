page 50072 "SSD Item Vendor Factbox"
{
    ApplicationArea = All;
    Caption = 'SSD Item Vendor Factbox';
    PageType = CardPart;
    SourceTable = "Item Vendor";

    layout
    {
        area(content)
        {
            group(Attachment)
            {
                Caption = 'Attachments';

                field("Attached Doc Count"; Rec."Attached Doc Count")
                {
                    ApplicationArea = All;
                    Caption = 'Documents';
                    ToolTip = 'Specifies the number of attachments.';

                    trigger OnDrillDown()
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
}
