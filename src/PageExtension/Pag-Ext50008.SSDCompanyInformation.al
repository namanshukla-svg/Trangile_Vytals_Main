PageExtension 50008 "SSD Company Information" extends "Company Information"
{
    layout
    {
        addlast("Tax Information")
        {
            field("LUT No."; Rec."LUT No.")
            {
                ApplicationArea = All;
            }
            field("LUT Date"; Rec."LUT Date")
            {
                ApplicationArea = All;
            }
            field("Valid Upto"; Rec."Valid Upto")
            {
                ApplicationArea = All;
                Caption = 'LUT Valid Upto';
            }
        }
        addafter(Picture)
        {
            group("Image Group")
            {
                Caption = 'Image Group';

                field("New Logo1"; Rec."New Logo1")
                {
                    ApplicationArea = All;
                }
                field("New Logo2"; Rec."New Logo2")
                {
                    ApplicationArea = All;
                }
                field("Letter Head Header"; Rec."Letter Head Header")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Letter Head Header field.';
                }
                field("Letter Head Footer"; Rec."Letter Head Footer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Letter Head Footer field.';
                }
            }
        }
    }
}
