Report 50295 "Export HDFC Bank"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = sorting("Document No.", "Posting Date")where("Bal. Account Type"=filter(Vendor|"G/L Account"), "Source Code"=filter('BANKPYMTV'));
            RequestFilterFields = "Posting Date", "Bank Account No.";

            column(ReportForNavId_1170000000;1170000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if DocNo = "Bank Account Ledger Entry"."Document No." then CurrReport.Skip;
                if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."bal. account type"::Vendor then begin
                    if Vendor.Get("Bank Account Ledger Entry"."Bal. Account No.")then begin
                        if Vendor."Currency Code" <> '' then begin
                            DocNo:="Bank Account Ledger Entry"."Document No.";
                            CurrReport.Skip;
                        end;
                    end;
                end;
                if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."bal. account type"::Vendor then MakeExcelDataBody
                else
                    MakeExcelDataBodyGLAccount;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        ExcelBuf.DeleteAll();
        CreateHeader();
    end;
    trigger OnPostReport()
    begin
        CreateExcelBook();
    end;
    var ExportToExcel: Boolean;
    ExcelBuf: Record "Excel Buffer" temporary;
    TempExcelBuffer: Record "Excel Buffer" temporary;
    RowNo: Integer;
    PostedNarration: Record "Posted Narration";
    VLE: Record "Vendor Ledger Entry";
    VendorBankAccount: Record "Vendor Bank Account";
    BankAccount: Record "Bank Account";
    Vendor: Record Vendor;
    GLAccount: Record "G/L Account";
    GLEntry: Record "G/L Entry";
    DocNo: Code[20];
    DocNo2: Code[20];
    Amt: Decimal;
    BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    procedure CreateHeader()
    begin
        ExcelBuf.NewRow();
        //.. Allepr
        ExcelBuf.AddColumn('Document No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Vendor Code', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Vendor Name', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('External Document No.', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Client_Code', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Product_Code', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Payment_Type', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Payment_Date', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Dr_Ac_No', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Amount', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Bank_Code_Indicator', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Beneficiary_Code', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Beneficiary_Name', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Beneficiary_Bank', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Beneficiary_Bank/IFSC Code', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Beneficiary_Acc_No', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Beneficiary_Email', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Debit_Narration', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Credit_Narration', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
    // ..Allepr
    // ExcelBuf.AddColumn('ACCOUNT NO',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
    //ExcelBuf.AddColumn('DR/CR',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
    //ExcelBuf.AddColumn('AMOUNT',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
    //ExcelBuf.AddColumn('NARRATION',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
    //ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Document No."),FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
    //ExcelBuf.AddColumn(TempCustLedgEntry.FIELDCAPTION("Due Date"),FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
    end;
    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow();
        // >>Allepr
        Clear(VLE);
        VLE.Reset;
        VLE.SetRange("Document No.", "Bank Account Ledger Entry"."Document No.");
        VLE.SetRange("Document Type", "Bank Account Ledger Entry"."Document Type");
        if VLE.FindFirst then //ExcelBuf.NewRow;
            ExcelBuf.AddColumn(VLE."Document No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(VLE."Vendor No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        Vendor.SetRange("No.", VLE."Vendor No.");
        if Vendor.FindFirst then;
        ExcelBuf.AddColumn(Vendor.Name, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("Bank Account Ledger Entry"."External Document No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('ZAVENIR', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('VENPAY', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        if Abs("Bank Account Ledger Entry".Amount) < 200000 then ExcelBuf.AddColumn('NEFT', false, '', false, false, false, '', ExcelBuf."cell type"::Text)
        else
            ExcelBuf.AddColumn('RTGS', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        //ExcelBuf.AddColumn(VLE."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddColumn(VLE."Posting Date", false, '', false, false, false, '', ExcelBuf."cell type"::Date);
        BankAccount.Reset;
        BankAccount.SetRange("No.", VLE."Bal. Account No.");
        if BankAccount.FindFirst then ExcelBuf.AddColumn(BankAccount."Bank Account No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(Abs("Bank Account Ledger Entry".Amount), false, '', false, false, false, '', ExcelBuf."cell type"::Number);
        ExcelBuf.AddColumn('M', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        //ExcelBuf.AddColumn(VLE."Vendor No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        //VLE.RESET;
        //VLE.SETRANGE("Document No.","Bank Account Ledger Entry"."Document No.");
        //VendorBankAccount.SETRANGE("Vendor No.",VLE."Vendor No.");
        //IF VendorBankAccount.FINDFIRST THEN BEGIN
        if "Bank Account Ledger Entry"."Bal. Account Type" = "Bank Account Ledger Entry"."bal. account type"::Vendor then begin
            Clear(VendorBankAccount);
            VendorBankAccount.Reset;
            VendorBankAccount.SetRange("Vendor No.", "Bank Account Ledger Entry"."Bal. Account No.");
            if VendorBankAccount.FindFirst then begin
                if VendorBankAccount."Vendor No." <> '' then ExcelBuf.AddColumn(VendorBankAccount."Vendor No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text)
                else
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                if VendorBankAccount."Beneficiary Name" <> '' then ExcelBuf.AddColumn(VendorBankAccount."Beneficiary Name", false, '', false, false, false, '', ExcelBuf."cell type"::Text)
                else
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                if VendorBankAccount.Name <> '' then ExcelBuf.AddColumn(VendorBankAccount.Name, false, '', false, false, false, '', ExcelBuf."cell type"::Text)
                else
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                if VendorBankAccount."NEFT/RTGS Code" <> '' then ExcelBuf.AddColumn(VendorBankAccount."NEFT/RTGS Code", false, '', false, false, false, '', ExcelBuf."cell type"::Text)
                else
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                if VendorBankAccount."Bank Account No." <> '' then ExcelBuf.AddColumn(VendorBankAccount."Bank Account No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text)
                else
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                if Vendor."E-Mail" <> '' then ExcelBuf.AddColumn(Vendor."E-Mail", false, '', false, false, false, '', ExcelBuf."cell type"::Text)
                else
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                if VendorBankAccount."Beneficiary Name" <> '' then ExcelBuf.AddColumn(VendorBankAccount."Beneficiary Name", false, '', false, false, false, '', ExcelBuf."cell type"::Text)
                else
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                if Vendor.Name <> '' then ExcelBuf.AddColumn(Vendor.Name, false, '', false, false, false, '', ExcelBuf."cell type"::Text)
                else
                    ExcelBuf.AddColumn(Vendor.Name, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            end
            else
            begin
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                if Vendor."E-Mail" <> '' then ExcelBuf.AddColumn(Vendor."E-Mail", false, '', false, false, false, '', ExcelBuf."cell type"::Text)
                else
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
                if Vendor.Name <> '' then ExcelBuf.AddColumn(Vendor.Name, false, '', false, false, false, '', ExcelBuf."cell type"::Text)
                else
                    ExcelBuf.AddColumn(Vendor.Name, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            //
            end;
        end;
    //ExcelBuf.AddColumn(VLE."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
    //ExcelBuf.AddColumn("Bank Account Ledger Entry"."Bank Account No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
    //IF "Bank Account Ledger Entry"."Credit Amount" <> 0 THEN
    //ExcelBuf.AddColumn('Cr',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
    //ELSE
    // ExcelBuf.AddColumn('Dr',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
    //ExcelBuf.AddColumn(ABS("Bank Account Ledger Entry".Amount),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
    //PostedNarration.RESET;
    //PostedNarration.SETRANGE("Transaction No.","Bank Account Ledger Entry"."Transaction No.");
    //IF PostedNarration.FINDFIRST THEN
    // ExcelBuf.AddColumn(PostedNarration.Narration,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
    end;
    procedure MakeExcelDataBodyGLAccount()
    begin
        Amt:=0;
        if DocNo2 <> "Bank Account Ledger Entry"."Document No." then begin
            DocNo2:="Bank Account Ledger Entry"."Document No.";
            ExcelBuf.NewRow();
            // >>Allepr
            GLEntry.SetRange("Document No.", "Bank Account Ledger Entry"."Document No.");
            GLEntry.SetRange("Document Type", "Bank Account Ledger Entry"."Document Type");
            if GLEntry.FindFirst then //ExcelBuf.NewRow;
                ExcelBuf.AddColumn(GLEntry."Document No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn(GLEntry."G/L Account No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            GLAccount.SetRange("No.", GLEntry."G/L Account No.");
            if GLAccount.FindFirst then;
            ExcelBuf.AddColumn(GLAccount.Name, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn("Bank Account Ledger Entry"."External Document No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('ZAVENIR', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('VENPAY', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            if Abs("Bank Account Ledger Entry".Amount) < 200000 then ExcelBuf.AddColumn('NEFT', false, '', false, false, false, '', ExcelBuf."cell type"::Text)
            else
                ExcelBuf.AddColumn('RTGS', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            //ExcelBuf.AddColumn(VLE."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
            ExcelBuf.AddColumn(GLEntry."Posting Date", false, '', false, false, false, '', ExcelBuf."cell type"::Date);
            Clear(BankAccount);
            BankAccount.Reset;
            BankAccount.SetRange("No.", GLEntry."Bal. Account No.");
            if BankAccount.FindFirst then begin
                if BankAccount."Bank Account No." <> '' then ExcelBuf.AddColumn(BankAccount."Bank Account No.", false, '', false, false, false, '', ExcelBuf."cell type"::Text)
                else
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            end
            else
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            //IF DocNo2 = "Bank Account Ledger Entry"."Document No." THEN BEGIN
            BankAccountLedgerEntry.Reset;
            BankAccountLedgerEntry.SetCurrentkey("Document No.", "Posting Date");
            BankAccountLedgerEntry.SetRange("Document No.", "Bank Account Ledger Entry"."Document No.");
            if BankAccountLedgerEntry.FindSet then repeat Amt+=Abs(BankAccountLedgerEntry.Amount);
                    DocNo2:=BankAccountLedgerEntry."Document No.";
                until BankAccountLedgerEntry.Next = 0;
            //END ELSE
            //Amt := "Bank Account Ledger Entry".Amount;
            ExcelBuf.AddColumn(Amt, false, '', false, false, false, '', ExcelBuf."cell type"::Number);
            ExcelBuf.AddColumn('M', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
            if GLAccount.Name <> '' then ExcelBuf.AddColumn(GLAccount.Name, false, '', false, false, false, '', ExcelBuf."cell type"::Text)
            else
                ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        end; /*ELSE BEGIN
         Amt += ABS("Bank Account Ledger Entry".Amount);
         ExcelBuf.AddColumn(Amt,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        END;*/
    //VLE.RESET;
    //VLE.SETRANGE("Document No.","Bank Account Ledger Entry"."Document No.");
    //VendorBankAccount.SETRANGE("Vendor No.",VLE."Vendor No.");
    //IF VendorBankAccount.FINDFIRST THEN BEGIN
    /*IF "Bank Account Ledger Entry"."Bal. Account Type"="Bank Account Ledger Entry"."Bal. Account Type"::"G/L Account" THEN BEGIN
        VendorBankAccount.RESET;
        VendorBankAccount.SETRANGE("Vendor No.","Bank Account Ledger Entry"."Bal. Account No.");
        IF VendorBankAccount.FINDFIRST THEN BEGIN
        IF VendorBankAccount."Vendor No."<>'' THEN
          ExcelBuf.AddColumn(VendorBankAccount."Vendor No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ELSE
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        
        IF VendorBankAccount."Beneficiary Name"<>'' THEN
           ExcelBuf.AddColumn(VendorBankAccount."Beneficiary Name",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ELSE
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        
        IF VendorBankAccount.Name<>'' THEN
           ExcelBuf.AddColumn(VendorBankAccount.Name,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ELSE
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        
        IF VendorBankAccount."NEFT/RTGS Code"<>'' THEN
           ExcelBuf.AddColumn(VendorBankAccount."NEFT/RTGS Code",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ELSE
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        
        IF VendorBankAccount."Bank Account No."<>'' THEN
           ExcelBuf.AddColumn(VendorBankAccount."Bank Account No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ELSE
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        
        IF Vendor."E-Mail"<>'' THEN
           ExcelBuf.AddColumn(Vendor."E-Mail",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ELSE
          ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        
        IF VendorBankAccount."Beneficiary Name"<>'' THEN
            ExcelBuf.AddColumn(VendorBankAccount."Beneficiary Name",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ELSE
           ExcelBuf.AddColumn('',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        
        IF Vendor.Name<>'' THEN
             ExcelBuf.AddColumn(Vendor.Name,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ELSE
          ExcelBuf.AddColumn(Vendor.Name,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        
        END;
        */
    //ExcelBuf.AddColumn(VLE."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
    //ExcelBuf.AddColumn("Bank Account Ledger Entry"."Bank Account No.",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
    //IF "Bank Account Ledger Entry"."Credit Amount" <> 0 THEN
    //ExcelBuf.AddColumn('Cr',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
    //ELSE
    // ExcelBuf.AddColumn('Dr',FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
    //ExcelBuf.AddColumn(ABS("Bank Account Ledger Entry".Amount),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
    //PostedNarration.RESET;
    //PostedNarration.SETRANGE("Transaction No.","Bank Account Ledger Entry"."Transaction No.");
    //IF PostedNarration.FINDFIRST THEN
    // ExcelBuf.AddColumn(PostedNarration.Narration,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuf.CreateNewBook('Export HDFC Bank');
        ExcelBuf.WriteSheet('Export HDFC Bank', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename('Export HDFC Bank');
        ExcelBuf.OpenExcel();
    end;
}
