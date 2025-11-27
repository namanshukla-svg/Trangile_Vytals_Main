Report 50205 "Gate Pass"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Gate Pass.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Gate Pass Header"; "SSD Gate Pass Header")
        {
            DataItemTableView = where(Posted=filter(true));

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(No_GatePassHeader; "Gate Pass Header"."No.")
            {
            }
            column(Date_GatePassHeader; "Gate Pass Header".Date)
            {
            }
            column(VehicleNo_GatePassHeader; "Gate Pass Header"."Vehicle No.")
            {
            }
            column(DriverName_GatePassHeader; "Gate Pass Header"."Driver Name")
            {
            }
            column(TransporterCode_GatePassHeader; "Gate Pass Header"."Transporter Code")
            {
            }
            column(TransporterName_GatePassHeader; "Gate Pass Header"."Transporter Name")
            {
            }
            column(BiltyNo_GatePassHeader; "Gate Pass Header"."Bilty No.")
            {
            }
            column(Posted_GatePassHeader; "Gate Pass Header".Posted)
            {
            }
            column(NoSeries_GatePassHeader; "Gate Pass Header"."No. Series")
            {
            }
            column(ResponsibilityCenter_GatePassHeader; "Gate Pass Header"."Responsibility Center")
            {
            }
            column(MobileNo_GatePassHeader; "Gate Pass Header"."Mobile No.")
            {
            }
            column(GatePassTime_GatePassHeader; "Gate Pass Header"."Gate Pass Time")
            {
            }
            dataitem("Gate Pass Line"; "SSD Gate Pass Line")
            {
                DataItemLink = "No."=field("No.");

                column(ReportForNavId_1000000001;1000000001)
                {
                }
                column(No_GatePassLine; "Gate Pass Line"."No.")
                {
                }
                column(LineNo_GatePassLine; "Gate Pass Line"."Line No.")
                {
                }
                column(InvoiceNo_GatePassLine; "Gate Pass Line"."Invoice No.")
                {
                }
                column(InvoiceDate_GatePassLine; "Gate Pass Line"."Invoice Date")
                {
                }
                column(CustomerNo_GatePassLine; "Gate Pass Line"."Customer No.")
                {
                }
                column(CustomerName_GatePassLine; "Gate Pass Line"."Customer Name")
                {
                }
                column(InvoiceAmount_GatePassLine; "Gate Pass Line"."Invoice Amount")
                {
                }
                column(NetWt_GatePassLine; "Gate Pass Line"."Net Wt.")
                {
                }
                column(GrossWt_GatePassLine; "Gate Pass Line"."Gross Wt.")
                {
                }
                column(NoOfCartons_GatePassLine; "Gate Pass Line"."No. Of Cartons")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    GrossWt+="Gate Pass Line"."Gross Wt.";
                    NetWt+="Gate Pass Line"."Net Wt.";
                    NoOfCartons+="Gate Pass Line"."No. Of Cartons";
                    TotalInvoiceAmt+="Gate Pass Line"."Invoice Amount";
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
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
    end;
    var CompanyInfo: Record "Company Information";
    GrossWt: Decimal;
    NetWt: Decimal;
    NoOfCartons: Decimal;
    TotalInvoiceAmt: Decimal;
}
