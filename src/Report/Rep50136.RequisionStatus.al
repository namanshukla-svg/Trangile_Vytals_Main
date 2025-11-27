Report 50136 "Requision Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Requision Status.rdl';
    UseRequestPage = true;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Requision Slip Line"; "SSD Posted Requision Slip Line")
        {
            DataItemTableView = sorting("Document Type", "Req. Slip Document No.", "Line No.")order(ascending);

            column(ReportForNavId_9904;9904)
            {
            }
            column(REQUISITION_SLIP_NO_________Posted_Requision_Slip_Line___Req__Slip_Document_No__;'REQUISITION SLIP NO.-->  ' + "Posted Requision Slip Line"."Req. Slip Document No.")
            {
            }
            column(Posted_Requision_Slip_Line__Prod_Order_Source_No__; "Prod.Order Source No.")
            {
            }
            column(Posted_Requision_Slip_Line_Description; Description)
            {
            }
            column(Posted_Requision_Slip_Line__Item_No__; "Item No.")
            {
            }
            column(Posted_Requision_Slip_Line__Posted_Requision_Slip_Line__Quantity; "Posted Requision Slip Line".Quantity)
            {
            }
            column(Posted_Requision_Slip_Line__Posted_Requision_Slip_Line___Issued_Qty_; "Posted Requision Slip Line"."Issued Qty")
            {
            }
            column(SNO; SNO)
            {
            }
            column(Posted_Requision_Slip_Line__Quantity__Posted_Requision_Slip_Line___Issued_Qty_; "Posted Requision Slip Line".Quantity - "Posted Requision Slip Line"."Issued Qty")
            {
            }
            column(Material_Requirement_Vs_Issue_SlipCaption; Material_Requirement_Vs_Issue_SlipCaptionLbl)
            {
            }
            column(Required_QuantityCaption; Required_QuantityCaptionLbl)
            {
            }
            column(Issued_QuantityCaption; Issued_QuantityCaptionLbl)
            {
            }
            column(Balance_QuantityCaption; Balance_QuantityCaptionLbl)
            {
            }
            column(Item_NameCaption; Item_NameCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(S_No_Caption; S_No_CaptionLbl)
            {
            }
            column(S_No_Caption_Control1000000015; S_No_Caption_Control1000000015Lbl)
            {
            }
            column(Issued_QuantityCaption_Control1000000010; Issued_QuantityCaption_Control1000000010Lbl)
            {
            }
            column(Required_QuantityCaption_Control1000000004; Required_QuantityCaption_Control1000000004Lbl)
            {
            }
            column(Item_NameCaption_Control1000000006; Item_NameCaption_Control1000000006Lbl)
            {
            }
            column(Transfer_Receipt_Line__Item_No__Caption; "Transfer Receipt Line".FieldCaption("Item No."))
            {
            }
            column(Issuing_DateCaption; Issuing_DateCaptionLbl)
            {
            }
            column(Balance_QuantityCaption_Control1000000013; Balance_QuantityCaption_Control1000000013Lbl)
            {
            }
            column(Posted_Requision_Slip_Line_Document_Type; "Document Type")
            {
            }
            column(Posted_Requision_Slip_Line_Req__Slip_Document_No_; "Req. Slip Document No.")
            {
            }
            column(Posted_Requision_Slip_Line_Line_No_; "Line No.")
            {
            }
            column(Posted_Requision_Slip_Line_Prod__Order_No_; "Prod. Order No.")
            {
            }
            column(Posted_Requision_Slip_Line_Document_No_; "Document No.")
            {
            }
            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Slip No."=field("Document No."), "Item No."=field("Item No.");
                DataItemTableView = sorting("Document No.", "Line No.")order(ascending);

                column(ReportForNavId_4146;4146)
                {
                }
                column(Transfer_Receipt_Line__Item_No__; "Item No.")
                {
                }
                column(SNO3; SNO3)
                {
                }
                column(Transfer_Receipt_Line_Description; Description)
                {
                }
                column(Transfer_Receipt_Line__Transfer_Receipt_Line___Required_Qty__; "Transfer Receipt Line"."Required Qty.")
                {
                }
                column(Transfer_Receipt_Line_Quantity; Quantity)
                {
                }
                column(Transfer_Receipt_Line__Receipt_Date_; "Receipt Date")
                {
                }
                column(RectrnsferRcptLine__Required_Qty___TotalIssue; RectrnsferRcptLine."Required Qty." - TotalIssue)
                {
                }
                column(FORMAT_SNO3______FORMAT_SNO2_; Format(SNO3) + '.' + Format(SNO2))
                {
                }
                column(Transfer_Receipt_Line_Document_No_; "Document No.")
                {
                }
                column(Transfer_Receipt_Line_Line_No_; "Line No.")
                {
                }
                column(Transfer_Receipt_Line_Slip_No_; "Slip No.")
                {
                }
            }
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
        SNO1:=0;
        SNO2:=0;
        SNO3:=0;
    end;
    var RecILE: Record "Item Ledger Entry";
    SNO: Integer;
    Type: Option Summary, Detail;
    SNO1: Integer;
    RecProdComp: Record "Prod. Order Component";
    RectrnsferRcptLine: Record "Transfer Receipt Line";
    IssuedQty: Decimal;
    SNO2: Integer;
    SNO3: Integer;
    BalQty: Decimal;
    NetBal: Decimal;
    TotalIssue: Decimal;
    Material_Requirement_Vs_Issue_SlipCaptionLbl: label 'Material Requirement Vs Issue Slip';
    Required_QuantityCaptionLbl: label 'Required Quantity';
    Issued_QuantityCaptionLbl: label 'Issued Quantity';
    Balance_QuantityCaptionLbl: label 'Balance Quantity';
    Item_NameCaptionLbl: label 'Item Name';
    Item_No_CaptionLbl: label 'Item No.';
    S_No_CaptionLbl: label 'S.No.';
    S_No_Caption_Control1000000015Lbl: label 'S.No.';
    Issued_QuantityCaption_Control1000000010Lbl: label 'Issued Quantity';
    Required_QuantityCaption_Control1000000004Lbl: label 'Required Quantity';
    Item_NameCaption_Control1000000006Lbl: label 'Item Name';
    Issuing_DateCaptionLbl: label 'Issuing Date';
    Balance_QuantityCaption_Control1000000013Lbl: label 'Balance Quantity';
}
