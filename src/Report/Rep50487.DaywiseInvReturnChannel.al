report 50487 "Daywise Inv. & Return Channel"
{
    ApplicationArea = All;
    Caption = 'Daywise Invoice & Return - Channel Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/50486_DaywiseInvoice&ReturnReport.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord()
            begin
                Clear(PostedSalesInvoices);
                PostedSalesInvoices.SetRange(PostedSalesInvoices.Category_SalespersonPurchaser, PostedSalesInvoices.Category_SalespersonPurchaser::Channel);
                PostedSalesInvoices.SetRange(PostedSalesInvoices.Posting_Date, AsOnDate);
                PostedSalesInvoices.Open();
                while PostedSalesInvoices.Read()do begin
                    if not DaywiseRec.Get(PostedSalesInvoices.No, PostedSalesInvoices.LineNo)then begin
                        DaywiseRec.Init();
                        DaywiseRec.EntryType:='Invoice';
                        DaywiseRec.LinkedInvoice:='';
                        DaywiseRec.LinkedInvoiceDate:=0D;
                        DaywiseRec.No:=PostedSalesInvoices.No;
                        DaywiseRec.LineNo:=PostedSalesInvoices.LineNo;
                        DaywiseRec.Posting_Date:=PostedSalesInvoices.Posting_Date;
                        DaywiseRec.BilltoCustomerNo:=PostedSalesInvoices.BilltoCustomerNo;
                        DaywiseRec.BilltoName:=PostedSalesInvoices.BilltoName;
                        DaywiseRec.SalespersonCode:=PostedSalesInvoices.SalespersonCode;
                        DaywiseRec.Category:=Format(PostedSalesInvoices.Category_SalespersonPurchaser);
                        DaywiseRec.ItemCategoryCode:=PostedSalesInvoices.Parent_Category;
                        DaywiseRec.ItemNo:=PostedSalesInvoices.No_Sales_Invoice_Line;
                        DaywiseRec.Description:=PostedSalesInvoices.Description_Sales_Invoice_Line;
                        DaywiseRec.Description2:=PostedSalesInvoices.Description_Sales_Invoice_Line;
                        DaywiseRec.Quantity:=PostedSalesInvoices.Quantity_Sales_Invoice_Line;
                        DaywiseRec.UnitPrice:=PostedSalesInvoices.UnitPrice_Sales_Invoice_Line;
                        DaywiseRec.Amount:=PostedSalesInvoices.Quantity_Sales_Invoice_Line * PostedSalesInvoices.UnitPrice_Sales_Invoice_Line;
                        DaywiseRec.Insert();
                    end;
                    Clear(SalesReturnOrders);
                    SalesReturnOrders.SetRange(SalesReturnOrders.Category, SalesReturnOrders.Category::Channel);
                    SalesReturnOrders.SetRange(SalesReturnOrders.Posting_Date, AsOnDate);
                    SalesReturnOrders.Open();
                    while SalesReturnOrders.Read()do begin
                        if not DaywiseRec.Get(SalesReturnOrders.No, SalesReturnOrders.LineNo)then begin
                            DaywiseRec.Init();
                            DaywiseRec.EntryType:='Return';
                            DaywiseRec.LinkedInvoice:=SalesReturnOrders.External_Document_No_;
                            DaywiseRec.LinkedInvoiceDate:=SalesReturnOrders.External_Doc__Date;
                            DaywiseRec.No:=SalesReturnOrders.No;
                            DaywiseRec.LineNo:=SalesReturnOrders.LineNo;
                            DaywiseRec.Posting_Date:=SalesReturnOrders.Posting_Date;
                            DaywiseRec.BilltoCustomerNo:=SalesReturnOrders.BilltoCustomerNo;
                            DaywiseRec.BilltoName:=SalesReturnOrders.BilltoName;
                            DaywiseRec.SalespersonCode:=SalesReturnOrders.Salesperson_Code;
                            DaywiseRec.Category:=Format(SalesReturnOrders.Category);
                            DaywiseRec.ItemCategoryCode:=SalesReturnOrders.Parent_Category;
                            DaywiseRec.ItemNo:=SalesReturnOrders.No_Sales_Line;
                            DaywiseRec.Description:=SalesReturnOrders.Description_Sales_Line;
                            DaywiseRec.Description2:=SalesReturnOrders.Description2_Sales_Line;
                            DaywiseRec.Quantity:=SalesReturnOrders.Quantity_Sales_Line;
                            DaywiseRec.UnitPrice:=SalesReturnOrders.Unit_Price;
                            DaywiseRec.Amount:=SalesReturnOrders.Quantity_Sales_Line * SalesReturnOrders.Unit_Price;
                            DaywiseRec.Insert();
                        END;
                    end;
                end;
            end;
            trigger OnPreDataItem()
            begin
            end;
        }
        dataitem(Integer2; Integer)
        {
            DataItemTableView = SORTING(Number)ORDER(Ascending)WHERE(Number=FILTER(1..));

            column(DaywiseRec_EntryType; DaywiseRec.EntryType)
            {
            }
            column(DaywiseRec_LinkedInvoice; DaywiseRec.LinkedInvoice)
            {
            }
            column(DaywiseRec_LinkedInvoiceDate; Format(DaywiseRec.LinkedInvoiceDate))
            {
            }
            column(DaywiseRec_No; DaywiseRec.No)
            {
            }
            column(DaywiseRec_LineNo; DaywiseRec.LineNo)
            {
            }
            column(DaywiseRec_Posting_Date; Format(DaywiseRec.Posting_Date))
            {
            }
            column(DaywiseRec_BilltoCustomerNo; DaywiseRec.BilltoCustomerNo)
            {
            }
            column(DaywiseRec_BilltoName; DaywiseRec.BilltoName)
            {
            }
            column(DaywiseRec_SalespersonCode; DaywiseRec.SalespersonCode)
            {
            }
            column(DaywiseRec_Category; DaywiseRec.Category)
            {
            }
            column(DaywiseRec_ItemCategoryCode; DaywiseRec.ItemCategoryCode)
            {
            }
            column(DaywiseRec_ItemNo; DaywiseRec.ItemNo)
            {
            }
            column(DaywiseRec_Description; DaywiseRec.Description)
            {
            }
            column(DaywiseRec_Description2; DaywiseRec.Description2)
            {
            }
            column(DaywiseRec_Quantity; DaywiseRec.Quantity)
            {
            }
            column(DaywiseRec_UnitPrice; DaywiseRec.UnitPrice)
            {
            }
            column(DaywiseRec_Amount; DaywiseRec.Amount)
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN BEGIN
                    IF NOT DaywiseRec.FINDSET(FALSE, FALSE)THEN CurrReport.BREAK;
                END
                ELSE IF DaywiseRec.NEXT = 0 THEN CurrReport.BREAK;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field(AsOnDate; AsOnDate)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        DaywiseRec.Reset();
        if DaywiseRec.FindSet()then DaywiseRec.DeleteAll();
    end;
    trigger OnPostReport()
    begin
    end;
    var TypeText: Text[10];
    SalesReturnOrders: Query "Sales Return Orders";
    PostedSalesInvoices: Query "Posted Sales Invoices";
    AsOnDate: Date;
    DaywiseRec: Record "SSD Daywise Inv. & Return";
}
