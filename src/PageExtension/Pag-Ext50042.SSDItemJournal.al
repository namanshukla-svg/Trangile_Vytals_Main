PageExtension 50042 "SSD Item Journal" extends "Item Journal"
{
    layout
    {
        modify(Control1)
        {
            Editable = IsEditableLine;
        }
        modify(Control22)
        {
            Editable = IsEditableLine;
        }
        modify("Unit Amount")
        {
            Editable = false;
        }
        modify("Unit Cost")
        {
            Editable = false;
        }
        modify("Bin Code")
        {
            Visible = true;
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                Item.GET(Rec."Item No.");
                Rec."Quality Required" := Item."Quality Required";
                Rec."Pack Size" := Item."Pack Size";
            end;
        }
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Discount Amount")
        {
            field("Production Doc. No."; Rec."Production Doc. No.")
            {
                ApplicationArea = All;
                Visible = "Production Doc. No.Visible";
            }
            field("Production Doc. Type"; Rec."Production Doc. Type")
            {
                ApplicationArea = All;
                Visible = "Production Doc. TypeVisible";
            }
        }
        addafter("Reason Code")
        {
            field("Send for Approval"; Rec."Send for Approval")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Approval; Rec.Approval)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Quality Required"; Rec."Quality Required")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sender ID"; Rec."Sender ID")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("New Bin Code"; Rec."New Bin Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the new bin code to link to the items on this journal line.';
            }
            field("Pack Size"; Rec."Pack Size")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pack Size field.', Comment = '%';
            }
        }
        modify("Applies-from Entry")
        {
            Visible = true;
        }
    }
    actions
    {
        addafter("&Save as Standard Journal")
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = New;

                trigger OnAction()
                begin
                    //CORP::PK check for Phy. Bin Code >>>
                    if Rec.FindSet then
                        repeat
                            if Location.Get(Rec."Location Code") then;
                            if Item.Get(Rec."Item No.") then;
                            if (Location."Phy. Bin Required") and (Item."Phy. Bin Required") then begin
                                ItemPhyBinDetails.Reset;
                                ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                                ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                                ItemPhyBinDetails.SetRange("Posted Document No.", '');
                                if not ItemPhyBinDetails.FindFirst then
                                    Error('Please fill the Item Phy. Details in Line No. %1', Rec."Line No.")
                                else begin
                                    ItemPhyBinDetails."Posting Date" := Today;
                                    ItemPhyBinDetails.Modify;
                                end;
                            end;
                        until Rec.Next = 0;
                    //CORP::PK Check for Phy. Bin Code <<<
                    if UserSetup1.Get(UserId) then
                        if UserSetup1."IJL Send For Approval" then begin
                            CurrPage.SetSelectionFilter(ItemJournalLine);
                            if ItemJournalLine.FindSet then begin
                                ItemJournalLine.ModifyAll("Send for Approval", true);
                                ItemJournalLine.ModifyAll("Sender ID", UserId);
                            end;
                        end
                        else
                            Error('You are not authorised for sending approval');
                    Clear(ItemJournalLine);
                end;
            }
        }
        addafter("Post and &Print")
        {
            action("Item Phy. Bin Details")
            {
                ApplicationArea = All;
                Caption = 'Item Phy. Bin Details';
                Image = BinJournal;
                Promoted = true;
                ShortCutKey = 'Shift+Ctrl+P';

                trigger OnAction()
                var
                    ReservationEntry: Record "Reservation Entry";
                    EntryNo: Integer;
                    LotNo: Code[20];
                    Item: Record Item;
                    LineNo: Integer;
                begin
                    //CORP::PK 010719 >>>
                    if Location.Get(Rec."Location Code") then;
                    if Item.Get(Rec."Item No.") then;
                    if (Location."Phy. Bin Required") and (Item."Phy. Bin Required") then begin
                        ItemPhyBinDetails.Reset;
                        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                        ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                        ItemPhyBinDetails.SetRange("Posted Document No.", '');
                        if not ItemPhyBinDetails.FindFirst then begin
                            if Rec."Entry Type" = Rec."entry type"::"Positive Adjmt." then begin
                                ReservationEntry.Reset;
                                ReservationEntry.SetRange("Source ID", Rec."Journal Template Name");
                                ReservationEntry.SetRange("Source Batch Name", Rec."Journal Batch Name");
                                ReservationEntry.SetRange("Item No.", Rec."Item No.");
                                ReservationEntry.SetRange(Positive, true);
                                if ReservationEntry.FindSet then
                                    repeat
                                        ItemPhyBinDetails.Reset;
                                        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                                        if ItemPhyBinDetails.FindLast then
                                            LineNo := ItemPhyBinDetails."Line No." + 10000
                                        else
                                            LineNo := 10000;
                                        ItemPhyBinDetails.Init;
                                        ItemPhyBinDetails.Validate("Line No.", LineNo);
                                        ItemPhyBinDetails.Validate("Document No.", Rec."Document No.");
                                        ItemPhyBinDetails.Validate("Document Line No.", Rec."Line No.");
                                        ItemPhyBinDetails.Validate("Item No.", Rec."Item No.");
                                        ItemPhyBinDetails.Validate("Unit Of Measure", Rec."Unit of Measure Code");
                                        ItemPhyBinDetails.Validate("Qty. Per Unit Of Measure", Rec."Qty. per Unit of Measure");
                                        ItemPhyBinDetails.Validate("Location Code", Rec."Location Code");
                                        ItemPhyBinDetails.Validate("Bin Code", Rec."Bin Code");
                                        ItemPhyBinDetails.Validate("Lot No.", ReservationEntry."Lot No.");
                                        ItemPhyBinDetails.Validate("Journal Batch Name", Rec."Journal Batch Name");
                                        ItemPhyBinDetails.Validate("Journal Template Name", Rec."Journal Template Name");
                                        ItemPhyBinDetails.Validate("Posting Date", Rec."Posting Date");
                                        ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::"Positive Adjmt.");
                                        ItemPhyBinDetails.Insert;
                                    until ReservationEntry.Next = 0;
                            end;
                            if Rec."Entry Type" = Rec."entry type"::"Negative Adjmt." then begin
                                ReservationEntry.Reset;
                                ReservationEntry.SetRange("Source ID", Rec."Journal Template Name");
                                ReservationEntry.SetRange("Source Batch Name", Rec."Journal Batch Name");
                                ReservationEntry.SetRange("Item No.", Rec."Item No.");
                                ReservationEntry.SetRange(Positive, false);
                                if ReservationEntry.FindSet then
                                    repeat
                                        ItemPhyBinDetails.Reset;
                                        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                                        if ItemPhyBinDetails.FindLast then
                                            LineNo := ItemPhyBinDetails."Line No." + 10000
                                        else
                                            LineNo := 10000;
                                        ItemPhyBinDetails.Init;
                                        ItemPhyBinDetails.Validate("Line No.", LineNo);
                                        ItemPhyBinDetails.Validate("Document No.", Rec."Document No.");
                                        ItemPhyBinDetails.Validate("Document Line No.", Rec."Line No.");
                                        ItemPhyBinDetails.Validate("Item No.", Rec."Item No.");
                                        ItemPhyBinDetails.Validate("Unit Of Measure", Rec."Unit of Measure Code");
                                        ItemPhyBinDetails.Validate("Qty. Per Unit Of Measure", Rec."Qty. per Unit of Measure");
                                        ItemPhyBinDetails.Validate("Location Code", Rec."Location Code");
                                        ItemPhyBinDetails.Validate("Bin Code", Rec."Bin Code");
                                        ItemPhyBinDetails.Validate("Lot No.", ReservationEntry."Lot No.");
                                        ItemPhyBinDetails.Validate("Journal Batch Name", Rec."Journal Batch Name");
                                        ItemPhyBinDetails.Validate("Journal Template Name", Rec."Journal Template Name");
                                        ItemPhyBinDetails.Validate("Posting Date", Rec."Posting Date");
                                        ItemPhyBinDetails.Validate("Document Type", ItemPhyBinDetails."document type"::"Negative Adjmt.");
                                        ItemPhyBinDetails.Insert;
                                    until ReservationEntry.Next = 0;
                            end;
                        end;
                        Commit;
                        ItemPhyBinDetails.Reset;
                        ItemPhyBinDetails.SetRange("Document No.", Rec."Document No.");
                        ItemPhyBinDetails.SetRange("Document Line No.", Rec."Line No.");
                        ItemPhyBinDetails.SetRange("Posted Document No.", '');
                        Page.RunModal(50238, ItemPhyBinDetails);
                    end;
                    //CORP::PK 010719 <<<
                end;
            }
        }
    }
    var
        ItemJnlBatchLocal: Record "Item Journal Batch";
        IsEditableLine: Boolean;

    var
        UserMgt: Codeunit "SSD User Setup Management";

    var
        ItemJnlBatch: Record "Item Journal Batch";
        UserSetup: Record "User Setup";
        "Production Doc. No.Visible": Boolean;
        "Production Doc. TypeVisible": Boolean;

    var
        UserSetup1: Record "User Setup";
        ItemJournalLine: Record "Item Journal Line";
        Item: Record Item;
        Location: Record Location;
        ItemPhyBinDetails: Record "SSD Item Phy. Bin Details";

    trigger OnAfterGetCurrRecord()
    begin
        IF ItemJnlBatch.GET(Rec."Journal Template Name", Rec."Journal Batch Name") THEN BEGIN
            IF ItemJnlBatch."Input/Output" THEN BEGIN
                "Production Doc. No.Visible" := TRUE;
                "Production Doc. TypeVisible" := TRUE;
            END
            ELSE BEGIN
                "Production Doc. No.Visible" := FALSE;
                "Production Doc. TypeVisible" := FALSE;
            END;
        END;

        IsEditableLine := true;

        if (Rec."Journal Template Name" = 'ISSUE') and (Rec."Journal Batch Name" = 'ISSUESLIP') then
            IsEditableLine := false;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        IsEditableLine := true;

        if (Rec."Journal Template Name" = 'ISSUE') and (Rec."Journal Batch Name" = 'ISSUESLIP') then
            IsEditableLine := false;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        ItemPhyBinDetails.RESET;
        ItemPhyBinDetails.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        ItemPhyBinDetails.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        ItemPhyBinDetails.SETRANGE("Whse. Entry  No.", 0);
        IF ItemPhyBinDetails.FINDSET THEN ItemPhyBinDetails.DELETEALL;
    end;

    trigger OnOpenPage()
    begin
        "Production Doc. TypeVisible" := TRUE;
        "Production Doc. No.Visible" := TRUE;

        IsEditableLine := true;

        if (Rec."Journal Template Name" = 'ISSUE') and (Rec."Journal Batch Name" = 'ISSUESLIP') then
            IsEditableLine := false;
    end;
}
