Codeunit 50014 CreateGenJnlEmpPayroll
{
    trigger OnRun()
    begin
        if UserSetup.Get(UserId) then if not UserSetup."HRMS Permission" = true then Error('You do not have permission to access this action');
        CreateGenJnlEmpPayroll();
        Message(Format(countrecord) + ' ' + 'Voucher Lines Inserted');
        //CreateGenJnlEmpClaim();
    end;

    var //NoSeriesMgt1: Codeunit NoSeriesManagement; //IG_DS_Before
        NoSeriesMgt1: Codeunit "No. Series";
        NextNo: Code[20];
        NextNo1: Code[20];
        LineNo: Integer;
        DefaultDim: Record "Default Dimension";
        Recemp: Record Employee;
        DimValue2: Record "Dimension Value";
        cuDimMangmnt: Codeunit DimensionManagement;
        DimSetID2: Integer;
        DefaultDimPage: Page "Edit Dimension Set Entries";
        year: Integer;
        TempDim: Record "Dimension Set Entry";
        Templatename: Text;
        BatchName: Text;
        emploc: Text;
        Window: Dialog;
        countrecord: Integer;
        UserSetup: Record "User Setup";

    procedure CreateGenJnlEmpPayroll()
    var
        GenJournalLine: Record "Gen. Journal Line";
        PayrollandClaimSetup: Record "SSD Payroll Setup";
        DimensionValue: Record "Dimension Value";
        DimensionSetEntry: Record "Dimension Set Entry" temporary;
        EmpCode: Code[20];
        genjourBatch1: Record "Gen. Journal Batch";
        InsGenJL: Record "Gen. Journal Line";
        SalaryUplodeStaging: Record "SSD Salary Upload Staging";
        RecComp: Record "Company Information";
    begin
        LineNo := 10000;
        countrecord := 0;
        emploc := '';
        SalaryUplodeStaging.Reset;
        SalaryUplodeStaging.SetCurrentkey("Emp Location");
        SalaryUplodeStaging.SetRange(Status, SalaryUplodeStaging.Status::Open);
        if SalaryUplodeStaging.FindSet then
            repeat
                if EmpCode <> SalaryUplodeStaging."Employee Code" then begin
                    RecComp.Get;
                    Recemp.Reset;
                    Recemp.SetRange("No.", SalaryUplodeStaging."Employee Code");
                    Recemp.FindFirst;
                    CreateDimension(Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    if RecComp.Name = 'VYTALS WELLBEING INDIA PRIVATE LIMITED' then
                        DimSetID2 := GetDimensions(Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code", Recemp."Business Segment")
                    else
                        DimSetID2 := GetDimensions(Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code", '');
                    if (SalaryUplodeStaging."Emp Location" = SalaryUplodeStaging."emp location"::Corporate) then begin
                        Templatename := 'GENERAL';
                        BatchName := 'PAYROLL';
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", Templatename);
                        GenJournalLine.SetRange("Journal Batch Name", BatchName);
                        if GenJournalLine.FindLast then LineNo := LineNo + 10000;
                        genjourBatch1.Reset();
                        genjourBatch1.SetRange("Journal Template Name", Templatename);
                        genjourBatch1.SetRange(Name, BatchName);
                        if genjourBatch1.FindFirst() then begin
                            if NextNo = '' then begin
                                Clear(NoSeriesMgt1);
                                NextNo := NoSeriesMgt1.GetNextNo(genjourBatch1."No. Series", 0D, false);
                            end;
                        end;
                        //ELSE
                        // LineNo := 10000;
                    end;
                    if SalaryUplodeStaging."Emp Location" = SalaryUplodeStaging."emp location"::Plant then begin
                        if emploc <> Format(SalaryUplodeStaging."Emp Location") then LineNo := 10000;
                        Templatename := 'GENERAL';
                        BatchName := 'WAGES';
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", Templatename);
                        GenJournalLine.SetRange("Journal Batch Name", BatchName);
                        if GenJournalLine.FindLast then LineNo := LineNo + 10000;
                        genjourBatch1.Reset();
                        genjourBatch1.SetRange("Journal Template Name", Templatename);
                        genjourBatch1.SetRange(Name, BatchName);
                        if genjourBatch1.FindFirst() then begin
                            if NextNo1 = '' then begin
                                Clear(NoSeriesMgt1);
                                NextNo1 := NoSeriesMgt1.GetNextNo(genjourBatch1."No. Series", 0D, false);
                            end;
                        end;
                        // ELSE
                        //  LineNo := 10000;
                    end;
                    /*
                                        if emploc <> Format(SalaryUplodeStaging."Emp Location") then begin
                                            genjourBatch1.SetRange("Journal Template Name", Templatename);
                                            genjourBatch1.SetRange(Name, BatchName);
                                            if genjourBatch1.FindFirst() then begin
                                                //NoSeriesMgt1.SetPayrollNumSeries(true);
                                                NextNo := NoSeriesMgt1.GetNextNo(genjourBatch1."No. Series", 0D, false);
                                            end;
                                        end;
                                        */
                    emploc := Format(SalaryUplodeStaging."Emp Location");
                    if ((SalaryUplodeStaging.FieldCaption("NET PAY") = 'NET PAY') and (SalaryUplodeStaging."NET PAY" <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption("NET PAY"), SalaryUplodeStaging."NET PAY", SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption(Basic) = 'Basic') and (SalaryUplodeStaging.Basic <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption(Basic), SalaryUplodeStaging.Basic, SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption(HRA) = 'HRA') and (SalaryUplodeStaging.HRA <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption(HRA), SalaryUplodeStaging.HRA, SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption(LTA) = 'LTA') and (SalaryUplodeStaging.LTA <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption(LTA), SalaryUplodeStaging.LTA, SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption("SPL ALLOW") = 'SPL ALLOW') and (SalaryUplodeStaging."SPL ALLOW" <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption("SPL ALLOW"), SalaryUplodeStaging."SPL ALLOW", SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption("DVR REIM") = 'DVR REIM') and (SalaryUplodeStaging."DVR REIM" <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption("DVR REIM"), SalaryUplodeStaging."DVR REIM", SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption("Veh REIM") = 'Veh REIM') and (SalaryUplodeStaging."Veh REIM" <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption("Veh REIM"), SalaryUplodeStaging."Veh REIM", SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption("Fuel REIM") = 'Fuel REIM') and (SalaryUplodeStaging."Fuel REIM" <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption("Fuel REIM"), SalaryUplodeStaging."Fuel REIM", SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption("GWA OT") = 'GWA OT') and (SalaryUplodeStaging."GWA OT" <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption("GWA OT"), SalaryUplodeStaging."GWA OT", SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption("ATT Award") = 'ATT Award') and (SalaryUplodeStaging."ATT Award" <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption("ATT Award"), SalaryUplodeStaging."ATT Award", SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption("Other Earn") = 'Other Earn') and (SalaryUplodeStaging."Other Earn" <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption("Other Earn"), SalaryUplodeStaging."Other Earn", SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    //    IF ((SalaryUplodeStaging.FIELDCAPTION("Gross Earn") = 'Gross Earn')AND(SalaryUplodeStaging."Gross Earn"<>0)) THEN BEGIN
                    //       VoucherEntryForPayroll(SalaryUplodeStaging.FIELDCAPTION("Gross Earn"),SalaryUplodeStaging."Gross Earn",SalaryUplodeStaging);
                    //    END;
                    if ((SalaryUplodeStaging.FieldCaption(PF) = 'PF') and (SalaryUplodeStaging.PF <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption(PF), SalaryUplodeStaging.PF, SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code")
                    end;
                    if ((SalaryUplodeStaging.FieldCaption("VPF SAL") = 'VPF SAL') and (SalaryUplodeStaging."VPF SAL" <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption("VPF SAL"), SalaryUplodeStaging."VPF SAL", SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption(ESI) = 'ESI') and (SalaryUplodeStaging.ESI <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption(ESI), SalaryUplodeStaging.ESI, SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption(EECLWF) = 'EECLWF') and (SalaryUplodeStaging.EECLWF <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption(EECLWF), SalaryUplodeStaging.EECLWF, SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption(IT) = 'IT') and (SalaryUplodeStaging.IT <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption(IT), SalaryUplodeStaging.IT, SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption("SAL ADV") = 'SAL ADV') and (SalaryUplodeStaging."SAL ADV" <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption("SAL ADV"), SalaryUplodeStaging."SAL ADV", SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                    if ((SalaryUplodeStaging.FieldCaption("MEALS REC") = 'MEALS REC') and (SalaryUplodeStaging."MEALS REC" <> 0)) then begin
                        VoucherEntryForPayroll(SalaryUplodeStaging.FieldCaption("MEALS REC"), SalaryUplodeStaging."MEALS REC", SalaryUplodeStaging, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    end;
                end;
                SalaryUplodeStaging.Status := SalaryUplodeStaging.Status::Success;
                SalaryUplodeStaging.Modify;
                EmpCode := SalaryUplodeStaging."Employee Code";
            until SalaryUplodeStaging.Next = 0;
    end;

    local procedure VoucherEntryForPayroll(Component: Code[10]; Amt: Decimal; SalaryUplodeStaging: Record "SSD Salary Upload Staging"; DimsetID: Integer; GlobalDim1: Code[10]; EmpId: Code[10])
    var
        InsGenJournalLine: Record "Gen. Journal Line";
        PayrollandClaimSetup: Record "SSD Payroll Setup";
        Recemp: Record Employee;
        PayrollandClaimSetup1: Record "SSD Payroll Setup";
        DefaultDim: Record "Default Dimension";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        InsGenJournalLine.LockTable;
        InsGenJournalLine.Init;
        if ((SalaryUplodeStaging."Emp Location" = SalaryUplodeStaging."emp location"::Corporate) or (SalaryUplodeStaging."Emp Location" = SalaryUplodeStaging."emp location"::" ")) then begin
            InsGenJournalLine.Validate("Journal Template Name", 'GENERAL');
            InsGenJournalLine.Validate("Journal Batch Name", 'PAYROLL');
            InsGenJournalLine."Document No." := NextNo
        end
        else begin
            InsGenJournalLine.Validate("Journal Template Name", 'GENERAL');
            InsGenJournalLine.Validate("Journal Batch Name", 'WAGES');
            InsGenJournalLine."Document No." := NextNo1;
        end;
        InsGenJournalLine.Validate("Line No.", LineNo);
        // if ((SalaryUplodeStaging."Emp Location" = SalaryUplodeStaging."emp location"::Corporate) or (SalaryUplodeStaging."Emp Location" = SalaryUplodeStaging."emp location"::" ")) then
        //     InsGenJournalLine."Document No." := NextNo
        // else
        //     InsGenJournalLine."Document No." := NextNo1;
        InsGenJournalLine.Validate("Document Type", InsGenJournalLine."document type"::" ");
        InsGenJournalLine."Source Code" := 'GENJNL';
        Evaluate(year, CopyStr(Format(Date2dmy(Today, 3)), 3, 2));
        countrecord += 1;
        //         IF DATE2DMY(WORKDATE,2)=2 THEN
        //         InsGenJournalLine.VALIDATE("Posting Date",DMY2DATE(28,DATE2DMY(TODAY,2),22))
        //           ELSE
        //        InsGenJournalLine.VALIDATE("Posting Date",DMY2DATE(30,3,22));
        InsGenJournalLine.Validate("Posting Date", SalaryUplodeStaging."Posting Date");
        InsGenJournalLine.Validate("Account Type", InsGenJournalLine."account type"::"G/L Account");
        InsGenJournalLine.Validate("Bal. Account Type", InsGenJournalLine."bal. account type"::"G/L Account");
        PayrollandClaimSetup.Reset;
        PayrollandClaimSetup.SetRange("Pay Element", Component);
        PayrollandClaimSetup.SetRange("Emp Location", SalaryUplodeStaging."Emp Location");
        if PayrollandClaimSetup.FindFirst then begin
            InsGenJournalLine.Validate("Account No.", PayrollandClaimSetup."G/L Account No");
            if PayrollandClaimSetup."Debit/Credit" = PayrollandClaimSetup."debit/credit"::Debit then
                InsGenJournalLine.Validate("Debit Amount", Amt)
            else
                InsGenJournalLine.Validate("Credit Amount", Amt);
        end;
        PayrollandClaimSetup1.Reset;
        PayrollandClaimSetup1.SetRange("Pay Element", 'NET PAY');
        PayrollandClaimSetup.SetRange("Emp Location", SalaryUplodeStaging."Emp Location");
        //PayrollandClaimSetup1.SETRANGE("Shortcut Dimension 1 Code",SalaryUplodeStaging."Shortcut Dimension 1 Code");
        if PayrollandClaimSetup1.FindFirst then begin
            InsGenJournalLine.Validate("Bal. Account No.", PayrollandClaimSetup1."G/L Account No");
        end;
        InsGenJournalLine.Validate("Shortcut Dimension 1 Code", GlobalDim1);
        InsGenJournalLine.Validate("Dimension Set ID", DimsetID);
        LineNo += 10000;
        InsGenJournalLine.Insert();
    end;

    procedure CreateGenJnlEmpClaim()
    var
        GenJournalLine: Record "Gen. Journal Line";
        PayrollandClaimSetup: Record "SSD Payroll Setup";
        DimensionValue: Record "Dimension Value";
        DimensionSetEntry: Record "Dimension Set Entry" temporary;
        ClaimID: Code[20];
        genjourBatch1: Record "Gen. Journal Batch";
        ClaimStaging: Record "SSD Claims Staging";
        TemptabClaiim: Record "SSD Claims Staging";
        Tempextype: Code[30];
        TempexCat: Code[30];
        Temp2: Record "SSD Claims Staging";
    begin
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
        GenJournalLine.SetRange("Journal Batch Name", 'CLAIM');
        if GenJournalLine.FindLast then
            LineNo := GenJournalLine."Line No." + 10000
        else
            LineNo := 10000;
        ClaimStaging.Reset;
        ClaimStaging.SetRange(Status, ClaimStaging.Status::Open);
        ClaimStaging.SetCurrentkey("Claims No.", "Expense Type", "Expense Category");
        if ClaimStaging.FindSet then
            repeat
                if ClaimID <> ClaimStaging."Claims No." then begin
                    Recemp.Reset;
                    Recemp.SetRange("No.", ClaimStaging."Employee Code");
                    Recemp.FindFirst;
                    genjourBatch1.Reset();
                    genjourBatch1.SetRange("Journal Template Name", 'GENERAL');
                    genjourBatch1.SetRange(Name, 'PAYROLL');
                    if genjourBatch1.FindFirst() then NextNo := NoSeriesMgt1.GetNextNo(genjourBatch1."No. Series", 0D, true);
                    TemptabClaiim.Reset;
                    TemptabClaiim.SetRange("Claims No.", ClaimID);
                    TemptabClaiim.SetRange(Status, TemptabClaiim.Status::Open);
                    TemptabClaiim.SetCurrentkey("Claims No.", "Expense Type", "Expense Category");
                    if TemptabClaiim.FindFirst then
                        repeat
                            if (Tempextype <> TemptabClaiim."Expense Type") and (TempexCat <> TemptabClaiim."Expense Category") then VoucherEntryforClaim(TemptabClaiim."Expense Type", TemptabClaiim."Expense Category", TemptabClaiim."Expense Amount", ClaimStaging, DimSetID2, TemptabClaiim."Shortcut Dimension 1 Code", Recemp."Global Dimension 1 Code");
                            Temp2.Reset;
                            Temp2.SetRange("Claims No.", TemptabClaiim."Claims No.");
                            Temp2.SetRange("Expense Type", TemptabClaiim."Expense Type");
                            Temp2.SetRange("Expense Category", TemptabClaiim."Expense Category");
                            if Temp2.FindFirst then
                                repeat
                                    Temp2.Status := Temp2.Status::Success;
                                    Temp2.Modify;
                                until Temp2.Next = 0;
                            Tempextype := TemptabClaiim."Expense Type";
                            TempexCat := TemptabClaiim."Expense Category";
                        until TemptabClaiim.Next = 0;
                end;
                ClaimID := ClaimStaging."Claims No.";
            until ClaimStaging.Next = 0;
    end;

    local procedure VoucherEntryforClaim(Component: Code[20]; comp2: Code[20]; Amt: Decimal; ClaimStaging: Record "SSD Claims Staging"; DimsetID: Integer; GlobalDim1: Code[10]; EmpId: Code[20])
    var
        InsGenJournalLine: Record "Gen. Journal Line";
        PayrollandClaimSetup: Record "SSD Claim Setup";
        Recemp: Record Employee;
        PayrollandClaimSetup1: Record "SSD Claim Setup";
        DefaultDim: Record "Default Dimension";
        TempDimSetEntry: Record "Dimension Set Entry";
    begin
        InsGenJournalLine.LockTable;
        InsGenJournalLine.Init;
        InsGenJournalLine.Validate("Journal Template Name", 'GENERAL');
        InsGenJournalLine.Validate("Journal Batch Name", 'CLAIM');
        InsGenJournalLine.Validate("Line No.", LineNo);
        InsGenJournalLine."Document No." := NextNo;
        InsGenJournalLine.Validate("Document Type", InsGenJournalLine."document type"::" ");
        InsGenJournalLine."Source Code" := 'GENJNL';
        InsGenJournalLine.Validate("Posting Date", ClaimStaging."Posting Date");
        InsGenJournalLine.Validate("Account Type", InsGenJournalLine."account type"::"G/L Account");
        InsGenJournalLine.Validate("Bal. Account Type", InsGenJournalLine."bal. account type"::"G/L Account");
        PayrollandClaimSetup.Reset;
        PayrollandClaimSetup.SetRange("Expense Type", Component);
        PayrollandClaimSetup.SetRange("Expense Category", comp2);
        PayrollandClaimSetup.SetRange("Shortcut Dimension 1 Code", ClaimStaging."Shortcut Dimension 1 Code");
        if PayrollandClaimSetup.FindFirst then begin
            InsGenJournalLine.Validate("Account No.", PayrollandClaimSetup."G/L Account No");
            if PayrollandClaimSetup."Debit/Credit" = PayrollandClaimSetup."debit/credit"::Debit then
                InsGenJournalLine.Validate("Debit Amount", Amt)
            else
                InsGenJournalLine.Validate("Credit Amount", Amt);
        end;
        PayrollandClaimSetup1.Reset;
        PayrollandClaimSetup1.SetRange("Expense Type", 'EXPENSE PAYABLE');
        PayrollandClaimSetup1.SetRange("Shortcut Dimension 1 Code", ClaimStaging."Shortcut Dimension 1 Code");
        if PayrollandClaimSetup1.FindFirst then begin
            InsGenJournalLine.Validate("Bal. Account No.", PayrollandClaimSetup1."G/L Account No");
        end;
        CreateDimension(GlobalDim1, EmpId);
        DimsetID := GetDimensions(GlobalDim1, EmpId, '');
        InsGenJournalLine.Validate("Dimension Set ID", DimsetID);
        LineNo += 10000;
        InsGenJournalLine.Insert();
        InsGenJournalLine.Validate("Shortcut Dimension 1 Code", GlobalDim1);
        //   InsGenJournalLine."Dimension Set ID":=DimsetID;
        //   InsGenJournalLine.MODIFY;
        //
    end;

    local procedure GetDimensions(Dim1: Code[20]; DIm2: Code[20]; Dim3: Code[20]) DimensionSetId: Integer
    var
        DimensionBuffer: Record "Dimension Buffer";
        cuDimensionBufferManagement: Codeunit "Dimension Buffer Management";
        cuDimMangmnt: Codeunit DimensionManagement;
        DimSetid: Integer;
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimValue: Record "Dimension Value";
        RecDefautDim: Record "Default Dimension";
        RecGlSEtup: Record "General Ledger Setup";
        Dimid: Integer;
        Dimid2: Integer;
    begin
        TempDimSetEntry.Reset();
        if Dim1 <> '' then begin
            RecGlSEtup.Get();
            DimValue.Get(RecGlSEtup."Global Dimension 1 Code", Dim1);
            Evaluate(Dimid2, Dim1);
            TempDimSetEntry.Reset;
            TempDimSetEntry.Init;
            TempDimSetEntry.Validate("Dimension Code", RecGlSEtup."Global Dimension 1 Code");
            TempDimSetEntry.Validate("Dimension Value Code", DimValue.Code);
            TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
            TempDimSetEntry.Insert;
            // TempDimSetEntry.MODIFY;
        end;
        if DIm2 <> '' then begin
            RecGlSEtup.Get();
            DimValue2.Get(RecGlSEtup."Shortcut Dimension 4 Code", DIm2);
            Evaluate(Dimid2, DIm2);
            TempDimSetEntry.Reset;
            TempDimSetEntry.Init;
            TempDimSetEntry.Validate("Dimension Code", RecGlSEtup."Shortcut Dimension 4 Code");
            TempDimSetEntry.Validate("Dimension Value Code", DimValue2.Code);
            TempDimSetEntry."Dimension Value ID" := DimValue2."Dimension Value ID";
            TempDimSetEntry.Insert;
            // TempDimSetEntry.MODIFY;
        end;
        if Dim3 <> '' then begin
            RecGlSEtup.Get();
            DimValue2.Get('BUSINESS SEGMENT', Dim3);
            TempDimSetEntry.Reset;
            TempDimSetEntry.Init;
            TempDimSetEntry.Validate("Dimension Code", 'BUSINESS SEGMENT');
            TempDimSetEntry.Validate("Dimension Value Code", Dim3);
            TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
            TempDimSetEntry.Insert;
        end;
        exit(cuDimMangmnt.GetDimensionSetID(TempDimSetEntry));
    end;

    local procedure CreateDimension(Dimension1: Code[20]; Dimension2: Code[20])
    var
        Dvalue: Record "Dimension Value";
        GL_Setup: Record "General Ledger Setup";
    begin
        GL_Setup.Get;
        if not Dvalue.Get(GL_Setup."Global Dimension 1 Code", Dimension1) then begin
            Dvalue.Init;
            Dvalue."Dimension Code" := GL_Setup."Global Dimension 1 Code";
            Dvalue.Code := Dimension1;
            Dvalue.Name := Dimension1;
            Dvalue.Insert;
        end;
        if not Dvalue.Get(GL_Setup."Shortcut Dimension 4 Code", Dimension2) then begin
            Dvalue.Init;
            Dvalue."Dimension Code" := GL_Setup."Shortcut Dimension 4 Code";
            Dvalue.Code := Dimension2;
            Dvalue.Name := Dimension2;
            Dvalue.Insert;
        end;
    end;

    procedure EmployeeContribution()
    var
        EmpContribution: Record "SSD Employee Contribution";
        EmpCode: Code[20];
        genjourBatch1: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        RecComp: Record "Company Information";
    begin
        LineNo := 10000;
        countrecord := 0;
        emploc := '';
        EmpContribution.Reset;
        //EmpContribution.SETCURRENTKEY("Emp Location");
        EmpContribution.SetRange(Status, EmpContribution.Status::Open);
        if EmpContribution.FindSet then
            repeat
                if EmpCode <> EmpContribution."Employee Code" then begin
                    if EmpContribution."PF Admin Charges" = 0 then begin
                        Recemp.Reset;
                        Recemp.SetRange("No.", EmpContribution."Employee Code");
                        Recemp.FindFirst;
                    end;
                    RecComp.Get;
                    CreateDimension(Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                    if RecComp.Name = 'VYTALS WELLBEING INDIA PRIVATE LIMITED' then
                        DimSetID2 := GetDimensions(Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code", Recemp."Business Segment")
                    else
                        DimSetID2 := GetDimensions(Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code", '');
                    genjourBatch1.Reset();
                    Templatename := 'GENERAL';
                    BatchName := 'PAYROLL';
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", Templatename);
                    GenJournalLine.SetRange("Journal Batch Name", BatchName);
                    if GenJournalLine.FindLast then LineNo := LineNo + 10000;
                    //ELSE
                    // LineNo := 10000;
                end;
                if emploc <> Format(EmpContribution."Emp Location") then begin
                    genjourBatch1.SetRange("Journal Template Name", Templatename);
                    genjourBatch1.SetRange(Name, BatchName);
                    if genjourBatch1.FindFirst() then begin
                        if NextNo = '' then NextNo := NoSeriesMgt1.GetNextNo(genjourBatch1."No. Series", 0D, false);
                    end;
                end;
                //  emploc:=FORMAT(EmpContribution."Emp Location");
                if ((EmpContribution.FieldCaption("PF EmpCon") = 'PF EmpCon') and (EmpContribution."PF EmpCon" <> 0)) then begin
                    VoucherEntryForEmpContribution(EmpContribution.FieldCaption("PF EmpCon"), EmpContribution."PF EmpCon", EmpContribution, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                end;
                if ((EmpContribution.FieldCaption("ESI EmpCon") = 'ESI EmpCon') and (EmpContribution."ESI EmpCon" <> 0)) then begin
                    VoucherEntryForEmpContribution(EmpContribution.FieldCaption("ESI EmpCon"), EmpContribution."ESI EmpCon", EmpContribution, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                end;
                if ((EmpContribution.FieldCaption("LWF EmpCon") = 'LWF EmpCon') and (EmpContribution."LWF EmpCon" <> 0)) then begin
                    VoucherEntryForEmpContribution(EmpContribution.FieldCaption("LWF EmpCon"), EmpContribution."LWF EmpCon", EmpContribution, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                end;
                if ((EmpContribution.FieldCaption("NPS EmpCon") = 'NPS EmpCon') and (EmpContribution."NPS EmpCon" <> 0)) then begin
                    VoucherEntryForEmpContribution(EmpContribution.FieldCaption("NPS EmpCon"), EmpContribution."NPS EmpCon", EmpContribution, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                end;
                if ((EmpContribution.FieldCaption("PF Admin Charges") = 'PF Admin Charges') and (EmpContribution."PF Admin Charges" <> 0)) then begin
                    VoucherEntryForEmpContribution(EmpContribution.FieldCaption("PF Admin Charges"), EmpContribution."PF Admin Charges", EmpContribution, DimSetID2, Recemp."Global Dimension 1 Code", Recemp."Employee Dimension Code");
                end;
                EmpContribution.Status := EmpContribution.Status::Success;
                EmpContribution.Modify;
                EmpCode := EmpContribution."Employee Code";
            until EmpContribution.Next = 0;
    end;

    local procedure VoucherEntryForEmpContribution(Component: Code[20]; Amt: Decimal; EmpContribution: Record "SSD Employee Contribution"; DimsetID: Integer; GlobalDim1: Code[10]; EmpId: Code[10])
    var
        InsGenJournalLine: Record "Gen. Journal Line";
        PayrollandClaimSetup: Record "SSD Payroll Setup";
        Recemp: Record Employee;
        PayrollandClaimSetup1: Record "SSD Payroll Setup";
        DefaultDim: Record "Default Dimension";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        InsGenJournalLine.LockTable;
        InsGenJournalLine.Init;
        InsGenJournalLine.Validate("Journal Template Name", 'GENERAL');
        InsGenJournalLine.Validate("Journal Batch Name", 'PAYROLL');
        InsGenJournalLine.Validate("Line No.", LineNo);
        InsGenJournalLine."Document No." := NextNo;
        InsGenJournalLine.Validate("Document Type", InsGenJournalLine."document type"::" ");
        InsGenJournalLine."Source Code" := 'GENJNL';
        Evaluate(year, CopyStr(Format(Date2dmy(Today, 3)), 3, 2));
        countrecord += 1;
        InsGenJournalLine.Validate("Posting Date", EmpContribution."Posting Date");
        InsGenJournalLine.Validate("Account Type", InsGenJournalLine."account type"::"G/L Account");
        InsGenJournalLine.Validate("Bal. Account Type", InsGenJournalLine."bal. account type"::"G/L Account");
        PayrollandClaimSetup.Reset;
        PayrollandClaimSetup.SetRange("Pay Element", Component);
        PayrollandClaimSetup.SetRange("Emp Location", EmpContribution."Emp Location");
        if PayrollandClaimSetup.FindFirst then begin
            InsGenJournalLine.Validate("Account No.", PayrollandClaimSetup."G/L Account No");
            InsGenJournalLine.Validate("Bal. Account No.", PayrollandClaimSetup."Emp Contribution");
            if PayrollandClaimSetup."Debit/Credit" = PayrollandClaimSetup."debit/credit"::Debit then
                InsGenJournalLine.Validate("Debit Amount", Amt)
            else
                InsGenJournalLine.Validate("Credit Amount", Amt);
        end;
        InsGenJournalLine.Validate("Shortcut Dimension 1 Code", GlobalDim1);
        InsGenJournalLine.Validate("Dimension Set ID", DimsetID);
        LineNo += 10000;
        InsGenJournalLine.Insert();
    end;
}
