Report 50002 "Dispatch Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Dispatch Slip.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.");
            RequestFilterFields = "No.", "Posting Date";

            column(ReportForNavId_6640;6640)
            {
            }
            column(ResName; ResName)
            {
            }
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header__Posting_Date_; "Posting Date")
            {
            }
            column(UserId; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Sales_Header__Sales_Header___Sell_to_Customer_Name_; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(Sales_Header__Sales_Header___External_Document_No__; "Sales Header"."External Document No.")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Sales_Header__Order_Scd__No__; "Order/Scd. No.")
            {
            }
            column(Work_Order__;'Work Order ')
            {
            }
            column(ResAdd; ResAdd)
            {
            }
            column(Sales_Schedule_Buffer___No__of_Box_; "Sales Schedule Buffer"."No. of Box")
            {
            }
            column(Sales_Schedule_Buffer___Actual_Weight_; "Sales Schedule Buffer"."Actual Weight")
            {
            }
            column(Sales_Schedule_Buffer___Gross_Weight_; "Sales Schedule Buffer"."Gross Weight")
            {
            }
            column(Total_;'Total')
            {
            }
            column(Sales_Schedule_Buffer___Total_Qty_; "Sales Schedule Buffer"."Total Qty")
            {
            }
            column(Packing_ListCaption; Packing_ListCaptionLbl)
            {
            }
            column(Dispatch_Slip_No_Caption; Dispatch_Slip_No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Sales_Schedule_Buffer__No__of_Box_Caption; Sales_Schedule_Buffer__No__of_Box_CaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(G__Wt__KG_Caption; G__Wt__KG_CaptionLbl)
            {
            }
            column(N__Wt__KG_Caption; N__Wt__KG_CaptionLbl)
            {
            }
            column(Product_CodeCaption; Product_CodeCaptionLbl)
            {
            }
            column(Product_DescriptionCaption; Product_DescriptionCaptionLbl)
            {
            }
            column(S_No_Caption; S_No_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(P_O_No_Caption; P_O_No_CaptionLbl)
            {
            }
            column(Sales_Schedule_Buffer__Sales_Schedule_Buffer___Batch_No__Caption; "Sales Schedule Buffer".FieldCaption("Batch No."))
            {
            }
            column(Sales_Line___Unit_of_Measure_Code_Caption; Sales_Line___Unit_of_Measure_Code_CaptionLbl)
            {
            }
            column(Sales_Schedule_Buffer_PackingCaption; Sales_Schedule_Buffer_PackingCaptionLbl)
            {
            }
            column(Auth__SignatoryCaption; Auth__SignatoryCaptionLbl)
            {
            }
            column(Prepared_byCaption; Prepared_byCaptionLbl)
            {
            }
            column(Notes___RemarksCaption; Notes___RemarksCaptionLbl)
            {
            }
            column(FM_ST_03__Rev__00_Effective_date_13_01_2012_Caption; FM_ST_03__Rev__00_Effective_date_13_01_2012_CaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type"=field("Document Type"), "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "No.")order(ascending);

                column(ReportForNavId_2844;2844)
                {
                }
                column(Sales_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Line_Line_No_; "Line No.")
                {
                }
                column(Sales_Line_Sell_to_Customer_No_; "Sell-to Customer No.")
                {
                }
                column(Sales_Line_No_; "No.")
                {
                }
                column(Bin_Code; "Bin Code")
                {
                }
                dataitem("Sales Schedule Buffer"; "SSD Sales Schedule Buffer")
                {
                    CalcFields = "Lot No.";
                    DataItemLink = "Document Type"=field("Document Type"), "Document No."=field("Document No."), "Sell-to Customer No."=field("Sell-to Customer No."), "Order Line No."=field("Line No."), "Item No."=field("No.");
                    DataItemTableView = sorting("Document Type", "Document No.", "Sell-to Customer No.", "Order Line No.", "Item No.", "Line No.")order(ascending);

                    column(Sales_Line___No__; "Sales Line"."No.")
                    {
                    }
                    column(Sales_Line__Description__________Sales_Line___Description_2_; "Sales Line".Description + ' ' + "Sales Line"."Description 2")
                    {
                    }
                    column(Sales_Schedule_Buffer__No__of_Box_; "No. of Box")
                    {
                    }
                    column(SrNo; SrNo)
                    {
                    }
                    column(Sales_Schedule_Buffer__Actual_Weight_; "Actual Weight")
                    {
                    }
                    column(Sales_Schedule_Buffer__Sales_Schedule_Buffer___Total_Qty_; "Sales Schedule Buffer"."Total Qty")
                    {
                    }
                    column(SSBTotalQty; SSBTotalQty)
                    {
                    }
                    column(SSBNoOfBox; SSBNoOfBox)
                    {
                    }
                    column(SSBGrossWeight; SSBGrossWeight)
                    {
                    }
                    column(Sales_Schedule_Buffer__Gross_Weight_; "Gross Weight")
                    {
                    }
                    column(Batch_No_; "Batch No.")
                    {
                    }
                    column(Lot_No_; "Lot No.")
                    {
                    }
                    column(Sales_Schedule_Buffer__Sales_Schedule_Buffer___Batch_No__; "Sales Schedule Buffer"."Batch No.")
                    {
                    }
                    column(Sales_Schedule_Buffer__Sales_Schedule_Buffer___Lot_No__; LotNo)
                    {
                    }
                    column(Sales_Line___Unit_of_Measure_Code_; "Sales Line"."Unit of Measure Code")
                    {
                    }
                    column(Qty_per_Box; "Qty per Box")
                    {
                    }
                    column(Sales_Schedule_Buffer_Packing; Packing)
                    {
                    }
                    column(Sales_Schedule_Buffer_Document_Type; "Document Type")
                    {
                    }
                    column(Sales_Schedule_Buffer_Document_No_; "Document No.")
                    {
                    }
                    column(Sales_Schedule_Buffer_Sell_to_Customer_No_; "Sell-to Customer No.")
                    {
                    }
                    column(Sales_Schedule_Buffer_Order_Line_No_; "Order Line No.")
                    {
                    }
                    column(Sales_Schedule_Buffer_Item_No_; "Item No.")
                    {
                    }
                    column(Sales_Schedule_Buffer_Line_No_; "Line No.")
                    {
                    }
                    dataitem("Item Phy. Bin Details"; "SSD Item Phy. Bin Details")
                    {
                        DataItemLink = "Document No."=field("Document No."), "Item No."=field("Item No.");

                        column(ReportForNavId_1000000008;1000000008)
                        {
                        }
                        column(Quantity_ItemPhyBinDetails; Abs("Item Phy. Bin Details".Quantity))
                        {
                        }
                        column(PhyBinCode_ItemPhyBinDetails; "Item Phy. Bin Details"."Phy. Bin Code")
                        {
                        }
                        column(LotNo_ItemPhyBinDetails; "Item Phy. Bin Details"."Lot No.")
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            // <<<< Alle 31072020
                            if Flag_1 then "Item Phy. Bin Details".SetRange("Line No.", "Sales Schedule Buffer"."Line No.");
                            if Flag_2 then "Item Phy. Bin Details".SetRange("Document Line No.", "Sales Schedule Buffer"."Order Line No.");
                        // >>>> Alle 31072020
                        end;
                    }
                    trigger OnAfterGetRecord()
                    var
                        SalesScheduleBuffer: Record "SSD Sales Schedule Buffer";
                        SalesShipmentLine: Record "Sales Shipment Line";
                        ItemLedgerEntry: Record "Item Ledger Entry";
                        OrderLineNo: Integer;
                        LineNo: Integer;
                        Cont: Integer;
                    begin
                        SrNo:=SrNo + 1;
                        SSBNoOfBox+="Sales Schedule Buffer"."No. of Box";
                        SSBTotalQty+="Sales Schedule Buffer"."Total Qty";
                        SSBGrossWeight+="Sales Schedule Buffer"."Gross Weight";
                        "Sales Schedule Buffer".CalcFields("Lot No.");
                        // <<<< Alle 31072020
                        if Flag = false then begin
                            SalesScheduleBuffer.Reset;
                            SalesScheduleBuffer.SetRange("Document No.", "Sales Schedule Buffer"."Document No.");
                            if SalesScheduleBuffer.FindSet then begin
                                repeat Cont+=1;
                                    if Cont = 2 then begin
                                        if LineNo <> SalesScheduleBuffer."Line No." then Flag_1:=true;
                                        if OrderLineNo <> SalesScheduleBuffer."Order Line No." then Flag_2:=true;
                                    end;
                                    LineNo:=SalesScheduleBuffer."Line No.";
                                    OrderLineNo:=SalesScheduleBuffer."Order Line No.";
                                until SalesScheduleBuffer.Next = 0;
                                Flag:=true;
                            end;
                        end;
                        // >>>> Alle 31072020
                        //SSD
                        LotNo:='';
                        if "Lot No." <> '' then LotNo+="Lot No.";
                        SalesShipmentLine.SetRange("Despatch Slip No.", "Document No.");
                        SalesShipmentLine.SetRange("Despatch Slip Line No.", "Order Line No.");
                        if SalesShipmentLine.FindFirst()then begin
                            ItemLedgerEntry.SetCurrentKey("Document No.", "Document Type", "Document Line No.");
                            ItemLedgerEntry.SetRange("Document No.", SalesShipmentLine."Document No.");
                            ItemLedgerEntry.SetRange("Document Line No.", SalesShipmentLine."Line No.");
                            if ItemLedgerEntry.FindSet()then repeat if ItemLedgerEntry."Lot No." <> '' then if LotNo = '' then LotNo:=ItemLedgerEntry."Lot No."
                                        else
                                            LotNo+=',' + ItemLedgerEntry."Lot No.";
                                until ItemLedgerEntry.Next() = 0;
                        end;
                    //SSD
                    end;
                }
                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals("Sales Schedule Buffer"."No. of Box", "Sales Schedule Buffer"."Gross Weight", "Sales Schedule Buffer"."Actual Weight", "Sales Schedule Buffer"."Total Qty");
                end;
            }
            trigger OnAfterGetRecord()
            begin
                SrNo:=0;
            end;
            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals("Sales Schedule Buffer"."No. of Box", "Sales Schedule Buffer"."Gross Weight", "Sales Schedule Buffer"."Actual Weight", "Sales Schedule Buffer"."Total Qty");
                //"Sales Header".SetRange("Responsibility Center", ResponsibilityCenter.Code);
                if not StateRec.Get(CompanyInfo."State Code")then StateRec.Init;
                ResName:=CompanyInfo.Name;
                ResAdd:=CompanyInfo.Address + ', ' + CompanyInfo."Address 2" + ', ' + CompanyInfo.City + '-' + CompanyInfo."Post Code" + ', ' + StateRec.Description + ', India';
                ResAdd:=UpperCase(ResAdd);
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
        // ResponsibilityCenter.Get(UserMgt.GetRespCenterFilter);
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        SSBTotalQty:=0;
        SSBGrossWeight:=0;
        SSBNoOfBox:=0;
    end;
    var SrNo: Integer;
    CompanyInfo: Record "Company Information";
    SalesHeaderRec: Record "Sales Header";
    PurchaseOrderNo: Code[10];
    ResponsibilityCenter: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    ResAdd: Text[500];
    RecItem: Record Item;
    "DrawingNo.": Text[50];
    No2: Code[20];
    StateRec: Record State;
    Packing_ListCaptionLbl: label 'Packing List';
    Dispatch_Slip_No_CaptionLbl: label 'Dispatch Slip No.';
    DateCaptionLbl: label 'Date';
    Sales_Schedule_Buffer__No__of_Box_CaptionLbl: label 'No of Pack''s';
    QuantityCaptionLbl: label 'Quantity';
    G__Wt__KG_CaptionLbl: label 'G. Wt (KG)';
    N__Wt__KG_CaptionLbl: label 'N. Wt (KG)';
    Product_CodeCaptionLbl: label 'Product Code';
    Product_DescriptionCaptionLbl: label 'Product Description';
    S_No_CaptionLbl: label 'S.No.';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    CustomerCaptionLbl: label 'Customer';
    P_O_No_CaptionLbl: label 'P.O.No:';
    Sales_Line___Unit_of_Measure_Code_CaptionLbl: label 'UOM';
    Sales_Schedule_Buffer_PackingCaptionLbl: label 'Package Type';
    Auth__SignatoryCaptionLbl: label 'Auth. Signatory';
    Prepared_byCaptionLbl: label 'Prepared by';
    Notes___RemarksCaptionLbl: label 'Notes / Remarks';
    FM_ST_03__Rev__00_Effective_date_13_01_2012_CaptionLbl: label '<FM-ST-03, Rev. 00 Effective date 13.01.2012>';
    ResName: Text[250];
    SSBTotalQty: Decimal;
    SSBNoOfBox: Integer;
    SSBGrossWeight: Decimal;
    Flag_1: Boolean;
    Flag_2: Boolean;
    Flag: Boolean;
    LotNo: Text;
}
