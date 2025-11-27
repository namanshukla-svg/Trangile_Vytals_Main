Report 50180 "Ticket Print Label QR"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Ticket Print Label QR.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";

            column(ReportForNavId_1000000001;1000000001)
            {
            }
            dataitem("QR Printing Item Info. PS"; "SSD QR Prining info")
            {
                DataItemLink = "Item No."=field("No.");
                DataItemTableView = sorting("QR Printing Type", "QR Printing Code", "Item No.")order(ascending)where("QR Printing Type"=filter("PRECAUTIONARY STATEMENTS"), "QR Description"=filter(<>''));

                column(ReportForNavId_1000000000;1000000000)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if MaxLevelCount > 2 then CurrReport.Skip;
                    "Print Labels":=true;
                    Modify;
                    MaxLevelCount+=1;
                end;
            }
            dataitem("QR Printing Item Info. CL"; "SSD QR Prining info")
            {
                DataItemLink = "Item No."=field("No.");
                DataItemTableView = sorting("QR Printing Type", "QR Printing Code", "Item No.")order(ascending)where("QR Printing Type"=filter(CLASSIFICATIONS), "QR Description"=filter(<>''));

                column(ReportForNavId_1000000002;1000000002)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if MaxLevelCount2 > 2 then CurrReport.Skip;
                    "Print Labels":=true;
                    Modify;
                    MaxLevelCount2+=1;
                end;
            }
            dataitem("QR Printing Item Info. HS"; "SSD QR Prining info")
            {
                DataItemLink = "Item No."=field("No.");
                DataItemTableView = sorting("QR Printing Type", "QR Printing Code", "Item No.")order(ascending)where("QR Printing Type"=filter("HAZARD STATEMENTS"), "QR Description"=filter(<>''));

                column(ReportForNavId_1000000003;1000000003)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if MaxLevelCount3 > 2 then CurrReport.Skip;
                    "Print Labels":=true;
                    Modify;
                    MaxLevelCount3+=1;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                MaxLevelCount:=0;
                MaxLevelCount2:=0;
                MaxLevelCount3:=0;
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
    var MaxLevelCount: Integer;
    MaxLevelCount2: Integer;
    MaxLevelCount3: Integer;
}
