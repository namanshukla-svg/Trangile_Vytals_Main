xmlport 50002 "Sales Invoice Summary - MIS"
{
    Caption = 'Sales Invoice Summary - MIS';
    Format = VariableText;
    Direction = Export;
    TextEncoding = UTF8;
    FileName = 'Sales Invoice Report Summary - MIS.csv';
    UseRequestPage = true;
    TableSeparator = '<NewLine>';

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                SourceTableView = where(Number = const(1));
                textelement(ZDInvNo)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ZDInvNo := 'ZD Inv No';
                    end;
                }
                textelement(TypeOfInvoice)
                {
                    trigger OnBeforePassVariable()
                    begin
                        TypeOfInvoice := 'Type Of Invoice';
                    end;
                }
                textelement(InvDate)
                {
                    trigger OnBeforePassVariable()
                    begin
                        InvDate := 'Inv Date';
                    end;
                }
                textelement(DueDate)
                {
                    trigger OnBeforePassVariable()
                    begin
                        DueDate := 'Due Date';
                    end;
                }
                textelement(SelltoCustomerCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SelltoCustomerCode := 'Sell to Customer Code';
                    end;
                }
                textelement(SelltoName)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SelltoName := 'Sell to Name';
                    end;
                }
                textelement(BilltoCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BilltoCode := 'Bill to Code';
                    end;
                }
                textelement(BilltoName)
                {
                    trigger OnBeforePassVariable()
                    begin
                        BilltoName := 'Bill to Name';
                    end;
                }
                textelement(SalesAreaName)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesAreaName := 'Sales Area Name';
                    end;
                }
                textelement(SalespersonCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalespersonCode := 'Salesperson Code';
                    end;
                }
                textelement(ItemCategoryCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemCategoryCode := 'Item Category Code';
                    end;
                }
                textelement(ItemCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemCode := 'Item Code';
                    end;
                }
                textelement(Description)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Description := 'Description';
                    end;
                }
                textelement(Description2)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Description2 := 'Description 2';
                    end;
                }
                textelement(UnitofMeasureCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UnitofMeasureCode := 'Unit of Measure Code';
                    end;
                }
                textelement(Quantity)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Quantity := 'Quantity';
                    end;
                }
                textelement(NetWeight)
                {
                    trigger OnBeforePassVariable()
                    begin
                        NetWeight := 'Net Weight';
                    end;
                }
                textelement(UnitPrice)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UnitPrice := 'Unit Price';
                    end;
                }
                textelement(LineAmount)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LineAmount := 'Line Amount';
                    end;
                }
                textelement(GSTPer)
                {
                    trigger OnBeforePassVariable()
                    begin
                        GSTPer := 'GST %';
                    end;
                }
                textelement(HSNSAC)
                {
                    trigger OnBeforePassVariable()
                    begin
                        HSNSAC := 'HSN/SAC';
                    end;
                }
                textelement(GSTAmount)
                {
                    trigger OnBeforePassVariable()
                    begin
                        GSTAmount := 'GST Amount';
                    end;
                }
                textelement(TransporterName)
                {
                    trigger OnBeforePassVariable()
                    begin
                        TransporterName := 'Transporter Name';
                    end;
                }
                textelement(TransportMethod)
                {
                    trigger OnBeforePassVariable()
                    begin
                        TransportMethod := 'Transport Method';
                    end;
                }
                textelement(ShipmentMethod)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ShipmentMethod := 'Shipment Method';
                    end;
                }
                textelement(LR_RRNo)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LR_RRNo := 'LR_RR No_';
                    end;
                }
                textelement(LR_RRDate)
                {
                    trigger OnBeforePassVariable()
                    begin
                        LR_RRDate := 'LR_RR Date';
                    end;
                }
                textelement(ActualDeliveryDate)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ActualDeliveryDate := 'Actual Delivery Date';
                    end;
                }
                textelement(AmounttoCustomer)
                {
                    trigger OnBeforePassVariable()
                    begin
                        AmounttoCustomer := 'Amount to Customer';
                    end;
                }
                textelement(FirmFreight)
                {
                    trigger OnBeforePassVariable()
                    begin
                        FirmFreight := 'Firm Freight';
                    end;
                }
                textelement(CalculatedFreightField)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CalculatedFreightField := 'Calculated Freight Field';
                    end;
                }
                textelement(Remarks1)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Remarks1 := 'Remarks1';
                    end;
                }
            }
            tableelement("SalesInvoiceLine"; "Sales Invoice Line")
            {
                fieldelement(No; SalesInvoiceLine."Document No.") { }
                textelement(TypeofInvoiceData) { }
                textelement(PostingDateInv) { }
                textelement(DueDateInv) { }
                textelement(SelltoCustomerNo) { }
                textelement(SelltoCustomerName) { }
                textelement(BilltoCustomerNo) { }
                textelement(BilltoNameInv) { }
                textelement(SalesAreaNameInv) { }
                textelement(SalespersonCodeInv) { }
                textelement(Parent_Category) { }
                fieldelement(No_; SalesInvoiceLine."No.") { }
                fieldelement(Description; SalesInvoiceLine.Description) { }
                fieldelement(Description_2; SalesInvoiceLine."Description 2") { }
                fieldelement(Unit_of_Measure_Code; SalesInvoiceLine."Unit of Measure Code") { }
                fieldelement(Quantity; SalesInvoiceLine.Quantity) { }
                fieldelement(Net_Weight; SalesInvoiceLine."Net Weight") { }
                textelement(Unit_Price) { }
                textelement(Line_Amount) { }
                textelement(GST_Per) { }
                fieldelement(HSN_SAC_Code; SalesInvoiceLine."HSN/SAC Code") { }
                textelement(GST_Amount) { }
                textelement(ShippingAgentCode) { }
                textelement(Transport_Method) { }
                textelement(ShipmentMethodCode) { }
                textelement(LRRRNo) { }
                textelement(LRRRDate) { }
                textelement(ActualDeliveryDateInv) { }
                textelement(Amount_to_Customer) { }
                textelement(Firm_Freight) { }
                textelement(Calculated_Freight_Field) { }
                textelement(Remarks_1) { }

                trigger OnAfterGetRecord()
                begin
                    SalesAreaNameInv := '';
                    TypeofInvoiceData := '';
                    PostingDateInv := '';
                    DueDateInv := '';
                    SelltoCustomerNo := '';
                    SelltoCustomerName := '';
                    BilltoCustomerNo := '';
                    BilltoNameInv := '';
                    SalespersonCodeInv := '';
                    Parent_Category := '';
                    Unit_Price := '';
                    Line_Amount := '';
                    GST_Per := '';
                    GST_Amount := '';
                    ShippingAgentCode := '';
                    Transport_Method := '';
                    ShipmentMethodCode := '';
                    LRRRNo := '';
                    LRRRDate := '';
                    ActualDeliveryDateInv := '';
                    Amount_to_Customer := '';
                    Firm_Freight := '';
                    Calculated_Freight_Field := '';
                    Remarks_1 := '';
                    GstAmt := 0;
                    GLSetup.Get();
                    if DimensionSetEntry.Get(SalesInvoiceLine."Dimension Set ID", GLSetup."Shortcut Dimension 5 Code") then begin
                        DimensionSetEntry.CalcFields("Dimension Value Name");
                        SalesAreaNameInv := DimensionSetEntry."Dimension Value Name";
                    end;

                    DetailedGstLedgerEntry.Reset();
                    DetailedGstLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
                    DetailedGstLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
                    if DetailedGstLedgerEntry.FindSet() then begin
                        DetailedGstLedgerEntry.CalcSums("GST %", "GST Amount");
                        GST_Per := Format(DetailedGstLedgerEntry."GST %");
                        GstAmt := Abs(DetailedGstLedgerEntry."GST Amount");
                        GST_Amount := Format(GstAmt);
                    end;

                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", SalesInvoiceLine."Document No.");
                    if SalesInvoiceHeader.FindFirst() then begin
                        TypeofInvoiceData := Format(SalesInvoiceHeader."Type of Invoice");
                        PostingDateInv := Format(SalesInvoiceHeader."Posting Date");
                        DueDateInv := Format(SalesInvoiceHeader."Due Date");
                        SelltoCustomerNo := SalesInvoiceHeader."Sell-to Customer No.";
                        SelltoCustomerName := SalesInvoiceHeader."Sell-to Customer Name";
                        BilltoCustomerNo := SalesInvoiceHeader."Bill-to Customer No.";
                        BilltoNameInv := SalesInvoiceHeader."Bill-to Name";
                        SalespersonCodeInv := SalesInvoiceHeader."Salesperson Code";
                        if SalesInvoiceHeader."Currency Code" <> '' then begin
                            Unit_Price := Format(SalesInvoiceLine."Unit Price" / SalesInvoiceHeader."Currency Factor");
                            Line_Amount := Format(SalesInvoiceLine."Line Amount" / SalesInvoiceHeader."Currency Factor");
                            Amount_to_Customer := Format((SalesInvoiceLine."Line Amount" / SalesInvoiceHeader."Currency Factor") + GstAmt);
                            Calculated_Freight_Field := Format(SalesInvoiceHeader."Calculated Freight Amount" / SalesInvoiceHeader."Currency Factor");
                        end else begin
                            Unit_Price := Format(SalesInvoiceLine."Unit Price");
                            Line_Amount := Format(SalesInvoiceLine."Line Amount");
                            Amount_to_Customer := Format(SalesInvoiceLine."Line Amount" + GstAmt);
                            Calculated_Freight_Field := Format(SalesInvoiceHeader."Calculated Freight Amount");
                        end;
                        ShippingAgentCode := SalesInvoiceHeader."Shipping Agent Code";
                        Transport_Method := SalesInvoiceHeader."Transport Method";
                        ShipmentMethodCode := SalesInvoiceHeader."Shipment Method Code";
                        LRRRNo := SalesInvoiceHeader."LR/RR No.";
                        LRRRDate := Format(SalesInvoiceHeader."LR/RR Date");
                        ActualDeliveryDateInv := Format(SalesInvoiceHeader."Actual Delivery Date");
                        Firm_Freight := Format(SalesInvoiceHeader."Firm Freight");
                        Remarks_1 := SalesInvoiceHeader.Remarks1;
                    end;

                    ItemCategory.Reset();
                    ItemCategory.SetRange(Code, SalesInvoiceLine."Item Category Code");
                    if ItemCategory.FindFirst() then
                        Parent_Category := ItemCategory."Parent Category";
                end;

                trigger OnPreXmlItem()
                begin
                    SalesInvoiceLine.SetRange("Posting Date", StartDate, EndDate);
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(FILTERS)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = ALL;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = ALL;
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
    var
        StartDate: Date;
        EndDate: Date;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        GLSetup: Record "General Ledger Setup";
        DimensionSetEntry: Record "Dimension Set Entry";
        ItemCategory: Record "Item Category";
        DetailedGstLedgerEntry: Record "Detailed GST Ledger Entry";
        GstAmt: Decimal;
}//IG_AS 16-07-2025 