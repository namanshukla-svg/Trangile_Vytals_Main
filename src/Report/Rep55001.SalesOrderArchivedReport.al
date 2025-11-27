/// <summary>
/// Report Sales Order Archived Report (ID 55001).
/// </summary>
report 55001 "Sales Order Archived Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sales Order Archived.rdl';
    Caption = 'Sales Order Archived Report';
    // UsageCategory = ReportsandAnalysis;
    // ApplicationArea = all;

    dataset
    {
        dataitem(SalesHeaderMain; "Sales Header")
        {
            DataItemTableView = where("Document Type" = filter('Order'));
            dataitem(SalesHeader; "Sales Header")
            {
                DataItemLinkReference = SalesHeaderMain;
                DataItemLink = "Document Type" = field("Document Type"), "No." = field("No.");
                DataItemTableView = where("Document Type" = filter('Order'));
                column(SH; 'SH') { }
                column(SalesOrder; "No.") { }
                column(Order_Date; "Order Date") { }
                column(Status; Status) { }
                column(Sell_to_Customer_Code; "Sell-to Customer No.") { }
                column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
                column(Bill_to_Customer_Code; "Bill-to Customer No.") { }
                column(Bill_to_Name; "Bill-to Name") { }
                column(External_Document_No_; "External Document No.") { }
                column(External_Doc__Date; "External Doc. Date") { }
                column(Salesperson_Code; "Salesperson Code") { }

                dataitem(SalesLine; "Sales Line")
                {
                    DataItemLinkReference = SalesHeader;
                    DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                    DataItemTableView = where("Document Type" = filter('Order'), "No." = filter(<> ''));
                    column(SL; 'SL') { }
                    column(Item_Category_Code; ItemCategoryCode_Arh) { }// "Item Category Code") { }
                    column(ItemCode; "No.") { }
                    column(Description; Description) { }
                    column(Description_2; "Description 2") { }
                    column(Description3; Description3) { }
                    column(UOM; "Unit of Measure Code") { }
                    column(SOQuantity; Quantity) { }
                    column(Outstanding_Quantity; "Outstanding Quantity") { }
                    column(Unit_Price; "Unit Price") { }
                    column(Line_Amount; "Line Amount") { }
                    column(Net_Weight; "Net Weight") { }
                    column(MOQ_Quantity; "MOQ Quantity") { }
                    column(Shipment_Date; "Shipment Date") { }
                    column(Remarks; Remarks) { }
                    column(Internal_Remarks; "Internal Remarks") { }
                    column(PMM_Remarks; "PMM Remarks") { }
                    trigger OnAfterGetRecord()
                    var
                        Item: Record Item;
                    begin
                        if item.Get(SalesLine."No.") then
                            Description3 := Item."Description 3";

                        if ItemCategory.Get(SalesLine."Item Category Code") then
                            if ItemCategory."Parent Category" <> '' then
                                ItemCategoryCode := ItemCategory."Parent Category"
                            else
                                ItemCategoryCode := ''
                        else
                            ItemCategoryCode := '';
                    end;
                }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    if (StartDate <> 0D) and (EndDate <> 0D) then
                        SalesHeader.SetRange("Order Date", StartDate, EndDate);
                end;
            }
            dataitem(SalesHeaderArchive; "Sales Header Archive")
            {
                DataItemLinkReference = SalesHeaderMain;
                DataItemLink = "Document Type" = field("Document Type"), "No." = field("No.");
                DataItemTableView = where("Document Type" = filter('Order'));
                column(SHA; 'SHA') { }
                column(SalesOrder_Arh; "No.") { }
                column(Order_Date_Arh; "Order Date") { }
                column(Status_Arh; Status) { }
                column(Sell_to_Customer_Code_Arh; "Sell-to Customer No.") { }
                column(Sell_to_Customer_Name_Arh; "Sell-to Customer Name") { }
                column(Bill_to_Customer_Code_Arh; "Bill-to Customer No.") { }
                column(Bill_to_Name_Arh; "Bill-to Name") { }
                column(External_Document_No__Arh; "External Document No.") { }
                //  column(External_Doc__Date_Arh; "External Doc. Date") { }
                column(Salesperson_Code_Arh; "Salesperson Code") { }

                dataitem(SalesLineArchive; "Sales Line Archive")
                {
                    DataItemLinkReference = SalesHeaderArchive;
                    DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                    DataItemTableView = where("Document Type" = filter('Order'), "No." = filter(<> ''));
                    column(SLA; 'SLA') { }
                    column(Item_Category_Code_Arh; ItemCategoryCode_Arh) { }// "Item Category Code") { }
                    column(ItemCode_Arh; "No.") { }
                    column(Description_Arh; Description) { }
                    column(Description_2_Arh; "Description 2") { }
                    column(Description3_Arh; Description3) { }
                    column(UOM_Arh; "Unit of Measure Code") { }
                    column(SOQuantity_Arh; Quantity) { }
                    column(Outstanding_Quantity_Arh; "Outstanding Quantity") { }
                    column(Unit_Price_Arh; "Unit Price") { }
                    column(Line_Amount_Arh; "Line Amount") { }
                    column(Net_Weight_Arh; "Net Weight") { }
                    //  column(MOQ_Quantity_Arh; "MOQ Quantity") { }
                    column(Shipment_Date_Arh; "Shipment Date") { }
                    //  column(Remarks_Arh; Remarks) { }
                    // column(Internal_Remarks_Arh; "Internal Remarks") { }
                    // column(PMM_Remarks_Arh; "PMM Remarks") { }
                    trigger OnAfterGetRecord()
                    var
                        Item: Record Item;
                    begin
                        if item.Get(SalesLine."No.") then
                            Description3_Arh := Item."Description 3";

                        if ItemCategory_Arh.Get(SalesLineArchive."Item Category Code") then
                            if ItemCategory_Arh."Parent Category" <> '' then
                                ItemCategoryCode_Arh := ItemCategory_Arh."Parent Category"
                            else
                                ItemCategoryCode_Arh := ''
                        else
                            ItemCategoryCode_Arh := '';
                    end;
                }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    if (StartDate <> 0D) and (EndDate <> 0D) then
                        SalesHeaderArchive.SetRange("Order Date", StartDate, EndDate);
                end;
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if (StartDate <> 0D) and (EndDate <> 0D) then
                    SalesHeaderMain.SetRange("Order Date", StartDate, EndDate);
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Request Page")
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
                        Caption = 'End Date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }

    var
        StartDate: Date;
        EndDate: Date;
        Description3: Text;
        Description3_Arh: Text;
        ItemCategoryCode: Code[20];
        ItemCategory: Record "Item Category";
        ItemCategoryCode_Arh: Code[20];
        ItemCategory_Arh: Record "Item Category";
}