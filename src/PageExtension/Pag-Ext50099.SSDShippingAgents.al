PageExtension 50099 "SSD Shipping Agents" extends "Shipping Agents"
{
    layout
    {
        addafter("Internet Address")
        {
            field("Contact3 Name"; Rec."Contact3 Name")
            {
                ApplicationArea = All;
            }
            field("Contact3 Mobile"; Rec."Contact3 Mobile")
            {
                ApplicationArea = All;
            }
            field("Contact3 Email"; Rec."Contact3 Email")
            {
                ApplicationArea = All;
            }
        }
        addafter("GST Registration No.")
        {
            field("Transporter GST No."; Rec."Transporter GST No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
