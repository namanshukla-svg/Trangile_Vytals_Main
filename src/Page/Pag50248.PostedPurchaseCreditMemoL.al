Page 50248 "Posted Purchase Credit  Memo L"
{
    // SM_PP001 13.07.2005 Reference to the "Posted GateOut Nos" changed to "Gate Out Nos"
    ApplicationArea = All;
    Caption = 'Posted Purchase Credit Memo';
    CardPageID = "Posted Purchase Credit  Memo";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Purch. Cr. Memo Hdr." = rimd;
    RefreshOnActivate = true;
    SourceTable = "Purch. Cr. Memo Hdr.";
    UsageCategory = Tasks;

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
                    Editable = false;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Lookup = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Buy-from Post Code/City';
                    Editable = false;
                    Lookup = false;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Lookup = false;
                }
                field("Gate Out Remarks"; Rec."Gate Out Remarks")
                {
                    ApplicationArea = All;
                    Editable = "Gate Out RemarksEditable";
                }
                field("Gate Out Date"; Rec."Gate Out Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gate Out Time"; Rec."Gate Out Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gate Out User ID"; Rec."Gate Out User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gate Out No."; Rec."Gate Out No.")
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
            action(Print)
            {
                ApplicationArea = All;
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    PurchCrMemHdr.Copy(Rec);
                    PurchCrMemHdr.SetRange(PurchCrMemHdr."No.", Rec."No.");
                    PurchCrMemHdr.SetRange(PurchCrMemHdr."Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                    //QtyOrdHdr.SETRANGE(QtyOrdHdr."Work Center No.",'QLT_WC');
                    //SSDU Report.RunModal(Report::"Outward Gate Pass", true, false, PurchCrMemHdr);
                end;
            }
            action(Out)
            {
                ApplicationArea = All;
                Caption = '&Out';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Allow to send?') then begin
                        if DateNotAllowed(Rec."Posting Date") then Rec.FieldError("Posting Date", Text001);
                        Post;
                    end;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Gate Out Posted" then
            "Gate Out RemarksEditable" := false
        else
            "Gate Out RemarksEditable" := true;
    end;

    trigger OnInit()
    begin
        "Gate Out RemarksEditable" := true;
    end;

    trigger OnOpenPage()
    begin
        if Rec."Gate Out Posted" then "Gate Out RemarksEditable" := false;
        //CF001 St
        if UserMgt.GetPurchasesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FilterGroup(0);
        end;
        //CF001 En
    end;

    var
        GateOutNo: Code[20];
        GateRegister: Record "SSD Gate Register";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        Text001: label 'is not within your range of allowed posting dates';
        UserMgt: Codeunit "User Setup Management";
        PurchCrMemHdr: Record "Purch. Cr. Memo Hdr.";
        "Gate Out RemarksEditable": Boolean;

    procedure Post()
    begin
        if Rec."Gate Out Posted" then
            Message('Gate entry already done')
        else begin
            InsertGateRegister;
            Rec."Gate Out Date" := WorkDate;
            Rec."Gate Out Time" := Time;
            Rec."Gate Out User ID" := UserId;
            Rec."Gate Out No." := GateOutNo;
            Rec."Gate Out Posted" := true;
            Rec.Modify;
            "Gate Out RemarksEditable" := false;
            Commit;
            Message('Posted');
        end;
    end;

    procedure InsertGateRegister()
    var
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        GateSetup: Record "SSD AddOn Setup";
        NoSeriesCode: Code[20];
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        LastEntryNo: Integer;
    begin
        GateSetup.Get;
        GateSetup.TestField(GateSetup."Gate Out Nos");
        NoSeriesCode := GateSetup."Gate Out Nos";
        Clear(GateOutNo);
        //IG_DS NoSeriesMgt.InitSeries(NoSeriesCode, NoSeriesCode, Rec."Posting Date", GateOutNo, Rec."No. Series");
        // if NoSeriesMgt.AreRelated(NoSeriesCode, NoSeriesCode) then
        if NoSeriesCode = '' then
            Error('Gate Out No. Series is not defined in Gate Setup.');
        Rec."No. Series" := NoSeriesCode;
        GateOutNo := NoSeriesMgt.GetNextNo(Rec."No. Series", Rec."Posting Date");

        PurchCrMemoLine.SetRange("Document No.", Rec."No.");
        PurchCrMemoLine.SetRange(Type, PurchCrMemoLine.Type::Item);
        if PurchCrMemoLine.Find('-') then begin
            GateRegister.LockTable;
            if GateRegister.Find('+') then
                LastEntryNo := GateRegister."Entry No."
            else
                LastEntryNo := 0;
            repeat
                LastEntryNo += 1;
                GateRegister.Init;
                GateRegister."Entry No." := LastEntryNo;
                GateRegister."Gate Entry Type" := GateRegister."gate entry type"::Outbound;
                GateRegister."Gate Entry No." := GateOutNo;
                GateRegister."Gate Entry Date" := WorkDate;
                GateRegister."Gate Entry Time" := Time;
                GateRegister."Document Type" := GateRegister."document type"::"Purchase Return";
                GateRegister."Document No." := Rec."No.";
                GateRegister.NRGP := false;
                GateRegister."Document Line No." := PurchCrMemoLine."Line No.";
                GateRegister."Party Type" := GateRegister."party type"::Vendor;
                GateRegister."Party No." := Rec."Buy-from Vendor No.";
                GateRegister."Party Name" := Rec."Buy-from Vendor Name";
                GateRegister."User ID" := UserId;
                GateRegister.Remarks := Rec."Gate Out Remarks";
                GateRegister.Type := GateRegister.Type::Item;
                GateRegister."No." := PurchCrMemoLine."No.";
                GateRegister.Description := PurchCrMemoLine.Description;
                GateRegister."Unit of Measure Code" := PurchCrMemoLine."Unit of Measure Code";
                GateRegister.Quantity := PurchCrMemoLine.Quantity;
                GateRegister."Responsibility Center" := Rec."Responsibility Center";
                GateRegister.Insert;
            until PurchCrMemoLine.Next = 0;
        end
        else
            Error('Nothing to send out');
    end;

    procedure DateNotAllowed(PostingDate: Date): Boolean
    begin
        if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
            if UserId <> '' then
                if UserSetup.Get(UserId) then begin
                    AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                end;
            if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                GLSetup.Get;
                AllowPostingFrom := GLSetup."Allow Posting From";
                AllowPostingTo := GLSetup."Allow Posting To";
            end;
            if AllowPostingTo = 0D then AllowPostingTo := 99991231D;
        end;
        exit((PostingDate < AllowPostingFrom) or (PostingDate > AllowPostingTo));
    end;
}
