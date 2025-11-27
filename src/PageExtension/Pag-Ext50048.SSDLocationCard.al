PageExtension 50048 "SSD Location Card" extends "Location Card"
{
    Editable = true;

    layout
    {
        addafter(Contact)
        {
            field("Quality Rejects"; Rec."Quality Rejects")
            {
                ApplicationArea = All;
            }
            field("Temp JW Location"; Rec."Temp JW Location")
            {
                ApplicationArea = All;
            }
            field("Temp State Code"; Rec."Temp State Code")
            {
                ApplicationArea = All;
            }
            field("Temp GST Registration No."; Rec."Temp GST Registration No.")
            {
                ApplicationArea = All;
            }
            field("PAN No."; Rec."PAN No.")
            {
                ApplicationArea = All;
                Caption = 'PAN No.';
            }
            //IG_DS
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = all;
            }
            //IG_DS
        }
        addafter("Use As In-Transit")
        {
            field("Use As In-Transit New"; Rec."Use As In-Transit")
            {
                ApplicationArea = Location;
                ToolTip = 'Specifies that this location is an in-transit location.';
                Caption = 'Use As In-Transit New';
            }
            field("Phy. Bin Required"; Rec."Phy. Bin Required")
            {
                ApplicationArea = All;
            }
            field("Transfer Receipt No. Series"; Rec."Transfer Receipt No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer Receipt No. Series field.';
            }
        }
    }
}
