Page 50088 "Cash Purchase"
{
    // SM_MUA01 2005.07.13 Responsibilty Center Pickes By Userid
    // SM_MUA34 2005.07.29 New Form
    PageType = Document;
    SourceTable = "SSD Gate Header";
    SourceTableView = sorting("No.")order(ascending)where("Ref. Document Type"=const("Cash Purchase"));
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
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(Rec)then CurrPage.Update;
                    end;
                }
                field("Party Type"; Rec."Party Type")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Subfrm.Page.DeleteGateLines(Rec);
                        PartyTypeOnAfterValidate;
                    end;
                }
                field("Party No."; Rec."Party No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Subfrm.Page.DeleteGateLines(Rec);
                        PartyNoOnAfterValidate;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("In Time"; Rec."In Time")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(RDT; Rec."Ref. Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Ref. Document Type';
                    Editable = false;
                    Enabled = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Subfrm.Page.DeleteGateLines(Rec);
                    end;
                }
                field("Ref. Document No."; Rec."Ref. Document No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Subfrm.Page.DeleteGateLines(Rec);
                        CurrPage.Subfrm.Page.InsertGateLines(Rec);
                        RefDocumentNoOnAfterValidate;
                    end;
                }
                field("ST38 No."; Rec."ST38 No.")
                {
                    ApplicationArea = All;
                }
                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = All;
                }
                field("Bill Date"; Rec."Bill Date")
                {
                    ApplicationArea = All;
                }
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ApplicationArea = All;
                }
                field("Excise Amount"; Rec."Excise Amount")
                {
                    ApplicationArea = All;
                }
                field("Sales Tax Amount"; Rec."Sales Tax Amount")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }
            }
            part(Subfrm; "Cash Purchase Subform")
            {
                SubPageLink = "Document No."=field("No."), "Ref. Document Type"=field("Ref. Document Type"), "Ref. Document No."=field("Ref. Document No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Post")
            {
                Caption = '&Post';

                action(Post)
                {
                    ApplicationArea = All;
                    Caption = '&Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        PostGateEntry(Rec);
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //SM_MUA01 Starts
        if UserSetup.Get(UserId)then Rec."Responsibility Center":=UserSetup."Responsibility Center";
        //SM_MUA01 Ends
        //>>SM_MUA34
        Rec."Party Type":=Rec."party type"::Employee;
        Rec."Ref. Document Type":=Rec."ref. document type"::"Cash Purchase";
    //<<SM_MUA34
    end;
    trigger OnOpenPage()
    begin
        //>>SM_MUA34
        Rec."Party Type":=Rec."party type"::Employee;
        Rec."Ref. Document Type":=Rec."ref. document type"::"Cash Purchase";
    //<<SM_MUA34
    //CF001 St
    // if UserMgt.GetRespCenterFilter <> '' then begin
    //     Rec.FilterGroup(2);
    //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
    //     Rec.FilterGroup(0);
    // end;
    //CF001 En
    end;
    var Text000: label 'Do you want to post the gate entry?';
    GateEntryLine: Record "SSD Gate Line";
    Text001: label 'is not within your range of allowed posting dates';
    AllowPostingFrom: Date;
    AllowPostingTo: Date;
    UserSetup: Record "User Setup";
    GLSetup: Record "General Ledger Setup";
    GateLine: Record "SSD Gate Line";
    PostedGateHeader: Record "SSD Posted Gate Header";
    PostedGateLine: Record "SSD Posted Gate Line";
    GateRegister: Record "SSD Gate Register";
    LastEntryNo: Integer;
    UserMgt: Codeunit "SSD User Setup Management";
    procedure PostGateEntry(var GateHeader: Record "SSD Gate Header")
    begin
        if not Confirm(Text000, false)then exit;
        CheckGateEntry(GateHeader);
        //Insert Posted Header
        PostedGateHeader.Init;
        PostedGateHeader.TransferFields(GateHeader);
        PostedGateHeader.Insert;
        //Insert Posted Lines
        GateLine.Reset;
        GateLine.SetRange("Document No.", GateHeader."No.");
        GateLine.Find('-');
        GateRegister.LockTable;
        if GateRegister.Find('+')then LastEntryNo:=GateRegister."Entry No."
        else
            LastEntryNo:=0;
        repeat PostedGateLine.Init;
            PostedGateLine.TransferFields(GateLine);
            PostedGateLine."Responsibility Center":=GateHeader."Responsibility Center";
            PostedGateLine.Insert;
            InsertGateRegister(GateLine, GateHeader); //Insert Gate Register
        until GateLine.Next = 0;
        GateLine.DeleteAll;
        GateHeader.Delete;
        Message('Gate Entry %1 has posted successfully', PostedGateHeader."No.");
    end;
    procedure CheckGateEntry(GateHeader: Record "SSD Gate Header")
    begin
        if DateNotAllowed(Rec."Posting Date")then Rec.FieldError("Posting Date", Text001);
        GateHeader.TestField("No.");
        GateHeader.TestField("Party No.");
        GateHeader.TestField("Bill No.");
        GateHeader.TestField("Bill Date");
        GateLine.SetRange("Document No.", GateHeader."No.");
        GateLine.SetRange("Challan Quantity", 0);
        GateLine.DeleteAll;
        GateLine.SetRange("Challan Quantity");
    /*
        IF NOT GateLine.FIND('-') THEN BEGIN
          ERROR('There is nothing to post')
        END
        */
    end;
    procedure DateNotAllowed(PostingDate: Date): Boolean begin
        if(AllowPostingFrom = 0D) and (AllowPostingTo = 0D)then begin
            if UserId <> '' then if UserSetup.Get(UserId)then begin
                    AllowPostingFrom:=UserSetup."Allow Posting From";
                    AllowPostingTo:=UserSetup."Allow Posting To";
                end;
            if(AllowPostingFrom = 0D) and (AllowPostingTo = 0D)then begin
                GLSetup.Get;
                AllowPostingFrom:=GLSetup."Allow Posting From";
                AllowPostingTo:=GLSetup."Allow Posting To";
            end;
            if AllowPostingTo = 0D then AllowPostingTo:=99991231D;
        end;
        exit((PostingDate < AllowPostingFrom) or (PostingDate > AllowPostingTo));
    end;
    procedure InsertGateRegister(GateLine: Record "SSD Gate Line"; GateHeader: Record "SSD Gate Header")
    begin
        LastEntryNo+=1;
        GateRegister.Init;
        GateRegister."Entry No.":=LastEntryNo;
        GateRegister."Gate Entry Type":=GateRegister."gate entry type"::Inbound;
        GateRegister."Gate Entry No.":=GateLine."Document No.";
        GateRegister."Gate Entry Date":=WorkDate;
        GateRegister."Gate Entry Time":=GateHeader."In Time";
        case GateLine."Ref. Document Type" of GateLine."ref. document type"::"Sales Returns": GateRegister."Document Type":=GateRegister."document type"::"Sales Return";
        GateLine."ref. document type"::"Purchase Order": GateRegister."Document Type":=GateRegister."document type"::"Purchase Order";
        GateLine."ref. document type"::"RGP Outbound": GateRegister."Document Type":=GateRegister."document type"::"RGP Outbound";
        GateLine."ref. document type"::"Cash Purchase": GateRegister."Document Type":=GateRegister."document type"::"Cash Purchase";
        end;
        GateRegister."Document No.":=GateLine."Ref. Document No.";
        GateRegister.NRGP:=false;
        GateRegister."Document Line No.":=GateLine."Line No.";
        GateRegister."Party Type":=GateLine."Party Type";
        GateRegister."Party No.":=GateLine."Party No.";
        GateRegister."Party Name":=GateHeader.Name;
        GateRegister."Challan/Bill No.":=GateHeader."Bill No.";
        GateRegister."Challan/Bill Date":=GateHeader."Bill Date";
        GateRegister."User ID":=UserId;
        GateRegister.Remarks:=GateHeader.Remarks;
        GateRegister.Type:=GateRegister.Type::Item;
        GateRegister."No.":=GateLine."No.";
        GateRegister.Quantity:=GateLine."Challan Quantity";
        GateRegister."Vechile No.":=GateHeader."Vehicle No.";
        GateRegister.Description:=GateLine.Description;
        GateRegister."Unit of Measure Code":=GateLine."Unit of Measure Code";
        GateRegister."Responsibility Center":=GateHeader."Responsibility Center";
        GateRegister.Insert;
    end;
    local procedure PartyTypeOnAfterValidate()
    begin
        CurrPage.Update;
    //CurrPage.Subfrm.FORM.UPDATECONTROLS; // BIS 1145
    end;
    local procedure PartyNoOnAfterValidate()
    begin
        CurrPage.Update;
    //CurrPage.Subfrm.FORM.UPDATECONTROLS; // BIS 1145
    end;
    local procedure RefDocumentNoOnAfterValidate()
    begin
        CurrPage.Update;
    //CurrPage.Subfrm.FORM.UPDATECONTROLS; // BIS 1145
    end;
}
