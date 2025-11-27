Report 50033 "Item Ledger-Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Item Ledger-Summary.rdl';
    Caption = 'Item Ledger Report';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Item Category Code", "Date Filter", "Location Filter";

            column(ReportForNavId_8129;8129)
            {
            }
            column(Item_GETFILTER__Date_Filter__; Item.GetFilter("Date Filter"))
            {
            }
            column(DataItem1000000035; LocationName)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(ArrQty_2_; ArrQty[2])
            {
            DecimalPlaces = 0: 5;
            }
            column(ArrValue_6_; ArrValue[6])
            {
            DecimalPlaces = 0: 5;
            }
            column(ArrValue_2_; ArrValue[2])
            {
            }
            column(ArrQty_6_; ArrQty[6])
            {
            }
            column(ArrQty_4_; ArrQty[4])
            {
            }
            column(ArrValue_4_; ArrValue[4])
            {
            }
            column(ArrQty_3_; ArrQty[3])
            {
            DecimalPlaces = 0: 5;
            }
            column(ArrValue_3_; ArrValue[3])
            {
            }
            column(ArrValue_8_; ArrValue[8])
            {
            }
            column(ArrQty_8_; ArrQty[8])
            {
            }
            column(ArrQty_5_; ArrQty[5])
            {
            DecimalPlaces = 0: 5;
            }
            column(ArrValue_5_; ArrValue[5])
            {
            }
            column(ArrQty_7_; ArrQty[7])
            {
            }
            column(ArrValue_7_; ArrValue[7])
            {
            }
            column(ArrQty_9_; ArrQty[9])
            {
            DecimalPlaces = 0: 5;
            }
            column(ArrValue_9_; ArrValue[9])
            {
            }
            column(ArrQty_10_; ArrQty[10])
            {
            DecimalPlaces = 0: 5;
            }
            column(ArrValue_10_; ArrValue[10])
            {
            }
            column(TotOpenqty; TotOpenqty)
            {
            DecimalPlaces = 0: 5;
            }
            column(TotOpenvalue; TotOpenvalue)
            {
            }
            column(Item_LedgerCaption; Item_LedgerCaptionLbl)
            {
            }
            column(For_the_PeriodCaption; For_the_PeriodCaptionLbl)
            {
            }
            column(Closing_Qty_Caption; Closing_Qty_CaptionLbl)
            {
            }
            column(Sale_Qty_Caption; Sale_Qty_CaptionLbl)
            {
            }
            column(Purchase_QtyCaption; Purchase_QtyCaptionLbl)
            {
            }
            column(Purchase_ValueCaption; Purchase_ValueCaptionLbl)
            {
            }
            column(Closing_ValueCaption; Closing_ValueCaptionLbl)
            {
            }
            column(Sale_ValueCaption; Sale_ValueCaptionLbl)
            {
            }
            column(Positive_Adj__ValueCaption; Positive_Adj__ValueCaptionLbl)
            {
            }
            column(Positive_Adj__Qty_Caption; Positive_Adj__Qty_CaptionLbl)
            {
            }
            column(Negative_Adj__Qty_Caption; Negative_Adj__Qty_CaptionLbl)
            {
            }
            column(Negative_Adj__ValueCaption; Negative_Adj__ValueCaptionLbl)
            {
            }
            column(Opening_Qty_Caption; Opening_Qty_CaptionLbl)
            {
            }
            column(Opening_ValueCaption; Opening_ValueCaptionLbl)
            {
            }
            column(Output_ValueCaption; Output_ValueCaptionLbl)
            {
            }
            column(Output_QtyCaption; Output_QtyCaptionLbl)
            {
            }
            column(Consu___mption_Qty_Caption; Consu___mption_Qty_CaptionLbl)
            {
            }
            column(Consumption_ValueCaption; Consumption_ValueCaptionLbl)
            {
            }
            column(Increase_Transfer_ValueCaption; Increase_Transfer_ValueCaptionLbl)
            {
            }
            column(Increase_Transfer_Qty_Caption; Increase_Transfer_Qty_CaptionLbl)
            {
            }
            column(Decrease_Transfer_ValueCaption; Decrease_Transfer_ValueCaptionLbl)
            {
            }
            column(Decrease_Transfer_Qty_Caption; Decrease_Transfer_Qty_CaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Grand_Total_Caption; Grand_Total_CaptionLbl)
            {
            }
            column(Item_No_; "No.")
            {
            }
            column(Item_Variant_Filter; "Variant Filter")
            {
            }
            column(Item_Date_Filter; "Date Filter")
            {
            }
            column(Item_Location_Filter; "Location Filter")
            {
            }
            column(Item_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Item_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No."=field("No."), "Variant Code"=field("Variant Filter"), "Posting Date"=field("Date Filter"), "Location Code"=field("Location Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter");
                DataItemLinkReference = Item;
                DataItemTableView = sorting("Item No.", "Posting Date", "Unit of Measure Code", "Entry Type")order(ascending);

                column(ReportForNavId_7209;7209)
                {
                }
                column(ArrQty_2__Control1000000022; ArrQty[2])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrQty_6__Control1000000023; ArrQty[6])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_2__Control1000000024; ArrValue[2])
                {
                }
                column(ArrValue_6__Control1000000025; ArrValue[6])
                {
                }
                column(ArrQty_4__Control1000000026; ArrQty[4])
                {
                }
                column(ArrValue_4__Control1000000027; ArrValue[4])
                {
                }
                column(ArrQty_3__Control1000000038; ArrQty[3])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_3__Control1000000039; ArrValue[3])
                {
                }
                column(ArrValue_8__Control1000000040; ArrValue[8])
                {
                }
                column(ArrQty_8__Control1000000044; ArrQty[8])
                {
                }
                column(ArrQty_5__Control1000000046; ArrQty[5])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_5__Control1000000047; ArrValue[5])
                {
                }
                column(ArrQty_7__Control1000000048; ArrQty[7])
                {
                }
                column(ArrValue_7__Control1000000051; ArrValue[7])
                {
                }
                column(ArrQty_9__Control1000000052; ArrQty[9])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_9__Control1000000061; ArrValue[9])
                {
                }
                column(CloseQty; CloseQty)
                {
                DecimalPlaces = 0: 5;
                }
                column(CloseValue; CloseValue)
                {
                }
                column(Openqty; Openqty)
                {
                DecimalPlaces = 0: 5;
                }
                column(OpenValue; OpenValue)
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(Item__No__; Item."No.")
                {
                }
                column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(ArrQty_2__Control1000000028; ArrQty[2])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_6__Control1000000029; ArrValue[6])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_2__Control1000000030; ArrValue[2])
                {
                }
                column(ArrQty_6__Control1000000031; ArrQty[6])
                {
                }
                column(ArrQty_4__Control1000000032; ArrQty[4])
                {
                }
                column(ArrValue_4__Control1000000033; ArrValue[4])
                {
                }
                column(ArrQty_3__Control1000000041; ArrQty[3])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_3__Control1000000042; ArrValue[3])
                {
                }
                column(ArrValue_8__Control1000000043; ArrValue[8])
                {
                }
                column(ArrQty_8__Control1000000045; ArrQty[8])
                {
                }
                column(ArrQty_5__Control1000000049; ArrQty[5])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_5__Control1000000050; ArrValue[5])
                {
                }
                column(ArrQty_7__Control1000000053; ArrQty[7])
                {
                }
                column(ArrValue_7__Control1000000054; ArrValue[7])
                {
                }
                column(ArrQty_9__Control1000000055; ArrQty[9])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_9__Control1000000056; ArrValue[9])
                {
                }
                column(CloseQty_Control1000000057; CloseQty)
                {
                DecimalPlaces = 0: 5;
                }
                column(CloseValue_Control1000000058; CloseValue)
                {
                }
                column(Openqty1; Openqty1)
                {
                DecimalPlaces = 0: 5;
                }
                column(OpenValue1; OpenValue1)
                {
                }
                column(Item_Description_Control1000000098; Item.Description)
                {
                }
                column(Item__No___Control1000000106; Item."No.")
                {
                }
                column(Total_For_;'Total For')
                {
                }
                column(ArrQty_2__Control1000000071; ArrQty[2])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_6__Control1000000097; ArrValue[6])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_2__Control1000000099; ArrValue[2])
                {
                }
                column(ArrQty_6__Control1000000100; ArrQty[6])
                {
                }
                column(ArrQty_4__Control1000000101; ArrQty[4])
                {
                }
                column(ArrValue_4__Control1000000102; ArrValue[4])
                {
                }
                column(ArrQty_3__Control1000000103; ArrQty[3])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_3__Control1000000104; ArrValue[3])
                {
                }
                column(ArrValue_8__Control1000000105; ArrValue[8])
                {
                }
                column(ArrQty_8__Control1000000107; ArrQty[8])
                {
                }
                column(ArrQty_5__Control1000000108; ArrQty[5])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_5__Control1000000109; ArrValue[5])
                {
                }
                column(ArrQty_7__Control1000000110; ArrQty[7])
                {
                }
                column(ArrValue_7__Control1000000111; ArrValue[7])
                {
                }
                column(ArrQty_9__Control1000000112; ArrQty[9])
                {
                DecimalPlaces = 0: 5;
                }
                column(ArrValue_9__Control1000000113; ArrValue[9])
                {
                }
                column(CloseQty_Control1000000114; CloseQty)
                {
                DecimalPlaces = 0: 5;
                }
                column(CloseValue_Control1000000115; CloseValue)
                {
                }
                column(Openqty1_Control1000000116; Openqty1)
                {
                DecimalPlaces = 0: 5;
                }
                column(OpenValue1_Control1000000117; OpenValue1)
                {
                }
                column(Item_Description_Control1000000118; Item.Description)
                {
                }
                column(Item__No___Control1000000119; Item."No.")
                {
                }
                column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Item_Ledger_Entry_Item_No_; "Item No.")
                {
                }
                column(Item_Ledger_Entry_Variant_Code; "Variant Code")
                {
                }
                column(Item_Ledger_Entry_Location_Code; "Location Code")
                {
                }
                column(Item_Ledger_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Item_Ledger_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Clear(ArrQty);
                    Clear(ArrValue);
                    "Item Ledger Entry".CalcFields("Cost Amount (Expected)", "Cost Amount (Actual)");
                    IleCost:="Cost Amount (Expected)" + "Cost Amount (Actual)";
                    if("Entry Type" = "entry type"::Purchase)then begin
                        ArrQty[2]:=Quantity;
                        ArrValue[2]:=IleCost;
                    end
                    else if("Entry Type" = "entry type"::Output)then begin
                            ArrQty[3]:=Quantity;
                            ArrValue[3]:=IleCost;
                        end
                        else if("Entry Type" = "entry type"::"Positive Adjmt.")then begin
                                ArrQty[4]:=Quantity;
                                ArrValue[4]:=IleCost;
                            end
                            else if("Entry Type" = "entry type"::Sale)then begin
                                    ArrQty[5]:=Quantity;
                                    ArrValue[5]:=IleCost;
                                end
                                else if("Entry Type" = "entry type"::Consumption)then begin
                                        ArrQty[6]:=Quantity;
                                        ArrValue[6]:=IleCost;
                                    end
                                    else if("Entry Type" = "entry type"::"Negative Adjmt.")then begin
                                            ArrQty[7]:=Quantity;
                                            ArrValue[7]:=IleCost;
                                        end
                                        else if("Entry Type" = "entry type"::Transfer)then begin
                                                if Positive then begin
                                                    ArrQty[8]:=Quantity;
                                                    ArrValue[8]:=IleCost;
                                                end
                                                else
                                                begin
                                                    ArrQty[9]:=Quantity;
                                                    ArrValue[9]:=IleCost;
                                                end end;
                    Openqty:=CloseQty;
                    OpenValue:=CloseValue;
                    for i:=2 to 9 do begin
                        CloseQty+=ArrQty[i];
                        CloseValue+=ArrValue[i];
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                if Location.Get("Location Filter")then begin
                    if STATES1.Get(Location."State Code")then StateName2:=STATES1.Description
                    else
                        StateName2:='';
                    LocationName:=Location.Address + ',' + Location."Address 2" + ',' + Location.City + '-' + Location."Post Code" + ',' + StateName2 + 'TEL No. ' + Location."Phone No." + ' FAX No. ' + Location."Fax No." end;
                if Item.GetFilters <> '' then Openqty:=0;
                OpenValue:=0;
                if Item.GetRangeMin("Date Filter") > 0D then begin
                    ILE.Reset;
                    ILE.SetCurrentkey("Item No.", "Posting Date", "Location Code");
                    ILE.SetRange("Item No.", Item."No.");
                    ILE.SetRange("Posting Date", 0D, Item.GetRangeMin("Date Filter") - 1);
                    if LocationFilter <> '' then ILE.SetRange("Location Code", LocationFilter);
                    if ILE.FindSet then repeat ILE.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                            Openqty+=ILE.Quantity;
                            OpenValue+=ILE."Cost Amount (Actual)" + ILE."Cost Amount (Expected)";
                        until ILE.Next = 0;
                end;
                Openqty1:=Openqty;
                OpenValue1:=OpenValue;
                CloseQty:=Openqty;
                CloseValue:=OpenValue;
            end;
            trigger OnPreDataItem()
            begin
                CompInfo.Get;
                CompInfo.CalcFields(Picture);
                TotOpenqty:=0;
                TotOpenvalue:=0;
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
        Detail:=false;
    end;
    trigger OnPostReport()
    begin
    /* // BIS 1145
        IF ExportTOExcel THEN BEGIN
          ExcelBuf.CreateBook;
          ExcelBuf.CreateSheet('Dept','Dept',COMPANYNAME,USERID);
          ExcelBuf.GiveUserControl;
        END;
        */
    // BIS 1145
    end;
    trigger OnPreReport()
    begin
        LocationFilter:=Item.GetFilter("Location Filter");
        // respcent.Get(UserMgt.GetRespCenterFilter);
        Clear(ExcelBuf);
        Rowno:=2;
    end;
    var STATES1: Record State;
    Location: Record Location;
    LocationName: Text;
    StateName2: Text[50];
    Text000: label 'Period: %1';
    CompInfo: Record "Company Information";
    LocationFilter: Text[30];
    ExportTOExcel: Boolean;
    Rowno: Integer;
    Item1: Record Item;
    ArrQty: array[10]of Decimal;
    ArrValue: array[10]of Decimal;
    i: Integer;
    respcent: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    ILE: Record "Item Ledger Entry";
    IleCost: Decimal;
    PrintOnlyOnePerPage: Boolean;
    Openqty: Decimal;
    OpenValue: Decimal;
    ExcelBuf: Record "Excel Buffer" temporary;
    j: Integer;
    Totopnqty: Decimal;
    Totopnvalue: Decimal;
    Detail: Boolean;
    TotOpenqty: Decimal;
    TotOpenvalue: Decimal;
    CloseQty: Decimal;
    CloseValue: Decimal;
    Openqty1: Decimal;
    OpenValue1: Decimal;
    Item_LedgerCaptionLbl: label 'Item Ledger';
    For_the_PeriodCaptionLbl: label 'For the Period';
    Closing_Qty_CaptionLbl: label 'Closing Qty.';
    Sale_Qty_CaptionLbl: label 'Sale Qty.';
    Purchase_QtyCaptionLbl: label 'Purchase Qty';
    Purchase_ValueCaptionLbl: label 'Purchase Value';
    Closing_ValueCaptionLbl: label 'Closing Value';
    Sale_ValueCaptionLbl: label 'Sale Value';
    Positive_Adj__ValueCaptionLbl: label 'Positive Adj. Value';
    Positive_Adj__Qty_CaptionLbl: label 'Positive Adj. Qty.';
    Negative_Adj__Qty_CaptionLbl: label 'Negative Adj. Qty.';
    Negative_Adj__ValueCaptionLbl: label 'Negative Adj. Value';
    Opening_Qty_CaptionLbl: label 'Opening Qty.';
    Opening_ValueCaptionLbl: label 'Opening Value';
    Output_ValueCaptionLbl: label 'Output Value';
    Output_QtyCaptionLbl: label 'Output Qty';
    Consu___mption_Qty_CaptionLbl: label 'Consu - mption Qty.';
    Consumption_ValueCaptionLbl: label 'Consumption Value';
    Increase_Transfer_ValueCaptionLbl: label 'Increase Transfer Value';
    Increase_Transfer_Qty_CaptionLbl: label 'Increase Transfer Qty.';
    Decrease_Transfer_ValueCaptionLbl: label 'Decrease Transfer Value';
    Decrease_Transfer_Qty_CaptionLbl: label 'Decrease Transfer Qty.';
    Item_DescriptionCaptionLbl: label 'Item Description';
    Item_No_CaptionLbl: label 'Item No.';
    Posting_DateCaptionLbl: label 'Posting Date';
    Grand_Total_CaptionLbl: label 'Grand Total:';
    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
    begin
        ExcelBuf.Init;
        ExcelBuf.Validate("Row No.", RowNo);
        ExcelBuf.Validate("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text":=CellValue;
        ExcelBuf.Formula:='';
        ExcelBuf.Bold:=Bold;
        ExcelBuf.Italic:=Italic;
        ExcelBuf.Underline:=UnderLine;
        ExcelBuf.Insert;
    end;
}
