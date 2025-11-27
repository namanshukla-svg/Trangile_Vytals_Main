Report 50144 "Sales Dash Board"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sales Dash Board.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.")where("Document Type"=const(Order), "Document Subtype"=const(Order), "Outstanding Quantity"=filter(>0));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Document No.", "Line No.";

            column(ReportForNavId_2844;2844)
            {
            }
            column(UserId; UserId)
            {
            }
            column(CompanyInfo__New_Logo1_; CompanyInfo."New Logo1")
            {
            }
            column(CompanyInfo__New_Logo2_; CompanyInfo."New Logo2")
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Sales_Line___Document_No________FORMAT_SalesHeader__Posting_Date__; "Sales Line"."Document No." + ' ' + Format(SalesHeader."Posting Date"))
            {
            }
            column(FORMAT__Sales_Line___Line_No___________FORMAT__Sales_Line___No____; Format("Sales Line"."Line No.") + ' ' + Format("Sales Line"."No."))
            {
            }
            column(Sales_Line___Bill_to_Customer_No___________SalesHeader__Bill_to_Name_; "Sales Line"."Bill-to Customer No." + ' ' + SalesHeader."Bill-to Name")
            {
            }
            column(Sales_Line__Description________Sales_Line___Description_2_; "Sales Line".Description + ' ' + "Sales Line"."Description 2")
            {
            }
            column(Sales_Line___Sell_to_Customer_No___________SalesHeader__Sell_to_Customer_Name_; "Sales Line"."Sell-to Customer No." + ' ' + SalesHeader."Sell-to Customer Name")
            {
            }
            column(Sales_Line___Outstanding_Quantity____Unit_Price_; "Sales Line"."Outstanding Quantity" * "Unit Price")
            {
            }
            column(Sales_Line__Sales_Line___Shipment_Date_; "Sales Line"."Shipment Date")
            {
            }
            column(Sales_Line__Sales_Line___Outstanding_Quantity_; "Sales Line"."Outstanding Quantity")
            {
            }
            column(Sales_Line__Sales_Line__Quantity; "Sales Line".Quantity)
            {
            }
            column(DASH_BOARD_FOR_PENDING_SALES_ORDERCaption; DASH_BOARD_FOR_PENDING_SALES_ORDERCaptionLbl)
            {
            }
            column(Sales_Order_No____DateCaption; Sales_Order_No____DateCaptionLbl)
            {
            }
            column(Sale_to_Customer_Code___NameCaption; Sale_to_Customer_Code___NameCaptionLbl)
            {
            }
            column(Line_No__Item_CodeCaption; Line_No__Item_CodeCaptionLbl)
            {
            }
            column(Bill_to_Customer_Code___NameCaption; Bill_to_Customer_Code___NameCaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Pending_QuantityCaption; Pending_QuantityCaptionLbl)
            {
            }
            column(Pending_ValueCaption; Pending_ValueCaptionLbl)
            {
            }
            column(Shipment_DateCaption; Shipment_DateCaptionLbl)
            {
            }
            column(Order_QuantityCaption; Order_QuantityCaptionLbl)
            {
            }
            column(Sales_Line_Document_Type; "Document Type")
            {
            }
            column(Sales_Line_Document_No_; "Document No.")
            {
            }
            column(Sales_Line_Line_No_; "Line No.")
            {
            }
            dataitem("Sales DashBoard Comment LineCC"; "SSD SalesDashBoardCommentLine")
            {
                DataItemLink = "No."=field("Document No."), "Document Line No."=field("Line No.");
                DataItemTableView = sorting("Document Type", "No.", "Document Line No.", Code, "Line No.")order(descending)where(Code=const('CC'));
                PrintOnlyIfDetail = false;

                column(ReportForNavId_5298;5298)
                {
                }
                column(FORMAT_CommentCaption____FORMAT_Sno_; Format(CommentCaption) + Format(Sno))
                {
                }
                column(FORMAT__Sales_DashBoard_Comment_LineCC___Comment_Date___________FORMAT__Sales_DashBoard_Comment_LineCC___Comment_Time__; Format("Sales DashBoard Comment LineCC"."Comment Date") + ' ' + Format("Sales DashBoard Comment LineCC"."Comment Time"))
                {
                }
                column(Sales_DashBoard_Comment_LineCC__Sales_DashBoard_Comment_LineCC___User_Id_; "Sales DashBoard Comment LineCC"."User Id")
                {
                }
                column(Sales_DashBoard_Comment_LineCC__Sales_DashBoard_Comment_LineCC__Comment; "Sales DashBoard Comment LineCC".Comment)
                {
                }
                column(Sales_DashBoard_Comment_LineCC_Document_Type; "Document Type")
                {
                }
                column(Sales_DashBoard_Comment_LineCC_No_; "No.")
                {
                }
                column(Sales_DashBoard_Comment_LineCC_Document_Line_No_; "Document Line No.")
                {
                }
                column(Sales_DashBoard_Comment_LineCC_Code; Code)
                {
                }
                column(Sales_DashBoard_Comment_LineCC_Line_No_; "Line No.")
                {
                }
            }
            dataitem("Sales DashBoard Comment LinePP"; "SSD SalesDashBoardCommentLine")
            {
                DataItemLink = "No."=field("Document No."), "Document Line No."=field("Line No.");
                DataItemTableView = sorting("Document Type", "No.", "Document Line No.", Code, "Line No.")order(descending)where(Code=const('PPC'));
                PrintOnlyIfDetail = false;

                column(ReportForNavId_3320;3320)
                {
                }
                column(Sales_DashBoard_Comment_LinePP__Sales_DashBoard_Comment_LinePP__Comment; "Sales DashBoard Comment LinePP".Comment)
                {
                }
                column(Sales_DashBoard_Comment_LinePP__Sales_DashBoard_Comment_LinePP___User_Id_; "Sales DashBoard Comment LinePP"."User Id")
                {
                }
                column(FORMAT__Sales_DashBoard_Comment_LinePP___Comment_Date___________FORMAT__Sales_DashBoard_Comment_LinePP___Comment_Time__; Format("Sales DashBoard Comment LinePP"."Comment Date") + ' ' + Format("Sales DashBoard Comment LinePP"."Comment Time"))
                {
                }
                column(FORMAT_CommentCaption1_________FORMAT_Sno2_; Format(CommentCaption1) + ' ' + Format(Sno2))
                {
                }
                column(Sales_DashBoard_Comment_LinePP_Document_Type; "Document Type")
                {
                }
                column(Sales_DashBoard_Comment_LinePP_No_; "No.")
                {
                }
                column(Sales_DashBoard_Comment_LinePP_Document_Line_No_; "Document Line No.")
                {
                }
                column(Sales_DashBoard_Comment_LinePP_Code; Code)
                {
                }
                column(Sales_DashBoard_Comment_LinePP_Line_No_; "Line No.")
                {
                }
            }
            dataitem("Sales DashBoard Comment LineSC"; "SSD SalesDashBoardCommentLine")
            {
                DataItemLink = "No."=field("Document No."), "Document Line No."=field("Line No.");
                DataItemTableView = sorting("Document Type", "No.", "Document Line No.", Code, "Line No.")order(descending)where(Code=const('SCM'));
                PrintOnlyIfDetail = false;

                column(ReportForNavId_6545;6545)
                {
                }
                column(Sales_DashBoard_Comment_LineSC__Sales_DashBoard_Comment_LineSC__Comment; "Sales DashBoard Comment LineSC".Comment)
                {
                }
                column(Sales_DashBoard_Comment_LineSC__Sales_DashBoard_Comment_LineSC___User_Id_; "Sales DashBoard Comment LineSC"."User Id")
                {
                }
                column(FORMAT__Sales_DashBoard_Comment_LineSC___Comment_Date___________FORMAT__Sales_DashBoard_Comment_LineSC___Comment_Time__; Format("Sales DashBoard Comment LineSC"."Comment Date") + ' ' + Format("Sales DashBoard Comment LineSC"."Comment Time"))
                {
                }
                column(FORMAT_CommentCaption2__________FORMAT_Sno3_; Format(CommentCaption2) + ' ' + Format(Sno3))
                {
                }
                column(Sales_DashBoard_Comment_LineSC_Document_Type; "Document Type")
                {
                }
                column(Sales_DashBoard_Comment_LineSC_No_; "No.")
                {
                }
                column(Sales_DashBoard_Comment_LineSC_Document_Line_No_; "Document Line No.")
                {
                }
                column(Sales_DashBoard_Comment_LineSC_Code; Code)
                {
                }
                column(Sales_DashBoard_Comment_LineSC_Line_No_; "Line No.")
                {
                }
            }
            dataitem("Sales DashBoard Comment LinePH"; "SSD SalesDashBoardCommentLine")
            {
                DataItemLink = "No."=field("Document No."), "Document Line No."=field("Line No.");
                DataItemTableView = sorting("Document Type", "No.", "Document Line No.", Code, "Line No.")order(descending)where(Code=const('MGMT'));
                PrintOnlyIfDetail = false;

                column(ReportForNavId_8307;8307)
                {
                }
                column(Sales_DashBoard_Comment_LinePH__Sales_DashBoard_Comment_LinePH__Comment; "Sales DashBoard Comment LinePH".Comment)
                {
                }
                column(Sales_DashBoard_Comment_LinePH__Sales_DashBoard_Comment_LinePH___User_Id_; "Sales DashBoard Comment LinePH"."User Id")
                {
                }
                column(FORMAT__Sales_DashBoard_Comment_LinePH___Comment_Date___________FORMAT__Sales_DashBoard_Comment_LinePH___Comment_Time__; Format("Sales DashBoard Comment LinePH"."Comment Date") + ' ' + Format("Sales DashBoard Comment LinePH"."Comment Time"))
                {
                }
                column(FORMAT_CommentCaption3__________FORMAT_Sno4_; Format(CommentCaption3) + ' ' + Format(Sno4))
                {
                }
                column(Sales_DashBoard_Comment_LinePH_Document_Type; "Document Type")
                {
                }
                column(Sales_DashBoard_Comment_LinePH_No_; "No.")
                {
                }
                column(Sales_DashBoard_Comment_LinePH_Document_Line_No_; "Document Line No.")
                {
                }
                column(Sales_DashBoard_Comment_LinePH_Code; Code)
                {
                }
                column(Sales_DashBoard_Comment_LinePH_Line_No_; "Line No.")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                Customer.Get("Sales Line"."Sell-to Customer No.");
                if SalesHeader.Get(SalesHeader."document type"::Order, "Document No.")then;
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
        Sno:=0;
        Sno2:=0;
        Sno3:=0;
        Sno4:=0;
        CommentCaption:='Customer Care-Comment';
        CommentCaption1:='PPC-Comment';
        CommentCaption2:='SCM-Comment';
        CommentCaption3:='PH/MGMT-Comment';
        CompanyInfo.Get;
        CompanyInfo.CalcFields(CompanyInfo.Picture, CompanyInfo."New Logo1", CompanyInfo."New Logo2");
    end;
    var SalesHeader: Record "Sales Header";
    CompanyInfo: Record "Company Information";
    CommentCaption: Text[30];
    Sno: Integer;
    CommentCaption1: Text[30];
    CommentCaption2: Text[30];
    CommentCaption3: Text[30];
    CommentCaption4: Text[30];
    Customer: Record Customer;
    Sno2: Integer;
    Sno3: Integer;
    Sno4: Integer;
    DASH_BOARD_FOR_PENDING_SALES_ORDERCaptionLbl: label 'DASH BOARD FOR PENDING SALES ORDER';
    Sales_Order_No____DateCaptionLbl: label ' Sales Order No. & Date';
    Sale_to_Customer_Code___NameCaptionLbl: label ' Sale to Customer Code & Name';
    Line_No__Item_CodeCaptionLbl: label ' Line No.-Item Code';
    Bill_to_Customer_Code___NameCaptionLbl: label ' Bill to Customer Code & Name';
    Item_DescriptionCaptionLbl: label ' Item Description';
    Pending_QuantityCaptionLbl: label 'Pending Quantity';
    Pending_ValueCaptionLbl: label 'Pending Value';
    Shipment_DateCaptionLbl: label 'Shipment Date';
    Order_QuantityCaptionLbl: label 'Order Quantity';
}
