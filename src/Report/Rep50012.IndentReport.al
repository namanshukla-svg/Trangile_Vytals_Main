Report 50012 "Indent Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Indent Report.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Indent Header"; "SSD Indent Header")
        {
            RequestFilterFields = "No.";

            column(ReportForNavId_4745; 4745)
            {
            }
            column(ResponsibilityCenter_Name; CompanyInfoRec.Name)
            {
            }
            column(ResAdd; ResAdd)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Indent_Header__Indent_Date_; "Indent Date")
            {
            }
            column(Indent_Header__Shortcut_Dimension_2_Code_; ShorcutDim1Name)//IG_DS"Shortcut Dimension 2 Code")
            {
            }
            column(UserName; "Indenter ID")//IG_DS UserName)
            {
            }
            column(Indent_Header__No__; "No.")
            {
            }
            column(Indent_Header__Due_Date_; "Due Date")
            {
            }
            column(CurrReport_PAGENO__1; CurrReport.PageNo + 1)
            {
            }
            column(TransApproxAmount; TransApproxAmount)
            {
            }
            column(totamt; totamt)
            {
            }
            column(Indent_Header_Remarks; Remarks)
            {
            }
            column(INDENT__FORMCaption; INDENT__FORMCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(TSF__PU__01_REV_No__A__01_06_2006Caption; TSF__PU__01_REV_No__A__01_06_2006CaptionLbl)
            {
            }
            column(Indent_Header__Indent_Date_Caption; FieldCaption("Indent Date"))
            {
            }
            column(Indentor_NameCaption; Indentor_NameCaptionLbl)
            {
            }
            column(Indentor_Dept_Caption; Indentor_Dept_CaptionLbl)
            {
            }
            column(Indent_Header__No__Caption; FieldCaption("No."))
            {
            }
            column(Indent_Header__Due_Date_Caption; FieldCaption("Due Date"))
            {
            }
            column(Description_1Caption; Description_1CaptionLbl)
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(SrNoCaption; SrNoCaptionLbl)
            {
            }
            column(StockCaption; StockCaptionLbl)
            {
            }
            column(Item_CategoryCaption; Item_CategoryCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Unit_PriceCaption; Unit_PriceCaptionLbl)
            {
            }
            column(Approx_AmountCaption; Approx_AmountCaptionLbl)
            {
            }
            column(Description_2Caption; Description_2CaptionLbl)
            {
            }
            column(Continue__Caption; Continue__CaptionLbl)
            {
            }
            column(Page_TotalCaption; Page_TotalCaptionLbl)
            {
            }
            column(Indentor_SignCaption; Indentor_SignCaptionLbl)
            {
            }
            column(HOD_SignCaption; HOD_SignCaptionLbl)
            {
            }
            column(HOD_StoreCaption; HOD_StoreCaptionLbl)
            {
            }
            column(Special_Remarks_Caption; Special_Remarks_CaptionLbl)
            {
            }
            column(Sanctioning_AuthorityCaption; Sanctioning_AuthorityCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(Purchase_Dept_Caption; Purchase_Dept_CaptionLbl)
            {
            }
            dataitem("Indent Line"; "SSD Indent Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") order(ascending);

                column(ReportForNavId_9370; 9370)
                {
                }
                column(Indent_Line__No__; "No.")
                {
                }
                column(Indent_Line_Description; Description)
                {
                }
                column(Indent_Line_Quantity; Quantity)
                {
                }
                column(Indent_Line__Inventory_Main_Store_; "Inventory Main Store")
                {
                }
                column(ItemRec__Purch__Unit_of_Measure_; ItemRec."Purch. Unit of Measure")
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(ItemRec__Item_Category_Code_; ItemRec."Item Category Code")
                {
                }
                column(Indent_Line___Expected_Cost___Indent_Line__Quantity; "Indent Line"."Expected Cost" * "Indent Line".Quantity)
                {
                }
                column(Indent_Line__Description_2_; Description + ',' + "Description 2" + ',' + "Description 3")
                {
                }
                column(UnitCost; UnitCost)
                {
                }
                column(Indent_Line_Remarks; Remarks)
                {
                }
                column(Indent_Line_Document_No_; "Document No.")
                {
                }
                column(Indent_Line_Line_No_; "Line No.")
                {
                }
                column(Indent_Line_Expected_Cost; "Expected Cost")
                {
                }
                column(DirectUnitCost_IndentLine; "Indent Line"."Direct Unit Cost")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    SrNo := SrNo + 1;
                    LineNo := LineNo + 1;
                    totamt := totamt + "Indent Line"."Direct Unit Cost" * "Indent Line".Quantity;
                    if ItemRec.Get("Indent Line"."No.") then begin
                        GradeItm := ItemRec.Grade;
                        if ItemRec."Last Direct Cost" <> 0 then
                            UnitCost := ItemRec."Last Direct Cost"
                        else
                            UnitCost := ItemRec."Unit Cost";
                        ApproxAmount := "Indent Line".Quantity * UnitCost;
                        TotalUnitPrice := TotalUnitPrice + ItemRec."Unit Price";
                        TotalLastDirectCost := TotalLastDirectCost + UnitCost;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                DimensionValue: Record "Dimension Value";
            begin
                // "Indent Header".SetRange("Responsibility Center", ResponsibilityCenter.Code);
                ResAdd := CompanyInfoRec.Address + ', ' + CompanyInfoRec."Address 2" + ', ' + CompanyInfoRec.City + '-' + CompanyInfoRec."Post Code";
                SrNo := 0;
                LineNo := 0;
                ApproxAmount := 0;
                TotalApproxAmount := 0;
                TotalUnitPrice := 0;
                SrNo := 0;
                TotalLastDirectCost := 0;
                totamt := 0;

                Clear(ShorcutDim1Name);
                DimensionValue.Reset();
                DimensionValue.SetRange(code, "Indent Header"."Shortcut Dimension 1 Code");
                if DimensionValue.FindFirst() then
                    ShorcutDim1Name := DimensionValue.Name;
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
        CompanyInfoRec.Get;
        CompanyInfoRec.CalcFields(Picture);
        // ResponsibilityCenter.Get(UserMgt.GetRespCenterFilter);
    end;

    var
        ShorcutDim1Name: Text[50];
        ItemRec: Record Item;
        UserRec: Record User;
        TotalUnitPrice: Decimal;
        TotalApproxAmount: Decimal;
        ApproxAmount: Decimal;
        SrNo: Integer;
        ResponsibilityCenter: Record "Responsibility Center";
        TotalLastDirectCost: Decimal;
        LineNo: Integer;
        CompanyInfoRec: Record "Company Information";
        UserMgt: Codeunit "SSD User Setup Management";
        UnitCost: Decimal;
        TransApproxAmount: Decimal;
        ResAdd: Text[250];
        UserTable: Record User;
        UserName: Text[50];
        GradeItm: Text[50];
        totamt: Decimal;
        INDENT__FORMCaptionLbl: label 'INDENT  FORM';
        PageCaptionLbl: label 'Page';
        TSF__PU__01_REV_No__A__01_06_2006CaptionLbl: label ' TSF (PU) 01 REV No. A. 01/06/2006';
        Indentor_NameCaptionLbl: label 'Indentor Name';
        Indentor_Dept_CaptionLbl: label 'Indentor Dept.';
        Description_1CaptionLbl: label 'Description';//IG_DS 1';
        Item_CodeCaptionLbl: label 'Item Code';
        SrNoCaptionLbl: label 'Sr. No.';
        StockCaptionLbl: label 'Stock';
        Item_CategoryCaptionLbl: label 'Item Category';
        QtyCaptionLbl: label 'Qty';
        UOMCaptionLbl: label 'UOM';
        Unit_PriceCaptionLbl: label 'Unit Price';
        Approx_AmountCaptionLbl: label 'Approx Amount';
        Description_2CaptionLbl: label 'Description 2';
        Continue__CaptionLbl: label 'Continue..';
        Page_TotalCaptionLbl: label 'Page Total';
        Indentor_SignCaptionLbl: label 'Indentor Sign';
        HOD_SignCaptionLbl: label 'HOD Sign';
        HOD_StoreCaptionLbl: label 'HOD Store';
        Special_Remarks_CaptionLbl: label 'Special Remarks:';
        Sanctioning_AuthorityCaptionLbl: label 'Sanctioning Authority';
        Grand_TotalCaptionLbl: label 'Grand Total';
        Purchase_Dept_CaptionLbl: label 'Purchase Dept.';
}
