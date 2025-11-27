Report 50370 "Inventory Valuation New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Inventory Valuation.rdl';
    Caption = 'Inventory Valuation Base';
    EnableHyperlinks = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("Inventory Posting Group")where(Type=const(Inventory));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Inventory Posting Group", "Statistics Group";

            column(ReportForNavId_8129;8129)
            {
            }
            column(BoM_Text; BoM_TextLbl)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(STRSUBSTNO___1___2__Item_TABLECAPTION_ItemFilter_; StrSubstNo('%1: %2', TableCaption, ItemFilter))
            {
            }
            column(STRSUBSTNO_Text005_StartDateText_; StrSubstNo(Text005, StartDateText))
            {
            }
            column(STRSUBSTNO_Text005_FORMAT_EndDate__; StrSubstNo(Text005, Format(EndDate)))
            {
            }
            column(ShowExpected; ShowExpected)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(InvCostPostedToGL_Control53; InvCostPostedToGL)
            {
            AutoFormatType = 1;
            }
            column(ValueOfQtyOnHand; ValueOfQtyOnHand)
            {
            AutoFormatType = 1;
            }
            column(ValueOfRcdIncreases; ValueOfRcdIncreases)
            {
            AutoFormatType = 1;
            }
            column(CostOfShipDecreases; CostOfShipDecreases)
            {
            AutoFormatType = 1;
            }
            column(ValueOfQtyOnHand___ValueOfRcdIncreases___CostOfShipDecreases; ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases)
            {
            AutoFormatType = 1;
            }
            column(Item_Inventory_Posting_Group; "Inventory Posting Group")
            {
            }
            column(Inventory_ValuationCaption; Inventory_ValuationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(This_report_includes_entries_that_have_been_posted_with_expected_costs_Caption; This_report_includes_entries_that_have_been_posted_with_expected_costs_CaptionLbl)
            {
            }
            column(Value_Entry__Item_No__Caption; "Value Entry".FieldCaption("Item No."))
            {
            }
            column(Item_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(InvIncreasesCaption; InvIncreasesCaptionLbl)
            {
            }
            column(InvDecreasesCaption; InvDecreasesCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(ValueCaption; ValueCaptionLbl)
            {
            }
            column(QuantityCaption_Control31; QuantityCaption_Control31Lbl)
            {
            }
            column(QuantityCaption_Control40; QuantityCaption_Control40Lbl)
            {
            }
            column(InvCostPostedToGL_Control53Caption; InvCostPostedToGL_Control53CaptionLbl)
            {
            }
            column(QuantityCaption_Control58; QuantityCaption_Control58Lbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Expected_Cost_Included_TotalCaption; Expected_Cost_Included_TotalCaptionLbl)
            {
            }
            column(Expected_Cost_TotalCaption; Expected_Cost_TotalCaptionLbl)
            {
            }
            column(GetUrlForReportDrilldown; GetUrlForReportDrilldown("Value Entry"."Item No."))
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemTableView = sorting("Item No.", "Posting Date", "Item Ledger Entry Type");
                MaxIteration = 1;

                column(ReportForNavId_8894;8894)
                {
                }
                column(InvCostPostedToGL; InvCostPostedToGL)
                {
                AutoFormatType = 1;
                }
                column(Value_Entry___Cost_Amount__Actual__; "Cost Amount (Actual)")
                {
                }
                column(Value_Entry__Invoiced_Quantity_; "Invoiced Quantity")
                {
                }
                column(CostOfInvDecreases; CostOfInvDecreases)
                {
                AutoFormatType = 1;
                }
                column(InvDecreases; InvDecreases)
                {
                DecimalPlaces = 0: 5;
                }
                column(ValueOfInvIncreases; ValueOfInvIncreases)
                {
                AutoFormatType = 1;
                }
                column(InvIncreases; InvIncreases)
                {
                DecimalPlaces = 0: 5;
                }
                column(ValueOfInvoicedQty; ValueOfInvoicedQty)
                {
                AutoFormatType = 1;
                }
                column(InvoicedQty; InvoicedQty)
                {
                DecimalPlaces = 0: 5;
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(Value_Entry__Item_No__; "Item No.")
                {
                }
                column(QtyOnHand; QtyOnHand)
                {
                DecimalPlaces = 0: 5;
                }
                column(RcdIncreases; RcdIncreases)
                {
                DecimalPlaces = 0: 5;
                }
                column(ShipDecreases; ShipDecreases)
                {
                DecimalPlaces = 0: 5;
                }
                column(Value_Entry__Item_Ledger_Entry_Quantity_; "Item Ledger Entry Quantity")
                {
                }
                column(CostPostedToGL; CostPostedToGL)
                {
                AutoFormatType = 1;
                }
                column(ExpCostPostedToGL; ExpCostPostedToGL)
                {
                AutoFormatType = 1;
                }
                column(Expected_Cost_IncludedCaption; Expected_Cost_IncludedCaptionLbl)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CalcCostAtStartDate;
                    CalcCostOfIncreases;
                    CalcCostOfDecreases;
                    CalcCostOfTransfers;
                    CalcCostAtEndDate;
                    ValueOfQtyOnHand+=ValueOfInvoicedQty;
                    ValueOfRcdIncreases+=ValueOfInvIncreases;
                    CostOfShipDecreases+=CostOfInvDecreases;
                    CostPostedToGL:=ExpCostPostedToGL + InvCostPostedToGL;
                end;
                trigger OnPreDataItem()
                begin
                    SetRange("Item No.", Item."No.");
                    SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
                    SetFilter("Location Code", Item.GetFilter("Location Filter"));
                    SetFilter("Global Dimension 1 Code", Item.GetFilter("Global Dimension 1 Filter"));
                    SetFilter("Global Dimension 2 Code", Item.GetFilter("Global Dimension 2 Filter"));
                    if EndDate <> 0D then SetRange("Posting Date", 0D, EndDate);
                    CurrReport.CreateTotals(QtyOnHand, RcdIncreases, ShipDecreases, "Item Ledger Entry Quantity", InvoicedQty, InvIncreases, InvDecreases, "Invoiced Quantity");
                    CurrReport.CreateTotals(ValueOfQtyOnHand, ValueOfRcdIncreases, CostOfShipDecreases, CostPostedToGL, ExpCostPostedToGL, ValueOfInvoicedQty, ValueOfInvIncreases, CostOfInvDecreases, "Cost Amount (Actual)", InvCostPostedToGL);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Assembly BOM");
            end;
            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals(QtyOnHand, RcdIncreases, ShipDecreases, "Value Entry"."Item Ledger Entry Quantity");
                CurrReport.CreateTotals(InvoicedQty, InvIncreases, InvDecreases);
                CurrReport.CreateTotals(ValueOfQtyOnHand, ValueOfRcdIncreases, CostOfShipDecreases, CostPostedToGL, ExpCostPostedToGL);
                CurrReport.CreateTotals(ValueOfInvoicedQty, ValueOfInvIncreases, CostOfInvDecreases, "Value Entry"."Cost Amount (Actual)", InvCostPostedToGL);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(StartDate; StartDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Starting Date';
                    }
                    field(EndingDate; EndDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Ending Date';
                    }
                    field(IncludeExpectedCost; ShowExpected)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Expected Cost';
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            if(StartDate = 0D) and (EndDate = 0D)then EndDate:=WorkDate;
        end;
    }
    labels
    {
    Inventory_Posting_Group_NameCaption='Inventory Posting Group Name';
    Expected_CostCaption='Expected Cost';
    }
    trigger OnPreReport()
    begin
        if(StartDate = 0D) and (EndDate = 0D)then EndDate:=WorkDate;
        if StartDate in[0D, 00000101D]then StartDateText:=''
        else
            StartDateText:=Format(StartDate - 1);
        ItemFilter:=Item.GetFilters;
    end;
    var Text005: label 'As of %1';
    StartDate: Date;
    EndDate: Date;
    ShowExpected: Boolean;
    ItemFilter: Text;
    StartDateText: Text[10];
    ValueOfInvoicedQty: Decimal;
    ValueOfQtyOnHand: Decimal;
    ValueOfInvIncreases: Decimal;
    ValueOfRcdIncreases: Decimal;
    CostOfInvDecreases: Decimal;
    CostOfShipDecreases: Decimal;
    InvCostPostedToGL: Decimal;
    CostPostedToGL: Decimal;
    InvoicedQty: Decimal;
    QtyOnHand: Decimal;
    InvIncreases: Decimal;
    RcdIncreases: Decimal;
    InvDecreases: Decimal;
    ShipDecreases: Decimal;
    ExpCostPostedToGL: Decimal;
    BoM_TextLbl: label 'Base UoM';
    Inventory_ValuationCaptionLbl: label 'Inventory Valuation';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    This_report_includes_entries_that_have_been_posted_with_expected_costs_CaptionLbl: label 'This report includes entries that have been posted with expected costs.';
    InvIncreasesCaptionLbl: label 'Increases (LCY)';
    InvDecreasesCaptionLbl: label 'Decreases (LCY)';
    QuantityCaptionLbl: label 'Quantity';
    ValueCaptionLbl: label 'Value';
    QuantityCaption_Control31Lbl: label 'Quantity';
    QuantityCaption_Control40Lbl: label 'Quantity';
    InvCostPostedToGL_Control53CaptionLbl: label 'Cost Posted to G/L';
    QuantityCaption_Control58Lbl: label 'Quantity';
    TotalCaptionLbl: label 'Total';
    Expected_Cost_Included_TotalCaptionLbl: label 'Expected Cost Included Total';
    Expected_Cost_TotalCaptionLbl: label 'Expected Cost Total';
    Expected_Cost_IncludedCaptionLbl: label 'Expected Cost Included';
    local procedure AddAmounts(ValueEntry: Record "Value Entry"; var CostAmtExp: Decimal; var CostAmtActual: Decimal; var InvQty: Decimal; var Qty: Decimal; Sign: Integer)
    begin
        with ValueEntry do begin
            CostAmtExp+="Cost Amount (Expected)" * Sign;
            CostAmtActual+="Cost Amount (Actual)" * Sign;
            InvQty+="Invoiced Quantity" * Sign;
            Qty+="Item Ledger Entry Quantity" * Sign;
        end;
    end;
    local procedure GetOutboundItemEntry(ItemLedgerEntryNo: Integer): Boolean var
        ItemApplnEntry: Record "Item Application Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemApplnEntry.SetCurrentkey("Item Ledger Entry No.");
        ItemApplnEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntryNo);
        if not ItemApplnEntry.FindFirst then exit(true);
        ItemLedgEntry.SetRange("Item No.", Item."No.");
        ItemLedgEntry.SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        ItemLedgEntry.SetFilter("Location Code", Item.GetFilter("Location Filter"));
        ItemLedgEntry.SetFilter("Global Dimension 1 Code", Item.GetFilter("Global Dimension 1 Filter"));
        ItemLedgEntry.SetFilter("Global Dimension 2 Code", Item.GetFilter("Global Dimension 2 Filter"));
        ItemLedgEntry."Entry No.":=ItemApplnEntry."Outbound Item Entry No.";
        exit(not ItemLedgEntry.Find);
    end;
    procedure SetStartDate(DateValue: Date)
    begin
        StartDate:=DateValue;
    end;
    procedure SetEndDate(DateValue: Date)
    begin
        EndDate:=DateValue;
    end;
    procedure InitializeRequest(NewStartDate: Date; NewEndDate: Date; NewShowExpected: Boolean)
    begin
        StartDate:=NewStartDate;
        EndDate:=NewEndDate;
        ShowExpected:=NewShowExpected;
    end;
    local procedure CalcCostAtStartDate()
    var
        ValueEntry: Record "Value Entry";
    begin
        with ValueEntry do begin
            if StartDate = 0D then exit;
            Copy("Value Entry");
            SetRange("Posting Date", 0D, CalcDate('<-1D>', StartDate));
            CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)", "Invoiced Quantity");
            AddAmounts(ValueEntry, ValueOfQtyOnHand, ValueOfInvoicedQty, InvoicedQty, QtyOnHand, 1)end;
    end;
    local procedure CalcCostOfIncreases()
    var
        ValueEntry: Record "Value Entry";
    begin
        with ValueEntry do begin
            Copy("Value Entry");
            if EndDate = 0D then SetRange("Posting Date", StartDate, 99991231D)
            else
                SetRange("Posting Date", StartDate, EndDate);
            SetFilter("Item Ledger Entry Type", '%1|%2|%3|%4', "item ledger entry type"::Purchase, "item ledger entry type"::"Positive Adjmt.", "item ledger entry type"::Output, "item ledger entry type"::"Assembly Output");
            CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)", "Invoiced Quantity");
            AddAmounts(ValueEntry, ValueOfRcdIncreases, ValueOfInvIncreases, InvIncreases, RcdIncreases, 1)end;
    end;
    local procedure CalcCostOfDecreases()
    var
        ValueEntry: Record "Value Entry";
    begin
        with ValueEntry do begin
            Copy("Value Entry");
            if EndDate = 0D then SetRange("Posting Date", StartDate, 99991231D)
            else
                SetRange("Posting Date", StartDate, EndDate);
            SetFilter("Item Ledger Entry Type", '%1|%2|%3|%4', "item ledger entry type"::Sale, "item ledger entry type"::"Negative Adjmt.", "item ledger entry type"::Consumption, "item ledger entry type"::"Assembly Consumption");
            CalcSums("Item Ledger Entry Quantity", "Cost Amount (Actual)", "Cost Amount (Expected)", "Invoiced Quantity");
            AddAmounts(ValueEntry, CostOfShipDecreases, CostOfInvDecreases, InvDecreases, ShipDecreases, -1);
        end;
    end;
    local procedure CalcCostAtEndDate()
    var
        ValueEntry: Record "Value Entry";
    begin
        with ValueEntry do begin
            Copy("Value Entry");
            if EndDate = 0D then SetRange("Posting Date", 0D, 99991231D)
            else
                SetRange("Posting Date", 0D, EndDate);
            CalcSums("Cost Amount (Actual)", "Cost Posted to G/L", "Expected Cost Posted to G/L", "Item Ledger Entry Quantity", "Invoiced Quantity");
            ExpCostPostedToGL:="Expected Cost Posted to G/L";
            InvCostPostedToGL:="Cost Posted to G/L";
            "Value Entry":=ValueEntry;
        end;
    end;
    local procedure CalcCostOfTransfers()
    var
        ValueEntry: Record "Value Entry";
    begin
        with ValueEntry do begin
            Copy("Value Entry");
            SetRange("Item Ledger Entry Type", "item ledger entry type"::Transfer);
            if Find('-')then repeat if "Posting Date" >= StartDate then if true in["Valued Quantity" < 0, not GetOutboundItemEntry("Item Ledger Entry No.")]then AddAmounts(ValueEntry, CostOfShipDecreases, CostOfInvDecreases, InvDecreases, ShipDecreases, -1)
                        else
                            AddAmounts(ValueEntry, ValueOfRcdIncreases, ValueOfInvIncreases, InvIncreases, RcdIncreases, 1);
                until Next = 0;
        end;
    end;
    local procedure GetUrlForReportDrilldown(ItemNumber: Code[20]): Text begin
        // Generates a URL to the report which sets tab "Item" and field "Field1" on the request page, such as
        // dynamicsnav://hostname:port/instance/company/runreport?report=5801<&Tenant=tenantId>&filter=Item.Field1:1100.
        // TODO
        // Eventually leverage parameters 5 and 6 of GETURL by adding ",Item,TRUE)" and
        // use filter Item.SETFILTER("No.",'=%1',ItemNumber);.
        exit(GetUrl(Clienttype::Current, COMPANYNAME, Objecttype::Report, Report::"Invt. Valuation - Cost Spec.") + StrSubstNo('&filter=Item.Field1:%1', ItemNumber));
    end;
}
