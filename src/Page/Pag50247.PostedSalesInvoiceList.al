Page 50247 "Posted Sales  Invoice List"
{
    // SM_PP001 13.07.2005 Reference to the "Posted GateOut Nos" changed to "Gate Out Nos"
    //ApplicationArea = All;
    Caption = 'Posted Sales Invoice List';
    CardPageID = "Posted Sales  Invoice";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Sales Invoice Header" = rimd;
    RefreshOnActivate = true;
    SourceTable = "Sales Invoice Header";
    UsageCategory = Tasks;
    ApplicationArea = All;

    //ApplicationArea = All;
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
                field("Excise Invoice No."; Rec."Excise Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Lookup = false;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Sell-to Post Code/City';
                    Editable = false;
                    Lookup = false;
                }
                field("Sell-to City"; Rec."Sell-to City")
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
                field("Gate Out No."; Rec."Gate Out No.")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Vehicle No1"; Rec."Vehicle No1")
                {
                    ApplicationArea = All;
                    Editable = "Vehicle NoEditable";
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Action1102152000)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    SalesInvLine: Record "Sales Invoice Line";
                    GateSetup: Record "SSD AddOn Setup";
                    NoSeriesCode: Code[20];
                    NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
                    LastEntryNo: Integer;
                begin
                    if Rec.Find('-') then
                        repeat
                            if not Rec."Gate Out Posted" then begin
                                GateSetup.Get;
                                GateSetup.TestField(GateSetup."Gate Out Nos");
                                NoSeriesCode := GateSetup."Gate Out Nos";
                                Clear(GateOutNo);
                                //IG_DS_Before   NoSeriesMgt.InitSeries(NoSeriesCode, NoSeriesCode, Rec."Posting Date", GateOutNo, Rec."No. Series");
                                // if NoSeriesMgt.AreRelated(NoSeriesCode, NoSeriesCode) then
                                if NoSeriesCode = '' then
                                    Error('Gate Out No. Series is not defined in Gate Setup.');
                                Rec."No. Series" := NoSeriesCode;
                                GateOutNo := NoSeriesMgt.GetNextNo(Rec."No. Series", Rec."Posting Date");

                                SalesInvLine.SetRange("Document No.", Rec."No.");
                                SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                                if SalesInvLine.Find('-') then begin
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
                                        GateRegister."Gate Entry Date" := Rec."Posting Date";
                                        GateRegister."Gate Entry Time" := Time;
                                        GateRegister."Document Type" := GateRegister."document type"::"Sales Invoice";
                                        GateRegister."Document No." := Rec."No.";
                                        GateRegister.NRGP := false;
                                        GateRegister."Document Line No." := SalesInvLine."Line No.";
                                        GateRegister."Party Type" := GateRegister."party type"::Customer;
                                        GateRegister."Party No." := Rec."Sell-to Customer No.";
                                        GateRegister."Party Name" := Rec."Sell-to Customer Name";
                                        GateRegister."User ID" := 'RKUMAR';
                                        GateRegister.Remarks := Rec."Gate Out Remarks";
                                        GateRegister.Type := GateRegister.Type::Item;
                                        GateRegister."No." := SalesInvLine."No.";
                                        GateRegister.Description := SalesInvLine.Description;
                                        GateRegister."Unit of Measure Code" := SalesInvLine."Unit of Measure Code";
                                        GateRegister.Quantity := SalesInvLine.Quantity;
                                        GateRegister."Vechile No." := Rec."Vehicle No1";
                                        GateRegister."Responsibility Center" := Rec."Responsibility Center";
                                        GateRegister.Insert;
                                    until SalesInvLine.Next = 0;
                                end;
                                Rec."Gate Out Date" := Rec."Posting Date";
                                Rec."Gate Out Time" := Time;
                                Rec."Gate Out User ID" := 'RKUMAR';
                                Rec."Gate Out No." := GateOutNo;
                                Rec."Gate Out Posted" := true;
                                Rec.Modify;
                            end;
                        until Rec.Next = 0;
                end;
            }
            action(Print)
            {
                ApplicationArea = All;
                Caption = '&Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    SalesInvHdr.Reset;
                    SalesInvHdr.Copy(Rec);
                    SalesInvHdr.SetRange(SalesInvHdr."No.", Rec."No.");
                    SalesInvHdr.SetRange(SalesInvHdr."Sell-to Customer No.", Rec."Sell-to Customer No.");
                    //QtyOrdHdr.SETRANGE(QtyOrdHdr."Work Center No.",'QLT_WC');
                    //SSDU Report.RunModal(Report::"Outward Gate Pass", true, false, SalesInvHdr);
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
        VehicleNoOnFormat;
    end;

    trigger OnInit()
    begin
        "Vehicle NoEditable" := true;
        "Gate Out RemarksEditable" := true;
    end;

    trigger OnOpenPage()
    begin
        if Rec."Gate Out Posted" then "Gate Out RemarksEditable" := false;
        //CF001 St
        if UserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter);
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
        SalesInvHdr: Record "Sales Invoice Header";
        "Gate Out RemarksEditable": Boolean;
        "Vehicle NoEditable": Boolean;

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
        SalesInvLine: Record "Sales Invoice Line";
        GateSetup: Record "SSD AddOn Setup";
        NoSeriesCode: Code[20];
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        LastEntryNo: Integer;
    begin
        GateSetup.Get;
        GateSetup.TestField(GateSetup."Gate Out Nos");
        NoSeriesCode := GateSetup."Gate Out Nos";
        Clear(GateOutNo);
        //IG_DS_Before NoSeriesMgt.InitSeries(NoSeriesCode, NoSeriesCode, Rec."Posting Date", GateOutNo, Rec."No. Series");
        // if NoSeriesMgt.AreRelated(NoSeriesCode, NoSeriesCode) then
        if NoSeriesCode = '' then
            Error('Gate Out No. Series is not defined in Gate Setup.');
        Rec."No. Series" := NoSeriesCode;
        GateOutNo := NoSeriesMgt.GetNextNo(Rec."No. Series", Rec."Posting Date");

        SalesInvLine.SetRange("Document No.", Rec."No.");
        SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
        if SalesInvLine.Find('-') then begin
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
                GateRegister."Document Type" := GateRegister."document type"::"Sales Invoice";
                GateRegister."Document No." := Rec."No.";
                GateRegister.NRGP := false;
                GateRegister."Document Line No." := SalesInvLine."Line No.";
                GateRegister."Party Type" := GateRegister."party type"::Customer;
                GateRegister."Party No." := Rec."Sell-to Customer No.";
                GateRegister."Party Name" := Rec."Sell-to Customer Name";
                GateRegister."User ID" := UserId;
                GateRegister.Remarks := Rec."Gate Out Remarks";
                GateRegister.Type := GateRegister.Type::Item;
                GateRegister."No." := SalesInvLine."No.";
                GateRegister.Description := SalesInvLine.Description;
                GateRegister."Unit of Measure Code" := SalesInvLine."Unit of Measure Code";
                GateRegister.Quantity := SalesInvLine.Quantity;
                GateRegister."Vechile No." := Rec."Vehicle No1";
                GateRegister."Responsibility Center" := Rec."Responsibility Center";
                GateRegister.Insert;
            until SalesInvLine.Next = 0;
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

    local procedure VehicleNoOnFormat()
    begin
        "Vehicle NoEditable" := not Rec."Gate Out Posted";
    end;
}
