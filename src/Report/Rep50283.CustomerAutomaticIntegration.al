Report 50283 "Customer Automatic Integration"
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("No."=filter(<>'C0475'), Sync=filter(false));

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if COMPANYNAME = 'Zavenir Daubert India (P) Ltd.' then begin
                    Customer2.ChangeCompany('Zavenir Kluthe India (P) Ltd.');
                    if not Customer2.Get(Customer."No.")then begin
                        Customer2.Init;
                        Customer2.TransferFields(Customer);
                        Customer2.Insert(true);
                        Customer2.Sync:=true;
                        Customer2.Modify;
                        Customer.Sync:=true;
                        Customer.Modify;
                    end
                    else
                    begin
                        if Customer.Name <> Customer2.Name then Customer2.Name:=Customer.Name;
                        if Customer.Address <> Customer2.Address then Customer2.Address:=Customer.Address;
                        if Customer."Post Code" <> Customer2."Post Code" then Customer2."Post Code":=Customer."Post Code";
                        if Customer.City <> Customer2.City then Customer2.City:=Customer.City;
                        if Customer."Country/Region Code" <> Customer2."Country/Region Code" then Customer2."Country/Region Code":=Customer."Country/Region Code";
                        if Customer."State Code" <> Customer2."State Code" then Customer2."State Code":=Customer."State Code";
                        if Customer."Phone No." <> Customer2."Phone No." then Customer2."Phone No.":=Customer."Phone No.";
                        if Customer.Contact <> Customer2.Contact then Customer2.Contact:=Customer.Contact;
                        if Customer."Salesperson Code" <> Customer2."Salesperson Code" then Customer2."Salesperson Code":=Customer."Salesperson Code";
                        if Customer."Location Code" <> Customer2."Location Code" then Customer2."Location Code":=Customer."Location Code";
                        // IF Customer."Our Account No." <> Customer2."Our Account No." THEN
                        // Customer2."Our Account No." := Customer."Our Account No.";
                        if Customer."E-Mail" <> Customer2."E-Mail" then Customer2."E-Mail":=Customer."E-Mail";
                        Customer.Sync:=true;
                        Customer.Modify;
                        Customer2.Sync:=true;
                        Customer2.Modify;
                    end;
                end;
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
    var CompanyInformation: Record "Company Information";
    Customer2: Record Customer;
}
