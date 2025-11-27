Report 50166 "Label - A5 - RPO Test"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Label - A5 - RPO Test.rdlc';
    UseRequestPage = false;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Reservation Entry"; "Reservation Entry")
        {
            RequestFilterFields = "Entry No.", "Source ID", "Item No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(EntryNo_ItemLedgerEntry; "Entry No.")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item No.")
            {
            }
            column(Quantity_ItemLedgerEntry; Format(QtyPrint) + '  ' + Item."Base Unit of Measure")
            {
            }
            column(LotNo_ItemLedgerEntry; "Lot No.")
            {
            }
            column(Item_Description; Item.Description)
            {
            }
            column(Item_Description_2; Item."Description 2")
            {
            }
            column(UnitofMeasureCode_ItemLedgerEntry; Item."Base Unit of Measure")
            {
            }
            column(CrossReferenceDescription; CrossReferenceDescription)
            {
            }
            column(ItemLedgerEntryPostingDate; Format("Creation Date"))
            {
            }
            column(ItemLedgerEntryExpirationDate; Format("Expiration Date"))
            {
            }
            column(NetWT; Format(NetWT))
            {
            }
            column(GrossWT; Format(GrossWT))
            {
            }
            column(NetWTLabel;'Net WT')
            {
            }
            column(GrossWTLabel;'Gross WT')
            {
            }
            column(mfgsLabel;'Mfg.  Date')
            {
            }
            column(BestBeforeLabel;'Best Before')
            {
            }
            column(CompanyInfo2Picture; Item."QR Code")
            {
            }
            column(CompanyInfo3Picture; Item."QR Code")
            {
            }
            column(CompanyInfo1Picture; Item."QR Code")
            {
            }
            column(ProductType; ProductType)
            {
            }
            column(UNNumber; UNNumber)
            {
            }
            column(SingleWord; SingleWord)
            {
            }
            column(QRImages_QRPrintingItemInfo; QRPrinting."QR Images")
            {
            }
            column(QRImages2_QRPrintingItemInfo; QRPrinting2."QR Images")
            {
            }
            column(QRImages3_QRPrintingItemInfo; QRPrinting3."QR Images")
            {
            }
            column(QRImages4_QRPrintingItemInfo; QRPrinting4."QR Images")
            {
            }
            column(QRIndex_QRPrintingItemInfo; IndexQR)
            {
            }
            column(QRIndex2_QRPrintingItemInfo; IndexQR2)
            {
            }
            column(QRIndex3_QRPrintingItemInfo; IndexQR3)
            {
            }
            column(QRIndex4_QRPrintingItemInfo; IndexQR4)
            {
            }
            dataitem("QR Prining info"; "SSD QR Prining info")
            {
                DataItemLink = "Item No."=field("Item No.");
                DataItemTableView = sorting("QR Printing Code")order(ascending)where("QR Printing Type"=filter(<>"PRODUCT TYPE"&<>"UN NUMBER"), "Print Labels"=filter(true));

                column(ReportForNavId_1000000011;1000000011)
                {
                }
                column(QRCode; QRCode)
                {
                }
                column(Sno; "QR Prining info"."QR Printing Code")
                {
                }
                column(QRPrintingType_QRPrintingItemInfo; "QR Prining info"."QR Printing Type")
                {
                }
                column(QRPrintingCode_QRPrintingItemInfo; "QR Prining info"."QR Printing Code")
                {
                }
                column(ItemNo_QRPrintingItemInfo; "QR Prining info"."Item No.")
                {
                }
                column(QRDescription_QRPrintingItemInfo; "QR Prining info"."QR Description")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Sno+=1;
                    if "QR Printing Type" = "qr printing type"::PICTOGRAMS then CurrReport.Skip;
                    if not("QR Printing Type" = "qr printing type"::CLASSIFICATIONS)then QRCode:="QR Prining info"."QR Printing Code"
                    else
                        QRCode:='';
                end;
                trigger OnPreDataItem()
                begin
                    Sno:=0;
                end;
            }
            trigger OnAfterGetRecord()
            var
                SalesShipHead: Record "Sales Shipment Header";
                ItemLedgerEntry: Record "Item Ledger Entry";
            begin
                QRMng.GetRPO(true, "Reservation Entry");
                QRMng.Run(ItemLedgerEntry);
                /*
                Barcode.FINDFIRST;
                NetWT:=Barcode."Net Weight";
                GrossWT:=Barcode."Gross Weight";
                QtyPrint:= Barcode.Quantity;
                */
                Item.Get("Item No.");
                Item.CalcFields("QR Code");
                "Expiration Date":=CalcDate(Item."Expiration Calculation", "Creation Date");
                RecCrossReference.Reset;
                RecCrossReference.SetRange("Item No.", "Item No.");
                RecCrossReference.SetRange("Reference Type", RecCrossReference."Reference Type"::Customer);
                RecCrossReference.SetRange(RecCrossReference."Reference Type No.", SalesShipHead."Sell-to Customer No.");
                if not RecCrossReference.FindFirst then RecCrossReference."Reference No.":='';
                CrossReferenceDescription:='';
                if RecCrossReference.Description <> '' then CrossReferenceDescription:=RecCrossReference.Description;
                QRPrintingItemInfo.Reset;
                QRPrintingItemInfo.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::"PRODUCT TYPE");
                QRPrintingItemInfo.SetRange(QRPrintingItemInfo."Item No.", "Item No.");
                if QRPrintingItemInfo.FindFirst then ProductType:=QRPrintingItemInfo."QR Description";
                QRPrintingItemInfo.Reset;
                QRPrintingItemInfo.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::"UN NUMBER");
                QRPrintingItemInfo.SetRange(QRPrintingItemInfo."Item No.", "Item No.");
                if QRPrintingItemInfo.FindFirst then UNNumber:=QRPrintingItemInfo."QR Description";
                QRPrintingItemInfo.Reset;
                QRPrintingItemInfo.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::PICTOGRAMS);
                QRPrintingItemInfo.SetRange(QRPrintingItemInfo."Item No.", "Item No.");
                if QRPrintingItemInfo.FindFirst then repeat if QRPrintingItemInfo."QR Print Index" = 1 then begin
                            QRPrinting.Reset;
                            QRPrinting.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::PICTOGRAMS);
                            QRPrinting.SetRange("QR Printing Code", QRPrintingItemInfo."QR Printing Code");
                            if QRPrinting.FindFirst then QRPrinting.CalcFields("QR Images");
                            IndexQR:=1;
                        end;
                        if QRPrintingItemInfo."QR Print Index" = 2 then begin
                            QRPrinting2.Reset;
                            QRPrinting2.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::PICTOGRAMS);
                            QRPrinting2.SetRange("QR Printing Code", QRPrintingItemInfo."QR Printing Code");
                            if QRPrinting2.FindFirst then QRPrinting2.CalcFields("QR Images");
                            IndexQR2:=2;
                        end;
                        if QRPrintingItemInfo."QR Print Index" = 3 then begin
                            QRPrinting3.Reset;
                            QRPrinting3.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::PICTOGRAMS);
                            QRPrinting3.SetRange("QR Printing Code", QRPrintingItemInfo."QR Printing Code");
                            if QRPrinting3.FindFirst then QRPrinting3.CalcFields("QR Images");
                            IndexQR3:=3;
                        end;
                        if QRPrintingItemInfo."QR Print Index" = 4 then begin
                            QRPrinting4.Reset;
                            QRPrinting4.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::PICTOGRAMS);
                            QRPrinting4.SetRange("QR Printing Code", QRPrintingItemInfo."QR Printing Code");
                            if QRPrinting4.FindFirst then QRPrinting4.CalcFields("QR Images");
                            IndexQR4:=4;
                        end;
                    until QRPrintingItemInfo.Next = 0;
                QRPrintingItemInfo.Reset;
                QRPrintingItemInfo.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::"SINGLE WORD");
                QRPrintingItemInfo.SetRange(QRPrintingItemInfo."Item No.", "Item No.");
                if QRPrintingItemInfo.FindFirst then SingleWord:=QRPrintingItemInfo."QR Description";
            end;
            trigger OnPreDataItem()
            begin
                SetRange("Source ID", SourceID);
                SetRange("Item No.", ItemNoG);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NetWT; NetWT)
                    {
                        ApplicationArea = All;
                        Caption = 'Qty. NWT';
                    }
                    field(GrossWT; GrossWT)
                    {
                        ApplicationArea = All;
                        Caption = 'Qty. GWT';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var Item: Record Item;
    RecCrossReference: Record "Item Reference";
    CrossReferenceDescription: Text;
    QRPrintingItemInfo: Record "SSD QR Prining info";
    ProductType: Text;
    NetWT: Decimal;
    GrossWT: Decimal;
    QRMng: Codeunit "QR Code Management";
    Sno: Integer;
    UNNumber: Text;
    QRPrinting: Record "SSD QR Printing";
    QRPrinting2: Record "SSD QR Printing";
    QRPrinting3: Record "SSD QR Printing";
    QRPrinting4: Record "SSD QR Printing";
    IndexQR: Integer;
    IndexQR2: Integer;
    IndexQR3: Integer;
    IndexQR4: Integer;
    SingleWord: Text;
    QtyPrint: Decimal;
    QRCode: Code[20];
    Barcode: Record "SSD Barcode Labelpp";
    SourceID: Code[20];
    ItemNoG: Code[20];
    procedure GETParameter(SourceNo: Code[20]; ItemNo: Code[20]; NtWt: Decimal; GroseWt: Decimal; Qty: Decimal)
    begin
        SourceID:=SourceNo;
        ItemNoG:=ItemNo;
        NetWT:=NtWt;
        GrossWT:=GroseWt;
        QtyPrint:=Qty;
    end;
}
