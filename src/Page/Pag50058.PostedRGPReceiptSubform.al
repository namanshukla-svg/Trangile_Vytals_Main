Page 50058 "Posted RGP Receipt Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SSD RGP Receipt Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
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
                field("In-Transit Code"; Rec."In-Transit Code")
                {
                    ApplicationArea = All;
                }
                field("Write Off"; Rec."Write Off")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Receipt Time"; Rec."Receipt Time")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';

                action("Line Details")
                {
                    ApplicationArea = All;
                    Caption = 'Line Details';

                    trigger OnAction()
                    begin
                        //This functionality was copied from page #50057. Unsupported part was commented. Please check it.
                        /*CurrPage.RGPRcptLines.PAGE.*/
                        PostedLineDetails;
                    end;
                }
            }
        }
    }
    procedure ShowRGPLedger()
    begin
        Rec.ShowLedgerEntries(Rec);
    end;
    procedure PostedLineDetails()
    var
        PostedRecRGPDetail: Record "SSD Posted RGP Line Detail";
        PostedFrmRGPdetails: Page "Posted RGP line Details";
    begin
        //***********CEN006***************
        if Rec."No." <> '' then begin
            PostedRecRGPDetail.Reset;
            PostedRecRGPDetail.SetRange(PostedRecRGPDetail."Document Type", Rec."Document Type");
            PostedRecRGPDetail.SetRange(PostedRecRGPDetail."Document No.", Rec."Document No.");
            PostedRecRGPDetail.SetRange(PostedRecRGPDetail."Item No.", Rec."No.");
            PostedRecRGPDetail.SetRange(PostedRecRGPDetail."Line No.", Rec."Line No.");
            Clear(PostedFrmRGPdetails);
            PostedFrmRGPdetails.SetRecord(PostedRecRGPDetail);
            PostedFrmRGPdetails.SetTableview(PostedRecRGPDetail);
            PostedFrmRGPdetails.RunModal;
        end;
    end;
}
