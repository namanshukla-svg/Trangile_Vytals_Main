Report 50019 "Posted Indent Pending MRR"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Posted Indent Pending MRR.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Indent Header"; "SSD Posted Indent Header")
        {
            RequestFilterFields = "Shortcut Dimension 2 Code", "No.";

            column(ReportForNavId_8065;8065)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(UserId; UserId)
            {
            }
            column(CompanyInfoRec_Picture; CompanyInfoRec.Picture)
            {
            }
            column(rescen__Country_Region_Code_; rescen."Country/Region Code")
            {
            }
            column(rescen_City; rescen.City)
            {
            }
            column(rescen__Post_Code_; rescen."Post Code")
            {
            }
            column(rescen_State; rescen.State)
            {
            }
            column(rescen__Address_2_; rescen."Address 2")
            {
            }
            column(rescen_Address; rescen.Address)
            {
            }
            column(rescen_Name; rescen.Name)
            {
            }
            column(Posted_Indent_Header_Remarks; Remarks)
            {
            }
            column(Posted_Indent_Header__Indent_Date_; "Indent Date")
            {
            }
            column(Posted_Indent_Header__Shortcut_Dimension_2_Code_; "Shortcut Dimension 2 Code")
            {
            }
            column(Posted_Indent_Header__Posted_Indent_Header___User_ID_; "Posted Indent Header"."User ID")
            {
            }
            column(Posted_Indent_Header__No__; "No.")
            {
            }
            column(Posted_Indent_Header__Due_Date_; "Due Date")
            {
            }
            column(Posted_Indent_Header_Remarks_Control1000000020; Remarks)
            {
            }
            column(Posted_Indent_Header__Indent_Date__Control1000000023; "Indent Date")
            {
            }
            column(Posted_Indent_Header__Shortcut_Dimension_2_Code__Control1000000026; "Shortcut Dimension 2 Code")
            {
            }
            column(Posted_Indent_Header__Posted_Indent_Header___User_ID__Control1000000027; "Posted Indent Header"."User ID")
            {
            }
            column(Posted_Indent_Header__No___Control1000000028; "No.")
            {
            }
            column(Posted_Indent_Header__Due_Date__Control1000000032; "Due Date")
            {
            }
            column(Format_No__PUR_CF_003Caption; Format_No__PUR_CF_003CaptionLbl)
            {
            }
            column(PENDING_INDENT__Caption; PENDING_INDENT__CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(User_IdCaption; User_IdCaptionLbl)
            {
            }
            column(Posted_Indent_Header_RemarksCaption; FieldCaption(Remarks))
            {
            }
            column(Posted_Indent_Header__Indent_Date_Caption; FieldCaption("Indent Date"))
            {
            }
            column(Indentor_NameCaption; Indentor_NameCaptionLbl)
            {
            }
            column(Indentor_Dept_Caption; Indentor_Dept_CaptionLbl)
            {
            }
            column(Posted_Indent_Header__No__Caption; FieldCaption("No."))
            {
            }
            column(Posted_Indent_Header__Due_Date_Caption; FieldCaption("Due Date"))
            {
            }
            column(Receipt_Qty_Caption; Receipt_Qty_CaptionLbl)
            {
            }
            column(PO_Qty_Caption; PO_Qty_CaptionLbl)
            {
            }
            column(Pending_PO_Qty_Caption; Pending_PO_Qty_CaptionLbl)
            {
            }
            column(UnitCaption; UnitCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Description_Of_Item_ServicesCaption; Description_Of_Item_ServicesCaptionLbl)
            {
            }
            column(Item_CodeCaption; Item_CodeCaptionLbl)
            {
            }
            column(SrNoCaption; SrNoCaptionLbl)
            {
            }
            column(Posted_Indent_Header_Remarks_Control1000000020Caption; FieldCaption(Remarks))
            {
            }
            column(Indentor_NameCaption_Control1000000022; Indentor_NameCaption_Control1000000022Lbl)
            {
            }
            column(Posted_Indent_Header__Indent_Date__Control1000000023Caption; FieldCaption("Indent Date"))
            {
            }
            column(Indentor_Dept_Caption_Control1000000025; Indentor_Dept_Caption_Control1000000025Lbl)
            {
            }
            column(Posted_Indent_Header__No___Control1000000028Caption; FieldCaption("No."))
            {
            }
            column(Posted_Indent_Header__Due_Date__Control1000000032Caption; FieldCaption("Due Date"))
            {
            }
            column(Item_CodeCaption_Control1000000001; Item_CodeCaption_Control1000000001Lbl)
            {
            }
            column(SrNoCaption_Control1000000015; SrNoCaption_Control1000000015Lbl)
            {
            }
            column(Description_Of_Item_ServicesCaption_Control1000000003; Description_Of_Item_ServicesCaption_Control1000000003Lbl)
            {
            }
            column(Posted_Indent_Line_QuantityCaption; "Posted Indent Line".FieldCaption(Quantity))
            {
            }
            column(UnitCaption_Control1000000011; UnitCaption_Control1000000011Lbl)
            {
            }
            column(PO_Qty_Caption_Control1000000012; PO_Qty_Caption_Control1000000012Lbl)
            {
            }
            column(Receipt_Qty_Caption_Control1000000013; Receipt_Qty_Caption_Control1000000013Lbl)
            {
            }
            column(Pending_PO_Qty_Caption_Control1000000007; Pending_PO_Qty_Caption_Control1000000007Lbl)
            {
            }
            column(Special_Remarks_Caption; Special_Remarks_CaptionLbl)
            {
            }
            column(Sanctioning_AuthorityCaption; Sanctioning_AuthorityCaptionLbl)
            {
            }
            dataitem("Posted Indent Line"; "SSD Posted Indent Line")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = sorting("Document No.", "Line No.")order(ascending);

                column(ReportForNavId_3692;3692)
                {
                }
                column(Posted_Indent_Line__No__; "No.")
                {
                }
                column(Posted_Indent_Line_Description; Description)
                {
                }
                column(Posted_Indent_Line_Quantity; Quantity)
                {
                }
                column(Posted_Indent_Line__Posted_Indent_Line___PO_Qty_; "Posted Indent Line"."PO Qty")
                {
                }
                column(ItemRec__Purch__Unit_of_Measure_; ItemRec."Purch. Unit of Measure")
                {
                }
                column(Posted_Indent_Line__Posted_Indent_Line___Receipt_qty_; "Posted Indent Line"."Receipt qty")
                {
                }
                column(SrNo; SrNo)
                {
                }
                column(Posted_Indent_Line__Posted_Indent_Line___Pending_PO_Qty_; "Posted Indent Line"."Pending PO Qty")
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
                trigger OnAfterGetRecord()
                begin
                    SrNo:=SrNo + 1;
                    LineNo:=LineNo + 1;
                    if ItemRec.Get("Posted Indent Line"."No.")then begin
                        ApproxAmount:="Posted Indent Line".Quantity * ItemRec."Last Direct Cost";
                        TotalApproxAmount:=TotalApproxAmount + ApproxAmount;
                        TotalUnitPrice:=TotalUnitPrice + ItemRec."Unit Price";
                        TotalLastDirectCost:=TotalLastDirectCost + ItemRec."Last Direct Cost" end;
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number)order(ascending);

                column(ReportForNavId_5444;5444)
                {
                }
                trigger OnPreDataItem()
                begin
                    SetRange(Integer.Number, LineNo, 14);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                ApproxAmount:=0;
                TotalApproxAmount:=0;
                TotalUnitPrice:=0;
                SrNo:=0;
                TotalLastDirectCost:=0;
            end;
            trigger OnPreDataItem()
            begin
                //"Posted Indent Header".SetRange("Responsibility Center", ResponsibilityCenter.Code);
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
        ResponsibilityCenter.Get(UserMgt.GetRespCenterFilter);
        CompanyInfoRec.CalcFields(Picture);
        rescen.Get(UserMgt.GetRespCenterFilter);
    end;
    var rescen: Record "Responsibility Center";
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
    ResAdd: Text[250];
    Format_No__PUR_CF_003CaptionLbl: label 'Format No. PUR/CF/003';
    PENDING_INDENT__CaptionLbl: label 'PENDING INDENT  ';
    Page_No_CaptionLbl: label 'Page No.';
    User_IdCaptionLbl: label 'User Id';
    Indentor_NameCaptionLbl: label 'Indentor Name';
    Indentor_Dept_CaptionLbl: label 'Indentor Dept.';
    Receipt_Qty_CaptionLbl: label 'Receipt Qty.';
    PO_Qty_CaptionLbl: label 'PO Qty.';
    Pending_PO_Qty_CaptionLbl: label 'Pending PO Qty.';
    UnitCaptionLbl: label 'Unit';
    QuantityCaptionLbl: label 'Quantity';
    Description_Of_Item_ServicesCaptionLbl: label 'Description Of Item/Services';
    Item_CodeCaptionLbl: label 'Item Code';
    SrNoCaptionLbl: label 'SrNo';
    Indentor_NameCaption_Control1000000022Lbl: label 'Indentor Name';
    Indentor_Dept_Caption_Control1000000025Lbl: label 'Indentor Dept.';
    Item_CodeCaption_Control1000000001Lbl: label 'Item Code';
    SrNoCaption_Control1000000015Lbl: label 'SrNo';
    Description_Of_Item_ServicesCaption_Control1000000003Lbl: label 'Description Of Item/Services';
    UnitCaption_Control1000000011Lbl: label 'Unit';
    PO_Qty_Caption_Control1000000012Lbl: label 'PO Qty.';
    Receipt_Qty_Caption_Control1000000013Lbl: label 'Receipt Qty.';
    Pending_PO_Qty_Caption_Control1000000007Lbl: label 'Pending PO Qty.';
    Special_Remarks_CaptionLbl: label 'Special Remarks:';
    Sanctioning_AuthorityCaptionLbl: label 'Sanctioning Authority';
}
