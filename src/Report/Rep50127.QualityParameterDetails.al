Report 50127 "Quality Parameter Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Quality Parameter Details.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Item No.", "Posting Date")order(ascending)where("Entry Type"=filter(Purchase|Output));
            RequestFilterFields = "Item No.", "Posting Date";

            column(ReportForNavId_7209;7209)
            {
            }
            column(UserId; UserId)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(ResCen__Address_2_; ResCen."Address 2")
            {
            }
            column(ResCen_Address; ResCen.Address)
            {
            }
            column(ResCen_City_______ResCen__Post_Code_; ResCen.City + ' - ' + ResCen."Post Code")
            {
            }
            column(ResCen_State; ResCen.State)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(ResCen_Name; ResCen.Name)
            {
            }
            column(Filters______Item_Ledger_Entry__GETFILTERS;'Filters ' + "Item Ledger Entry".GetFilters)
            {
            }
            column(ParamDetail_7_; ParamDetail[7])
            {
            }
            column(ParamDetail_6_; ParamDetail[6])
            {
            }
            column(ParamDetail_5_; ParamDetail[5])
            {
            }
            column(ParamDetail_4_; ParamDetail[4])
            {
            }
            column(ParamDetail_3_; ParamDetail[3])
            {
            }
            column(ParamDetail_2_; ParamDetail[2])
            {
            }
            column(ParamDetail_1_; ParamDetail[1])
            {
            }
            column(ParamDetail_10_; ParamDetail[10])
            {
            }
            column(ParamDetail_9_; ParamDetail[9])
            {
            }
            column(ParamDetail_8_; ParamDetail[8])
            {
            }
            column(ItemRec_Description_______ItemRec__Description_2_; ItemRec.Description + ' ' + ItemRec."Description 2")
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(Item_Ledger_Entry__Entry_Type_; "Entry Type")
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(Item_Ledger_Entry__Document_Date_; "Document Date")
            {
            }
            column(McNameVendName; McNameVendName)
            {
            }
            column(ItemBaseUOM; ItemBaseUOM)
            {
            }
            column(Qua_Remark; Qua_Remark)
            {
            }
            column(LotSize; LotSize)
            {
            }
            column(AcceptQty; AcceptQty)
            {
            }
            column(RejQty; RejQty)
            {
            }
            column(AvgValue_2_; AvgValue[2])
            {
            }
            column(AvgValue_3_; AvgValue[3])
            {
            }
            column(AvgValue_4_; AvgValue[4])
            {
            }
            column(AvgValue_5_; AvgValue[5])
            {
            }
            column(AvgValue_6_; AvgValue[6])
            {
            }
            column(AvgValue_7_; AvgValue[7])
            {
            }
            column(AvgValue_1_; AvgValue[1])
            {
            }
            column(AvgValue_10_; AvgValue[10])
            {
            }
            column(AvgValue_9_; AvgValue[9])
            {
            }
            column(AvgValue_8_; AvgValue[8])
            {
            }
            column(Quality_Parameter_DetailsCaption; Quality_Parameter_DetailsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ConfidentialCaption; ConfidentialCaptionLbl)
            {
            }
            column(Qty__RejectedCaption; Qty__RejectedCaptionLbl)
            {
            }
            column(Qty__AcceptedCaption; Qty__AcceptedCaptionLbl)
            {
            }
            column(Qty__Recd_Caption; Qty__Recd_CaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(M_C_Name_Vendor_NameCaption; M_C_Name_Vendor_NameCaptionLbl)
            {
            }
            column(Doc__DateCaption; Doc__DateCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Entry_Type_Caption; FieldCaption("Entry Type"))
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; FieldCaption("Item No."))
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(ILE_Desc; "Item Ledger Entry".Description)
            {
            }
            column(ItemRec_UOMC; ItemRec."Base Unit of Measure")
            {
            }
            column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
            {
            }
            trigger OnAfterGetRecord()
            begin
                ItemRec.Reset;
                if ItemRec.Get("Item No.")then;
                //ItemNo:="Item No.";
                if "Entry Type" = "entry type"::Output then begin
                    DocNo:="Order No.";
                    if DocNo <> '' then begin
                        ProdOrdrRoutLine.SetRange(ProdOrdrRoutLine."Prod. Order No.", DocNo);
                        if ProdOrdrRoutLine.FindFirst then repeat if ProdOrdrRoutLine.Type = ProdOrdrRoutLine.Type::"Machine Center" then McNameVendName:=ProdOrdrRoutLine.Description;
                            until ProdOrdrRoutLine.Next = 0;
                    end
                    else
                        McNameVendName:='';
                end
                else if "Entry Type" = "entry type"::Purchase then begin
                        DocNo:="Item Ledger Entry"."MRN No.";
                        if Vend.Get("Source No.")then McNameVendName:=Vend.Name;
                    end;
                PostQualityOrdHeader.Reset;
                CalcFields("Posted Quality Order No.");
                PostQualityOrdHeader.SetRange(PostQualityOrdHeader."No.", ("Posted Quality Order No."));
                if PostQualityOrdHeader.FindFirst then begin
                    Qua_Remark:=PostQualityOrdHeader.Remarks;
                    LotSize:=PostQualityOrdHeader."Lot Size";
                    RejQty:=PostQualityOrdHeader."Rejected Qty.";
                    AcceptQty:=PostQualityOrdHeader."Accepted Qty.";
                end
                else
                begin
                    LotSize:=0;
                    RejQty:=0;
                    AcceptQty:=0;
                    Qua_Remark:='';
                end;
                Countt:=1;
                PostQualityOrderLine.SetRange(PostQualityOrderLine."Document No.", ("Posted Quality Order No."));
                if PostQualityOrderLine.FindFirst then;
                repeat //  ParamDetail[Countt]:=PostQualityOrderLine.Description;
                    //  MESSAGE('%1',PostQualityOrderLine.Description);
                    //  AvgValue[Countt]:=PostQualityOrderLine."Inspection Value2";     //Commented By RA As per User Requirement 22022012
                    //ALLE RA 22022012 >>
                    if PostQualityOrderLine."Meas. Value Type" = PostQualityOrderLine."meas. value type"::Value then begin
                        AvgValue[Countt]:=Format(PostQualityOrderLine."Inspection Value2");
                    end
                    else
                    begin
                        if PostQualityOrderLine."Quality Pass" then AvgValue[Countt]:='PASS'
                        else
                            AvgValue[Countt]:='NOT PASS' end;
                    //ALLE RA 22022012 <<
                    Countt+=1;
                until PostQualityOrderLine.Next = 0;
            end;
            trigger OnPreDataItem()
            begin
                PrintOnce:=1;
                if "Item Ledger Entry".GetFilter("Item No.") = '' then Error('You Have to select only one item No.');
                Countt:=1;
                ItemRec.Reset;
                if ItemRec.Get("Item Ledger Entry".GetFilter("Item No."))then;
                if ItemRec."Routing No." <> '' then begin
                    RoutingLine.SetRange(RoutingLine."Routing No.", ItemRec."Routing No.");
                    if RoutingLine.FindFirst then;
                    SamplingNo:=RoutingLine."Quality Sampling No.";
                end
                else
                begin
                    ItemSamplingTemplate.SetRange(ItemSamplingTemplate."Item Code", "Item Ledger Entry".GetFilter("Item No."));
                    if ItemSamplingTemplate.FindFirst then SamplingNo:=ItemSamplingTemplate."Sampling Temp. No.";
                end;
                SamplingTempLine.SetRange(SamplingTempLine."Document No.", SamplingNo);
                if SamplingTempLine.FindFirst then repeat ParamDetail[Countt]:=SamplingTempLine.Description;
                        Countt+=1;
                    until SamplingTempLine.Next = 0;
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
        ResCen.Get(UserMgt.GetRespCenterFilter);
        ExcelBuf.DeleteAll;
        Clear(ExcelBuf);
        RowNo:=0;
    end;
    trigger OnPostReport()
    begin
    /* // BIS 1145
        IF ExportToExcel THEN BEGIN
          ExcelBuf.CreateBook;
          ExcelBuf.CreateSheet('Quality Parameter Details', '', COMPANYNAME, USERID);
          ExcelBuf.GiveUserControl;
        END;
        */
    // BIS 1145
    end;
    var PostQualityOrdHeader: Record "SSD Posted Quality Order Hdr";
    LotSize: Decimal;
    RejQty: Decimal;
    AcceptQty: Decimal;
    DocNo: Code[20];
    McNameVendName: Text[100];
    ProdOrdrRoutLine: Record "Prod. Order Routing Line";
    Vend: Record Vendor;
    PostQualityOrderLine: Record "SSD Posted Quality Order Line";
    ParamDetail: array[20]of Text[150];
    Countt: Integer;
    AvgValue: array[20]of Text[150];
    ItemRec: Record Item;
    ResCen: Record "Responsibility Center";
    UserMgt: Codeunit "SSD User Setup Management";
    PrintOnce: Integer;
    ItemNo: Code[10];
    RoutingLine: Record "Routing Line";
    SamplingTempLine: Record "SSD Sampling Temp. Line";
    ItemSamplingTemplate: Record "Item Sampling Template";
    SamplingNo: Code[20];
    ExcelBuf: Record "Excel Buffer" temporary;
    ExportToExcel: Boolean;
    RowNo: Integer;
    ItemRec2: Record Item;
    ItemBaseUOM: Code[20];
    Quality_Parameter_DetailsCaptionLbl: label 'Quality Parameter Details';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    ConfidentialCaptionLbl: label 'Confidential';
    Qty__RejectedCaptionLbl: label 'Qty. Rejected';
    Qty__AcceptedCaptionLbl: label 'Qty. Accepted';
    Qty__Recd_CaptionLbl: label 'Qty. Recd.';
    UOMCaptionLbl: label 'UOM';
    M_C_Name_Vendor_NameCaptionLbl: label 'M/C Name/Vendor Name';
    Doc__DateCaptionLbl: label 'Doc. Date';
    Document_No_CaptionLbl: label 'Document No.';
    Item_DescriptionCaptionLbl: label 'Item Description';
    Qua_Remark: Text;
    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean)
    begin
        ExcelBuf.Init;
        ExcelBuf.Validate("Row No.", RowNo);
        ExcelBuf.Validate("Column No.", ColumnNo);
        ExcelBuf."Cell Value as Text":=CellValue;
        ExcelBuf.Formula:='';
        ExcelBuf.Bold:=Bold;
        ExcelBuf.Underline:=UnderLine;
        ExcelBuf.Insert;
    end;
}
