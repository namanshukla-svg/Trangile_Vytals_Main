Report 55005 "Label - 3 * 2 IG"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Label - 3  2_IG.rdl';
    PreviewMode = PrintLayout;
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
                column(mfgsLabel; 'MFG.  DATE')
                {
                }
                column(BestBeforeLabel; 'BEST BEFORE')
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
                    DataItemLink = "Item No." = field("Item No.");
                    DataItemTableView = sorting("QR Printing Type", "QR Printing Code", "Item No.") order(ascending) where("QR Printing Type" = filter(<> "PRODUCT TYPE" & <> "UN NUMBER"));

                    column(ReportForNavId_1000000011; 1000000011)
                    {
                    }
                    column(Sno; 'P' + Format(Sno))
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
                        Sno += 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        Sno := 0;
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    SalesShipHead: Record "Sales Shipment Header";
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
                    Barcode.FindFirst;
                    //IG_DS
                    Itemtext := DelChr(Item.Description, '=', '®,™');
                    QRCodeInput := CreateQRCodeInput(Itemtext + 'Desc:' + Item."Description 2" + '; Lot:' + "Item Ledger Entry"."Lot No." + '; Item:' + Item."No." + '; Location:' + "Item Ledger Entry"."Location Code" + '; QTY:' + Format(Barcode.Quantity) + '; Mfg. Date/Best Before-' + Format("Item Ledger Entry"."Expiration Date") + '-NW-' + Format(Barcode."Net Weight"), '-GW-' + Format(Barcode."Gross Weight") + '-' + Item."Base Unit of Measure" + '; Package No: ' + "Package Tracking"."Package No."); //SSD_Sunil_110325_Add package No.
                    TempBlob1.CreateInStream(IS_iIN); //IG_DS_AFter
                    QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob1);
                    MfgSetup.Get();
                    Clear(MfgSetup."Label QR Code");
                    MfgSetup."Label QR Code".CreateOutStream(OS_iOS);
                    COPYSTREAM(OS_iOS, IS_iIN);
                    //IG_DS
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
                    RecCrossReference.SetRange("Reference Type", RecCrossReference."Reference Type"::Customer);
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
                            if QRPrintingItemInfo."QR Print Index" = 1 then;
                            if QRPrintingItemInfo."QR Print Index" = 2 then;
                            if QRPrintingItemInfo."QR Print Index" = 3 then;
                            if QRPrintingItemInfo."QR Print Index" = 4 then;
                        until QRPrintingItemInfo.Next = 0;
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
        ExpirationDate: Date;
        ILEPostingDate: Date;

    local procedure CreateQRCodeInput(Name: Text[500]; PhoneNo: Text[80]) QRCodeInput: Text[1024]
    begin
        QRCodeInput := Name + ';' + PhoneNo + ';';
    end;
}
