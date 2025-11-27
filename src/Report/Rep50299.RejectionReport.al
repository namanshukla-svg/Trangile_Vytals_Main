Report 50299 "Rejection Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Rejection Report.rdl';
    Caption = 'Rejection Report';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Quality Order Header"; "SSD Posted Quality Order Hdr")
        {
            DataItemTableView = sorting("No.")where("Template Type"=filter(Receipt));
            RequestFilterFields = "Source Document No.";

            column(ReportForNavId_2159;2159)
            {
            }
            column(Quantity_ReceivedCaption; Quantity_ReceivedCaptionLbl)
            {
            }
            column(CompInfo__New_Logo1_; CompInfo."New Logo1")
            {
            }
            column(CompInfo__New_Logo2_; CompInfo."New Logo2")
            {
            }
            column(Posted_Quality_Order_Header__No__; "No.")
            {
            }
            column(Posted_Quality_Order_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Posted_Quality_Order_Header__Item_No__; "Item No.")
            {
            }
            column(Item_Description_____Item__Description_2_; Item.Description + ' ' + Item."Description 2")
            {
            }
            column(Posted_Quality_Order_Header__Sampling_Temp__No__; "Sampling Temp. No.")
            {
            }
            column(Posted_Quality_Order_Header__Lot_No__; "Lot No.")
            {
            }
            column(FORMAT__Lot_Size_______Item__Base_Unit_of_Measure_; Format("Lot Size") + ' ' + Item."Base Unit of Measure")
            {
            }
            column(FORMAT__Sample_Size_______Item__Base_Unit_of_Measure_; Format("Sample Size") + ' ' + Item."Base Unit of Measure")
            {
            }
            column(RcptNo_______FORMAT_RcptDate_; RcptNo + ' & ' + Format(RcptDate))
            {
            }
            column(VendInvNo_______FORMAT_RcptDate_; VendInvNo + ' & ' + Format(RcptDate))
            {
            }
            column(Posted_Quality_Order_Header__Posted_Quality_Order_Header___Order_No__; "Posted Quality Order Header"."Order No.")
            {
            }
            column(Vendor_Name_____Vendor__Name_2_; Vendor.Name + ' ' + Vendor."Name 2")
            {
            }
            column(Incoming_Material_Analysis_ReportCaption; Incoming_Material_Analysis_ReportCaptionLbl)
            {
            }
            column(Certificate_No_Caption; Certificate_No_CaptionLbl)
            {
            }
            column(Certificate_DateCaption; Certificate_DateCaptionLbl)
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(Item_NameCaption; Item_NameCaptionLbl)
            {
            }
            column(Specification_No_Caption; Specification_No_CaptionLbl)
            {
            }
            column(Batch_No_Caption; Batch_No_CaptionLbl)
            {
            }
            column(Receipt_QuantityCaption; Receipt_QuantityCaptionLbl)
            {
            }
            column(Sample_SizeCaption; Sample_SizeCaptionLbl)
            {
            }
            column(Posted_Receipt_No___DateCaption; Posted_Receipt_No___DateCaptionLbl)
            {
            }
            column(Vendor_Document_No___DateCaption; Vendor_Document_No___DateCaptionLbl)
            {
            }
            column(Purchase_Order_No_Caption; Purchase_Order_No_CaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(VendorItemDescription_PostedQualityOrderHeader; "Vendor Item Description")
            {
            }
            dataitem("Posted Quality Order Line"; "SSD Posted Quality Order Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(ReportForNavId_7730;7730)
                {
                }
                column(Posted_Quality_Order_Line_Description; Description)
                {
                }
                column(QualityMeasurements_Protocol; QualityMeasurements.Protocol)
                {
                }
                column(MinVal; MinVal)
                {
                }
                column(MaxVal; MaxVal)
                {
                }
                column(AverageTestValue; AverageTestValue)
                {
                }
                column(Posted_Quality_Order_Line__Posted_Quality_Order_Line___Unit_of_Measure_Code_; "Posted Quality Order Line"."Unit of Measure Code")
                {
                }
                column(AverageTestValue_Control1000000053; AverageTestValue)
                {
                }
                column(MaxVal_Control1000000055; MaxVal)
                {
                }
                column(MinVal_Control1000000074; MinVal)
                {
                }
                column(Posted_Quality_Order_Line__Posted_Quality_Order_Line___Unit_of_Measure_Code__Control1000000075; "Posted Quality Order Line"."Unit of Measure Code")
                {
                }
                column(QualityMeasurements_Protocol_Control1000000076; QualityMeasurements.Protocol)
                {
                }
                column(Posted_Quality_Order_Line_Description_Control1000000077; Description)
                {
                }
                column(Posted_Quality_Order_Header___Accepted_Qty__; "Posted Quality Order Header"."Accepted Qty.")
                {
                }
                column(Posted_Quality_Order_Header___Rejected_Qty__; "Posted Quality Order Header"."Rejected Qty.")
                {
                }
                column(Posted_Quality_Order_Header__Remarks; "Posted Quality Order Header".Remarks)
                {
                }
                column(DataItem1000000049;'This document is system generated by ' + 'Zavenir Daubert India Private Limited ' + 'and is valid without a signature. For any queries regarding the same, please contact us with the relevent certificate no(s).')
                {
                }
                column(Web___CompInfo__Home_Page_;'Web ' + CompInfo."Home Page")
                {
                }
                column(FixedText; FixedText)
                {
                }
                column(Test_ParameterCaption; Test_ParameterCaptionLbl)
                {
                }
                column(ProtocolCaption; ProtocolCaptionLbl)
                {
                }
                column(Min__ValueCaption; Min__ValueCaptionLbl)
                {
                }
                column(Max__ValueCaption; Max__ValueCaptionLbl)
                {
                }
                column(Test_ValueCaption; Test_ValueCaptionLbl)
                {
                }
                column(UnitCaption; UnitCaptionLbl)
                {
                }
                column(Quantity_AcceptedCaption; Quantity_AcceptedCaptionLbl)
                {
                }
                column(Quantity_RejectedCaption; Quantity_RejectedCaptionLbl)
                {
                }
                column(RemarksCaption; RemarksCaptionLbl)
                {
                }
                column(Material_Acceptance_NoteCaption; Material_Acceptance_NoteCaptionLbl)
                {
                }
                column(Posted_Quality_Order_Line_Document_No_; "Document No.")
                {
                }
                column(Posted_Quality_Order_Line_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    if "Posted Quality Order Line"."Meas. Value Type" = "Posted Quality Order Line"."meas. value type"::Value then begin
                        AverageTestValue:=Format(ROUND("Posted Quality Order Line"."Inspection Value2"));
                    end
                    else
                    begin
                        if "Posted Quality Order Line"."Quality Pass" then AverageTestValue:='PASS'
                        else
                            AverageTestValue:='NOT PASS' end;
                    if "Posted Quality Order Line"."Minimum Value" <> 0 then MinVal:=Format("Posted Quality Order Line"."Minimum Value")
                    else
                        MinVal:='-';
                    if "Posted Quality Order Line"."Maximum Value" <> 0 then MaxVal:=Format("Posted Quality Order Line"."Maximum Value")
                    else
                        MaxVal:='-';
                    QualityMeasurements.Reset;
                    if QualityMeasurements.Get("Posted Quality Order Line"."Meas. Code")then;
                end;
            }
            trigger OnAfterGetRecord()
            var
                PostedWhseRcptLineLocal: Record "Posted Whse. Receipt Line";
            begin
                if Item.Get("Posted Quality Order Header"."Item No.")then;
                if "Posted Quality Order Header"."Template Type" = "Posted Quality Order Header"."Template Type"::Receipt then begin
                    PostedWhseRcptLineLocal.Reset;
                    PostedWhseRcptLineLocal.SetCurrentkey("Posted Quality Order No.", "Source No.", "Item No.");
                    PostedWhseRcptLineLocal.SetRange("Posted Quality Order No.", "Posted Quality Order Header"."No.");
                    PostedWhseRcptLineLocal.SetRange("Source No.", "Posted Quality Order Header"."Order No.");
                    PostedWhseRcptLineLocal.SetRange("Item No.", "Posted Quality Order Header"."Item No.");
                    if PostedWhseRcptLineLocal.FindFirst()then begin
                        if Vendor.Get(PostedWhseRcptLineLocal."Party No.")then;
                        if PurchRcptHdr.Get(PostedWhseRcptLineLocal."Posted Source No.")then begin
                            RcptNo:=PurchRcptHdr."No.";
                            RcptDate:=PurchRcptHdr."Posting Date";
                            VendInvNo:=PurchRcptHdr."Vendor Shipment No.";
                        end;
                    end;
                end;
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
    trigger OnInitReport()
    begin
        FixedText:='FM-QA-05, Rev.No.00, Effective Date 01/12/2018';
    end;
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(CompInfo.Picture, CompInfo."New Logo1", CompInfo."New Logo2");
    end;
    var CompInfo: Record "Company Information";
    Item: Record Item;
    Vendor: Record Vendor;
    AverageTestValue: Text[30];
    PurchRcptHdr: Record "Purch. Rcpt. Header";
    VendInvNo: Code[20];
    RcptNo: Code[20];
    RcptDate: Date;
    FixedText: Text[250];
    MinVal: Text[30];
    MaxVal: Text[30];
    QualityMeasurements: Record "SSD Quality Measurements";
    Incoming_Material_Analysis_ReportCaptionLbl: label 'Rejection Report - Incoming Material';
    Certificate_No_CaptionLbl: label 'Certificate No.';
    Certificate_DateCaptionLbl: label 'Certificate Date';
    Item_CodeCaptionLbl: label 'Item Code';
    Item_NameCaptionLbl: label 'Item Name';
    Specification_No_CaptionLbl: label 'Specification No.';
    Batch_No_CaptionLbl: label 'Batch No.';
    Receipt_QuantityCaptionLbl: label 'Receipt Quantity';
    Sample_SizeCaptionLbl: label 'Sample Size';
    Posted_Receipt_No___DateCaptionLbl: label 'Posted Receipt No.& Date';
    Vendor_Document_No___DateCaptionLbl: label 'Vendor Document No.& Date';
    Purchase_Order_No_CaptionLbl: label 'Purchase Order No.';
    Vendor_NameCaptionLbl: label 'Vendor Name';
    Test_ParameterCaptionLbl: label 'Test Parameter';
    ProtocolCaptionLbl: label 'Protocol';
    Min__ValueCaptionLbl: label 'Min. Value';
    Max__ValueCaptionLbl: label 'Max. Value';
    Test_ValueCaptionLbl: label 'Test Value';
    UnitCaptionLbl: label 'Unit';
    Quantity_AcceptedCaptionLbl: label 'Quantity Received';
    Quantity_RejectedCaptionLbl: label 'Quantity Rejected';
    RemarksCaptionLbl: label 'Remarks';
    Material_Acceptance_NoteCaptionLbl: label 'Material Rejection Note';
    Quantity_ReceivedCaptionLbl: label 'Quantity Rejected';
}
