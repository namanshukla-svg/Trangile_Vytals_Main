Codeunit 50024 UnitCostAPI
{
    trigger OnRun()
    begin
    end;
    var CustXmlFile: File;
    XmlStream: OutStream;
    CXml: XmlPort UnitCostAPI;
    procedure ItemMasterExport(ItemNo: Code[20]; Date: Date; var UnitpriceAPI: XmlPort UnitCostAPI)
    var
        Item: Record Item;
        UnitItemTab: Record "SSD Unit Cost API";
        UnitCostAPI: XmlPort UnitCostAPI;
        CDate: Date;
    begin
        UnitItemTab.Reset;
        UnitItemTab.SetCurrentkey("Item No.", "Creation Date");
        UnitItemTab.SetRange("Item No.", ItemNo);
        UnitItemTab.SetRange("Creation Date", Date);
        UnitpriceAPI.SetTableview(UnitItemTab);
        UnitpriceAPI.Export;
        Commit;
    end;
}
