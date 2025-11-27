Page 50207 "RGP ApprovalPage"
{
    // CF001 08.01.2005 Responsibility Center
    CardPageID = "RGP outbound";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "SSD RGP Header";
    SourceTableView = sorting(NRGP)order(ascending)where(NRGP=const(false), "Document Type"=filter("RGP Outbound"), "Document SubType"=const(" "), Approved=filter(false), "Approval ID"=filter(<>''));
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
                field("Sender ID"; Rec."Sender ID")
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
                        if UserSetup.Get(UserId)then if UserSetup."RGP Approval" then begin
                                CurrPage.SetSelectionFilter(RGPHeader);
                                if RGPHeader.FindSet then begin
                                    RGPHeader.ModifyAll(Approved, true);
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
        if UserSetup.Get(UserId)then if UserSetup."RGP Approval" then begin
                RGPHeader.Reset;
                RGPHeader.SetRange("Send to Approval", true);
                if RGPHeader.FindSet then RGPHeader.ModifyAll("Approval ID", UserSetup."User ID");
            end
            else
            begin
                RGPHeader.Reset;
                RGPHeader.SetRange("Send to Approval", true);
                if RGPHeader.FindSet then RGPHeader.ModifyAll("Approval ID", '');
            end;
    end;
    var UserSetup: Record "User Setup";
    RGPHeader: Record "SSD RGP Header";
}
