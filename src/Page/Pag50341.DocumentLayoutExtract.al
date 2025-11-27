Page 50341 "Document Layout Extract"
{
    PageType = List;
    SourceTable = "SSD Document Layout Extract";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
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
            // SSDU Commented
            action("Extract Sales Invoice")
            {
                ApplicationArea = All;
                Image = ElectronicDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                    DocumentExtract: Record "SSD Document Layout Extract";
                    // InvoiceReport: Report "Zavenir_Sales Invoice Modified";
                    // gurmeet
                    InvoiceReport: Report "Sales Invoice new_";
                    TempBlob: Codeunit "Temp Blob";
                    OutStr: OutStream;
                    RecRef: RecordRef;
                    FileManagement: Codeunit "File Management";
                // gurmeet
                begin
                    OutFilePath:='D:\DocExport\SI\';
                    DocumentExtract.Reset;
                    DocumentExtract.CopyFilters(Rec);
                    DocumentExtract.SetRange(Type, DocumentExtract.Type::"Sales Invoice");
                    DocumentExtract.SetRange("Document No.", Rec."Document No.");
                    if DocumentExtract.FindSet then repeat SalesInvHeader.Reset();
                            SalesInvHeader.SetRange("No.", DocumentExtract."Document No.");
                            if SalesInvHeader.FindFirst()then begin
                                OutFileName:='';
                                DocNo:=GetDocNo(SalesInvHeader."No.");
                                OutFileName:=OutFilePath + DocNo + '.pdf';
                                // if Exists(OutFileName) then
                                //     Erase(OutFileName);
                                // ServerFileName := FileManagement.ServerTempFileName(DocNo + '.pdf');
                                // Clear(InvoiceReport);
                                // InvoiceReport.SetTableview(SalesInvHeader);
                                // InvoiceReport.SaveAsPdf(ServerFileName);
                                // FileManagement.DownloadToFile(ServerFileName, OutFileName);
                                // FileManagement.DeleteServerFile(ServerFileName);
                                // gurmeet
                                Clear(TempBlob);
                                TempBlob.CreateOutStream(OutStr, TEXTENCODING::UTF8);
                                RecRef.GetTable(SalesInvHeader);
                                REPORT.SAVEAS(Report::"Sales Invoice new_", '', REPORTFORMAT::Pdf, OutStr, RecRef);
                                FileManagement.BLOBExport(TempBlob, OutFileName, TRUE);
                            // gurmeet
                            end;
                        until DocumentExtract.Next = 0;
                end;
            }
            action("Extract Sales Cr Memo")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                    DocumentExtract: Record "SSD Document Layout Extract";
                    // CRMemoReport: Report "Zavenir_Sales_Cr. Memo_Mod.";
                    // gurmeet
                    CRMemoReport: Report "Sales - Credit Memo GST";
                    TempBlob: Codeunit "Temp Blob";
                    OutStr: OutStream;
                    RecRef: RecordRef;
                    FileManagement: Codeunit "File Management";
                // gurmeet
                begin
                    OutFilePath:='D:\DocExport\SC\';
                    DocumentExtract.Reset;
                    DocumentExtract.CopyFilters(Rec);
                    DocumentExtract.SetRange(Type, DocumentExtract.Type::"Sales Cr Memo");
                    DocumentExtract.SetRange("Document No.", Rec."Document No.");
                    if DocumentExtract.FindSet then repeat SalesCrMemoHeader.Reset();
                            SalesCrMemoHeader.SetRange("No.", DocumentExtract."Document No.");
                            if SalesCrMemoHeader.FindFirst then begin
                                OutFileName:='';
                                DocNo:=GetDocNo(SalesCrMemoHeader."No.");
                                OutFileName:=OutFilePath + DocNo + '.pdf';
                                // if Exists(OutFileName) then
                                //     Erase(OutFileName);
                                // ServerFileName := FileManagement.ServerTempFileName(DocNo + '.pdf');
                                // Clear(CRMemoReport);
                                // CRMemoReport.SetTableview(SalesCrMemoHeader);
                                // CRMemoReport.SaveAsPdf(ServerFileName);
                                // FileManagement.DownloadToFile(ServerFileName, OutFileName);
                                // FileManagement.DeleteServerFile(ServerFileName);
                                // gurmeet
                                Clear(TempBlob);
                                TempBlob.CreateOutStream(OutStr, TEXTENCODING::UTF8);
                                RecRef.GetTable(SalesCrMemoHeader);
                                REPORT.SAVEAS(Report::"Sales - Credit Memo GST", '', REPORTFORMAT::Pdf, OutStr, RecRef);
                                FileManagement.BLOBExport(TempBlob, OutFileName, TRUE);
                            // gurmeet
                            end;
                        until DocumentExtract.Next = 0;
                end;
            }
            action("Extract Purchase Order")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    DocumentExtract: Record "SSD Document Layout Extract";
                    POReport: Report "PO Print";
                    // gurmeet
                    TempBlob: Codeunit "Temp Blob";
                    OutStr: OutStream;
                    RecRef: RecordRef;
                    FileManagement: Codeunit "File Management";
                // gurmeet
                begin
                    OutFilePath:='D:\DocExport\PO\';
                    DocumentExtract.Reset;
                    DocumentExtract.CopyFilters(Rec);
                    DocumentExtract.SetRange(Type, DocumentExtract.Type::"Purchase Order");
                    DocumentExtract.SetRange("Document No.", Rec."Document No.");
                    if DocumentExtract.FindSet then repeat PurchaseHeader.Reset();
                            PurchaseHeader.SetRange("Document Type", PurchaseHeader."document type"::Order);
                            PurchaseHeader.SetRange("No.", DocumentExtract."Document No.");
                            if PurchaseHeader.FindFirst then begin
                                OutFileName:='';
                                DocNo:=GetDocNo(PurchaseHeader."No.");
                                OutFileName:=OutFilePath + DocNo + '.pdf';
                                // if Exists(OutFileName) then
                                //     Erase(OutFileName);
                                // ServerFileName := FileManagement.ServerTempFileName(DocNo + '.pdf');
                                // Clear(POReport);
                                // POReport.SetTableview(PurchaseHeader);
                                // POReport.SaveAsPdf(ServerFileName);
                                // FileManagement.DownloadToFile(ServerFileName, OutFileName);
                                // FileManagement.DeleteServerFile(ServerFileName);
                                // gurmeet
                                Clear(TempBlob);
                                TempBlob.CreateOutStream(OutStr, TEXTENCODING::UTF8);
                                RecRef.GetTable(PurchaseHeader);
                                REPORT.SAVEAS(Report::"PO Print", '', REPORTFORMAT::Pdf, OutStr, RecRef);
                                FileManagement.BLOBExport(TempBlob, OutFileName, TRUE);
                            // gurmeet
                            end;
                        until DocumentExtract.Next = 0;
                end;
            }
            action("Extract Sales Order")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    DocumentExtract: Record "SSD Document Layout Extract";
                    // SOReport: Report "Zavenir Order Confirmation";
                    // gurmeet
                    TempBlob: Codeunit "Temp Blob";
                    OutStr: OutStream;
                    RecRef: RecordRef;
                    FileManagement: Codeunit "File Management";
                // gurmeet
                begin
                    OutFilePath:='D:\DocExport\SO\';
                    DocumentExtract.Reset;
                    DocumentExtract.CopyFilters(Rec);
                    DocumentExtract.SetRange(Type, DocumentExtract.Type::"Sales Order");
                    DocumentExtract.SetRange("Document No.", Rec."Document No.");
                    if DocumentExtract.FindSet then repeat SalesHeader.Reset();
                            SalesHeader.SetRange("Document Type", SalesHeader."document type"::Order);
                            SalesHeader.SetRange("No.", DocumentExtract."Document No.");
                            if SalesHeader.FindFirst then begin
                                OutFileName:='';
                                DocNo:=GetDocNo(SalesHeader."No.");
                                OutFileName:=OutFilePath + DocNo + '.pdf';
                                // if Exists(OutFileName) then
                                //     Erase(OutFileName);
                                // ServerFileName := FileManagement.ServerTempFileName(DocNo + '.pdf');
                                // Clear(SOReport);
                                // SOReport.SetTableview(SalesHeader);
                                // SOReport.SaveAsPdf(ServerFileName);
                                // FileManagement.DownloadToFile(ServerFileName, OutFileName);
                                // FileManagement.DeleteServerFile(ServerFileName);
                                // gurmeet
                                Clear(TempBlob);
                                TempBlob.CreateOutStream(OutStr, TEXTENCODING::UTF8);
                                RecRef.GetTable(SalesHeader);
                                REPORT.SAVEAS(Report::"Order Confirmation New", '', REPORTFORMAT::Pdf, OutStr, RecRef);
                                FileManagement.BLOBExport(TempBlob, OutFileName, TRUE);
                            // gurmeet
                            end;
                        until DocumentExtract.Next = 0;
                end;
            }
        //SSDU Commented
        }
    }
    var OutFilePath: Text;
    OutFileName: Text;
    DocNo: Code[20];
    FileManagement: Codeunit "File Management";
    ServerFileName: Text;
    local procedure GetDocNo(InDocNo: Code[20])OutDocNo: Code[20]begin
        if InDocNo <> '' then OutDocNo:=DelChr(InDocNo, '=', '!|@|#|$|%/\');
    end;
}
