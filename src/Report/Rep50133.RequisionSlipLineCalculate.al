Report 50133 "Requision Slip Line Calculate"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = sorting(Status, "No.")order(ascending)where(Status=filter(Released), "Req Generated"=filter(false));
            RequestFilterFields = "No.", "Inventory Posting Group", "Gen. Prod. Posting Group";

            column(ReportForNavId_4824;4824)
            {
            }
            trigger OnAfterGetRecord()
            begin
                ReqSlipLine.Reset;
                ReqSlipLine.SetRange(ReqSlipLine."Req. Slip Document No.", ReqSlipNum);
                if ReqSlipLine.FindLast then LineNo:=ReqSlipLine."Line No."
                else
                    LineNo:=0;
                ProdOrderComp.Reset;
                ProdOrderComp.SetFilter(ProdOrderComp."Prod. Order No.", "Production Order"."No.");
                ProdOrderComp.SetRange("Completely Issued", false);
                if InventoryPostingFilter <> '' then ProdOrderComp.SetRange("Inventory Posting Group", InventoryPostingFilter);
                if ProdOrderComp.FindFirst then repeat LineNo+=10000;
                        ReqSlipLineRec.Init;
                        ReqSlipLineRec."Document Type":=DocType1;
                        ReqSlipLineRec."Document No.":=ReqSlipNum;
                        ReqSlipLineRec."Req. Slip Document No.":=ReqSlipNum;
                        ReqSlipLineRec."Line No.":=LineNo;
                        ReqSlipLineRec."Prod. Order No.":=ProdOrderComp."Prod. Order No.";
                        ReqSlipLineRec."Prod. Order Line No.":=ProdOrderComp."Prod. Order Line No.";
                        ReqSlipLineRec.Validate("Item No.", ProdOrderComp."Item No.");
                        ReqSlipLineRec.Description:=ProdOrderComp.Description;
                        ReqSlipLineRec."Unit of Measure Code":=ProdOrderComp."Unit of Measure Code";
                        ReqSlipLineRec.Quantity:=ProdOrderComp."Expected Quantity";
                        ReqSlipLineRec."Routing Link Code":=ProdOrderComp."Routing Link Code";
                        ReqSlipLineRec."Due Date":=ProdOrderComp."Due Date";
                        ReqSlipLineRec."Due Time":=ProdOrderComp."Due Time";
                        ReqSlipLineRec."Due Date-Time":=ProdOrderComp."Due Date-Time";
                        ReqSlipLineRec."Location Code":=ProdOrderComp."Location Code";
                        ReqSlipLineRec."Remaining Qty":=ProdOrderComp."Remaining Quantity";
                        ReqSlipLineRec."Issued Qty":=ProdOrderComp."Expected Quantity" - ProdOrderComp."Remaining Quantity";
                        ReqSlipLineRec."From-Location Code":=TFromLoc;
                        ReqSlipLineRec."Responsibility Center":=RespCent;
                        ReqSlipLineRec."Shortcut Dimension 1 Code":=SDim1Code;
                        ReqSlipLineRec."Shortcut Dimension 2 Code":=SDim2Code;
                        ReqSlipLineRec."Quantity Per":=ProdOrderComp."Quantity per";
                        ReqSlipLineRec."Location Code":=ToLocationGlb;
                        ReqSlipLineRec."Prod.Order Source No.":=ProdOrderComp."Source No.";
                        ReqSlipLineRec.Insert;
                    until ProdOrderComp.Next = 0;
            end;
            trigger OnPreDataItem()
            begin
            //InventoryPostingFilter:= GETFILTER("Inventory Posting Group");
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
    trigger OnPreReport()
    begin
        ProdOrderFilter:="Production Order".GetFilter("Production Order"."No.");
    end;
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
    ToLocationGlb: Code[10];
    InventoryPostingFilter: Code[20];
    InventoryPostingGrp: Code[10];
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
