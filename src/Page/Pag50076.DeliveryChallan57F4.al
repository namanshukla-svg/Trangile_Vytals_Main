Page 50076 "Delivery Challan 57F4"
{
    // SM_PP001 13.07.2005 Reference to the "Posted GateOut Nos" changed to "Gate Out Nos"
    Caption = 'Delivery Challan 57F4';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "Delivery Challan Header";
    SourceTableView = sorting("No.") order(ascending);
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Challan Date"; Rec."Challan Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sub. order No."; Rec."Sub. order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Process Description"; Rec."Process Description")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field(partyname; partyname)
                {
                    ApplicationArea = All;
                    Caption = 'Party Name';
                }
            }
            part(SubDCLines; "Sub Delivery Challan  Subform")
            {
                Editable = false;
                SubPageLink = "Delivery Challan No." = field("No.");
                ApplicationArea = all;
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
                    DelChallanHead.Copy(Rec);
                    DelChallanHead.SetRange(DelChallanHead."No.", Rec."No.");
                    DelChallanHead.SetRange(DelChallanHead."Vendor No.", Rec."Vendor No.");
                    //QtyOrdHdr.SETRANGE(QtyOrdHdr."Work Center No.",'QLT_WC');
                    //REPORT.RUNMODAL(50121,TRUE,FALSE,DelChallanHead);
                    //report by  PK CGN 005
                    Report.RunModal(50181, true, false, DelChallanHead);
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
        if Vend.Get(Rec."Vendor No.") then partyname := Vend.Name;
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
        Vend: Record Vendor;
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        Text001: label 'is not within your range of allowed posting dates';
        UserMgt: Codeunit "User Setup Management";
        DelChallanHead: Record "Delivery Challan Header";
        partyname: Text[100];
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
        DeliveryChallanLine: Record "Delivery Challan Line";
        GateSetup: Record "SSD AddOn Setup";
        NoSeriesCode: Code[20];
        //IG_DS_Before   NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        LastEntryNo: Integer;
    begin
        GateSetup.Get;
        GateSetup.TestField(GateSetup."Gate Out Nos");
        NoSeriesCode := GateSetup."Gate Out Nos";
        Clear(GateOutNo);
        //IG_DS_before  NoSeriesMgt.InitSeries(NoSeriesCode, NoSeriesCode, Rec."Posting Date", GateOutNo, Rec."No. Series");
        // if NoSeriesMgt.AreRelated(NoSeriesCode, NoSeriesCode) then
        if NoSeriesCode = '' then
            Error('Gate Out No. Series is not defined in Gate Setup.');
        Rec."No. Series" := NoSeriesCode;
        GateOutNo := NoSeriesMgt.GetNextNo(Rec."No. Series", Rec."Posting Date");
        DeliveryChallanLine.SetRange("Delivery Challan No.", Rec."No.");
        if DeliveryChallanLine.Find('-') then begin
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
                GateRegister."Document Type" := GateRegister."document type"::"Delivery Challan";
                GateRegister."Document No." := Rec."No.";
                GateRegister.NRGP := false;
                GateRegister."Document Line No." := DeliveryChallanLine."Line No.";
                GateRegister."Party Type" := GateRegister."party type"::Vendor;
                GateRegister."Party No." := Rec."Vendor No.";
                if Vend.Get(Rec."Vendor No.") then GateRegister."Party Name" := Vend.Name;
                GateRegister."User ID" := UserId;
                GateRegister.Remarks := Rec."Gate Out Remarks";
                GateRegister.Type := GateRegister.Type::Item;
                GateRegister."No." := DeliveryChallanLine."Item No.";
                GateRegister.Description := DeliveryChallanLine.Description;
                GateRegister."Unit of Measure Code" := DeliveryChallanLine."Unit of Measure";
                GateRegister.Quantity := DeliveryChallanLine.Quantity;
                GateRegister."Responsibility Center" := Rec."Responsibility Center";
                GateRegister.Insert;
            until DeliveryChallanLine.Next = 0;
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
