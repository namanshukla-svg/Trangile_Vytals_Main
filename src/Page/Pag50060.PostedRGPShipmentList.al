Page 50060 "Posted RGP Shipment List"
{
    ApplicationArea = Basic;
    PageType = List;
    SourceTable = "SSD RGP Shipment Header";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = Basic;
                }
                field("Advising Department"; Rec."Advising Department")
                {
                    ApplicationArea = Basic;
                }
                field("Advising Employee"; Rec."Advising Employee")
                {
                    ApplicationArea = Basic;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = Basic;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = Basic;
                }
                field("Delivery Mode"; Rec."Delivery Mode")
                {
                    ApplicationArea = Basic;
                }
                field("Gate Out"; Rec."Gate Out")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Vehical No."; Rec."Vehical No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transporter No."; Rec."Transporter No.")
                {
                    ApplicationArea = Basic;
                }
                field("Bearer Name"; Rec."Bearer Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bearer Department"; Rec."Bearer Department")
                {
                    ApplicationArea = Basic;
                }
                field("Purpose Code"; Rec."Purpose Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Purpose Description"; Rec."Purpose Description")
                {
                    ApplicationArea = Basic;
                }
                field("MRR No."; Rec."MRR No.")
                {
                    ApplicationArea = Basic;
                }
                field("GR No."; Rec."GR No.")
                {
                    ApplicationArea = Basic;
                }
                field("LR No."; Rec."LR No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Shipment)
            {
                Caption = '&Shipment';

                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Posted RGP Shipment";
                    RunPageLink = "No." = field("No.");
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

    var
        UserMgt: Codeunit "SSD User Setup Management";
}
