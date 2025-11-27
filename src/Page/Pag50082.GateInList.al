Page 50082 "Gate In List"
{
    ApplicationArea = All;
    CardPageID = "Gate In";
    Editable = false;
    PageType = List;
    SourceTable = "SSD Gate Header";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                }
                field("MRN No."; Rec."MRN No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                }
                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = All;
                }
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("In Time"; Rec."In Time")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Excise Amount"; Rec."Excise Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sales Tax Amount"; Rec."Sales Tax Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bill Date"; Rec."Bill Date")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Telex; Rec.Telex)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ref. Document Type"; Rec."Ref. Document Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ref. Document No."; Rec."Ref. Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ST38 No."; Rec."ST38 No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Gate Entry")
            {
                action(ShowCard)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        Page.RunModal(Page::"Gate In", Rec);
                    end;
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
