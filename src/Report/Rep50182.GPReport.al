Report 50182 "GP Report"
{
    // AlleZav1.02/060815 -- Ravik -- Added Sales Credit Memo Entries in the report
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/GP Report.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Posting Date";

            column(ReportForNavId_5581;5581)
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
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Sales_Invoice_HeaderCaption; Sales_Invoice_HeaderCaptionLbl)
            {
            }
            column(Sales_Invoice_Line__Order_No__Caption; "Sales Invoice Line".FieldCaption("Order No."))
            {
            }
            column(External_Doc__No_Caption; External_Doc__No_CaptionLbl)
            {
            }
            column(Sales_Invoice_Line__Document_No__Caption; "Sales Invoice Line".FieldCaption("Document No."))
            {
            }
            column(Sales_Invoice_Line__Posting_Date_Caption; "Sales Invoice Line".FieldCaption("Posting Date"))
            {
            }
            column(Due_DateCaption; Due_DateCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Dim__Value_CodeCaption; Dim__Value_CodeCaptionLbl)
            {
            }
            column(Sales_Person_codeCaption; Sales_Person_codeCaptionLbl)
            {
            }
            column(Item_no_Caption; Item_no_CaptionLbl)
            {
            }
            column(Item_category_CodeCaption; Item_category_CodeCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Description_2Caption; Description_2CaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(QuanityCaption; QuanityCaptionLbl)
            {
            }
            column(Profit__Caption; Profit__CaptionLbl)
            {
            }
            column(Profit_Caption; Profit_CaptionLbl)
            {
            }
            column(COGSCaption; COGSCaptionLbl)
            {
            }
            column(Line_AmountCaption; Line_AmountCaptionLbl)
            {
            }
            column(Unit_Cost_LCY_Caption; Unit_Cost_LCY_CaptionLbl)
            {
            }
            column(Unit_PriceCaption; Unit_PriceCaptionLbl)
            {
            }
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.")where(Type=const(Item));
                RequestFilterFields = "No.";

                column(ReportForNavId_1570;1570)
                {
                }
                column(Sales_Invoice_Line__Order_No__; "Order No.")
                {
                }
                column(Sales_Invoice_Header___External_Document_No__; "Sales Invoice Header"."External Document No.")
                {
                }
                column(Sales_Invoice_Line__Document_No__; "Document No.")
                {
                }
                column(Sales_Invoice_Line__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Invoice_Header___Due_Date_; "Sales Invoice Header"."Due Date")
                {
                }
                column(Sales_Invoice_Header___Bill_to_Name_; "Sales Invoice Header"."Bill-to Name")
                {
                }
                column(Sales_Invoice_Header___Shortcut_Dimension_1_Code_; "Sales Invoice Header"."Shortcut Dimension 1 Code")
                {
                }
                column(Sales_Invoice_Header___Salesperson_Code_; "Sales Invoice Header"."Salesperson Code")
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Item_Category_Code_; "Sales Invoice Line"."Item Category Code")
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___No__; "Sales Invoice Line"."No.")
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line__Description; "Sales Invoice Line".Description)
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Description_2_; "Sales Invoice Line"."Description 2")
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Unit_of_Measure_; "Sales Invoice Line"."Unit of Measure")
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line__Quantity; "Sales Invoice Line".Quantity)
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Unit_Price_; "Sales Invoice Line"."Unit Price")
                {
                }
                column(UnitCost; UnitCost)
                {
                }
                column(Sales_Invoice_Line__Sales_Invoice_Line___Line_Amount_; "Sales Invoice Line"."Line Amount")
                {
                }
                column(COGS; COGS)
                {
                }
                column(Profit; Abs(Profit))
                {
                }
                column(ProfitPer; Abs(ProfitPer))
                {
                }
                column(Sales_Invoice_Line_Line_No_; "Line No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    UnitCost:=0;
                    ILEEntryNo:=0;
                    ValueEntry.Reset;
                    ValueEntry.SetCurrentkey("Document No.");
                    ValueEntry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    ValueEntry.SetRange("Item No.", "Sales Invoice Line"."No.");
                    if ValueEntry.Find('-')then repeat if(ILEEntryNo = ValueEntry."Item Ledger Entry No.") or (ILEEntryNo = 0)then UnitCost+=ValueEntry."Cost per Unit";
                            if ILEEntryNo = 0 then ILEEntryNo:=ValueEntry."Item Ledger Entry No.";
                        until ValueEntry.Next = 0;
                    COGS:=UnitCost * "Sales Invoice Line".Quantity;
                    Profit:="Sales Invoice Line"."Line Amount" - COGS;
                    if "Sales Invoice Line"."Line Amount" <> 0 then ProfitPer:=((Profit / "Sales Invoice Line"."Line Amount") * 100);
                end;
                trigger OnPreDataItem()
                begin
                    COGS:=0;
                    Profit:=0;
                    ProfitPer:=0;
                    UnitCost:=0;
                end;
            }
            dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
            {
                DataItemLink = "Posting Date"=field("Posting Date");
                DataItemTableView = sorting("No.");

                column(ReportForNavId_1000000005;1000000005)
                {
                }
                column(SCML_Order_No; "Sales Cr.Memo Header"."Applies-to Doc. No.")
                {
                }
                column(SCML_DocNo; "Sales Cr.Memo Header"."No.")
                {
                }
                column(SCML_ExternalDoc; "Sales Cr.Memo Header"."External Document No.")
                {
                }
                column(SCML_PostingDate; "Sales Cr.Memo Header"."Posting Date")
                {
                }
                column(SCML_DueDate; "Sales Cr.Memo Header"."Due Date")
                {
                }
                column(SCML_Name; "Sales Cr.Memo Header"."Bill-to Name")
                {
                }
                column(SCMH_SD1; "Sales Cr.Memo Header"."Shortcut Dimension 1 Code")
                {
                }
                column(SCMH_SPC; "Sales Cr.Memo Header"."Salesperson Code")
                {
                }
                dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                {
                    DataItemLink = "Document No."=field("No.");
                    DataItemTableView = sorting("Document No.", "Line No.")where(Type=const(Item));

                    column(ReportForNavId_1000000047;1000000047)
                    {
                    }
                    column(SCML_Item_No; "Sales Cr.Memo Line"."No.")
                    {
                    }
                    column(SCML_Desc; "Sales Cr.Memo Line".Description)
                    {
                    }
                    column(SCML_Desc2; "Sales Cr.Memo Line"."Description 2")
                    {
                    }
                    column(SCML_UOM; "Sales Cr.Memo Line"."Unit of Measure")
                    {
                    }
                    column(SCML_Qty; "Sales Cr.Memo Line".Quantity)
                    {
                    }
                    column(SCML_Unit_Price; "Sales Cr.Memo Line"."Unit Price")
                    {
                    }
                    column(SCML_Unit_Cost_LCY; "Sales Cr.Memo Line"."Unit Cost (LCY)")
                    {
                    }
                    column(SCML_Line_Amt; "Sales Cr.Memo Line".Amount)
                    {
                    }
                    column(SCML_ITC; "Sales Cr.Memo Line"."Item Category Code")
                    {
                    }
                    column(LineNo_SalesCrMemoLine; "Sales Cr.Memo Line"."Line No.")
                    {
                    }
                    column(COGSCR; COGSCR)
                    {
                    }
                    column(ProfitPer1; ProfitPer1)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        ILE: Record "Item Ledger Entry";
                    begin
                        ILE.Reset;
                        ILE.SetRange("Document No.", "Return Receipt No.");
                        ILE.SetRange("Item No.", "No.");
                        ILE.SetRange("Item No.", "No.");
                        //ILE.SETRANGE("Document Line No.","Line No.");
                        if ILE.FindFirst then begin
                            ILE.CalcFields("Cost Amount (Actual)");
                            COGSCR:=ILE."Cost Amount (Actual)";
                            ProfitPer1:=((("Line Amount" - COGSCR) / "Line Amount") * 100);
                        end;
                    end;
                    trigger OnPreDataItem()
                    begin
                        COGSCR:=0;
                    end;
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
    trigger OnPostReport()
    begin
    /* // BIS 1145
        IF ExportToExcel THEN BEGIN
          ExcelBuffer.CreateBook;
          ExcelBuffer.CreateSheet('GP Report','GP Report',COMPANYNAME,USERID);
          ExcelBuffer.GiveUserControl;
        END;
        */
    // BIS 1145
    end;
    trigger OnPreReport()
    begin
        if ExportToExcel then begin
            Flag:=true;
            ExcelBuffer.DeleteAll;
        end;
    end;
    var COGS: Decimal;
    Profit: Decimal;
    ProfitPer: Decimal;
    ExportToExcel: Boolean;
    Flag: Boolean;
    ExcelBuffer: Record "Excel Buffer";
    ValueEntry: Record "Value Entry";
    UnitCost: Decimal;
    ILEEntryNo: Integer;
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Sales_Invoice_HeaderCaptionLbl: label 'Sales Invoice Header';
    External_Doc__No_CaptionLbl: label 'External Doc. No.';
    Due_DateCaptionLbl: label 'Due Date';
    NameCaptionLbl: label 'Name';
    Dim__Value_CodeCaptionLbl: label 'Dim. Value Code';
    Sales_Person_codeCaptionLbl: label 'Sales Person code';
    Item_no_CaptionLbl: label 'Item no.';
    Item_category_CodeCaptionLbl: label 'Item category Code';
    DescriptionCaptionLbl: label 'Description';
    Description_2CaptionLbl: label 'Description 2';
    UOMCaptionLbl: label 'UOM';
    QuanityCaptionLbl: label 'Quanity';
    Profit__CaptionLbl: label 'Profit %';
    Profit_CaptionLbl: label 'Profit ';
    COGSCaptionLbl: label 'COGS';
    Line_AmountCaptionLbl: label 'Line Amount';
    Unit_Cost_LCY_CaptionLbl: label 'Unit Cost(LCY)';
    Unit_PriceCaptionLbl: label 'Unit Price';
    COGSCR: Decimal;
    ProfitPer1: Decimal;
}
