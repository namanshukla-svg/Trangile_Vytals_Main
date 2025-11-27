Page 50310 "ASP Sales"
{
    ApplicationArea = All;
    Editable = true;
    PageType = List;
    SourceTable = "SSD ASP Buffer";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(Control1000000073)
            {
                field("No. of Records"; Rec.Count)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
            repeater(Group)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field(Nos; Rec.Nos)
                {
                    ApplicationArea = All;
                }
                field("Company Code"; Rec."Company Code")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(GSTIN; Rec.GSTIN)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }
                field("Accounting Document No."; Rec."Accounting Document No.")
                {
                    ApplicationArea = All;
                }
                field("Accounting Document Date"; Rec."Accounting Document Date")
                {
                    ApplicationArea = All;
                }
                field("Transaction Count"; Rec."Transaction Count")
                {
                    ApplicationArea = All;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field(Taxability; Rec.Taxability)
                {
                    ApplicationArea = All;
                }
                field("Supply Type"; Rec."Supply Type")
                {
                    ApplicationArea = All;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                }
                field("Nature of Receipient"; Rec."Nature of Receipient")
                {
                    ApplicationArea = All;
                }
                field("GSTIN of Receipient"; Rec."GSTIN of Receipient")
                {
                    ApplicationArea = All;
                }
                field("Receipient State"; Rec."Receipient State")
                {
                    ApplicationArea = All;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Date';
                }
                field("Invoice Value"; Rec."Invoice Value")
                {
                    ApplicationArea = All;
                    Caption = 'GST Base Amount';
                }
                field("Line Item"; Rec."Line Item")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                field(UQC; Rec.UQC)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Taxable Value"; Rec."Taxable Value")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(IBT; Rec.IBT)
                {
                    ApplicationArea = All;
                }
                field("External Document No"; Rec."External Document No")
                {
                    ApplicationArea = All;
                }
                field("Actual HSN Code"; Rec."Actual HSN Code")
                {
                    ApplicationArea = All;
                }
                field("Total GST Rate"; Rec."Total GST Rate")
                {
                    ApplicationArea = All;
                }
                field("IGST Rate"; Rec."IGST Rate")
                {
                    ApplicationArea = All;
                }
                field("IGST Amount"; Rec."IGST Amount")
                {
                    ApplicationArea = All;
                }
                field("CGST Rate"; Rec."CGST Rate")
                {
                    ApplicationArea = All;
                }
                field("CGST Amount"; Rec."CGST Amount")
                {
                    ApplicationArea = All;
                }
                field("SGST Rate"; Rec."SGST Rate")
                {
                    ApplicationArea = All;
                }
                field("SGST Amount"; Rec."SGST Amount")
                {
                    ApplicationArea = All;
                }
                field("Credit Note Document No."; Rec."Credit Note Document No.")
                {
                    ApplicationArea = All;
                }
                field("Credit Note Date"; Rec."Credit Note Date")
                {
                    ApplicationArea = All;
                }
                field("Entry DateTime"; Rec."Entry DateTime")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("GL Account"; Rec."GL Account")
                {
                    ApplicationArea = All;
                }
                field("Nature of exemption"; Rec."Nature of exemption")
                {
                    ApplicationArea = All;
                }
                field("Name of the Receipient"; Rec."Name of the Receipient")
                {
                    ApplicationArea = All;
                }
                field("Reverse Charge"; Rec."Reverse Charge")
                {
                    ApplicationArea = All;
                }
                field("POS State"; Rec."POS State")
                {
                    ApplicationArea = All;
                }
                field("GSTIN of e-commerce"; Rec."GSTIN of e-commerce")
                {
                    ApplicationArea = All;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = All;
                }
                field("Sales Price"; Rec."Sales Price")
                {
                    ApplicationArea = All;
                }
                field(Discount; Rec.Discount)
                {
                    ApplicationArea = All;
                }
                field("Net Sales Price"; Rec."Net Sales Price")
                {
                    ApplicationArea = All;
                }
                field(VAT; Rec.VAT)
                {
                    ApplicationArea = All;
                }
                field("Central Excise"; Rec."Central Excise")
                {
                    ApplicationArea = All;
                }
                field("State Excise"; Rec."State Excise")
                {
                    ApplicationArea = All;
                }
                field("Ship From"; Rec."Ship From")
                {
                    ApplicationArea = All;
                }
                field("Ship To"; Rec."Ship To")
                {
                    ApplicationArea = All;
                }
                field("Way Bill No"; Rec."Way Bill No")
                {
                    ApplicationArea = All;
                }
                field("Transporter Name"; Rec."Transporter Name")
                {
                    ApplicationArea = All;
                }
                field("Lorry Receipt Number"; Rec."Lorry Receipt Number")
                {
                    ApplicationArea = All;
                }
                field("Lorry Receipt Date"; Rec."Lorry Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Reason for Issuing"; Rec."Reason for Issuing")
                {
                    ApplicationArea = All;
                }
                field("Advance Adjustment Date"; Rec."Advance Adjustment Date")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Cess Rate"; Rec."Cess Rate")
                {
                    ApplicationArea = All;
                }
                field("Cess Amount"; Rec."Cess Amount")
                {
                    ApplicationArea = All;
                }
                field("Eligibility of ITC"; Rec."Eligibility of ITC")
                {
                    ApplicationArea = All;
                }
                field("ITC IGST Amount"; Rec."ITC IGST Amount")
                {
                    ApplicationArea = All;
                }
                field("ITC CGST Amount"; Rec."ITC CGST Amount")
                {
                    ApplicationArea = All;
                }
                field("ITC SGST Amount"; Rec."ITC SGST Amount")
                {
                    ApplicationArea = All;
                }
                field("ITC Cess Amount"; Rec."ITC Cess Amount")
                {
                    ApplicationArea = All;
                }
                field("Assessable Value Before BCD"; Rec."Assessable Value Before BCD")
                {
                    ApplicationArea = All;
                }
                field("Basic Custom Duty"; Rec."Basic Custom Duty")
                {
                    ApplicationArea = All;
                }
                field("Port Code"; Rec."Port Code")
                {
                    ApplicationArea = All;
                }
                field("Application Document No"; Rec."Application Document No")
                {
                    ApplicationArea = All;
                }
                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                }
                field(Exempted; Rec.Exempted)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Export Sales File")
            {
                ApplicationArea = All;
                Caption = 'Export Sales File';
                Ellipsis = true;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ASPSales: XmlPort "ASP Sales";
                begin
                    /*IntegrationSetup.GET;
                    IntegrationSetup.TESTFIELD("No.of Records in File");
                    IF IntegrationSetup."Allow Single File - ASP" THEN BEGIN
                      FileNameUser:=CreateFileName('Sale');
                      FileNameUser:= FileManagement.SaveFileDialog(Text001,FileNameUser,FileManagement.GetToFilterText('','.csv'));
                      ASPBuffer.RESET;
                      ASPBuffer.SETCURRENTKEY(Nos);
                      ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::Sale);
                        //FileName := FileMgt.ClientTempFileName('CSV');
                        FileName := FileMgt.ServerTempFileName('CSV');
                        OutFile.CREATE(FileName);
                        OutFile.CREATEOUTSTREAM(OutS);
                        ASPSales.FILENAME(FileName);
                        ASPSales.SETTABLEVIEW(ASPBuffer);
                        ASPSales.SETDESTINATION(OutS);
                        ASPSales.EXPORT;
                        OutFile.CLOSE;
                        FileMgt.DownloadToFile(FileName,FileNameUser);
                    END
                    ELSE BEGIN
                      ASPBuffer.RESET;
                      ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::Sale);
                        TotalNoofRecords:=ASPBuffer.COUNT;
                        NoofFiles:=1;
                        IF TotalNoofRecords > IntegrationSetup."No.of Records in File" THEN
                         NoofFiles:=ROUND(TotalNoofRecords/IntegrationSetup."No.of Records in File",1,'>');
                        StartNo:=1;
                      FOR I:= 1 TO NoofFiles DO BEGIN
                       IF I < NoofFiles THEN
                          EndNo:=I*IntegrationSetup."No.of Records in File"
                        ELSE
                          EndNo:=TotalNoofRecords;
                       ASPBuffer.RESET;
                       ASPBuffer.SETCURRENTKEY(Nos);
                       ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::Sale);
                       ASPBuffer.SETRANGE(Nos,StartNo,EndNo);
                        FileName := FileMgt.ServerTempFileName('CSV');
                        OutFile.CREATE(FileName);
                        OutFile.CREATEOUTSTREAM(OutS);
                        ASPSales.FILENAME(FileName);
                        ASPSales.SETTABLEVIEW(ASPBuffer);
                        ASPSales.SETDESTINATION(OutS);
                        ASPSales.EXPORT;
                        OutFile.CLOSE;
                        FileMgt.DownloadToFile(FileName,CreateFileName('Sale'));
                        StartNo:=EndNo+1;
                      END;
                    END;
                    MESSAGE('Done');
                    */
                    ASPSales.Run;
                end;
            }
            action("Export Transfer-Ship File")
            {
                ApplicationArea = All;
                Caption = 'Export Transfer-Ship File';
                Ellipsis = true;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*IntegrationSetup.GET;
                    IntegrationSetup.TESTFIELD("No.of Records in File");
                    IF IntegrationSetup."Allow Single File - ASP" THEN BEGIN
                      FileNameUser:=CreateFileName('Transfer_Shipment');
                      FileNameUser:= FileManagement.SaveFileDialog(Text001,FileNameUser,FileManagement.GetToFilterText('','.csv'));
                      ASPBuffer.RESET;
                      ASPBuffer.SETCURRENTKEY(Nos);
                      ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::"Transfer Shipment");
                        //FileName := FileMgt.ClientTempFileName('CSV');
                        FileName := FileMgt.ServerTempFileName('CSV');
                        OutFile.CREATE(FileName);
                        OutFile.CREATEOUTSTREAM(OutS);
                        ASPSales.FILENAME(FileName);
                        ASPSales.SETTABLEVIEW(ASPBuffer);
                        ASPSales.SETDESTINATION(OutS);
                        ASPSales.EXPORT;
                        OutFile.CLOSE;
                        FileMgt.DownloadToFile(FileName,FileNameUser);
                    END
                    ELSE BEGIN
                      ASPBuffer.RESET;
                      ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::"Transfer Shipment");
                        TotalNoofRecords:=ASPBuffer.COUNT;
                        NoofFiles:=1;
                        IF TotalNoofRecords > IntegrationSetup."No.of Records in File" THEN
                         NoofFiles:=ROUND(TotalNoofRecords/IntegrationSetup."No.of Records in File",1,'>');
                        StartNo:=1;
                      FOR I:= 1 TO NoofFiles DO BEGIN
                       IF I < NoofFiles THEN
                         EndNo:=I*IntegrationSetup."No.of Records in File"
                       ELSE
                         EndNo:=TotalNoofRecords;
                        ASPBuffer.RESET;
                        ASPBuffer.SETCURRENTKEY(Nos);
                        ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::"Transfer Shipment");
                        ASPBuffer.SETRANGE(Nos,StartNo,EndNo);
                         FileName := FileMgt.ServerTempFileName('CSV');
                         OutFile.CREATE(FileName);
                         OutFile.CREATEOUTSTREAM(OutS);
                         ASPSales.FILENAME(FileName);
                         ASPSales.SETTABLEVIEW(ASPBuffer);
                         ASPSales.SETDESTINATION(OutS);
                         ASPSales.EXPORT;
                         OutFile.CLOSE;
                         FileMgt.DownloadToFile(FileName,CreateFileName('Transfer_Shipment'));
                         StartNo:=EndNo+1;
                      END;
                    END;
                    MESSAGE('Done');
                    */
                    ASPSales.Run;
                end;
            }
            action("Process Data")
            {
                ApplicationArea = All;
                Ellipsis = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            //SSDU RunObject = Report "Process GST Data";
            }
            action("Export Purchase File")
            {
                ApplicationArea = All;
                Caption = 'Export Purchase File';
                Ellipsis = true;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*IntegrationSetup.GET;
                    IntegrationSetup.TESTFIELD("No.of Records in File");
                    IF IntegrationSetup."Allow Single File - ASP" THEN BEGIN
                      FileNameUser:=CreateFileName('Purchase');
                      FileNameUser:= FileManagement.SaveFileDialog(Text001,FileNameUser,FileManagement.GetToFilterText('','.csv'));
                      ASPBuffer.RESET;
                      ASPBuffer.SETCURRENTKEY(Nos);
                      ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::Purchase);
                        //FileName := FileMgt.ClientTempFileName('CSV');
                        FileName := FileMgt.ServerTempFileName('CSV');
                        OutFile.CREATE(FileName);
                        OutFile.CREATEOUTSTREAM(OutS);
                        ASPPurch.FILENAME(FileName);
                        ASPPurch.SETTABLEVIEW(ASPBuffer);
                        ASPPurch.SETDESTINATION(OutS);
                        ASPPurch.EXPORT;
                        OutFile.CLOSE;
                        FileMgt.DownloadToFile(FileName,FileNameUser);
                    END
                    ELSE BEGIN
                      ASPBuffer.RESET;
                      ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::Purchase);
                        TotalNoofRecords:=ASPBuffer.COUNT;
                        NoofFiles:=1;
                        IF TotalNoofRecords > IntegrationSetup."No.of Records in File" THEN
                         NoofFiles:=ROUND(TotalNoofRecords/IntegrationSetup."No.of Records in File",1,'>');
                        StartNo:=1;
                      FOR I:= 1 TO NoofFiles DO BEGIN
                        IF I < NoofFiles THEN
                          EndNo:=I*IntegrationSetup."No.of Records in File"
                        ELSE
                          EndNo:=TotalNoofRecords;
                        ASPBuffer.RESET;
                        ASPBuffer.SETCURRENTKEY(Nos);
                        ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::Purchase);
                        ASPBuffer.SETRANGE(Nos,StartNo,EndNo);
                         FileName := FileMgt.ServerTempFileName('CSV');
                         OutFile.CREATE(FileName);
                         OutFile.CREATEOUTSTREAM(OutS);
                         ASPPurch.FILENAME(FileName);
                         ASPPurch.SETTABLEVIEW(ASPBuffer);
                         ASPPurch.SETDESTINATION(OutS);
                         ASPPurch.EXPORT;
                         OutFile.CLOSE;
                         FileMgt.DownloadToFile(FileName,CreateFileName('Purchase'));
                         StartNo:=EndNo+1;
                      END;
                    END;
                    MESSAGE('Done');
                    */
                    ASPPurch.Run;
                end;
            }
            action("Export Transfer-Recpt File")
            {
                ApplicationArea = All;
                Caption = 'Export Transfer-Recpt File';
                Ellipsis = true;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                /*IntegrationSetup.GET;
                    IntegrationSetup.TESTFIELD("No.of Records in File");
                    IF IntegrationSetup."Allow Single File - ASP" THEN BEGIN
                      FileNameUser:=CreateFileName('Transfer_Receipt');
                      FileNameUser:= FileManagement.SaveFileDialog(Text001,FileNameUser,FileManagement.GetToFilterText('','.csv'));
                      ASPBuffer.RESET;
                      ASPBuffer.SETCURRENTKEY(Nos);
                      ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::"Transfer Receipt");
                        //FileName := FileMgt.ClientTempFileName('CSV');
                        FileName := FileMgt.ServerTempFileName('CSV');
                        OutFile.CREATE(FileName);
                        OutFile.CREATEOUTSTREAM(OutS);
                        ASPPurch.FILENAME(FileName);
                        ASPPurch.SETTABLEVIEW(ASPBuffer);
                        ASPPurch.SETDESTINATION(OutS);
                        ASPPurch.EXPORT;
                        OutFile.CLOSE;
                        FileMgt.DownloadToFile(FileName,FileNameUser);
                    END
                    ELSE BEGIN
                      ASPBuffer.RESET;
                      ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::"Transfer Receipt");
                        TotalNoofRecords:=ASPBuffer.COUNT;
                        NoofFiles:=1;
                        IF TotalNoofRecords > IntegrationSetup."No.of Records in File" THEN
                         NoofFiles:=ROUND(TotalNoofRecords/IntegrationSetup."No.of Records in File",1,'>');
                        StartNo:=1;
                      FOR I:= 1 TO NoofFiles DO BEGIN
                        IF I < NoofFiles THEN
                          EndNo:=I*IntegrationSetup."No.of Records in File"
                        ELSE
                          EndNo:=TotalNoofRecords;
                        ASPBuffer.RESET;
                        ASPBuffer.SETCURRENTKEY(Nos);
                        ASPBuffer.SETRANGE("Transaction Type",ASPBuffer."Transaction Type"::"Transfer Receipt");
                        ASPBuffer.SETRANGE(Nos,StartNo,EndNo);
                         FileName := FileMgt.ServerTempFileName('CSV');
                         OutFile.CREATE(FileName);
                         OutFile.CREATEOUTSTREAM(OutS);
                         ASPPurch.FILENAME(FileName);
                         ASPPurch.SETTABLEVIEW(ASPBuffer);
                         ASPPurch.SETDESTINATION(OutS);
                         ASPPurch.EXPORT;
                         OutFile.CLOSE;
                         FileMgt.DownloadToFile(FileName,CreateFileName('Transfer_Receipt'));
                         StartNo:=EndNo+1;
                      END;
                    END;
                    MESSAGE('Done');
                    */
                end;
            }
            action(Tets)
            {
                ApplicationArea = All;
                Caption = 'Tets';

                trigger OnAction()
                begin
                    Message(Format(ROUND(2.95, 1, '>')));
                end;
            }
        }
    }
    var ASPSales: XmlPort "Update Requisition Lines";
    ASPBuffer: Record "SSD Posted Indent Line";
    OutFile: File;
    FileName: Text;
    FileMgt: Codeunit "File Management";
    OutS: OutStream;
    ASPPurch: XmlPort "ASP Purchase";
    FormatString: Text;
    CompInfo: Record "Company Information";
    FilePath: Text;
    TotalNoofRecords: Integer;
    NoofFiles: Integer;
    I: Integer;
    StartNo: Integer;
    EndNo: Integer;
    FileManagement: Codeunit "File Management";
    Text001: label 'Export to csv File';
    FileNameUser: Text;
    local procedure CreateFileName(NameText: Text): Text begin
    /*IntegrationSetup.GET;
        FilePath:=IntegrationSetup."ASP File Path";
        FormatString:='<Hours24,2><Minutes,2><Seconds,2>';
        CompInfo.GET;
        FileName:=NameText+'_'+FORMAT(TODAY,0,'<Day,2><Month,2><Year4>')+'_'+FORMAT(TIME,0,FormatString)+'_'+CompInfo."Company Code - ASP";
        FilePath:=FilePath+'\'+FileName+'_'+FORMAT(I)+'.csv';
        EXIT(FilePath);
        */
    end;
}
