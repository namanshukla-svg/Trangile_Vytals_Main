XmlPort 50033 "Employeee Contribution"
{
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
    textelement(Root)
    {
    tableelement("Employee Contribution";
    "SSD Employee Contribution")
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
    textelement(cc)
    {
    XmlName = 'CC';
    }
    textelement(pf)
    {
    XmlName = 'PF';
    }
    textelement(esi)
    {
    XmlName = 'ESI';
    }
    textelement(lwf)
    {
    XmlName = 'LWF';
    }
    textelement(nps)
    {
    XmlName = 'NPS';
    }
    textelement(pfadmincharges)
    {
    XmlName = 'PFAdminCharges';
    }
    textelement(postingdate)
    {
    XmlName = 'PostingDate';
    }
    textelement(remark)
    {
    MinOccurs = Zero;
    XmlName = 'Remark';
    }
    trigger OnAfterInsertRecord()
    begin
        // IF UserSetup.GET(USERID) THEN
        //  IF NOT UserSetup."HRMS Permission" =TRUE THEN
        //   ERROR('You do not have permission to access this action');
        if firstline then begin
            firstline:=false;
            currXMLport.Skip;
        end;
        RecEmpCont.Reset();
        if RecEmpCont.FindLast then Num:=RecEmpCont."Entry No." + 1;
        LineCount:=LineCount + 1;
        //Window.OPEN('Lines #1#######\');
        "Employee Contribution"."Entry No.":=Num;
        "Employee Contribution"."Employee Code":=EmpCode;
        "Employee Contribution"."Employee Name":=EmpName;
        "Employee Contribution"."Cost Centre":=CC;
        if PF <> '' then Evaluate("Employee Contribution"."PF EmpCon", PF)
        else
            "Employee Contribution"."PF EmpCon":=0;
        if ESI <> '' then Evaluate("Employee Contribution"."ESI EmpCon", ESI)
        else
            "Employee Contribution"."ESI EmpCon":=0;
        if LWF <> '' then Evaluate("Employee Contribution"."LWF EmpCon", LWF)
        else
            "Employee Contribution"."LWF EmpCon":=0;
        if NPS <> '' then Evaluate("Employee Contribution"."NPS EmpCon", NPS)
        else
            "Employee Contribution"."NPS EmpCon":=0;
        if PFAdminCharges <> '' then Evaluate("Employee Contribution"."PF Admin Charges", PFAdminCharges)
        else
            "Employee Contribution"."PF Admin Charges":=0;
        Evaluate(Postdate, PostingDate);
        "Employee Contribution"."Posting Date":=Postdate;
        "Employee Contribution".Remark:=Remark;
        "Employee Contribution".Insert;
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
        Recsal.SetFilter("Employee Name", '%1', '');
        if Recsal.FindSet then Recsal.DeleteAll;
        Message(Format(LineCount) + ' ' + 'lines Imported');
    end;
    trigger OnPreXmlPort()
    begin
        firstline:=true;
        LineCount:=0;
    end;
    var UserSetup: Record "User Setup";
    firstline: Boolean;
    RecEmpCont: Record "SSD Employee Contribution";
    Num: Integer;
    LineCount: Integer;
    Postdate: Date;
    Recsal: Record "SSD Employee Contribution";
}
