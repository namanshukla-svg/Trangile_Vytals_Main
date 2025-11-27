XmlPort 50024 "ASP Sales"
{
    Direction = Export;
    FieldDelimiter = '<None>';
    FieldSeparator = '|';
    Format = VariableText;
    TableSeparator = '<NewLine>';

    schema
    {
    textelement(Root)
    {
    tableelement(Integer;
    Integer)
    {
    XmlName = 'Integer';
    SourceTableView = sorting(Number)order(ascending)where(Number=filter(1));

    textelement(CompanyCodeCap)
    {
    trigger OnBeforePassVariable()
    begin
        CompanyCodeCap:='Company Code';
    end;
    }
    textelement(CompanyNameCap)
    {
    trigger OnBeforePassVariable()
    begin
        CompanyNameCap:='Company Name';
    end;
    }
    textelement(StateCap)
    {
    trigger OnBeforePassVariable()
    begin
        StateCap:='State';
    end;
    }
    textelement(GSTINCap)
    {
    trigger OnBeforePassVariable()
    begin
        GSTINCap:='GSTIN';
    end;
    }
    textelement(YearCap)
    {
    trigger OnBeforePassVariable()
    begin
        YearCap:='Year';
    end;
    }
    textelement(MonthCap)
    {
    trigger OnBeforePassVariable()
    begin
        MonthCap:='Month';
    end;
    }
    textelement(AccountingDocumentNoCap)
    {
    trigger OnBeforePassVariable()
    begin
        AccountingDocumentNoCap:='Accounting Document No.';
    end;
    }
    textelement(AccountingDocumentDateCap)
    {
    trigger OnBeforePassVariable()
    begin
        AccountingDocumentDateCap:='Account Document Date';
    end;
    }
    textelement(TransactionCountCap)
    {
    trigger OnBeforePassVariable()
    begin
        TransactionCountCap:='Transaction Count';
    end;
    }
    textelement(CurrencyCap)
    {
    trigger OnBeforePassVariable()
    begin
        CurrencyCap:='Currency';
    end;
    }
    textelement(GLAccntCap)
    {
    trigger OnBeforePassVariable()
    begin
        GLAccntCap:='GL Account';
    end;
    }
    textelement(DocumentTypeCap)
    {
    trigger OnBeforePassVariable()
    begin
        DocumentTypeCap:='Document Type';
    end;
    }
    textelement(TaxabilityCap)
    {
    trigger OnBeforePassVariable()
    begin
        TaxabilityCap:='Taxability';
    end;
    }
    textelement(NatureofExmpCap)
    {
    trigger OnBeforePassVariable()
    begin
        NatureofExmpCap:='Nature of Exemption(if applicable)';
    end;
    }
    textelement(SupplyTypeCap)
    {
    trigger OnBeforePassVariable()
    begin
        SupplyTypeCap:='Supply Type';
    end;
    }
    textelement(CustomerCodeCap)
    {
    trigger OnBeforePassVariable()
    begin
        CustomerCodeCap:='Customer Code';
    end;
    }
    textelement(NatureofReceipientCap)
    {
    trigger OnBeforePassVariable()
    begin
        NatureofReceipientCap:='Nature of Receipient';
    end;
    }
    textelement(GSTINofReceipientCap)
    {
    trigger OnBeforePassVariable()
    begin
        GSTINofReceipientCap:='GSTIN/UIN of Recipient';
    end;
    }
    textelement(ReceipientStateCap)
    {
    trigger OnBeforePassVariable()
    begin
        ReceipientStateCap:='Recipient State';
    end;
    }
    textelement(ReceipientNameCap)
    {
    trigger OnBeforePassVariable()
    begin
        ReceipientNameCap:='Name of Recipient';
    end;
    }
    textelement(InvoiceNoCap)
    {
    trigger OnBeforePassVariable()
    begin
        InvoiceNoCap:='Invoice/Debit Note/Credit Note/Receipt Voucher/Refund Voucher (No.)';
    end;
    }
    textelement(InvoiceDateCap)
    {
    trigger OnBeforePassVariable()
    begin
        InvoiceDateCap:='Invoice/Debit Note/ Credit Note / Receipt Voucher/ Refund Voucher(Date)';
    end;
    }
    textelement(InvoiceValueCap)
    {
    trigger OnBeforePassVariable()
    begin
        InvoiceValueCap:='Invoice/Debit Note/Credit Note/Receipt Voucher/Refund Voucher (Value)';
    end;
    }
    textelement(RevChargeCap)
    {
    trigger OnBeforePassVariable()
    begin
        RevChargeCap:='Supply attract reverse charge';
    end;
    }
    textelement(PosStateCap)
    {
    trigger OnBeforePassVariable()
    begin
        PosStateCap:='POS (State)';
    end;
    }
    textelement(GSTINEcomp)
    {
    trigger OnBeforePassVariable()
    begin
        GSTINEcomp:='GSTIN of e-commerce portal' end;
    }
    textelement(LineItemCap)
    {
    trigger OnBeforePassVariable()
    begin
        LineItemCap:='Line Item';
    end;
    }
    textelement(ItemCodeCap)
    {
    trigger OnBeforePassVariable()
    begin
        ItemCodeCap:='Item Code';
    end;
    }
    textelement(CategoryCap)
    {
    trigger OnBeforePassVariable()
    begin
        CategoryCap:='Category';
    end;
    }
    textelement(HSNSACCodeCap)
    {
    trigger OnBeforePassVariable()
    begin
        HSNSACCodeCap:='HSN/SAC Code';
    end;
    }
    textelement(ProductDesCap)
    {
    trigger OnBeforePassVariable()
    begin
        ProductDesCap:='Product/Service Description';
    end;
    }
    textelement(UQCCap)
    {
    trigger OnBeforePassVariable()
    begin
        UQCCap:='UQC';
    end;
    }
    textelement(QuantityCap)
    {
    trigger OnBeforePassVariable()
    begin
        QuantityCap:='Quantity';
    end;
    }
    textelement(SalesPriceBfDisc)
    {
    trigger OnBeforePassVariable()
    begin
        SalesPriceBfDisc:='Sales Price (Before Discount)';
    end;
    }
    textelement(DiscountCap)
    {
    trigger OnBeforePassVariable()
    begin
        DiscountCap:='Discount';
    end;
    }
    textelement(NetSalesPriceCap)
    {
    trigger OnBeforePassVariable()
    begin
        NetSalesPriceCap:='Net sale price (after discount)';
    end;
    }
    textelement(VATCap)
    {
    trigger OnBeforePassVariable()
    begin
        VATCap:='VAT';
    end;
    }
    textelement(CentralExciseCap)
    {
    trigger OnBeforePassVariable()
    begin
        CentralExciseCap:='Central Excise';
    end;
    }
    textelement(StateExciseCap)
    {
    trigger OnBeforePassVariable()
    begin
        StateExciseCap:='State Excise';
    end;
    }
    textelement(TaxableValueCap)
    {
    trigger OnBeforePassVariable()
    begin
        TaxableValueCap:='Taxable Value';
    end;
    }
    textelement(TotalGSTRateCap)
    {
    trigger OnBeforePassVariable()
    begin
        TotalGSTRateCap:='Total GST Rate';
    end;
    }
    textelement(IGSTRateCap)
    {
    trigger OnBeforePassVariable()
    begin
        IGSTRateCap:='IGST Rate';
    end;
    }
    textelement(IGSTAmountCap)
    {
    trigger OnBeforePassVariable()
    begin
        IGSTAmountCap:='IGST Amount';
    end;
    }
    textelement(CGSTRateCap)
    {
    trigger OnBeforePassVariable()
    begin
        CGSTRateCap:='CGST Rate';
    end;
    }
    textelement(CGSTAmountCap)
    {
    trigger OnBeforePassVariable()
    begin
        CGSTAmountCap:='CGST Amount';
    end;
    }
    textelement(SGSTRateCap)
    {
    trigger OnBeforePassVariable()
    begin
        SGSTRateCap:='SGST/UT Rate';
    end;
    }
    textelement(SGSTAmountCap)
    {
    trigger OnBeforePassVariable()
    begin
        SGSTAmountCap:='SGST/UT Amount';
    end;
    }
    textelement(CessRateCap)
    {
    trigger OnBeforePassVariable()
    begin
        CessRateCap:='Cess (Rate)' end;
    }
    textelement(CessAmountCap)
    {
    trigger OnBeforePassVariable()
    begin
        CessAmountCap:='Cess (Amount)' end;
    }
    textelement(ShipFromStateCap)
    {
    trigger OnBeforePassVariable()
    begin
        ShipFromStateCap:='Ship From (State)';
    end;
    }
    textelement(ShipToStateCap)
    {
    trigger OnBeforePassVariable()
    begin
        ShipToStateCap:='Ship To (State)';
    end;
    }
    textelement(WayBillNoCap)
    {
    trigger OnBeforePassVariable()
    begin
        WayBillNoCap:='Way bill No';
    end;
    }
    textelement(TransporterNameCap)
    {
    trigger OnBeforePassVariable()
    begin
        TransporterNameCap:='Transporter Name';
    end;
    }
    textelement(LorryReceiptNumCap)
    {
    trigger OnBeforePassVariable()
    begin
        LorryReceiptNumCap:='Lorry Receipt number';
    end;
    }
    textelement(LorryReceiptDateCap)
    {
    trigger OnBeforePassVariable()
    begin
        LorryReceiptDateCap:='Lorry Receipt date';
    end;
    }
    textelement(CreditNoteDocumentNoCap)
    {
    trigger OnBeforePassVariable()
    begin
        CreditNoteDocumentNoCap:='Credit Note/Debit Note/Refund Voucher (Original Document No.)';
    end;
    }
    textelement(CreditNoteDateCap)
    {
    trigger OnBeforePassVariable()
    begin
        CreditNoteDateCap:='Credit Note/Debit Note/Refund Voucher (Original Document Date)';
    end;
    }
    textelement(ReasonForIssueCap)
    {
    trigger OnBeforePassVariable()
    begin
        ReasonForIssueCap:='Reason for issuing Debit Note/Credit Note/Refund Voucher' end;
    }
    textelement(ShiippingBillNoCap)
    {
    trigger OnBeforePassVariable()
    begin
        ShiippingBillNoCap:='Shipping Bill/Bill of Export (No.)';
    end;
    }
    textelement(ShippingBillDateCap)
    {
    trigger OnBeforePassVariable()
    begin
        ShippingBillDateCap:='Shipping Bill/Bill of Export (Date)';
    end;
    }
    textelement(PortCodeCap)
    {
    trigger OnBeforePassVariable()
    begin
        PortCodeCap:='Port Code';
    end;
    }
    textelement(ExportDutyCap)
    {
    trigger OnBeforePassVariable()
    begin
        ExportDutyCap:='Export Duty (If any)';
    end;
    }
    textelement(ISAdvanceCap)
    {
    trigger OnBeforePassVariable()
    begin
        ISAdvanceCap:='Is advance adjustment';
    end;
    }
    textelement(AdvAdjustInvoiceCap)
    {
    trigger OnBeforePassVariable()
    begin
        AdvAdjustInvoiceCap:='Advance Adjustment (Invoice No.)';
    end;
    }
    textelement(AdvAdjustmentDate)
    {
    trigger OnBeforePassVariable()
    begin
        AdvAdjustmentDate:='Advance Adjustment (Invoice Date)';
    end;
    }
    }
    tableelement("ASP Buffer";
    "SSD ASP Buffer")
    {
    RequestFilterFields = "Document No.";
    XmlName = 'ASPBuffer';

    fieldelement(CompanyCode;
    "ASP Buffer"."Company Code")
    {
    }
    fieldelement(CompanyName;
    "ASP Buffer"."Company Name")
    {
    }
    fieldelement(State;
    "ASP Buffer".State)
    {
    }
    fieldelement(GSTIN;
    "ASP Buffer".GSTIN)
    {
    }
    fieldelement(Year;
    "ASP Buffer".Year)
    {
    }
    fieldelement(Month;
    "ASP Buffer".Month)
    {
    }
    fieldelement(AccountingDocumentNo;
    "ASP Buffer"."Accounting Document No.")
    {
    }
    fieldelement(AccountingDocumentDate;
    "ASP Buffer"."Accounting Document Date")
    {
    }
    fieldelement(TransactionCount;
    "ASP Buffer"."Transaction Count")
    {
    }
    fieldelement(Currency;
    "ASP Buffer".Currency)
    {
    }
    textelement(GLAccount)
    {
    }
    fieldelement(DocumentType;
    "ASP Buffer"."Document Type")
    {
    }
    fieldelement(Taxability;
    "ASP Buffer".Taxability)
    {
    }
    textelement(NatureofExemp)
    {
    }
    fieldelement(SupplyType;
    "ASP Buffer"."Supply Type")
    {
    }
    fieldelement(CustomerCode;
    "ASP Buffer"."Customer Code")
    {
    }
    fieldelement(NatureofReceipient;
    "ASP Buffer"."Nature of Receipient")
    {
    }
    fieldelement(GSTINofReceipient;
    "ASP Buffer"."GSTIN of Receipient")
    {
    }
    fieldelement(ReceipientState;
    "ASP Buffer"."Receipient State")
    {
    }
    fieldelement(ReceipientName;
    "ASP Buffer"."Name of the Receipient")
    {
    }
    fieldelement(InvoiceNo;
    "ASP Buffer"."Document No.")
    {
    }
    fieldelement(InvoiceDate;
    "ASP Buffer"."Invoice Date")
    {
    }
    textelement(InvoiceValue)
    {
    trigger OnBeforePassVariable()
    begin
        InvoiceValue:=Format("ASP Buffer"."Invoice Value", 0, 1);
    end;
    }
    fieldelement(RevCharge;
    "ASP Buffer"."Reverse Charge")
    {
    }
    fieldelement(POSState;
    "ASP Buffer"."POS State")
    {
    }
    fieldelement(GSTINEcom;
    "ASP Buffer"."GSTIN of e-commerce")
    {
    }
    fieldelement(LineItem;
    "ASP Buffer"."Line Item")
    {
    }
    fieldelement(ItemCode;
    "ASP Buffer"."Item Code")
    {
    }
    fieldelement(Category;
    "ASP Buffer".Category)
    {
    }
    fieldelement(HSNSACCode;
    "ASP Buffer"."Actual HSN Code")
    {
    }
    fieldelement(ProductDes;
    "ASP Buffer"."Product Description")
    {
    }
    fieldelement(UQC;
    "ASP Buffer".UQC)
    {
    }
    textelement(Quantity)
    {
    }
    textelement(SalePriceBeforeDisc)
    {
    }
    textelement(Discount)
    {
    }
    textelement(NetSales)
    {
    }
    textelement(VAT)
    {
    }
    textelement(CentralExcise)
    {
    }
    textelement(StateExcise)
    {
    }
    textelement(TaxableValue)
    {
    }
    textelement(TotalGSTRate)
    {
    }
    textelement(IGSTRate)
    {
    }
    textelement(IGSTAmount)
    {
    }
    textelement(CGSTRate)
    {
    }
    textelement(CGSTAmount)
    {
    }
    textelement(SGSTRate)
    {
    }
    textelement(SGSTAmount)
    {
    }
    textelement(CessRate)
    {
    }
    textelement(CessAmount)
    {
    }
    fieldelement(ShipFrom;
    "ASP Buffer"."Ship From")
    {
    }
    fieldelement(ShipTo;
    "ASP Buffer"."Ship To")
    {
    }
    fieldelement(WayBill;
    "ASP Buffer"."Way Bill No")
    {
    }
    fieldelement(TransporterName;
    "ASP Buffer"."Transporter Name")
    {
    }
    fieldelement(LorryReceiptNo;
    "ASP Buffer"."Lorry Receipt Number")
    {
    }
    fieldelement(LorryReceiptDate;
    "ASP Buffer"."Lorry Receipt Date")
    {
    }
    fieldelement(CreditNoteDocumentNo;
    "ASP Buffer"."Credit Note Document No.")
    {
    }
    fieldelement(CreditNoteDate;
    "ASP Buffer"."Credit Note Date")
    {
    }
    fieldelement(ReasonforIssue;
    "ASP Buffer"."Reason for Issuing")
    {
    }
    textelement(ShippingBillNo)
    {
    }
    textelement(ShippingBillDate)
    {
    }
    fieldelement(PortCode;
    "ASP Buffer"."Port Code")
    {
    }
    textelement(ExportDuty)
    {
    }
    textelement(IsAdvanceAdjustment)
    {
    }
    textelement(AdvanceAdjustmentInvoiceNo)
    {
    }
    fieldelement(AdvanceAdjustmentDate;
    "ASP Buffer"."Advance Adjustment Date")
    {
    }
    trigger OnAfterGetRecord()
    begin
        ExportDuty:=Format(ExportDuty, 0, 1);
        CessAmount:=Format("ASP Buffer"."Cess Amount", 0, 1);
        CessRate:=Format("ASP Buffer"."Cess Rate", 0, 1);
        SGSTAmount:=Format("ASP Buffer"."SGST Amount", 0, 1);
        SGSTRate:=Format("ASP Buffer"."SGST Rate", 0, 1);
        CGSTAmount:=Format("ASP Buffer"."CGST Amount", 0, 1);
        CGSTRate:=Format("ASP Buffer"."CGST Rate", 0, 1);
        IGSTAmount:=Format("ASP Buffer"."IGST Amount", 0, 1);
        IGSTRate:=Format("ASP Buffer"."IGST Rate", 0, 1);
        TotalGSTRate:=Format("ASP Buffer"."Total GST Rate", 0, 1);
        TaxableValue:=Format("ASP Buffer"."Taxable Value", 0, 1);
        StateExcise:=Format(StateExcise, 0, 1);
        CentralExcise:=Format(CentralExcise, 0, 1);
        VAT:=Format(VAT, 0, 1);
        NetSales:=Format(NetSales, 0, 1);
        Discount:=Format(Discount, 0, 1);
        SalePriceBeforeDisc:=Format(SalePriceBeforeDisc, 0, 1);
        Quantity:=Format(Quantity, 0, 1);
        InvoiceValue:=Format("ASP Buffer"."Invoice Value", 0, 1);
    end;
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
}
