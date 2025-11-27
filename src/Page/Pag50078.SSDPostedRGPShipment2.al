Page 50078 "SSDPosted RGP Shipment2"
{
    // SM_PP001 13.07.2005 Reference to the "Posted GateOut Nos" changed to "Gate Out Nos"
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    Permissions = TableData "SSD RGP Shipment Header" = rimd;
    RefreshOnActivate = true;
    SourceTable = "SSD RGP Shipment Header";
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
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        Rec."Document Date" := Rec."Posting Date";
                    end;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if Rec."Party No." <> '' then begin
                            if Confirm('Do you want to change Party Type') then begin
                                Rec."Party No." := '';
                                Rec."Party Name" := '';
                                Rec."Party Address" := '';
                                Rec."Party Address 2" := '';
                                Rec."Party City" := '';
                                Rec."Party PostCode" := '';
                                Rec."Party State" := '';
                                Rec."Party Country" := '';
                            end
                            else
                                Rec."Party Type" := xRec."Party Type";
                        end;
                    end;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Lookup = false;
                }
                field("Party Name"; Rec."Party Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Party Address"; Rec."Party Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Party PostCode"; Rec."Party PostCode")
                {
                    ApplicationArea = All;
                    Caption = 'Party PostCode / City';
                    Editable = false;
                    Lookup = false;
                }
                field("Party City"; Rec."Party City")
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
                field("Delivery Mode"; Rec."Delivery Mode")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vehical No."; Rec."Vehical No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transporter No."; Rec."Transporter No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transporter Name"; Rec."Transporter Name")
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
                field("Gate Out No."; Rec."Gate Out No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(RGPShptLine; "Posted RGP Shipment Subform2")
            {
                SubPageLink = "Document No." = field("No.");
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
                    RGPShipHdr.Reset;
                    RGPShipHdr.Copy(Rec);
                    RGPShipHdr.SetRange(RGPShipHdr."No.", Rec."No.");
                    //RGPShipHdr.SETRANGE(RGPShipHdr."Party Type","Party Type");
                    RGPShipHdr.SetRange(RGPShipHdr."Party No.", Rec."Party No.");
                    //QtyOrdHdr.SETRANGE(QtyOrdHdr."Work Center No.",'QLT_WC');
                    Report.RunModal(50018, true, false, RGPShipHdr);
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
        if Rec."Gate Out Posted" then
            "Gate Out RemarksEditable" := false
        else
            "Gate Out RemarksEditable" := true;
        //CF001 St
        // if UserMgt.GetRespCenterFilter() <> '' then begin
        //     Rec.FilterGroup(2);
        //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
        //     Rec.FilterGroup(0);
        // end;
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
        UserMgt: Codeunit "SSD User Setup Management";
        RGPShipHdr: Record "SSD RGP Shipment Header";
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
        RGPShptLine: Record "SSD RGP Shipment Line";
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
        Rec."No. Series" := NoSeriesCode;
        GateOutNo := NoSeriesMgt.GetNextNo(Rec."No. Series", Rec."Posting Date");

        RGPShptLine.SetRange("Document No.", Rec."No.");
        if RGPShptLine.Find('-') then begin
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
                GateRegister."Document Type" := GateRegister."document type"::"RGP Outbound";
                GateRegister."Document No." := Rec."No.";
                GateRegister.NRGP := Rec.NRGP;
                GateRegister."Document Line No." := RGPShptLine."Line No.";
                GateRegister."Party Type" := Rec."Party Type";
                GateRegister."Party No." := Rec."Party No.";
                GateRegister."Party Name" := Rec."Party Name";
                GateRegister."User ID" := UserId;
                GateRegister.Remarks := Rec."Gate Out Remarks";
                GateRegister.Type := RGPShptLine.Type;
                GateRegister."No." := RGPShptLine."No.";
                GateRegister.Description := RGPShptLine.Description;
                GateRegister."Unit of Measure Code" := RGPShptLine."Unit Of Measure Code";
                GateRegister.Quantity := RGPShptLine.Quantity;
                GateRegister."Delivery Mode" := Rec."Delivery Mode";
                GateRegister."Transporter No." := Rec."Transporter No.";
                GateRegister."Transporter Name" := Rec."Transporter Name";
                GateRegister."Vechile No." := Rec."Vehical No.";
                GateRegister."Responsibility Center" := Rec."Responsibility Center";
                GateRegister.Insert;
            until RGPShptLine.Next = 0;
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
