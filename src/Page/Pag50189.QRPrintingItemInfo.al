Page 50189 "QR Printing Item Info."
{
    ApplicationArea = All;
    DeleteAllowed = false;
    Editable = true;
    PageType = List;
    SourceTable = "SSD QR Prining info";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("QR Printing Type"; Rec."QR Printing Type")
                {
                    ApplicationArea = All;
                }
                field("QR Printing Code"; Rec."QR Printing Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("QR Description"; Rec."QR Description")
                {
                    ApplicationArea = All;
                }
                field("QR Print Index"; Rec."QR Print Index")
                {
                    ApplicationArea = All;
                }
                field("Print Labels"; Rec."Print Labels")
                {
                    ToolTip = 'Specifies the value of the Print Labels field.';
                }
            }
        }
    }
    actions
    {
    }
}
