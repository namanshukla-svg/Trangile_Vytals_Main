report 50456 "RGP NRGP Report - MIS"
{
    ApplicationArea = All;
    Caption = 'RGP/NRGP Report - MIS';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("SSD RGP Header"; "SSD RGP Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date";

            dataitem("SSD RGP Line"; "SSD RGP Line")
            {
                DataItemLinkReference = "SSD RGP Header";
                DataItemLink = "Document No."=field("No.");

                trigger OnAfterGetRecord()
                begin
                    if "SSD RGP Header".NRGP = true then NRGPRGPType:='NRGP'
                    ELSE
                        NRGPRGPType:='RGP';
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn("SSD RGP Header"."Document Type", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(NRGPRGPType, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Header"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("SSD RGP Header".Status, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Document Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Party Shipment/Rect. No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Party Shipment/Rect. Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Receipt Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Party No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Party Name", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Party Address", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Party Address 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Party City", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Party PostCode", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Shipment Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("SSD RGP Line"."No.", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Line".Description, false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Line"."Description 2", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Line"."Base Unit Of Measure", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Line"."Location Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Line"."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("SSD RGP Line".Quantity, false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("SSD RGP Line"."Quantity Received", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("SSD RGP Line"."Shipping Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Date);
                    ExcelBuffer.AddColumn("SSD RGP Line"."Document SubType", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Line"."Direct Unit Cost", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("SSD RGP Line"."Line Amount", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Purpose Code", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn("SSD RGP Header"."Purpose Description", false, '', false, false, false, '', ExcelBuffer."cell type"::Text);
                    ExcelBuffer.AddColumn(Today - "SSD RGP Header"."Posting Date", false, '', false, false, false, '', ExcelBuffer."cell type"::Number);
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        ExcelBuffer.DeleteAll();
        CreateHeading();
    end;
    trigger OnPostReport()
    begin
        CreateExcelBook();
    end;
    var ExcelBuffer: Record "Excel Buffer";
    NRGPRGPType: Text[10];
    procedure CreateHeading()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Document Type', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Type', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Document No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Status', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Document Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Party Shipment_Rect_ No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Party Shipment_Rect_ Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Receipt Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Party No_', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Party Name', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Party Address', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Party Address 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Party City', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Party PostCode', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipment Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Item No.', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Description 2', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Base Unit Of Measure', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Location Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Posting Date Line', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Quantity Received', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Shipping Date', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Document SubType', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Direct Unit Cost', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Line Amount', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Purpose Code', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('Purpose Description', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
        ExcelBuffer.AddColumn('AGE', false, '', true, false, true, '', ExcelBuffer."cell type"::Text);
    end;
    Local procedure CreateExcelBook();
    begin
        ExcelBuffer.CreateNewBook('RGP NRGP Report - MIS');
        ExcelBuffer.WriteSheet('RGP NRGP Report - MIS', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('RGP NRGP Report - MIS');
        ExcelBuffer.OpenExcel();
    end;
}
