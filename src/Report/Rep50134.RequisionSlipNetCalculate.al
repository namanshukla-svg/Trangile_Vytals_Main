Report 50134 "Requision Slip Net Calculate"
{
    // SP_NDM003
    //   - Create a process Report For Inser Record on Requisition Line From Net Component Line
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Prod. Order Component"; "Prod. Order Component")
        {
            DataItemTableView = sorting("Item No.")where(Status=filter(Released));
            RequestFilterFields = "Prod. Order No.";

            column(ReportForNavId_7771;7771)
            {
            }
            trigger OnAfterGetRecord()
            begin
                if ProdOrder.Get(Status, "Prod. Order No.")then if ProdOrder."Req Generated" then CurrReport.Skip;
            /*
                IF ItemRec1.GET("Item No.") THEN
                  IF ItemRec1."Replenishment System" = ItemRec1."Replenishment System"::"Prod. Order" THEN
                    IF NOT ItemRec1."Job Work Item" THEN
                      CurrReport.SKIP;
                 */
            //5.51
            end;
            trigger OnPreDataItem()
            begin
                CalcFields("Replensihment System");
            //SETRANGE("Replensihment System","Replensihment System"::Purchase);
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var ReqSlipNum: Code[20];
    SDim1Code: Code[20];
    SDim2Code: Code[20];
    RespCent: Code[20];
    TFromLoc: Code[10];
    ProdOrderComp: Record "Prod. Order Component";
    ProdOrderFilter: Text[30];
    ReqSlipLine: Record "SSD Requision Slip Line";
    LineNo: Integer;
    ReqSlipLineRec: Record "SSD Requision Slip Line";
    DocType1: Option " ", "Material Issue", "Material Return";
    RecItem: Code[20];
    XRecItem: Code[20];
    TotalQty: Decimal;
    DocSubType: Option;
    ItemRec: Record Item;
    ToLocationGlb: Code[10];
    ProdOrder: Record "Production Order";
    ItemRec1: Record Item;
    procedure SetDefaults(ReqSlipNo: Code[20]; ShorcutDim1Code: Code[20]; ShorcutDim2Code: Code[20]; RespCenter: Code[20]; FromLoc: Code[10]; DocType: Option " ", "Material Issue", "Material Return"; ToLocation: Code[10])
    begin
        ReqSlipNum:=ReqSlipNo;
        SDim1Code:=ShorcutDim1Code;
        SDim2Code:=ShorcutDim2Code;
        RespCent:=RespCenter;
        TFromLoc:=FromLoc;
        DocType1:=DocType;
        ToLocationGlb:=ToLocation;
    end;
}
