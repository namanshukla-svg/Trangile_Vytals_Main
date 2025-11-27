Report 50172 "Label - 3 * 5"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Label - 3  5.rdlc';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Entry No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(EntryNo_ItemLedgerEntry; "Item Ledger Entry"."Entry No.")
            {
            }
            column(SerialNo_ItemLedgerEntry; "Item Ledger Entry"."Serial No.")
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
            column(EMail_CompanyInformation; "Company Information"."E-Mail")
            {
            }
            column(Address; "Company Information".Address)
            {
            }
            column(Address2; "Company Information"."Address 2")
            {
            }
            column(City; "Company Information".City)
            {
            }
            column(PhoneNo_CompanyInformation; "Company Information"."Phone No.")
            {
            }
            column(Name_CompanyInformation; "Company Information".Name)
            {
            }
            column(HomePage_CompanyInformation; "Company Information"."Home Page")
            {
            }
            column(PostCode; "Company Information"."Post Code")
            {
            }
            column(Picture_CompanyInformation; "Company Information".Picture)
            {
            }
            column(ResponsibilityCenter; "Company Information"."Responsibility Center")
            {
            }
            column(NameofKAMAMC; NameofKAMAMC)
            {
            }
            column(NameofCustomer; NameofCustomer)
            {
            }
            column(SampleCollectionDt; SampleCollectionDt)
            {
            }
            column(ProductName; ProductName)
            {
            }
            column(ReasonforAnalysis; ReasonforAnalysis)
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
            begin
                QRMng.GetSerial(true);
                QRMng.Run("Item Ledger Entry");
                Barcode.FindFirst;
                NetWT:=Barcode."Net Weight";
                GrossWT:=Barcode."Gross Weight";
                QtyPrint:=Barcode.Quantity;
                Item.Get("Item No.");
                Item.CalcFields("QR Code");
                RecCrossReference.Reset;
                RecCrossReference.SetRange("Item No.", "Item No.");
                RecCrossReference.SetRange("Reference Type", RecCrossReference."Reference Type"::Customer);
                RecCrossReference.SetRange(RecCrossReference."Reference Type No.", SalesShipHead."Sell-to Customer No.");
                if not RecCrossReference.FindFirst then RecCrossReference."Reference No.":='';
                CrossReferenceDescription:='';
                if RecCrossReference.Description <> '' then CrossReferenceDescription:=RecCrossReference.Description;
                QRPrintingItemInfo.Reset;
                QRPrintingItemInfo.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::"PRODUCT TYPE");
                QRPrintingItemInfo.SetRange(QRPrintingItemInfo."Item No.", "Item Ledger Entry"."Item No.");
                if QRPrintingItemInfo.FindFirst then ProductType:=QRPrintingItemInfo."QR Description";
                QRPrintingItemInfo.Reset;
                QRPrintingItemInfo.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::"UN NUMBER");
                QRPrintingItemInfo.SetRange(QRPrintingItemInfo."Item No.", "Item Ledger Entry"."Item No.");
                if QRPrintingItemInfo.FindFirst then UNNumber:=QRPrintingItemInfo."QR Description";
                QRPrintingItemInfo.Reset;
                QRPrintingItemInfo.SetRange("QR Printing Type", QRPrintingItemInfo."qr printing type"::PICTOGRAMS);
                QRPrintingItemInfo.SetRange(QRPrintingItemInfo."Item No.", "Item Ledger Entry"."Item No.");
                if QRPrintingItemInfo.FindFirst then repeat if QRPrintingItemInfo."QR Print Index" = 1 then;
                        if QRPrintingItemInfo."QR Print Index" = 2 then;
                        if QRPrintingItemInfo."QR Print Index" = 3 then;
                        if QRPrintingItemInfo."QR Print Index" = 4 then;
                    until QRPrintingItemInfo.Next = 0;
            end;
            trigger OnPreDataItem()
            begin
                "Company Information".Get;
                "Company Information".CalcFields("Company Information".Picture);
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
                    field(NameofKAMAMC; NameofKAMAMC)
                    {
                        ApplicationArea = All;
                        Caption = 'Name of KAM/ AMC';
                    }
                    field(NameofCustomer; NameofCustomer)
                    {
                        ApplicationArea = All;
                        Caption = ' Name of Customer';
                    }
                    field(SampleCollectionDt; SampleCollectionDt)
                    {
                        ApplicationArea = All;
                        Caption = 'Sample Collection Dt.';
                    }
                    field(ProductName; ProductName)
                    {
                        ApplicationArea = All;
                        Caption = 'Product Name';
                    }
                    field(ReasonforAnalysis; ReasonforAnalysis)
                    {
                        ApplicationArea = All;
                        Caption = 'Reason for Analysis';
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
    "Company Information": Record "Company Information";
    NameofKAMAMC: Text[250];
    NameofCustomer: Text[250];
    SampleCollectionDt: Date;
    ProductName: Text[250];
    ReasonforAnalysis: Text[250];
}
