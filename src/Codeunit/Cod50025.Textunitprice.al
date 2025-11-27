Codeunit 50025 Textunitprice
{
    trigger OnRun()
    begin
        ItemMasterExport(20220811D, 'RM000060');
    end;
    procedure ItemMasterExport(Date: Date; ItemNo: Code[20])
    var
        Item: Record Item;
        UnitItemTab: Record "SSD Unit Cost API";
        UnitCostAPI: XmlPort UnitCostAPI;
        CDate: Date;
    begin
        //EVALUATE(CDate,Date);
        UnitItemTab.SetFilter("Item No.", ItemNo);
        UnitItemTab.SetRange("Creation Date", Date);
        UnitCostAPI.SetTableview(UnitItemTab);
        UnitCostAPI.Export;
        Commit;
    // CustXmlFile.CREATE(TEMPORARYPATH + 'Customer.xml');
    // CustXmlFile.CREATEOUTSTREAM(XmlStream);
    // IsExported := XMLPORT.EXPORT(XMLPORT::UnitCostAPI, XmlStream);
    // XmlStream.WRITETEXT(responsetxt);
    // FromFile := CustXmlFile.NAME;
    // ToFile := 'CustomerClient.xml';
    // CustXmlFile.CLOSE;
    // IF IsExported THEN
    // BEGIN
    //  DOWNLOAD(FromFile,'Download file','C:\Temp','Xml file(*.xml)|*.xml',ToFile);
    //  ERASE(FromFile);
    //  MESSAGE('The Export completed');
    // END
    // ELSE
    //  MESSAGE('The Export Failed.');
    end;
}
