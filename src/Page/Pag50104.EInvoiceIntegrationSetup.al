Page 50104 "E-Invoice Integration Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "SSD E-Inv Integration Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                }
                field("Client ID"; Rec."Client ID")
                {
                    ApplicationArea = All;
                }
                field("Client Secret"; Rec."Client Secret")
                {
                    ApplicationArea = All;
                }
                field("Access Token"; Rec."Access Token")
                {
                    ApplicationArea = All;
                }
                field("Access Token Validity"; Rec."Access Token Validity")
                {
                    ApplicationArea = All;
                }
                field("B2C E-Invoicing"; Rec."B2C E-Invoicing")
                {
                    ApplicationArea = All;
                }
                field("Mode of E-Invoice - Sales"; Rec."Mode of E-Invoice - Sales")
                {
                    ApplicationArea = All;
                }
                field("Mode of E-Invoice - Purchase"; Rec."Mode of E-Invoice - Purchase")
                {
                    ApplicationArea = All;
                }
                field("Mode of E-Invoice - Transfer"; Rec."Mode of E-Invoice - Transfer")
                {
                    ApplicationArea = All;
                }
                field("Access Token URL"; Rec."Access Token URL")
                {
                    ApplicationArea = All;
                }
                field("Generate E-Invoice URL"; Rec."Generate E-Invoice URL")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
