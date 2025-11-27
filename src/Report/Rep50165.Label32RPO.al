Report 50165 "Label - 3 * 2 - RPO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Label - 3  2 - RPO.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

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
            column(ItemLedgerEntryPostingDate; "Creation Date")
            {
            }
            column(ItemLedgerEntryExpirationDate; "Expiration Date")
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
            column(mfgsLabel;'MFG.  DATE')
            {
            }
            column(BestBeforeLabel;'BEST BEFORE')
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
            dataitem("QR Prining info"; "SSD QR Prining info")
            {
                DataItemLink = "Item No."=field("Item No.");
                DataItemTableView = sorting("QR Printing Type", "QR Printing Code", "Item No.")order(ascending)where("QR Printing Type"=filter(<>"PRODUCT TYPE"&<>"UN NUMBER"));

                column(ReportForNavId_1000000011;1000000011)
                {
                }
                column(Sno;'P' + Format(Sno))
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
                column(QRIndex_QRPrintingItemInfo; "QR Prining info"."QR Print Index")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Sno+=1;
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
                //ALLE-AU 11012020
                if UserSetup.Get(UserId)then if not UserSetup.AccessPermisson then if "Reservation Entry"."Creation Date" < Previousdate then Error('You are not authorised to take this print');
                QRMng.GetRPO(true, "Reservation Entry");
                QRMng.Run(ItemLedgerEntry);
                Barcode.FindFirst;
                NetWT:=Barcode."Net Weight";
                GrossWT:=Barcode."Gross Weight";
                QtyPrint:=Barcode.Quantity;
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
                if QRPrintingItemInfo.FindFirst then repeat if QRPrintingItemInfo."QR Print Index" = 1 then;
                        if QRPrintingItemInfo."QR Print Index" = 2 then;
                        if QRPrintingItemInfo."QR Print Index" = 3 then;
                        if QRPrintingItemInfo."QR Print Index" = 4 then;
                    until QRPrintingItemInfo.Next = 0;
            end;
            trigger OnPreDataItem()
            begin
                //ALLE-AU 11012020
                BeforeDate:='<-4M>';
                Todaydate:=Today;
                Previousdate:=CalcDate(BeforeDate, Todaydate);
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
    Pic1: Integer;
    Pic2: Integer;
    Pic3: Integer;
    Pic4: Integer;
    Barcode: Record "SSD Barcode Labelpp";
    QtyPrint: Decimal;
    Previousdate: Date;
    BeforeDate: Text;
    Todaydate: Date;
    UserSetup: Record "User Setup";
}
