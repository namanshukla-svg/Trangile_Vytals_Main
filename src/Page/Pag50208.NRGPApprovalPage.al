Page 50208 "NRGP Approval Page"
{
    CardPageID = "NRGP outbound";
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "SSD RGP Header";
    SourceTableView = sorting(NRGP)order(ascending)where(NRGP=const(true), "Document Type"=filter("RGP Outbound"), "NRGP Approved"=filter(false), "NRGP Approval ID"=filter(<>''));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
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
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("NRGP Sender ID"; Rec."NRGP Sender ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                action(Approve)
                {
                    ApplicationArea = All;
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = New;

                    trigger OnAction()
                    begin
                        if UserSetup1.Get(UserId)then if UserSetup1."NRGP Approval" then begin
                                CurrPage.SetSelectionFilter(RGPHeader);
                                if RGPHeader.FindSet then begin
                                    RGPHeader.ModifyAll("NRGP Approved", true);
                                    RGPHeader.ModifyAll(Status, RGPHeader.Status::Released);
                                end;
                            end
                            else
                                Error('You are not authorised for Approval');
                        Clear(RGPHeader);
                    end;
                }
            }
        }
    }
    trigger OnInit()
    begin
        if UserSetup1.Get(UserId)then if UserSetup1."RGP Approval" then begin
                RGPHeader.Reset;
                RGPHeader.SetRange("NRGP Send to Approval", true);
                if RGPHeader.FindSet then RGPHeader.ModifyAll("NRGP Approval ID", UserSetup1."User ID");
            end
            else
            begin
                RGPHeader.Reset;
                RGPHeader.SetRange("NRGP Send to Approval", true);
                if RGPHeader.FindSet then RGPHeader.ModifyAll("NRGP Approval ID", '');
            end;
    end;
    var UserSetup1: Record "User Setup";
    RGPHeader: Record "SSD RGP Header";
}
