Page 50061 "Posted Receipt List"
{
    Editable = false;
    PageType = List;
    SourceTable = "SSD RGP Receipt Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Advising Department"; Rec."Advising Department")
                {
                    ApplicationArea = All;
                }
                field("Advising Employee"; Rec."Advising Employee")
                {
                    ApplicationArea = All;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                }
                field("Delivery Mode"; Rec."Delivery Mode")
                {
                    ApplicationArea = All;
                }
                field("Vehical No."; Rec."Vehical No.")
                {
                    ApplicationArea = All;
                }
                field("Transporter No."; Rec."Transporter No.")
                {
                    ApplicationArea = All;
                }
                field("Bearer Name"; Rec."Bearer Name")
                {
                    ApplicationArea = All;
                }
                field("Bearer Department"; Rec."Bearer Department")
                {
                    ApplicationArea = All;
                }
                field("Purpose Code"; Rec."Purpose Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Receipt)
            {
                Caption = '&Receipt';

                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Posted RGP Receipt";
                    RunPageLink = "No."=field("No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
    //CF001 St
    // if UserMgt.GetRespCenterFilter <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    //CF001 En
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
}
