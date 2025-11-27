Codeunit 50009 "QR Code Management"
{
    // CAPMB 01JUN15: This objects assigns a QR Code related to a Sales Order and saves it into a BLOB field with Customer Information embedded in the QR Code
    //              : Visit http://www.capricorndynamics.com/ for more details
    //              : Email michael@capricorndynamics.com
    Permissions = TableData Customer=rm;
    TableNo = "Item Ledger Entry";

    trigger OnRun()
    var
        CompanyInfo: Record Company;
        Cust: Record Customer;
        Item: Record Item;
        ItemLegderEntry: Record "Item Ledger Entry";
        SalesHeader: Record "Sales Header";
        BarcodeL: Record "SSD Barcode Labelpp";
        TempBlob: Codeunit "Temp Blob";
        QRGenerator: Codeunit "QR Generator";
        SSDRecRef: RecordRef;
        SSDFieldRef: FieldRef;
        Itemtext: Text;
        QRCodeFileName: Text[1024];
        QRCodeInput: Text[1024];
    begin
        // Save a QR code image into a file in a temporary folder
        ItemLegderEntry:=Rec;
        // Get Customer Information
        if not GRPO and not GSalesInv then Item.Get(Rec."Item No.");
        if GSalesInv then Cust.Get(GSalesInvHeader."Sell-to Customer No.");
        if GSerialTest then QRCodeInput:=CreateQRCodeInput(Rec."Serial No.", COMPANYNAME);
        if GRPO then Item.Get(GReservationEntry."Item No.");
        ILEDate:=Format(ItemLegderEntry."Posting Date") + '/' + Format(ItemLegderEntry."Expiration Date");
        //Alle_150519_begin
        ProductionOrder.Reset;
        ProductionOrder.SetRange("No.", GReservationEntry."Source ID");
        if ProductionOrder.FindFirst then MfgDate:=ProductionOrder."Last Date Modified";
        if MfgDate <> 0D then BestBefore:=CalcDate(Item."Expiration Calculation", MfgDate);
        //Alle_150919_end
        // Assign QR Code Information for scanning
        BarcodeL.FindFirst;
        //QRCodeInput := CreateQRCodeInput(Item."No."+'-'+Item.Description+'-'+Item."Description 2"+'-'+"Lot No.",'QTY.-'+FORMAT(BarcodeL.Quantity)
        // +'-NW-'+FORMAT(BarcodeL."Net Weight")+'-GW-'+FORMAT(BarcodeL."Gross Weight")+'-'+ItemLegderEntry."Unit of Measure Code");
        /*
        QRCodeInput := CreateQRCodeInput(Item."No."+'-'+Item.Description+'-'+Item."Description 2"+'-'+GReservationEntry."Lot No."+'Mfg. Date/Best Before-'+ILEDate,'QTY.-'+FORMAT(BarcodeL.Quantity)
          +'-NW-'+FORMAT(BarcodeL."Net Weight")+'-GW-'+FORMAT(BarcodeL."Gross Weight")+'-'+Item."Base Unit of Measure"+'-'+'Lot No.-'+'-'+ItemLegderEntry."Lot No.");
         */
        //CORP
        Itemtext:=DelChr(Item.Description, '=', '®,™');
        QRCodeInput:=CreateQRCodeInput(Itemtext + 'Desc:' + Item."Description 2" + '; Lot:' + ItemLegderEntry."Lot No." + '; Item:' + Item."No." + '; Location:' + ItemLegderEntry."Location Code" + '; QTY:' + Format(BarcodeL.Quantity) + '; Mfg. Date/Best Before-' + Format(ItemLegderEntry."Expiration Date") + '-NW-' + Format(BarcodeL."Net Weight"), '-GW-' + Format(BarcodeL."Gross Weight") + '-' + Item."Base Unit of Measure" + '; Package No: ' + ItemLegderEntry."Package No."); //SSD_Sunil_110325_Add package No.
        if GSalesInv then QRCodeInput:=CreateQRCodeInput(GSalesInvHeader."No." + ';' + Format(GSalesInvHeader."Posting Date") + ';' + GSalesInvHeader."External Document No.", GSalesInvHeader."Sell-to Customer Name"); //+';'+GSalesInvHeader."Sell-to Customer No." +';'+Cust."Our Account No."); //CORP
        if GRPO then begin
            Item.Get(GReservationEntry."Item No.");
            //Item.GET(RPONo);
            //QRCodeInput := CreateQRCodeInput(Item."No."+'-'+Item.Description+'-'+Item."Description 2"+'-'+GReservationEntry."Lot No.",'QTY.-'+FORMAT(BarcodeL.Quantity)
            // +'-NW-'+FORMAT(BarcodeL."Net Weight")+'-GW-'+FORMAT(BarcodeL."Gross Weight")+'-'+Item."Base Unit of Measure");
            /*QRCodeInput := CreateQRCodeInput(Item."No."+'-'+Item.Description+'-'+Item."Description 2"+'-'+GReservationEntry."Lot No."+'Mfg. Date/Best Before-'+ILEDate,'QTY.-'+FORMAT(BarcodeL.Quantity)
              +'-NW-'+FORMAT(BarcodeL."Net Weight")+'-GW-'+FORMAT(BarcodeL."Gross Weight")+'-'+Item."Base Unit of Measure"+'-'+'Lot No.-'+'-'+ItemLegderEntry."Lot No.");*/
            //QRCodeInput := CreateQRCodeInput('Desc: '+RPONo+Item.Description+'-'+Item."Description 2"+'; Lot: '+GReservationEntry."Lot No."+ '; Item: ' + GReservationEntry."Item No." + '; Location: ' + GReservationEntry."Location Code" + '; QTY: ' +
            //FORMAT(GReservationEntry.Quantity),'Mfg. Date-'+FORMAT(MfgDate)+'/Best Before-'+FORMAT(GReservationEntry."Expiration Date") + 'QTY.-'+FORMAT(BarcodeL.Quantity)
            //+'-NW-'+FORMAT(BarcodeL."Net Weight")+'-GW-'+FORMAT(BarcodeL."Gross Weight")+'-'+Item."Base Unit of Measure");
            Itemtext:=DelChr(Item.Description, '=', '®,™');
            QRCodeInput:=CreateQRCodeInput(Itemtext + 'Desc:' + Item."Description 2" + '; Lot:' + GReservationEntry."Lot No." + '; Item:' + Item."No." + '; Location:' + GReservationEntry."Location Code" + '; QTY:' + Format(BarcodeL.Quantity) + '; Mfg. Date' + Format(MfgDate) + '/Best Before-' + Format(BestBefore) + '-NW-' + Format(BarcodeL."Net Weight"), '-GW-' + Format(BarcodeL."Gross Weight") + '-' + Item."Base Unit of Measure");
        //MESSAGE('%1...%2',MfgDate,BestBefore);
        end;
        //message('%1', QRCodeInput);
        // QRCodeFileName := GetQRCode(QRCodeInput);
        // QRCodeFileName := MoveToMagicPath(QRCodeFileName);
        // To avoid confirmation dialogue on RTC
        // Load the image from file into the BLOB field
        Clear(TempBlob);
        //Message(QRCodeInput);
        QRGenerator.GenerateQRCodeImage(QRCodeInput, TempBlob);
        if not GSalesInv then begin
            SSDRecRef.GetTable(Item);
            SSDFieldRef:=SSDRecRef.Field(Item.FieldNo("QR Code"));
            TempBlob.ToRecordRef(SSDRecRef, Item.FieldNo("QR Code"));
            SSDRecRef.Modify();
        end
        else
        begin
            SSDRecRef.GetTable(Cust);
            SSDFieldRef:=SSDRecRef.Field(Cust.FieldNo("QR Code"));
            TempBlob.ToRecordRef(SSDRecRef, Cust.FieldNo("QR Code"));
            SSDRecRef.Modify();
        end;
    //SSD Comment Start
    // Clear(TempBlob);
    // ThreeTierMgt.BLOBImport(TempBlob, QRCodeFileName);
    // if TempBlob.Blob.Hasvalue then begin
    //     if not GSalesInv then begin
    //         Item."QR Code" := TempBlob.Blob;
    //         Item.Modify;
    //     end else begin
    //         Cust."QR Code" := TempBlob.Blob;
    //         Cust.Modify;
    //     end;
    //end;
    //SSD Comment End
    // Erase the temporary file
    //SSD Comment Start
    // if not ISSERVICETIER then
    //     if Exists(QRCodeFileName) then
    //         Erase(QRCodeFileName);
    //SSD Comment Start
    end;
    var ProductionOrder: Record "Production Order";
    GPurchCrHeader: Record "Purch. Cr. Memo Hdr.";
    GReservationEntry: Record "Reservation Entry";
    GSalesInvHeader: Record "Sales Invoice Header";
    ThreeTierMgt: Codeunit "File Management";
    GPurchCr: Boolean;
    GRPO: Boolean;
    GSalesInv: Boolean;
    GSerialTest: Boolean;
    BestBefore: Date;
    MfgDate: Date;
    ILEDate: Text;
    local procedure CreateQRCodeInput(Name: Text[500]; PhoneNo: Text[80])QRCodeInput: Text[1024]begin
        QRCodeInput:=Name + ';' + PhoneNo + ';';
    end;
    procedure SaleInv(SalesInv: Boolean; SalesInvHeader: Record "Sales Invoice Header"; PurchCr: Boolean; PurchCrHead: Record "Purch. Cr. Memo Hdr.")
    begin
        GSalesInv:=SalesInv;
        GPurchCr:=PurchCr;
        if SalesInv then GSalesInvHeader:=SalesInvHeader;
        if PurchCr then GPurchCrHeader:=PurchCrHead;
    end;
    procedure GetRPO(RPO: Boolean; ReservationEntry: Record "Reservation Entry")
    begin
        GRPO:=RPO;
        if RPO then GReservationEntry:=ReservationEntry;
    end;
    procedure GetSerial(Serail: Boolean)
    begin
        GSerialTest:=Serail;
    end;
}
