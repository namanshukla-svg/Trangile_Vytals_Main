Report 50096 "Job Card/Production Card"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Job CardProduction Card.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Prod. Order Line"; "Prod. Order Line")
        {
            DataItemTableView = sorting(Status, "Prod. Order No.", "Line No.");
            RequestFilterFields = "Prod. Order No.";

            column(ReportForNavId_1000000147;1000000147)
            {
            }
            column(EmptyString;'')
            {
            }
            column(EmptyString_Control1170000021;'')
            {
            }
            column(Prod__Order_Line__Due_Date_; "Due Date")
            {
            }
            column(Prod__Order_Line_Description; Description)
            {
            }
            column(Prod__Order_Line__Description_2_; "Description 2")
            {
            }
            column(Prod__Order_Line__Item_No__; "Item No.")
            {
            }
            column(FORMAT_Quantity_______FORMAT__Prod__Order_Line___Unit_of_Measure_Code__; Format(Quantity) + '  ' + Format("Prod. Order Line"."Unit of Measure Code"))
            {
            }
            column(Prod__Order_Line___Prod__Order_No_________FORMAT__Due_Date__; "Prod. Order Line"."Prod. Order No." + ' & ' + Format("Due Date"))
            {
            }
            column(EmptyString_Control1170000035;'')
            {
            }
            column(Job_Card_Production_OrderCaption; Job_Card_Production_OrderCaptionLbl)
            {
            }
            column(QualityCaption; QualityCaptionLbl)
            {
            }
            column(Dispatch_Comm__DateCaption; Dispatch_Comm__DateCaptionLbl)
            {
            }
            column(Expected_finish_DateCaption; Expected_finish_DateCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(Prod__Order_Line_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Prod__Order_Line__Description_2_Caption; FieldCaption("Description 2"))
            {
            }
            column(Quantity___UOMCaption; Quantity___UOMCaptionLbl)
            {
            }
            column(Job_Card_No____DateCaption; Job_Card_No____DateCaptionLbl)
            {
            }
            column(Sales_Order_No_Caption; Sales_Order_No_CaptionLbl)
            {
            }
            column(FM_PD_12__REV_No__00_Effective_Date_13_01_2012_Caption; FM_PD_12__REV_No__00_Effective_Date_13_01_2012_CaptionLbl)
            {
            }
            column(Prod__Order_Line_Status; Status)
            {
            }
            column(Prod__Order_Line_Prod__Order_No_; "Prod. Order No.")
            {
            }
            column(Prod__Order_Line_Line_No_; "Line No.")
            {
            }
            column(DueDate_ProdOrderLine; "Prod. Order Line"."Due Date")
            {
            }
            column(Bool; Bool)
            {
            }
            column(Capacity_Starting_Time; Capacity_Starting_Time)
            {
            }
            column(Capacity_Ending_Time; Capacity_Ending_Time)
            {
            }
            dataitem("Prod. Order Component"; "Prod. Order Component")
            {
                DataItemLink = "Prod. Order No."=field("Prod. Order No.");
                DataItemTableView = sorting(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");

                column(ReportForNavId_1000000022;1000000022)
                {
                }
                column(BomSrNo; BomSrNo)
                {
                }
                column(Prod__Order_Component__Item_No__; "Item No.")
                {
                }
                column(Description_______Item1__Description_2_; Description + ' - ' + Item1."Description 2")
                {
                }
                column(Prod__Order_Component__Unit_of_Measure_Code_; "Unit of Measure Code")
                {
                }
                column(Prod__Order_Component__Expected_Quantity_; "Expected Quantity")
                {
                }
                column(Prod__Order_Component__Prod__Order_Component___Act__Consumption__Qty__; "Prod. Order Component"."Act. Consumption (Qty)")
                {
                }
                column(EmptyString_Control1170000016;'')
                {
                }
                column(Expected_Quantity___Act__Consumption__Qty__; "Expected Quantity" - "Act. Consumption (Qty)")
                {
                }
                column(RemarksCaption; RemarksCaptionLbl)
                {
                }
                column(Batch_No__UsedCaption; Batch_No__UsedCaptionLbl)
                {
                }
                column(Actual_Qty_ConsumedCaption; Actual_Qty_ConsumedCaptionLbl)
                {
                }
                column(Planned_QuantityCaption; Planned_QuantityCaptionLbl)
                {
                }
                column(UOM_CodeCaption; UOM_CodeCaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(Prod__Order_Component__Item_No__Caption; FieldCaption("Item No."))
                {
                }
                column(S__No_Caption; S__No_CaptionLbl)
                {
                }
                column(Bill_Of_Material__Input_Caption; Bill_Of_Material__Input_CaptionLbl)
                {
                }
                column(Prod__Order_Component_Status; Status)
                {
                }
                column(Prod__Order_Component_Prod__Order_No_; "Prod. Order No.")
                {
                }
                column(Prod__Order_Component_Prod__Order_Line_No_; "Prod. Order Line No.")
                {
                }
                column(Prod__Order_Component_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    BomSrNo+=1;
                    Item1.Reset;
                    if Item1.Get("Prod. Order Component"."Item No.")then;
                end;
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Document No."=field("Prod. Order No.");
                DataItemTableView = where("Source Code"=const('CONSUMPJNL'));

                column(ReportForNavId_1000000155;1000000155)
                {
                }
                column(ItemNo_ValueEntry; "Value Entry"."Item No.")
                {
                }
                column(Description_ValueEntry; "Value Entry".Description)
                {
                }
                column(LocationCode_ValueEntry; "Value Entry"."Location Code")
                {
                }
                column(ItemLedgerEntryQuantity_ValueEntry; "Value Entry"."Item Ledger Entry Quantity")
                {
                }
                column(ValueESr; ValueESr)
                {
                }
                column(Item2_Description; Item2.Description + ' ' + Item2."Description 2")
                {
                }
                column(Item2_Base_Unit_of_Measure; Item2."Base Unit of Measure")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    ProdOrderComponent.Reset;
                    ProdOrderComponent.SetRange(ProdOrderComponent."Prod. Order No.", "Value Entry"."Document No.");
                    ProdOrderComponent.SetRange(ProdOrderComponent."Item No.", "Value Entry"."Item No.");
                    if ProdOrderComponent.FindFirst then CurrReport.Skip
                    else
                        ValueESr+=1;
                    if Item2.Get("Value Entry"."Item No.")then;
                end;
            }
            dataitem("Prod. Order Routing Line"; "Prod. Order Routing Line")
            {
                DataItemLink = "Prod. Order No."=field("Prod. Order No.");
                DataItemTableView = sorting(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");

                column(ReportForNavId_1000000044;1000000044)
                {
                }
                column(EmptyString_Control1000000049;'')
                {
                }
                column(EmptyString_Control1000000050;'')
                {
                }
                column(EmptyString_Control1000000051;'')
                {
                }
                column(FORMAT__Ending_Date________FORMAT__Ending_Time__; Format("Ending Date") + ', ' + Format("Ending Time"))
                {
                }
                column(FORMAT__Starting_Date________FORMAT__Starting_Time__; Format("Starting Date") + ', ' + Format("Starting Time"))
                {
                }
                column(Prod__Order_Routing_Line__Work_Center_No__; "Work Center No.")
                {
                }
                column(Prod__Order_Routing_Line_Description; Description)
                {
                }
                column(Planned_RoutingCaption; Planned_RoutingCaptionLbl)
                {
                }
                column(RemarksCaption_Control1170000085; RemarksCaption_Control1170000085Lbl)
                {
                }
                column(Actual_End_TimeCaption; Actual_End_TimeCaptionLbl)
                {
                }
                column(Actual_Start_TimeCaption; Actual_Start_TimeCaptionLbl)
                {
                }
                column(End_Date_TimeCaption; End_Date_TimeCaptionLbl)
                {
                }
                column(Start_Date_TimeCaption; Start_Date_TimeCaptionLbl)
                {
                }
                column(Capacity_Ledger_Entry__Work_Center_No__Caption;'')
                {
                }
                column(Capacity_Ledger_Entry_DescriptionCaption;'')
                {
                }
                column(S__No_Caption_Control1170000070; S__No_Caption_Control1170000070Lbl)
                {
                }
                column(Prod__Order_Routing_Line_Status; Status)
                {
                }
                column(Prod__Order_Routing_Line_Prod__Order_No_; "Prod. Order No.")
                {
                }
                column(Prod__Order_Routing_Line_Routing_Reference_No_; "Routing Reference No.")
                {
                }
                column(Prod__Order_Routing_Line_Routing_No_; "Routing No.")
                {
                }
                column(Prod__Order_Routing_Line_Operation_No_; "Operation No.")
                {
                }
            }
            dataitem("Capacity Ledger Entry"; "Capacity Ledger Entry")
            {
                DataItemLink = "Order No."=field("Prod. Order No.");
                DataItemTableView = sorting("Document No.", "Posting Date");

                column(ReportForNavId_1000000054;1000000054)
                {
                }
                column(RoutSrNo; RoutSrNo)
                {
                }
                column(Capacity_Ledger_Entry_Description; Description)
                {
                }
                column(Capacity_Ledger_Entry__Work_Center_No__; "Work Center No.")
                {
                }
                column(FORMAT__Prod__Order_Line___Starting_Date________FORMAT__Prod__Order_Line___Starting_Time__; Format("Prod. Order Line"."Starting Date") + ', ' + Format("Prod. Order Line"."Starting Time"))
                {
                }
                column(FORMAT__Posting_Date________FORMAT__Prod__Order_Line___Ending_Time__; Format("Posting Date") + ', ' + Format("Prod. Order Line"."Ending Time"))
                {
                }
                column(EmptyString_Control1170000084;'')
                {
                }
                column(FORMAT__Starting_Time__; Format("Starting Time"))
                {
                }
                column(FORMAT__Ending_Time__; Format("Ending Time"))
                {
                }
                column(Capacity_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CountRouting+=1;
                    RoutSrNo+=1;
                    Capacity_Starting_Time:=Format("Starting Time");
                    Capacity_Ending_Time:=Format("Ending Time");
                end;
            }
            dataitem(Ouptput; "Prod. Order Routing Line")
            {
                DataItemLink = "Prod. Order No."=field("Prod. Order No.");
                DataItemTableView = sorting(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");

                column(ReportForNavId_1000000095;1000000095)
                {
                }
                column(Item_Ledger_Entry___Lot_No__; "Item Ledger Entry"."Lot No.")
                {
                }
                column(Prod__Order_Line__Quantity; "Prod. Order Line".Quantity)
                {
                }
                column(Prod__Order_Line___Unit_of_Measure_Code_; "Prod. Order Line"."Unit of Measure Code")
                {
                }
                column(Item1_Description_______Item1__Description_2_; Item1.Description + ' - ' + Item1."Description 2")
                {
                }
                column(Prod__Order_Line___Item_No__; "Prod. Order Line"."Item No.")
                {
                }
                column(OutputSrNo; OutputSrNo)
                {
                }
                column(EmptyString_Control1170000062;'')
                {
                }
                column(EmptyString_Control1170000060;'')
                {
                }
                column(EmptyString_Control1170000064;'')
                {
                }
                column(EmptyString_Control1170000066;'')
                {
                }
                column(EmptyString_Control1170000069;'')
                {
                }
                column(EmptyString_Control1170000088;'')
                {
                }
                column(EmptyString_Control1170000058;'')
                {
                }
                column(S__No_Caption_Control1170000006; S__No_Caption_Control1170000006Lbl)
                {
                }
                column(Item_No_Caption_Control1170000007; Item_No_Caption_Control1170000007Lbl)
                {
                }
                column(DescriptionCaption_Control1170000038; DescriptionCaption_Control1170000038Lbl)
                {
                }
                column(Output_DataCaption; Output_DataCaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(Planned_QuantityCaption_Control1170000041; Planned_QuantityCaption_Control1170000041Lbl)
                {
                }
                column(Actual_Qty_OutputCaption; Actual_Qty_OutputCaptionLbl)
                {
                }
                column(Batch_No__ProducedCaption; Batch_No__ProducedCaptionLbl)
                {
                }
                column(RemarksCaption_Control1170000044; RemarksCaption_Control1170000044Lbl)
                {
                }
                column(NWT__KGS__Caption; NWT__KGS__CaptionLbl)
                {
                }
                column(Sign_of_OperatorCaption; Sign_of_OperatorCaptionLbl)
                {
                }
                column(Sign_of_SupervisorCaption; Sign_of_SupervisorCaptionLbl)
                {
                }
                column(Sign_of_ERP_Posting_DateCaption; Sign_of_ERP_Posting_DateCaptionLbl)
                {
                }
                column(Supervisor_s_remarks__Whether_short_close_Order__Yes_No_Caption; Supervisor_s_remarks__Whether_short_close_Order__Yes_No_CaptionLbl)
                {
                }
                column(Test_Report_No_Caption; Test_Report_No_CaptionLbl)
                {
                }
                column(Quality_OrderCaption; Quality_OrderCaptionLbl)
                {
                }
                column(DateCaption; DateCaptionLbl)
                {
                }
                column(Date_of_completion_of_Quality_OrderCaption; Date_of_completion_of_Quality_OrderCaptionLbl)
                {
                }
                column(Qty_PassedCaption; Qty_PassedCaptionLbl)
                {
                }
                column(Qty_RejectedCaption; Qty_RejectedCaptionLbl)
                {
                }
                column(Comments_of_QCCaption; Comments_of_QCCaptionLbl)
                {
                }
                column(Quality_Order_No_Caption; Quality_Order_No_CaptionLbl)
                {
                }
                column(Ouptput_Status; Status)
                {
                }
                column(Ouptput_Prod__Order_No_; "Prod. Order No.")
                {
                }
                column(Ouptput_Routing_Reference_No_; "Routing Reference No.")
                {
                }
                column(Ouptput_Routing_No_; "Routing No.")
                {
                }
                column(Ouptput_Operation_No_; "Operation No.")
                {
                }
                column(QtyPosted; QtyPosted)
                {
                }
                column(PreLotNo; PreLotNo)
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Document No."=field("Prod. Order No.");
                    DataItemTableView = where("Entry Type"=const(Output));

                    column(ReportForNavId_1000000107;1000000107)
                    {
                    }
                    column(Prod__Order_Line__Quantity_QtyPosted; "Prod. Order Line".Quantity - QtyPosted)
                    {
                    }
                    column(Item_Ledger_Entry__Item_Ledger_Entry___Lot_No__; "Item Ledger Entry"."Lot No.")
                    {
                    }
                    column(Item_Ledger_Entry_Quantity; Quantity)
                    {
                    }
                    column(Prod__Order_Line__Quantity_Control1170000048; "Prod. Order Line".Quantity)
                    {
                    }
                    column(Prod__Order_Line___Unit_of_Measure_Code__Control1170000049; "Prod. Order Line"."Unit of Measure Code")
                    {
                    }
                    column(Item1_Description_______Item1__Description_2__Control1170000050; Item1.Description + ' - ' + Item1."Description 2")
                    {
                    }
                    column(Prod__Order_Line___Item_No___Control1170000051; "Prod. Order Line"."Item No.")
                    {
                    }
                    column(OutputSrNo_Control1170000052; OutputSrNo)
                    {
                    }
                    column(NetWeight; NetWeight)
                    {
                    DecimalPlaces = 2: 2;
                    }
                    column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Item_Ledger_Entry_Document_No_; "Document No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                    begin
                        OutputSrNo+=1;
                        Item1.Get("Prod. Order Line"."Item No.");
                        Item1.Reset;
                        if Item1.Get("Prod. Order Line"."Item No.")then;
                        QtyPosted+="Item Ledger Entry".Quantity;
                        NetWeight:=QtyPosted * Item1."Net Weight";
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    Item1.Reset;
                    if Item1.Get("Prod. Order Line"."Item No.")then;
                end;
            }
            dataitem("Posted Quality Order Header"; "SSD Posted Quality Order Hdr")
            {
                DataItemLink = "Source Document No."=field("Prod. Order No.");
                DataItemTableView = sorting("Source Document No.", "Item No.");

                column(ReportForNavId_1000000149;1000000149)
                {
                }
                column(EmptyString_Control1000000002;'')
                {
                }
                column(No_; "Posted Quality Order Header"."No.")
                {
                }
                column(Posted_Quality_Order_Header__Posted_Quality_Order_Header___Creation_Date_; "Posted Quality Order Header"."Creation Date")
                {
                }
                column(Posted_Quality_Order_Header__No__; "No.")
                {
                }
                column(Posted_Quality_Order_Header__Posted_Quality_Order_Header___Posting_Date_; "Posted Quality Order Header"."Posting Date")
                {
                }
                column(Posted_Quality_Order_Header__Posted_Quality_Order_Header__Comments; "Posted Quality Order Header".Comments)
                {
                }
                column(Posted_Quality_Order_Header__Posted_Quality_Order_Header___Decision_For_Quality_Pass_; "Posted Quality Order Header"."Decision For Quality Pass")
                {
                }
                column(Posted_Quality_Order_Header__Posted_Quality_Order_Header___Rejected_Qty__; "Posted Quality Order Header"."Rejected Qty.")
                {
                }
                column(Test_Report_No_Caption_Control1000000003; Test_Report_No_Caption_Control1000000003Lbl)
                {
                }
                column(Quality_OrderCaption_Control1000000004; Quality_OrderCaption_Control1000000004Lbl)
                {
                }
                column(DateCaption_Control1000000006; DateCaption_Control1000000006Lbl)
                {
                }
                column(Quality_Order_No_Caption_Control1000000016; Quality_Order_No_Caption_Control1000000016Lbl)
                {
                }
                column(Date_of_completion_of_Quality_OrderCaption_Control1000000008; Date_of_completion_of_Quality_OrderCaption_Control1000000008Lbl)
                {
                }
                column(Comments_of_QCCaption_Control1000000010; Comments_of_QCCaption_Control1000000010Lbl)
                {
                }
                column(Qty_PassedCaption_Control1000000012; Qty_PassedCaption_Control1000000012Lbl)
                {
                }
                column(Qty_RejectedCaption_Control1000000014; Qty_RejectedCaption_Control1000000014Lbl)
                {
                }
                column(Posted_Quality_Order_Header_Source_Document_No_; "Source Document No.")
                {
                }
                column(CommentsText; CommentsText)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CommentsText:='NO';
                    if "Posted Quality Order Header".Comments then CommentsText:='YES'
                    else
                        CommentsText:='NO';
                end;
            }
            trigger OnAfterGetRecord()
            var
                ReservationEntry: Record "Reservation Entry"; // Govind
            begin
                Clear(PreLotNo);
                PostedQualityOrderHeader.Reset;
                PostedQualityOrderHeader.SetRange(PostedQualityOrderHeader."Source Document No.", "Prod. Order Line"."Prod. Order No.");
                if PostedQualityOrderHeader.FindFirst then Bool:=true
                else
                    Bool:=false;
                //Govind>> 
                ReservationEntry.Reset();
                ReservationEntry.SetRange("Source Id", "Prod. Order Line"."Prod. Order No.");
                ReservationEntry.SetRange("Item No.", "Prod. Order Line"."Item No.");
                ReservationEntry.SetLoadFields("Lot No.");
                if ReservationEntry.FindFirst()then PreLotNo:=ReservationEntry."Lot No.";
            //Govind<<
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
        BomSrNo:=0;
        RoutSrNo:=0;
        Body3ShowOuptput:=0;
        CountRouting:=0;
        Countt:=0;
        Bool:=false; //5.51
    end;
    var BomSrNo: Integer;
    RoutSrNo: Integer;
    Body3ShowOuptput: Integer;
    CountRouting: Integer;
    ProdOrdRoutLine: Record "Prod. Order Routing Line";
    Countt: Integer;
    OutputSrNo: Integer;
    Bool: Boolean;
    PostedQualityOrderHeader: Record "SSD Posted Quality Order Hdr";
    Item1: Record Item;
    CapacityLedgerEntry1: Record "Capacity Ledger Entry";
    QtyPosted: Decimal;
    NetWeight: Decimal;
    Job_Card_Production_OrderCaptionLbl: label 'Job Card/Production Order';
    QualityCaptionLbl: label 'Quality';
    Dispatch_Comm__DateCaptionLbl: label 'Dispatch Comm. Date';
    Expected_finish_DateCaptionLbl: label 'Expected finish Date';
    Item_No_CaptionLbl: label 'Item No.';
    Quantity___UOMCaptionLbl: label 'Quantity & UOM';
    Job_Card_No____DateCaptionLbl: label 'Job Card No. & Date';
    Sales_Order_No_CaptionLbl: label 'Sales Order No.';
    FM_PD_12__REV_No__00_Effective_Date_13_01_2012_CaptionLbl: label '<FM-PD-12, REV.No. 00 Effective Date 13.01.2012>';
    RemarksCaptionLbl: label 'Remarks';
    Batch_No__UsedCaptionLbl: label 'Batch No. Used';
    Actual_Qty_ConsumedCaptionLbl: label 'Actual Qty Consumed';
    Planned_QuantityCaptionLbl: label 'Planned Quantity';
    UOM_CodeCaptionLbl: label 'UOM Code';
    DescriptionCaptionLbl: label 'Description';
    S__No_CaptionLbl: label 'S. No.';
    Bill_Of_Material__Input_CaptionLbl: label 'Bill Of Material (Input)';
    Planned_RoutingCaptionLbl: label 'Planned Routing';
    RemarksCaption_Control1170000085Lbl: label 'Remarks';
    Actual_End_TimeCaptionLbl: label 'Actual End Time';
    Actual_Start_TimeCaptionLbl: label 'Actual Start Time';
    End_Date_TimeCaptionLbl: label 'End Date/Time';
    Start_Date_TimeCaptionLbl: label 'Start Date/Time';
    S__No_Caption_Control1170000070Lbl: label 'S. No.';
    S__No_Caption_Control1170000006Lbl: label 'S. No.';
    Item_No_Caption_Control1170000007Lbl: label 'Item No.';
    DescriptionCaption_Control1170000038Lbl: label 'Description';
    Output_DataCaptionLbl: label 'Output Data';
    UOMCaptionLbl: label 'UOM';
    Planned_QuantityCaption_Control1170000041Lbl: label 'Planned Quantity';
    Actual_Qty_OutputCaptionLbl: label 'Actual Qty Output';
    Batch_No__ProducedCaptionLbl: label 'Batch No. Produced';
    RemarksCaption_Control1170000044Lbl: label 'Remarks';
    NWT__KGS__CaptionLbl: label 'NWT (KGS.)';
    Sign_of_OperatorCaptionLbl: label 'Sign of Operator';
    Sign_of_SupervisorCaptionLbl: label 'Sign of Supervisor';
    Sign_of_ERP_Posting_DateCaptionLbl: label 'Sign of ERP Posting/Date';
    Supervisor_s_remarks__Whether_short_close_Order__Yes_No_CaptionLbl: label 'Supervisor''s remarks: Whether short close Order: Yes/No.';
    Test_Report_No_CaptionLbl: label 'Test Report No.';
    Quality_OrderCaptionLbl: label 'Quality Order';
    DateCaptionLbl: label 'Date';
    Date_of_completion_of_Quality_OrderCaptionLbl: label 'Date of completion of Quality Order';
    Qty_PassedCaptionLbl: label 'Qty Passed';
    Qty_RejectedCaptionLbl: label 'Qty Rejected';
    Comments_of_QCCaptionLbl: label 'Comments of QC';
    Quality_Order_No_CaptionLbl: label 'Quality Order No.';
    Test_Report_No_Caption_Control1000000003Lbl: label 'Test Report No.';
    Quality_OrderCaption_Control1000000004Lbl: label 'Quality Order';
    DateCaption_Control1000000006Lbl: label 'Date';
    Quality_Order_No_Caption_Control1000000016Lbl: label 'Quality Order No.';
    Date_of_completion_of_Quality_OrderCaption_Control1000000008Lbl: label 'Date of completion of Quality Order';
    Comments_of_QCCaption_Control1000000010Lbl: label 'Comments of QC';
    Qty_PassedCaption_Control1000000012Lbl: label 'Qty Passed';
    Qty_RejectedCaption_Control1000000014Lbl: label 'Qty Rejected';
    Capacity_Starting_Time: Text;
    Capacity_Ending_Time: Text;
    CommentsText: Text;
    ProdOrderComponent: Record "Prod. Order Component";
    ValueESr: Integer;
    Item2: Record Item;
    PreLotNo: Code[50]; //Govind
}
