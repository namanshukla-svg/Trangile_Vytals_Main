Page 50103 "E-Invoice Requests"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = "SSD E-Invoicing Requests";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Acknowledgement No."; Rec."Acknowledgement No.")
                {
                    ApplicationArea = All;
                }
                field("Acknowledgement Date"; Rec."Acknowledgement Date")
                {
                    ApplicationArea = All;
                }
                field("IRN No."; Rec."IRN No.")
                {
                    ApplicationArea = All;
                }
                field("Signed QR Code"; Rec."Signed QR Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                }
                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Request Time"; Rec."Request Time")
                {
                    ApplicationArea = All;
                }
                field("Signed Invoice"; Rec."Signed Invoice")
                {
                    ApplicationArea = All;
                }
                field("Signed QR Code2"; Rec."Signed QR Code2")
                {
                    ApplicationArea = All;
                }
                field("Signed QR Code3"; Rec."Signed QR Code3")
                {
                    ApplicationArea = All;
                }
                field("QR Image"; Rec."QR Image")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("E-Invoice Generated"; Rec."E-Invoice Generated")
                {
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
                field("QR Code URL"; Rec."QR Code URL")
                {
                    ApplicationArea = All;
                }
                field("E Invoice PDF URL"; Rec."E Invoice PDF URL")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(QR; "SSD QR Display")
            {
                ApplicationArea = All;
                Caption = 'QR';
                SubPageLink = "Entry No."=field("Entry No.");
            }
        }
    }
    actions
    {
    }
}
