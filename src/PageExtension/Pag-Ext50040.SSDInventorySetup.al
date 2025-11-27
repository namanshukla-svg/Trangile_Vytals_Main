PageExtension 50040 "SSD Inventory Setup" extends "Inventory Setup"
{
    layout
    {
        addafter("Posted Serv. Trans. Rcpt. Nos.")
        {
            field("Issue Slip No."; Rec."Issue Slip No.")
            {
                ApplicationArea = All;
            }
            field("Issue Journal Template Name"; Rec."Issue Journal Template Name")
            {
                ApplicationArea = all;
            }
            field("Issue Journal Batch Name"; Rec."Issue Journal Batch Name")
            {
                ApplicationArea = all;
            }
        }
        addlast(content)
        {
            group(Zavenir)
            {
                field("Freight Zone No. Series"; Rec."Freight Zone No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Freight Zone No. Series field.';
                }
            }
        }
    }
}
