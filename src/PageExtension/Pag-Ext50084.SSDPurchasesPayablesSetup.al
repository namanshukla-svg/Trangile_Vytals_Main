PageExtension 50084 "SSD Purchases Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Allow Document Deletion Before")
        {
            field("Receipt Challan Nos."; Rec."Receipt Challan Nos.")
            {
                ApplicationArea = All;
            }
            field("Service Grace Period"; Rec."SSD Service Grace Period")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Service Grace Period field.';
            }
            field("SSD SPO Alert Mail"; Rec."SSD SPO Alert Mail")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Default SPO Alert Mail field.';
            }
            group("GSTR Reco and Return")
            {
                Caption = 'GSTR Reco and Return';

                field("GSTR 2 Client ID"; Rec."GSTR 2 Client ID")
                {
                    ApplicationArea = All;
                }
                field("GSTR 1 Client ID"; Rec."GSTR 1 Client ID")
                {
                    ApplicationArea = All;
                }
                field("GSTR 2 Start Date"; Rec."GSTR 2 Start Date")
                {
                    ApplicationArea = All;
                }
                field("GSTR 1 Start Date"; Rec."GSTR 1 Start Date")
                {
                    ApplicationArea = All;
                }
                field("FTP User ID"; Rec."FTP User ID")
                {
                    ApplicationArea = All;
                }
                field("FTP User Password"; Rec."FTP User Password")
                {
                    ApplicationArea = All;
                }
                field("GSTR Local Folder"; Rec."GSTR Local Folder")
                {
                    ApplicationArea = All;
                }
                field("GSTR FTP Input"; Rec."GSTR FTP Input")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Blanket Order Nos.")
        {
            field("Import PO"; Rec."Import PO")
            {
                ApplicationArea = All;
            }
            field("Item Charge No."; Rec."Item Charge No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
