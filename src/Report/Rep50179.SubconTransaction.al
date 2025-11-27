Report 50179 "Subcon Transaction"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Subcon Transaction.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Delivery Challan Header"; "Delivery Challan Header")
        {
            RequestFilterFields = "No.", "Challan Date";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            column(SubCon; SubCon)
            {
            }
            column(SubCon1; SubCon1)
            {
            }
            column(SubCon2; SubCon2)
            {
            }
            column(SubCon3; SubCon3)
            {
            }
            column(GSTRegNo; Vendor."GST Registration No.")
            {
            }
            column(Desc11; GSTGroup.Description)
            {
            }
            column(Desc; State.Description)
            {
            }
            column(UnitCost; Item."Unit Cost")
            {
            }
            column(VendorNo; "Delivery Challan Header"."Vendor No." + ' ' + "Delivery Challan Header"."Vendor Name")
            {
            }
            column(ChallanDate; "Delivery Challan Header"."Challan Date")
            {
            }
            column(No; "Delivery Challan Header"."No.")
            {
            }
            column(ProdOrderNo; "Delivery Challan Header"."Prod. Order No.")
            {
            }
            column(SuborderNo; "Delivery Challan Header"."Sub. order No.")
            {
            }
            column(InputCaption; InputCaptionLbl)
            {
            }
            dataitem("Delivery Challan Line"; "Delivery Challan Line")
            {
                DataItemLink = "Delivery Challan No."=field("No.");
                DataItemTableView = sorting("Delivery Challan No.", "Line No.")order(ascending);

                column(ReportForNavId_1000000001;1000000001)
                {
                }
                column(ItemNo; "Delivery Challan Line"."Item No.")
                {
                }
                column(Description; "Delivery Challan Line"."Item No." + ' ' + "Delivery Challan Line".Description)
                {
                }
                column(Quantity; "Delivery Challan Line".Quantity)
                {
                }
                column(UnitofMeasure; "Delivery Challan Line"."Unit of Measure")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                if Vendor.Get("Delivery Challan Header"."Vendor No.")then;
                if State.Get(Vendor."State Code")then;
                if Item.Get("Delivery Challan Header"."Item No.")then;
                if GSTGroup.Get(Item."GST Group Code")then;
            end;
        }
        dataitem("Sub. Comp. Rcpt. Header"; "Sub. Comp. Rcpt. Header")
        {
            DataItemTableView = sorting("No.")order(ascending);
            RequestFilterFields = "No.", "Posting Date";

            column(ReportForNavId_1000000003;1000000003)
            {
            }
            column(InputCaption1; InputCaptionLbl)
            {
            }
            column(Desc1; State.Description)
            {
            }
            column(No_SubCompRcptHeader; "Sub. Comp. Rcpt. Header"."No.")
            {
            }
            column(BuyfromVendorName_SubCompRcptHeader; "Sub. Comp. Rcpt. Header"."Buy-from Vendor Name")
            {
            }
            column(ProdOrderNo_SubCompRcptHeader; "Sub. Comp. Rcpt. Header"."Prod. Order No.")
            {
            }
            column(PostingDate_SubCompRcptHeader; "Sub. Comp. Rcpt. Header"."Posting Date")
            {
            }
            column(BuyfromVendorNo_SubCompRcptHeader; "Sub. Comp. Rcpt. Header"."Buy-from Vendor No." + ' ' + "Sub. Comp. Rcpt. Header"."Buy-from Vendor Name")
            {
            }
            column(GSTRegNo1; Vendor1."GST Registration No.")
            {
            }
            dataitem("Sub. Comp. Rcpt. Line"; "Sub. Comp. Rcpt. Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.")order(ascending);

                column(ReportForNavId_1000000014;1000000014)
                {
                }
                column(Desc12; GSTGroup.Description)
                {
                }
                column(No_SubCompRcptLine; "Sub. Comp. Rcpt. Line"."No.")
                {
                }
                column(Description_SubCompRcptLine; "Sub. Comp. Rcpt. Line"."No." + ' ' + "Sub. Comp. Rcpt. Line".Description)
                {
                }
                column(UnitofMeasure_SubCompRcptLine; "Sub. Comp. Rcpt. Line"."Unit of Measure")
                {
                }
                column(Quantity_SubCompRcptLine; "Sub. Comp. Rcpt. Line".Quantity)
                {
                }
                column(UnitCost_SubCompRcptLine; Item."Unit Cost")
                {
                }
                column(OrderNo_SubCompRcptLine; "Sub. Comp. Rcpt. Line"."Order No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if Item.Get("Sub. Comp. Rcpt. Line"."No.")then;
                    if GSTGroup.Get(Item."GST Group Code")then;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if Vendor1.Get("Sub. Comp. Rcpt. Header"."Buy-from Vendor No.")then;
                if State.Get(Vendor1."State Code")then;
            //IF Item.GET("Sub. Comp. Rcpt. Header"."Item No.")THEN;
            end;
        }
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            RequestFilterFields = "No.", "Posting Date";

            column(ReportForNavId_1000000027;1000000027)
            {
            }
            column(LocationName; Location.Name)
            {
            }
            column(LocationGST; Location."GST Registration No.")
            {
            }
            column(TransferfromCode_TransferShipmentHeader; "Transfer Shipment Header"."Transfer-from Code")
            {
            }
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Shipment Header"."Transfer Order No.")
            {
            }
            column(InputCaption2; InputCaptionLbl)
            {
            }
            column(InputCaption3; InputCaptionLbl)
            {
            }
            column(Desc2; State.Description)
            {
            }
            column(VendorNo_TransferShipmentHeader; "Transfer Shipment Header"."Vendor No.")
            {
            }
            column(PostingDate_TransferShipmentHeader; "Transfer Shipment Header"."Posting Date")
            {
            }
            column(No_TransferShipmentHeader; "Transfer Shipment Header"."No.")
            {
            }
            column(ProdOrderNo_TransferShipmentHeader; "Transfer Shipment Header"."Prod. Order No.")
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.")order(ascending);

                column(ReportForNavId_1000000033;1000000033)
                {
                }
                column(GSTGroupDescription; GSTGroup.Description)
                {
                }
                column(UnitPrice_TransferShipmentLine; "Transfer Shipment Line"."Unit Price")
                {
                }
                column(ItemNo_TransferShipmentLine; "Transfer Shipment Line"."Item No.")
                {
                }
                column(Quantity_TransferShipmentLine; "Transfer Shipment Line".Quantity)
                {
                }
                column(UnitofMeasure_TransferShipmentLine; "Transfer Shipment Line"."Unit of Measure")
                {
                }
                column(Description_TransferShipmentLine; "Transfer Shipment Line"."Item No." + ' ' + "Transfer Shipment Line".Description)
                {
                }
                column(QtyConsumed_SubOrderCompListVend; QtyConsumed)
                {
                }
                trigger OnAfterGetRecord()
                var
                    Item_L: Record Item;
                    GSTGroup_L: Record "GST Group";
                begin
                    if Item_L.Get("Transfer Shipment Line"."Item No.")then;
                    if GSTGroup.Get(Item_L."GST Group Code")then;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if Location.Get("Transfer Shipment Header"."Transfer-to Code")then;
            end;
        }
        dataitem("Sub Order Comp. List Vend"; "Sub Order Comp. List Vend")
        {
            column(ReportForNavId_1000000048;1000000048)
            {
            }
            trigger OnAfterGetRecord()
            begin
                QtyConsumed:=0;
                "Sub Order Comp. List Vend".CalcFields("Sub Order Comp. List Vend"."Qty. Consumed");
                QtyConsumed:="Qty. Consumed";
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("SubCon Trans. for Send"; SubCon)
                {
                    ApplicationArea = All;
                }
                field("SubCon Trans. for Received"; SubCon1)
                {
                    ApplicationArea = All;
                }
                field("SubCon Trans. for Trans.Order"; SubCon2)
                {
                    ApplicationArea = All;
                }
                field("SubCon Trans. for Trans.Order Consumption"; SubCon3)
                {
                    ApplicationArea = All;
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
    var Vendor: Record Vendor;
    State: Record State;
    Item: Record Item;
    SubCon: Boolean;
    SubCon1: Boolean;
    SubCon2: Boolean;
    SubCon3: Boolean;
    InputCaptionLbl: label 'Input';
    QtyConsumed: Decimal;
    GSTGroup: Record "GST Group";
    Vendor1: Record Vendor;
    Location: Record Location;
}
