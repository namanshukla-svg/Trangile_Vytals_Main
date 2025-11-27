Report 50102 "Production Material Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Production Material Analysis.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Quality Order Header"; "SSD Posted Quality Order Hdr")
        {
            DataItemTableView = sorting("No.")where("Template Type"=filter(Manufacturing));
            RequestFilterFields = "No.", "Source Document No.";

            column(ReportForNavId_2159;2159)
            {
            }
            column(CompInfo__New_Logo2_; CompInfo."New Logo2")
            {
            }
            column(CompInfo__New_Logo1_; CompInfo."New Logo1")
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
            column(Posted_Quality_Order_Header__Posted_Quality_Order_Header___Order_No__; "Posted Quality Order Header"."Order No.")
            {
            }
            column(MachineCentre_Name; MachineCentre.Name)
            {
            }
            column(Production_Material_Analysis_ReportCaption; Production_Material_Analysis_ReportCaptionLbl)
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
            column(Batch_QuantityCaption; Batch_QuantityCaptionLbl)
            {
            }
            column(Sample_SizeCaption; Sample_SizeCaptionLbl)
            {
            }
            column(Production_Order_No_Caption; Production_Order_No_CaptionLbl)
            {
            }
            column(Machine_Centre_NameCaption; Machine_Centre_NameCaptionLbl)
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
                column(AverageTestValue_Control1000000019; AverageTestValue)
                {
                }
                column(MaxVal_Control1000000021; MaxVal)
                {
                }
                column(MinVal_Control1000000052; MinVal)
                {
                }
                column(Posted_Quality_Order_Line__Posted_Quality_Order_Line___Unit_of_Measure_Code__Control1000000053; "Posted Quality Order Line"."Unit of Measure Code")
                {
                }
                column(QualityMeasurements_Protocol_Control1000000054; QualityMeasurements.Protocol)
                {
                }
                column(Posted_Quality_Order_Line_Description_Control1000000055; Description)
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
                column(DataItem1000000049;'This document is system generated by ' + 'Zavenir Daubert India Private Limited' + ' and is valid without a signature. For any queries regarding the same, please contact us with the relevent certificate no(s).')
                {
                }
                column(email___CompInfo__E_Mail_________Web___CompInfo__Home_Page_;'email ' + CompInfo."E-Mail" + ' | ' + 'Web ' + CompInfo."Home Page")
                {
                }
                column(fixedtext; fixedtext)
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
            begin
                Item.Reset;
                if Item.Get("Posted Quality Order Header"."Item No.")then;
                Vendor.Reset;
                if Vendor.Get("Posted Quality Order Header"."Source Code")then;
                MachineCentre.Reset;
                if MachineCentre.Get("Posted Quality Order Header"."W.C. / M.C. No.")then;
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
        fixedtext:='FM-QA-03, Rev.No.01, Effective Date 13/01/2012';
    end;
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(CompInfo.Picture, CompInfo."New Logo1", CompInfo."New Logo2");
    end;
    var CompInfo: Record "Company Information";
    Item: Record Item;
    Vendor: Record Vendor;
    MachineCentre: Record "Machine Center";
    AverageTestValue: Text[30];
    fixedtext: Text[250];
    MinVal: Text[30];
    MaxVal: Text[30];
    QualityMeasurements: Record "SSD Quality Measurements";
    Production_Material_Analysis_ReportCaptionLbl: label 'Production Material Analysis Report';
    Certificate_No_CaptionLbl: label 'Certificate No.';
    Certificate_DateCaptionLbl: label 'Certificate Date';
    Item_CodeCaptionLbl: label 'Item Code';
    Item_NameCaptionLbl: label 'Item Name';
    Specification_No_CaptionLbl: label 'Specification No.';
    Batch_No_CaptionLbl: label 'Batch No.';
    Batch_QuantityCaptionLbl: label 'Batch Quantity';
    Sample_SizeCaptionLbl: label 'Sample Size';
    Production_Order_No_CaptionLbl: label 'Production Order No.';
    Machine_Centre_NameCaptionLbl: label 'Machine Centre Name';
    Test_ParameterCaptionLbl: label 'Test Parameter';
    ProtocolCaptionLbl: label 'Protocol';
    Min__ValueCaptionLbl: label 'Min. Value';
    Max__ValueCaptionLbl: label 'Max. Value';
    Test_ValueCaptionLbl: label 'Test Value';
    UnitCaptionLbl: label 'Unit';
    Quantity_AcceptedCaptionLbl: label 'Quantity Accepted';
    Quantity_RejectedCaptionLbl: label 'Quantity Rejected';
    RemarksCaptionLbl: label 'Remarks';
    Material_Acceptance_NoteCaptionLbl: label 'Material Acceptance Note';
}
