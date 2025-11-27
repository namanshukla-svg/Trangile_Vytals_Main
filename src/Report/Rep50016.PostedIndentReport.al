Report 50016 "Posted Indent Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Posted Indent Report.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Indent Header"; "SSD Posted Indent Header")
        {
            RequestFilterFields = "No.";

            column(ReportForNavId_8065;8065)
            {
            }
            column(ResponsibilityCenter_Name; ResponsibilityCenter.Name)
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
            column(Posted_Indent_Header__No__; "No.")
            {
            }
            column(Posted_Indent_Header__Indent_Date_; "Indent Date")
            {
            }
            column(UserName; UserName)
            {
            }
            column(Posted_Indent_Header__Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code")
            {
            }
            column(Posted_Indent_Header__Due_Date_; "Due Date")
            {
            }
            column(TotalApproxAmount; TotalApproxAmount)
            {
            }
            column(Posted_Indent_Header_Remarks; Remarks)
            {
            }
            column(INDENT__FORMCaption; INDENT__FORMCaptionLbl)
            {
            }
            column(TSF__PU__01_REV_No__A__01_06_2006Caption; TSF__PU__01_REV_No__A__01_06_2006CaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(Posted_Indent_Header__No__Caption; FieldCaption("No."))
            {
            }
            column(Posted_Indent_Header__Indent_Date_Caption; FieldCaption("Indent Date"))
            {
            }
            column(SrNoCaption; SrNoCaptionLbl)
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(Description_Of_Item_ServicesCaption; Description_Of_Item_ServicesCaptionLbl)
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
            column(UnitCaption; UnitCaptionLbl)
            {
            }
            column(Unit_PriceCaption; Unit_PriceCaptionLbl)
            {
            }
            column(Posted_Indent_Header__Due_Date_Caption; FieldCaption("Due Date"))
            {
            }
            column(Indentor_Dept_Caption; Indentor_Dept_CaptionLbl)
            {
            }
            column(Indentor_NameCaption; Indentor_NameCaptionLbl)
            {
            }
            column(Approx_AmountCaption; Approx_AmountCaptionLbl)
            {
            }
            column(Unit_CostCaption; Unit_CostCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(Indentor_SignCaption; Indentor_SignCaptionLbl)
            {
            }
            column(Special_Remarks_Caption; Special_Remarks_CaptionLbl)
            {
            }
            column(HOD_SignCaption; HOD_SignCaptionLbl)
            {
            }
            column(Sanctioning_AuthorityCaption; Sanctioning_AuthorityCaptionLbl)
            {
            }
            column(HOD_StoreCaption; HOD_StoreCaptionLbl)
            {
            }
            column(DirectorCaption; DirectorCaptionLbl)
            {
            }
            column(Plant_HeadCaption; Plant_HeadCaptionLbl)
            {
            }
            dataitem("Posted Indent Line"; "SSD Posted Indent Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.")order(ascending);

                column(ReportForNavId_3692;3692)
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(Posted_Indent_Line__No__; "No.")
                {
                }
                column(Description2_PostedIndentLine; "Posted Indent Line"."Description 2")
                {
                }
                column(Posted_Indent_Line_Description; Description)
                {
                }
                column(Posted_Indent_Line__Inventory_Main_Store_; "Inventory Main Store")
                {
                }
                column(ItemRec__Item_Category_Code_; ItemRec."Item Category Code")
                {
                }
                column(Posted_Indent_Line_Quantity; Quantity)
                {
                }
                column(ItemRec__Purch__Unit_of_Measure_; ItemRec."Purch. Unit of Measure")
                {
                }
                column(UnitCost; ItemRec."Last Direct Cost")
                {
                }
                column(Posted_Indent_Line__Quantity__Expected_Cost_; "Posted Indent Line".Quantity * "Expected Cost")
                {
                }
                column(Posted_Indent_Line__Expected_Cost_; "Expected Cost")
                {
                }
                column(Posted_Indent_Line__Posted_Indent_Line___Description_2_; "Posted Indent Line"."Description 2")
                {
                }
                column(ApproxAmount; ApproxAmount)
                {
                }
                column(GradeItm; GradeItm)
                {
                }
                column(Posted_Indent_Line_Document_No_; "Document No.")
                {
                }
                column(Posted_Indent_Line_Line_No_; "Line No.")
                {
                }
                column(Posted_Indent_Line_Type; Type)
                {
                }
                column(DirectUnitCost_PostedIndentLine; "Posted Indent Line"."Direct Unit Cost")
                {
                }
                column(Amount; "Posted Indent Line"."Direct Unit Cost" * Quantity)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    SrNo+=1;
                    LineNo:=LineNo + 1;
                    if ItemRec.Get("Posted Indent Line"."No.")then begin
                        GradeItm:=ItemRec.Grade;
                        if ItemRec."Last Direct Cost" <> 0 then UnitCost:=ItemRec."Last Direct Cost"
                        else
                            UnitCost:=ItemRec."Unit Cost";
                        ApproxAmount:="Posted Indent Line".Quantity * "Posted Indent Line"."Expected Cost";
                        //TotalApproxAmount:=TotalApproxAmount+ ApproxAmount;// CE001
                        TotalApproxAmount+=ApproxAmount;
                        TotalUnitPrice:=TotalUnitPrice + ItemRec."Unit Price";
                        TotalLastDirectCost:=TotalLastDirectCost + UnitCost;
                    end;
                    PageLoop:=PageLoop - 1;
                end;
                trigger OnPreDataItem()
                begin
                    SrNo:=0;
                    PageLoop:=10;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number)order(ascending);

                column(ReportForNavId_5444;5444)
                {
                }
                column(CountLoop; CountLoop)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    PageLoop:=PageLoop - 1;
                end;
                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, PageLoop);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                "Posted Indent Header".SetRange("Responsibility Center", ResponsibilityCenter.Code);
                /*
                UserTable.RESET;
                UserTable.SETRANGE(UserTable."User ID","Posted Indent Header"."User ID");
                IF UserTable.FINDFIRST THEN
                 UserName:=UserTable.Name;
                */
                ApproxAmount:=0;
                TotalApproxAmount:=0;
                TotalUnitPrice:=0;
                SrNo:=0;
                TotalLastDirectCost:=0;
            end;
            trigger OnPreDataItem()
            begin
                "Posted Indent Header".SetRange("Responsibility Center", ResponsibilityCenter.Code);
                ResAdd:=ResponsibilityCenter.Address + ', ' + ResponsibilityCenter."Address 2" + ', ' + ResponsibilityCenter.City + '-' + ResponsibilityCenter."Post Code";
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
        ResponsibilityCenter.Get(UserMgt.GetRespCenterFilter);
    end;
    var ItemRec: Record Item;
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
    ResAdd: Text[250];
    Grd: Text[30];
    UserTable: Record User;
    UserName: Text[50];
    GradeItm: Text[50];
    INDENT__FORMCaptionLbl: label 'INDENT  FORM';
    TSF__PU__01_REV_No__A__01_06_2006CaptionLbl: label ' TSF (PU) 01 REV No. A. 01/06/2006';
    PageCaptionLbl: label 'Page';
    SrNoCaptionLbl: label 'SrNo';
    Item_CodeCaptionLbl: label 'Item Code';
    Description_Of_Item_ServicesCaptionLbl: label 'Description Of Item/Services';
    StockCaptionLbl: label 'Stock';
    Item_CategoryCaptionLbl: label 'Item Category';
    QtyCaptionLbl: label 'Qty';
    UnitCaptionLbl: label 'Unit';
    Unit_PriceCaptionLbl: label 'Unit Price';
    Indentor_Dept_CaptionLbl: label 'Indentor Dept.';
    Indentor_NameCaptionLbl: label 'Indentor Name';
    Approx_AmountCaptionLbl: label 'Approx Amount';
    Unit_CostCaptionLbl: label 'Amount';
    Grand_TotalCaptionLbl: label 'Grand Total';
    Indentor_SignCaptionLbl: label 'Indentor Sign';
    Special_Remarks_CaptionLbl: label 'Special Remarks:';
    HOD_SignCaptionLbl: label 'HOD Sign';
    Sanctioning_AuthorityCaptionLbl: label 'Sanctioning Authority';
    HOD_StoreCaptionLbl: label 'HOD Store';
    DirectorCaptionLbl: label 'Director';
    Plant_HeadCaptionLbl: label 'Plant Head';
    PageLoop: Integer;
    CountLoop: label 'CountLoopLbl';
}
