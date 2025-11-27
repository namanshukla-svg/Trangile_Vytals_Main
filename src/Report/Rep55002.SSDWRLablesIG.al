report 55002 "SSD WR Lables IG"
{
    Caption = 'Receipt Lables IG';
    WordMergeDataItem = "Warehouse Receipt Header";
    //IG_DS UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/WR_Labels_IG.rdl';
    //IG_DS ApplicationArea = All;

    dataset
    {
        dataitem("Warehouse Receipt Header"; "Warehouse Receipt Header")
        {
            //PrintOnlyIfDetail = true;
            dataitem("Warehouse Receipt Line"; "Warehouse Receipt Line")
            {
                RequestFilterFields = "Item No.";
                //PrintOnlyIfDetail = true;
                DataItemLink = "No." = field("No.");

                dataitem(ReservationEntry; "Package Tracking")//IG_DS "Reservation Entry")
                {
                    //PrintOnlyIfDetail = true;
                    DataItemLink = "Source Subtype" = field("Source Subtype"), "Source Type" = field("Source Type"), "Source ID" = field("Source No."), "Source Ref. No." = field("Line No.");
                    RequestFilterFields = "Package No.";

                    column(ItemNo; "Item No.")
                    {
                    }
                    column(Quantity__Base_; Quantity)//IG_DS "Quantity (Base)")
                    {
                    }
                    column(Lot_No_; "Lot No.")
                    {
                    }
                    column(Package_No_; "Package No.")
                    {
                    }
                    column(LotNoQRCode; LotNoQRCode)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        Item: Record "Item";
                        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
                        BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
                        BarcodeString: Text;
                    begin
                        Item.SetLoadFields(Item.Description, "Description 2", "Base Unit of Measure");
                        Item.Get("Item No.");
                        BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
                        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
                        //IG_DS_Before BarcodeString := "Item No." + ',' + Item.Description + ',' + Item."Description 2" + ',' + Format("Qty. to Handle (Base)") + ',' + Item."Base Unit of Measure" + ',' + "Lot No." + ',' + "Package No.";
                        BarcodeString := "Item No." + ',' + Item.Description + ',' + Item."Description 2" + ',' + Format(Quantity) + ',' + Item."Base Unit of Measure" + ',' + "Lot No." + ',' + "Package No.";
                        if BarcodeString <> '' then LotNoQRCode := BarcodeFontProvider2D.EncodeFont(BarcodeString, BarcodeSymbology2D);
                    end;
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
    }
    var
        LotNoQRCode: Text;
}
