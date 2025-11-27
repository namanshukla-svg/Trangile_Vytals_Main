Report 55004 "Label - 175 * 220 IG"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Label - 175  220_IG.rdl';
    // ApplicationArea = all;
    // UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Package Tracking"; "Package Tracking")
        {
            RequestFilterFields = "Lot No.";
            column(PackageNo_ItemLedgerEntry; "Package Tracking"."Package No.")
            {
            }

            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLinkReference = "Package Tracking";
                DataItemLink = "Lot No." = field("Lot No.");
                // RequestFilterFields = "Entry No.";

                column(LabelQRCode; MfgSetup."Label QR Code")//IG_DS Item."QR Code")
                {
                }
                column(ReportForNavId_1000000000; 1000000000)
                {
                }
                column(EntryNo_ItemLedgerEntry; "Item Ledger Entry"."Entry No.")
                {
                }
                column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
                {
                }
                column(Quantity_ItemLedgerEntry; Format(QtyPrint) + '  ' + "Item Ledger Entry"."Unit of Measure Code")
                {
                }
                column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(Item_Description_2; Item."Description 2")
                {
                }
                column(UnitofMeasureCode_ItemLedgerEntry; "Item Ledger Entry"."Unit of Measure Code")
                {
                }
                column(CrossReferenceDescription; CrossReferenceDescription)
                {
                }
                column(ItemLedgerEntryPostingDate; ILEPostingDate)
                {
                }
                column(ItemLedgerEntryExpirationDate; ExpirationDate)
                {
                }
                column(NetWT; Format(NetWT))
                {
                }
                column(GrossWT; Format(GrossWT))
                {
                }
                column(NetWTLabel; 'Net WT')
                {
                }
                column(GrossWTLabel; 'Gross WT')
                {
                }
                column(mfgsLabel; 'Mfg.  Date')
                {
                }
                column(BestBeforeLabel; 'Best Before')
                {
                }
                column(CompanyInfo2Picture; Item."QR Code")
                {
                }
                // column(CompanyInfo3Picture; MfgSetup."Label QR Code")//IG_DS Item."QR Code")
                // {
                // }
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
                column(QRIndex4_QRPrintingItemInfos; IndexQR4)
                {
                }
                dataitem("QR Prining info"; "SSD QR Prining info")
                {
                    DataItemLink = "Item No." = field("Item No.");
                    DataItemTableView = sorting("QR Printing Code") order(ascending) where("QR Printing Type" = filter(<> "PRODUCT TYPE" & <> "UN NUMBER"), "Print Labels" = filter(true));

                    column(ReportForNavId_1000000011; 1000000011)
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
                        Sno += 1;
                        if "QR Printing Type" = "qr printing type"::PICTOGRAMS then CurrReport.Skip;
                        if not ("QR Printing Type" = "qr printing type"::CLASSIFICATIONS) then
                            QRCode := "QR Prining info"."QR Printing Code"
                        else
                            QRCode := '';
                    end;

                    trigger OnPreDataItem()
                    begin
                        Sno := 0;
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    SalesShipHead: Record "Sales Shipment Header";
                    BarcodeSymbology2D: Enum "Barcode Symbology 2D";
                    BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
                    BarcodeString: Text;
                    Itemtext: Text;
                    QRCodeInput: Text[1024];
                    OS_iOS: OutStream;
                    IS_iIN: InStream;
                    TempBlob1: Codeunit "Temp Blob";
                    QRGenerator: Codeunit "QR Generator";

                begin
                    //ALLE-AU 11012020
                    if UserSetup.Get(UserId) then if not UserSetup.AccessPermisson then if "Item Ledger Entry"."Posting Date" < Previousdate then Error('You are not authorised to take this print');
                    QRMng.Run("Item Ledger Entry");
                    //IG_DS
                    Barcode.FindFirst;
                    Itemtext := DelChr(Item.Description, '=', '®,™');
                    QRCodeInput := CreateQRCodeInput(Itemtext + 'Desc:' + Item."Description 2" + '; Lot:' + "Item Ledger Entry"."Lot No." + '; Item:' + Item."No." + '; Location:' + "Item Ledger Entry"."Location Code" + '; QTY:' + Format(Barcode.Quantity) + '; Mfg. Date/Best Before-' + Format("Item Ledger Entry"."Expiration Date") + '-NW-' + Format(Barcode."Net Weight"), '-GW-' + Format(Barcode."Gross Weight") + '-' + Item."Base Unit of Measure" + '; Package No: ' + "Package Tracking"."Package No."); //SSD_Sunil_110325_Add package No.
                    TempBlob1.CreateInStream(IS_iIN); //IG_DS_AFter
                    QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob1);
                    MfgSetup.Get();
                    Clear(MfgSetup."Label QR Code");
                    MfgSetup."Label QR Code".CreateOutStream(OS_iOS);
                    COPYSTREAM(OS_iOS, IS_iIN);
                    //IG_DS
                    //  Barcode.FindFirst;
                    NetWT := Barcode."Net Weight";
                    GrossWT := Barcode."Gross Weight";
                    QtyPrint := Barcode.Quantity;
                    Item.Get("Item No.");
                    Item.CalcFields("QR Code");
                    //Alle - 221020 >>
                    ILEPostingDate := 0D;
                    if "Item Ledger Entry"."Manufacturing Date New" <> 0D then
                        ILEPostingDate := "Item Ledger Entry"."Manufacturing Date New"
                    else
                        ILEPostingDate := "Item Ledger Entry"."Posting Date";
                    if "Item Ledger Entry"."Manufacturing Date New" <> 0D then begin
                        ExpirationDate := 0D;
                        ExpirationDate := CalcDate(Item."Expiration Calculation", "Item Ledger Entry"."Manufacturing Date New");
                    end
                    else begin
                        ExpirationDate := 0D;
                        ExpirationDate := CalcDate(Item."Expiration Calculation", "Item Ledger Entry"."Posting Date");
                    end;
                    //Alle - 221020 <<
                    RecCrossReference.Reset;
                    RecCrossReference.SetRange("Item No.", "Item No.");
                    RecCrossReference.SetRange("Reference Type", RecCrossReference."Reference type"::Customer);
                    RecCrossReference.SetRange(RecCrossReference."Reference Type No.", SalesShipHead."Sell-to Customer No.");
                    if not RecCrossReference.FindFirst then RecCrossReference."Reference No." := '';
                    CrossReferenceDescription := '';
                    if RecCrossReference.Description <> '' then CrossReferenceDescription := RecCrossReference.Description;
                    QRPrintingItemInfo.Reset;
                    QRPrintingItemInfo.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::"PRODUCT TYPE");
                    QRPrintingItemInfo.SetRange(QRPrintingItemInfo."Item No.", "Item Ledger Entry"."Item No.");
                    if QRPrintingItemInfo.FindFirst then ProductType := QRPrintingItemInfo."QR Description";
                    QRPrintingItemInfo.Reset;
                    QRPrintingItemInfo.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::"UN NUMBER");
                    QRPrintingItemInfo.SetRange(QRPrintingItemInfo."Item No.", "Item Ledger Entry"."Item No.");
                    if QRPrintingItemInfo.FindFirst then UNNumber := QRPrintingItemInfo."QR Description";
                    QRPrintingItemInfo.Reset;
                    QRPrintingItemInfo.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::PICTOGRAMS);
                    QRPrintingItemInfo.SetRange(QRPrintingItemInfo."Item No.", "Item Ledger Entry"."Item No.");
                    if QRPrintingItemInfo.FindFirst then
                        repeat
                            if QRPrintingItemInfo."QR Print Index" = 1 then begin
                                QRPrinting.Reset;
                                QRPrinting.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::PICTOGRAMS);
                                QRPrinting.SetRange("QR Printing Code", QRPrintingItemInfo."QR Printing Code");
                                if QRPrinting.FindFirst then QRPrinting.CalcFields("QR Images");
                                IndexQR := 1;
                            end;
                            if QRPrintingItemInfo."QR Print Index" = 2 then begin
                                QRPrinting2.Reset;
                                QRPrinting2.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::PICTOGRAMS);
                                QRPrinting2.SetRange("QR Printing Code", QRPrintingItemInfo."QR Printing Code");
                                if QRPrinting2.FindFirst then QRPrinting2.CalcFields("QR Images");
                                IndexQR2 := 2;
                            end;
                            if QRPrintingItemInfo."QR Print Index" = 3 then begin
                                QRPrinting3.Reset;
                                QRPrinting3.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::PICTOGRAMS);
                                QRPrinting3.SetRange("QR Printing Code", QRPrintingItemInfo."QR Printing Code");
                                if QRPrinting3.FindFirst then QRPrinting3.CalcFields("QR Images");
                                IndexQR3 := 3;
                            end;
                            if QRPrintingItemInfo."QR Print Index" = 4 then begin
                                QRPrinting4.Reset;
                                QRPrinting4.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::PICTOGRAMS);
                                QRPrinting4.SetRange("QR Printing Code", QRPrintingItemInfo."QR Printing Code");
                                if QRPrinting4.FindFirst then QRPrinting4.CalcFields("QR Images");
                                IndexQR4 := 4;
                            end;
                        until QRPrintingItemInfo.Next = 0;
                    QRPrintingItemInfo.Reset;
                    QRPrintingItemInfo.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::"SINGLE WORD");
                    QRPrintingItemInfo.SetRange(QRPrintingItemInfo."Item No.", "Item Ledger Entry"."Item No.");
                    if QRPrintingItemInfo.FindFirst then SingleWord := QRPrintingItemInfo."QR Description";

                    //SSD_110325
                    BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
                    BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
                    //IG_DS_Before  BarcodeString := "Item Ledger Entry"."Package No.";
                    BarcodeString := "Package Tracking"."Package No.";
                    if BarcodeString <> '' then PackageQRCode := BarcodeFontProvider2D.EncodeFont(BarcodeString, BarcodeSymbology2D);
                    //SSD_110325
                end;

                trigger OnPreDataItem()
                begin
                    //ALLE-AU 11012020
                    BeforeDate := '<-4M>';
                    Todaydate := Today;
                    Previousdate := CalcDate(BeforeDate, Todaydate);
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
    var
        MfgSetup: Record "Manufacturing Setup";
        Item: Record Item;
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
        Barcode: Record "SSD Barcode Labelpp";
        QRCode: Code[20];
        Previousdate: Date;
        BeforeDate: Text;
        Todaydate: Date;
        UserSetup: Record "User Setup";
        ExpirationDate: Date;
        ILEPostingDate: Date;
        PackageQRCode: Text;

    local procedure CreateQRCodeInput(Name: Text[500]; PhoneNo: Text[80]) QRCodeInput: Text[1024]
    begin
        QRCodeInput := Name + ';' + PhoneNo + ';';
    end;
}

