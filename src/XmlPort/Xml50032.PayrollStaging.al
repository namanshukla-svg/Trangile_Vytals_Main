XmlPort 50032 "Payroll Staging"
{
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
    textelement(Root)
    {
    tableelement("Salary Upload Staging";
    "SSD Salary Upload Staging")
    {
    XmlName = 'Payroll';
    UseTemporary = false;

    textelement(snum)
    {
    XmlName = 'Snum';
    }
    textelement(empcode)
    {
    XmlName = 'EmpCode';
    }
    textelement(empname)
    {
    XmlName = 'EmpName';
    }
    textelement(empstatus)
    {
    XmlName = 'EmpStatus';
    }
    textelement(doj)
    {
    XmlName = 'DOJ';
    }
    textelement(dol)
    {
    XmlName = 'DOL';
    }
    textelement(location)
    {
    XmlName = 'Location';
    }
    textelement(designation)
    {
    XmlName = 'Designation';
    }
    textelement(department)
    {
    XmlName = 'Department';
    }
    textelement(grade)
    {
    XmlName = 'Grade';
    }
    textelement(costcentrecode)
    {
    XmlName = 'CostcentreCode';
    }
    textelement(costcentrename)
    {
    XmlName = 'CostcentreName';
    }
    textelement(gender)
    {
    XmlName = 'Gender';
    }
    textelement(pan)
    {
    XmlName = 'PAN';
    }
    textelement(bankname)
    {
    XmlName = 'BankName';
    }
    textelement(accountno)
    {
    XmlName = 'AccountNo';
    }
    textelement(salaryhold)
    {
    XmlName = 'salaryhold';
    }
    textelement(paymode)
    {
    XmlName = 'Paymode';
    }
    textelement(basic)
    {
    XmlName = 'Basic';
    }
    textelement(hra)
    {
    XmlName = 'HRA';
    }
    textelement(lta)
    {
    XmlName = 'LTA';
    }
    textelement(splallow)
    {
    XmlName = 'SPLAllow';
    }
    textelement(dvrreim)
    {
    XmlName = 'DVRREim';
    }
    textelement(vehmain)
    {
    XmlName = 'VEHMain';
    }
    textelement(gwaot)
    {
    XmlName = 'GWAot';
    }
    textelement(fuelreim)
    {
    XmlName = 'FUelReim';
    }
    textelement(attaward)
    {
    XmlName = 'ATTAward';
    }
    textelement(otherearn)
    {
    XmlName = 'OtherEArn';
    }
    textelement(grossearn)
    {
    XmlName = 'GrossEarn';
    }
    textelement(pf)
    {
    XmlName = 'PF';
    }
    textelement(vpfsal)
    {
    XmlName = 'VPFSAL';
    }
    textelement(esi)
    {
    XmlName = 'ESI';
    }
    textelement(eeclwf)
    {
    XmlName = 'EECLWF';
    }
    textelement(it)
    {
    XmlName = 'IT';
    }
    textelement(saladv)
    {
    XmlName = 'SALADV';
    }
    textelement(mealrec)
    {
    XmlName = 'MEALREC';
    }
    textelement(grossded)
    {
    XmlName = 'GROSSDED';
    }
    textelement(netpay)
    {
    XmlName = 'NETPAY';
    }
    textelement(BeneficiaryName)
    {
    }
    textelement(IFSECode)
    {
    }
    textelement(BankBranch)
    {
    MinOccurs = Zero;
    }
    textelement(EmpLocation)
    {
    MinOccurs = Zero;
    }
    textelement(PostingDate)
    {
    MinOccurs = Zero;
    }
    trigger OnAfterInsertRecord()
    begin
        if UserSetup.Get(UserId)then if not UserSetup."HRMS Permission" = true then Error('You do not have permission to access this action');
        if firstline then begin
            firstline:=false;
            currXMLport.Skip;
        end;
        Recsal.Reset();
        if Recsal.FindLast then Num:=Recsal."Entry No." + 1;
        LineCount:=LineCount + 1;
        //Window.OPEN('Lines #1#######\');
        "Salary Upload Staging"."Entry No.":=Num;
        "Salary Upload Staging"."Employee Code":=EmpCode;
        // Window.UPDATE(1,LineCount);
        "Salary Upload Staging"."Employee Name":=EmpName;
        // "Salary Upload Staging"."Employee Status":=EmpStatus;
        "Salary Upload Staging".Department:=Department;
        "Salary Upload Staging"."Shortcut Dimension 1 Code":=CostcentreCode;
        "Salary Upload Staging"."Cost Center Name":=CostcentreName;
        "Salary Upload Staging"."PAN Number":=PAN;
        "Salary Upload Staging"."Bank Name":=BankName;
        if AccountNo <> '' then Evaluate("Salary Upload Staging"."Bank Account Number", AccountNo)
        else
            "Salary Upload Staging"."Bank Account Number":='';
        // "Salary Upload Staging"."Salary Hold":=salaryhold;
        if Basic <> '' then Evaluate("Salary Upload Staging".Basic, Basic)
        else
            "Salary Upload Staging".Basic:=0;
        if HRA <> '' then Evaluate("Salary Upload Staging".HRA, HRA)
        else
            "Salary Upload Staging".HRA:=0;
        if LTA <> '' then Evaluate("Salary Upload Staging".LTA, LTA)
        else
            "Salary Upload Staging".LTA:=0;
        if SPLAllow <> '' then Evaluate("Salary Upload Staging"."SPL ALLOW", SPLAllow)
        else
            "Salary Upload Staging"."SPL ALLOW":=0;
        if DVRREim <> '' then Evaluate("Salary Upload Staging"."DVR REIM", DVRREim)
        else
            "Salary Upload Staging"."DVR REIM":=0;
        if VEHMain <> '' then Evaluate("Salary Upload Staging"."Veh REIM", VEHMain)
        else
            "Salary Upload Staging"."Veh REIM":=0;
        if GWAot <> '' then Evaluate("Salary Upload Staging"."GWA OT", GWAot)
        else
            "Salary Upload Staging"."GWA OT":=0;
        if FUelReim <> '' then Evaluate("Salary Upload Staging"."Fuel REIM", FUelReim)
        else
            "Salary Upload Staging"."Fuel REIM":=0;
        if ATTAward <> '' then Evaluate("Salary Upload Staging"."ATT Award", ATTAward)
        else
            "Salary Upload Staging"."ATT Award":=0;
        if OtherEArn <> '' then Evaluate("Salary Upload Staging"."Other Earn", OtherEArn)
        else
            "Salary Upload Staging"."Other Earn":=0;
        if GrossEarn <> '' then Evaluate("Salary Upload Staging"."Gross Earn", GrossEarn)
        else
            "Salary Upload Staging"."Gross Earn":=0;
        if PF <> '' then Evaluate("Salary Upload Staging".PF, PF)
        else
            "Salary Upload Staging".PF:=0;
        if VPFSAL <> '' then Evaluate("Salary Upload Staging"."VPF SAL", VPFSAL)
        else
            "Salary Upload Staging"."VPF SAL":=0;
        if ESI <> '' then Evaluate("Salary Upload Staging".ESI, ESI)
        else
            "Salary Upload Staging".ESI:=0;
        if EECLWF <> '' then Evaluate("Salary Upload Staging".EECLWF, EECLWF)
        else
            "Salary Upload Staging".EECLWF:=0;
        if IT <> '' then Evaluate("Salary Upload Staging".IT, IT)
        else
            "Salary Upload Staging".IT:=0;
        if SALADV <> '' then Evaluate("Salary Upload Staging"."SAL ADV", SALADV)
        else
            "Salary Upload Staging"."SAL ADV":=0;
        if MEALREC <> '' then Evaluate("Salary Upload Staging"."MEALS REC", MEALREC)
        else
            "Salary Upload Staging"."MEALS REC":=0;
        if GROSSDED <> '' then Evaluate("Salary Upload Staging"."GROSS DED", GROSSDED)
        else
            "Salary Upload Staging"."GROSS DED":=0;
        if NETPAY <> '' then Evaluate("Salary Upload Staging"."NET PAY", NETPAY)
        else
            "Salary Upload Staging"."NET PAY":=0;
        "Salary Upload Staging"."Beneficiary Name":=BeneficiaryName;
        "Salary Upload Staging"."IFSE code":=IFSECode;
        "Salary Upload Staging"."Bank Branch":=BankBranch;
        if EmpLocation = 'Plant' then "Salary Upload Staging"."Emp Location":="Salary Upload Staging"."emp location"::Plant
        else if EmpLocation = 'Corporate' then "Salary Upload Staging"."Emp Location":="Salary Upload Staging"."emp location"::Corporate
            else
                "Salary Upload Staging"."Emp Location":="Salary Upload Staging"."emp location"::" ";
        Evaluate(PostDate, PostingDate);
        "Salary Upload Staging"."Posting Date":=PostDate;
        if "Salary Upload Staging"."Employee Code" <> '' then begin
            Recsalary.Reset;
            Recsalary.SetRange("Employee Code", "Salary Upload Staging"."Employee Code");
            Recsalary.SetRange("Posting Date", "Salary Upload Staging"."Posting Date");
            if Recsalary.FindFirst then Error('Data already exist');
        end;
        // IF "Salary Upload Staging"."Employee Code"<>'' THEN
        "Salary Upload Staging".Insert;
    //  Num:=Num+1;
    end;
    }
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
    trigger OnPostXmlPort()
    begin
        Recsal.Reset;
        Recsal.SetFilter("Employee Code", '%1', '');
        if Recsal.FindSet then Recsal.DeleteAll;
        Message(Format(LineCount) + ' ' + 'lines Imported');
    end;
    trigger OnPreXmlPort()
    begin
        // Recsal.RESET();
        // IF Recsal.FINDLAST THEN
        //  Num:=Recsal."Entry No."+1;`
        firstline:=true;
        LineCount:=0;
    end;
    var firstline: Boolean;
    RecSalaryupload: Record "SSD Salary Upload Staging";
    Num: Integer;
    Recsal: Record "SSD Salary Upload Staging";
    BankAcc: Integer;
    Window: Dialog;
    LineCount: Integer;
    PostDate: Date;
    Recsalary: Record "SSD Salary Upload Staging";
    UserSetup: Record "User Setup";
}
