TableExtension 50024 "SSD Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        modify(Description)
        {
        trigger OnAfterValidate()
        begin
            "Check Name":=Description;
        end;
        }
        modify(Amount)
        {
        trigger OnAfterValidate()
        var
            PurchHeader: Record "Purchase Header";
            PurchL: Record "Purchase Line";
            AmttoVendor: decimal;
        begin
            if("Journal Template Name" = '') and ("Journal Batch Name" = '')then exit;
            if "PO No." <> '' then begin
                IF PurchHeader.GET(PurchHeader."Document Type"::Order, "PO No.")THEN PurchHeader.CALCFIELDS("Advance Payment Amount");
                PurchL.RESET();
                PurchL.SETRANGE("Document Type", PurchL."Document Type"::Order);
                PurchL.SETRANGE("Document No.", "PO No.");
                IF PurchL.FINDFIRST()THEN AmttoVendor:=0;
                REPEAT AmttoVendor+=PurchL."Amount";
                UNTIL PurchL.NEXT() = 0;
                TESTFIELD(Amount, AmttoVendor - PurchHeader."Advance Payment Amount");
            end;
            UserSetup.Get(UserId);
            GeneralLedgerSetup.Get();
            IF(GeneralLedgerSetup."Maximum Cash Receipt Limit" <> 0) AND ("Source Code" = 'CASHRCPTV')THEN CheckCashRcptLimit("Document No.", GeneralLedgerSetup."Maximum Cash Receipt Limit");
            IF(GeneralLedgerSetup."Maximum Cash Payment Limit" <> 0) AND ("Source Code" = 'CASHPYMTV')THEN CheckCashPmtLimit("Document No.", GeneralLedgerSetup."Maximum Cash Payment Limit");
        end;
        }
        modify("Applies-to Doc. No.")
        {
        trigger OnAfterValidate()
        begin
            IF("Document Type" = "Document Type"::" ") AND ("Recurring Method" <> "Recurring Method"::" ")THEN BEGIN
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                IF CustLedgerEntry.FINDFIRST THEN VALIDATE("Dimension Set ID", CustLedgerEntry."Dimension Set ID");
            END;
        end;
        }
        field(50000; "Line Narration"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Line Narration';
        }
        field(50001; "Responsibility Center"; Code[20])
        {
            Description = 'MSI.RC';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50002; "User ID"; Code[20])
        {
            Description = 'Alle VPB';
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(50057; "Suplementary Invoice"; Boolean)
        {
            Description = 'CF001.02 ->';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Suplementary Invoice';
        }
        field(50058; "Vendor Creditor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Creditor No.';
        }
        field(50059; "Preffered Bank Account"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Preffered Bank Account';
        }
        field(60008; "Excise Payment"; Option)
        {
            Description = 'CE_MT003';
            OptionCaption = ' ,Payment,Interest,Other';
            OptionMembers = " ", Payment, Interest, Other;
            DataClassification = CustomerContent;
            Caption = 'Excise Payment';
        }
        field(70001; "Check Name"; Text[100])
        {
            Description = 'CE_AA007.07';
            DataClassification = CustomerContent;
            Caption = 'Check Name';
        }
        field(70002; "Created By Data Import"; Boolean)
        {
            Description = 'CML-005';
            DataClassification = CustomerContent;
            Caption = 'Created By Data Import';
        }
        field(70003; "Delivery Challan No."; Code[20])
        {
            Description = 'CML-009';
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan No.';

            trigger OnValidate()
            var
                DeliveryChallanHeader: Record "Delivery Challan Header";
                NoOfDays: Integer;
            begin
                // CML-009 Start
                if "Delivery Challan No." <> '' then begin
                    if DeliveryChallanHeader.Get("Delivery Challan No.")then begin
                        NoOfDays:=WorkDate - DeliveryChallanHeader."Posting Date";
                        if NoOfDays < 180 then begin
                            if Confirm(Text50000, true, NoOfDays)then begin
                                Validate("Bal. Account Type", "bal. account type"::Vendor);
                                Validate("Bal. Account No.", DeliveryChallanHeader."Vendor No.");
                                Modify;
                            end
                            else
                            begin
                                "Delivery Challan No.":='';
                                Validate("Bal. Account Type", "bal. account type"::"G/L Account");
                                Validate("Bal. Account No.", '');
                                Modify;
                            end;
                        end
                        else
                        begin
                            Validate("Bal. Account Type", "bal. account type"::Vendor);
                            Validate("Bal. Account No.", DeliveryChallanHeader."Vendor No.");
                            Modify;
                        end;
                    end;
                end
                else
                begin
                    Validate("Bal. Account Type", "bal. account type"::"G/L Account");
                    Validate("Bal. Account No.", '');
                    Modify;
                end;
            // CML-009 Finish
            end;
        }
        field(75000; "PO No."; Code[20])
        {
            Description = 'ALLE 2.16';
            DataClassification = CustomerContent;
            Caption = 'PO No.';

            trigger OnLookup()
            begin
                //ALLE 2.16
                if("Source Code" = 'BANKPYMTV') and ("Account Type" = "account type"::Vendor) and (Amount <> 0)then begin
                    TestField(Amount);
                    PurchaseHeader.Reset;
                    PurchaseHeader.SetRange("Document Type", PurchaseHeader."document type"::Order);
                    PurchaseHeader.SetRange("Buy-from Vendor No.", "Account No.");
                    if PurchaseHeader.FindFirst then repeat PurchaseLine.Reset;
                            PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
                            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                            if PurchaseLine.FindFirst then AmttoVendor:=0;
                            repeat AmttoVendor+=PurchaseLine."Amount";
                            until PurchaseLine.Next = 0;
                            PurchaseHeader.CalcFields("Advance Payment Amount");
                            if(PurchaseHeader."Advance Payment Amount" < AmttoVendor)then PurchaseHeader.Mark(true);
                        until PurchaseHeader.Next = 0;
                    PurchaseHeader.MarkedOnly(true);
                    if Page.RunModal(Page::"Purchase List", PurchaseHeader, PurchaseHeader."No.") = Action::LookupOK then Validate("PO No.", PurchaseHeader."No.");
                end;
            end;
            trigger OnValidate()
            begin
                if PurchaseHeader.Get(PurchaseHeader."document type"::Order, "PO No.")then PurchaseHeader.CalcFields("Advance Payment Amount");
                PurchaseLine.Reset;
                PurchaseLine.SetRange("Document Type", PurchaseLine."document type"::Order);
                PurchaseLine.SetRange("Document No.", "PO No.");
                if PurchaseLine.FindFirst then AmttoVendor:=0;
                repeat AmttoVendor+=PurchaseLine."Amount";
                until PurchaseLine.Next = 0;
                Validate(Amount, AmttoVendor - PurchaseHeader."Advance Payment Amount");
            end;
        }
        field(75001; "Transfer Type"; Option)
        {
            Description = 'ALLE 2.15';
            OptionMembers = " ", NEFT, RTGS;
            DataClassification = CustomerContent;
            Caption = 'Transfer Type';
        }
        field(75002; "Vendor Bank Account"; Code[10])
        {
            Description = 'ALLE 2.15';
            TableRelation = if("Account Type"=filter(Vendor), "Transfer Type"=filter(NEFT|RTGS))"Vendor Bank Account".Code where("Vendor No."=field("Account No."));
            DataClassification = CustomerContent;
            Caption = 'Vendor Bank Account';
        }
        field(75003; "NEFT / RTGS Code"; Code[20])
        {
            Description = 'ALLE 2.15';
            DataClassification = CustomerContent;
            Caption = 'NEFT / RTGS Code';
        }
    }
    trigger OnAfterInsert()
    begin
        "User ID":=UserId;
    end;
    /// <summary>
    /// CheckCashRcptLimit.
    /// </summary>
    /// <param name="DocNo">Code[20].</param>
    /// <param name="CashRcptLimit">VAR Decimal.</param>
    procedure CheckCashRcptLimit(DocNo: Code[20]; var CashRcptLimit: Decimal)
    var
        GenJnlLineRec: Record "Gen. Journal Line";
        CashRcptAmt: Decimal;
    begin
        GenJnlLineRec.Reset;
        GenJnlLineRec.SetCurrentkey("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
        GenJnlLineRec.SetRange("Journal Template Name", "Journal Template Name");
        GenJnlLineRec.SetRange("Journal Batch Name", "Journal Batch Name");
        GenJnlLineRec.SetRange("Document No.", DocNo);
        GenJnlLineRec.SetFilter("Line No.", '<>%1', "Line No.");
        if Amount > 0 then GenJnlLineRec.SetFilter(Amount, '>%1', 0)
        else
            GenJnlLineRec.SetFilter(Amount, '<%1', 0);
        if GenJnlLineRec.FindFirst then CashRcptAmt:=0;
        repeat CashRcptAmt+=Abs(GenJnlLineRec.Amount);
        until GenJnlLineRec.Next = 0;
        if(CashRcptAmt + Abs(Amount)) > CashRcptLimit then Error('You Cannot Enter More Than %1 in Document No = %2 as the Maximum Cash Receipt Limit is %3', (CashRcptLimit - CashRcptAmt), "Document No.", CashRcptLimit);
    end;
    /// <summary>
    /// CheckCashPmtLimit.
    /// </summary>
    /// <param name="DocNo">Code[20].</param>
    /// <param name="CashPmtLimit">Decimal.</param>
    procedure CheckCashPmtLimit(DocNo: Code[20]; CashPmtLimit: Decimal)
    var
        GenJnlLineRec: Record "Gen. Journal Line";
        CashPmtAmt: Decimal;
    begin
        GenJnlLineRec.Reset;
        GenJnlLineRec.SetCurrentkey("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
        GenJnlLineRec.SetRange("Journal Template Name", "Journal Template Name");
        GenJnlLineRec.SetRange("Journal Batch Name", "Journal Batch Name");
        GenJnlLineRec.SetRange("Document No.", DocNo);
        GenJnlLineRec.SetFilter("Line No.", '<>%1', "Line No.");
        if Amount > 0 then GenJnlLineRec.SetFilter(Amount, '>%1', 0)
        else
            GenJnlLineRec.SetFilter(Amount, '<%1', 0);
        if GenJnlLineRec.FindFirst then CashPmtAmt:=0;
        repeat CashPmtAmt+=Abs(GenJnlLineRec.Amount);
        until GenJnlLineRec.Next = 0;
        if(CashPmtAmt + Abs(Amount)) > CashPmtLimit then Error('You Cannot Enter More Than %1 in Document No = %2 as the Maximum Cash Receipt Limit is %3', (CashPmtLimit - CashPmtAmt), "Document No.", CashPmtLimit);
    end;
    var UserSetup: Record "User Setup";
    GeneralLedgerSetup: Record "General Ledger Setup";
    CustLedgerEntry: Record "Cust. Ledger Entry";
    PurchaseHeader: Record "Purchase Header";
    PurchaseLine: Record "Purchase Line";
    Text50000: label 'Delivery challan is %1 days old, Do you want to continue?';
    AmttoVendor: Decimal;
}
