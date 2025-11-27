XmlPort 50025 "ASP Purchase"
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
    textelement(SupplyTypeCap)
    {
    trigger OnBeforePassVariable()
    begin
        SupplyTypeCap:='Supply Type';
    end;
    }
    textelement(VendorCodeCap)
    {
    trigger OnBeforePassVariable()
    begin
        VendorCodeCap:='Vendor Code';
    end;
    }
    textelement(NatureofSupplierCap)
    {
    trigger OnBeforePassVariable()
    begin
        NatureofSupplierCap:='Nature of Supplier';
    end;
    }
    textelement(GSTINofSupplierCap)
    {
    trigger OnBeforePassVariable()
    begin
        GSTINofSupplierCap:='GST No of Supplier';
    end;
    }
    textelement(SupplierState)
    {
    trigger OnBeforePassVariable()
    begin
        SupplierState:='Suppliers State';
    end;
    }
    textelement(SupplierName)
    {
    trigger OnBeforePassVariable()
    begin
        SupplierName:='Name of the Supplier';
    end;
    }
    textelement(InvoiceNoCap)
    {
    trigger OnBeforePassVariable()
    begin
        InvoiceNoCap:='Invoice/Debit Note/ Credit Note / Bill of Entry/Payment Voucher (No.)';
    end;
    }
    textelement(InvoiceDateCap)
    {
    trigger OnBeforePassVariable()
    begin
        InvoiceDateCap:='Invoice/Debit Note/ Credit Note / Bill of Entry/Payment Voucher (Date)';
    end;
    }
    textelement(InvoiceValueCap)
    {
    trigger OnBeforePassVariable()
    begin
        InvoiceValueCap:='Invoice/Debit Note/ Credit Note / Bill of Entry/Payment Voucher (Value)';
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
        PosStateCap:='POS';
    end;
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
        CessRateCap:='Cess (Rate)';
    end;
    }
    textelement(CessAmountCap)
    {
    trigger OnBeforePassVariable()
    begin
        CessAmountCap:='Cess (Amount)';
    end;
    }
    textelement(EligibiityofITCCap)
    {
    trigger OnBeforePassVariable()
    begin
        EligibiityofITCCap:='Eligibility of ITC';
    end;
    }
    textelement(ITCIGSTAmtCap)
    {
    trigger OnBeforePassVariable()
    begin
        ITCIGSTAmtCap:='ITC IGST (Amt)';
    end;
    }
    textelement(ITCCGSTAmtCap)
    {
    trigger OnBeforePassVariable()
    begin
        ITCCGSTAmtCap:='ITC CGST (Amt)';
    end;
    }
    textelement(ITCSGSTAmtCap)
    {
    trigger OnBeforePassVariable()
    begin
        ITCSGSTAmtCap:='ITC SGST (Amt)';
    end;
    }
    textelement(ITCCessAmtCap)
    {
    trigger OnBeforePassVariable()
    begin
        ITCCessAmtCap:='ITC Cess (Amt)';
    end;
    }
    textelement(NatureofExpenseCap)
    {
    trigger OnBeforePassVariable()
    begin
        NatureofExpenseCap:='Nature of Expense';
    end;
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
        CreditNoteDocumentNoCap:='Credit Note/Debit Note/(Original Invoice No.)';
    end;
    }
    textelement(CreditNoteDateCap)
    {
    trigger OnBeforePassVariable()
    begin
        CreditNoteDateCap:='Credit Note/Debit Note/(Original Invoice Date)';
    end;
    }
    textelement(ReasonForIssueCap)
    {
    trigger OnBeforePassVariable()
    begin
        ReasonForIssueCap:='Reason for issuing Debit Note/Credit Note';
    end;
    }
    textelement(AssessableValueCap)
    {
    trigger OnBeforePassVariable()
    begin
        AssessableValueCap:='Assessable value before BCD';
    end;
    }
    textelement(BasicCustomDutyCap)
    {
    trigger OnBeforePassVariable()
    begin
        BasicCustomDutyCap:='Basic Custom Duty';
    end;
    }
    textelement(PortcodeCap)
    {
    trigger OnBeforePassVariable()
    begin
        PortcodeCap:='Port Code';
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
    fieldelement(SupplyType;
    "ASP Buffer"."Supply Type")
    {
    }
    fieldelement(VendorCode;
    "ASP Buffer"."Customer Code")
    {
    }
    fieldelement(NatureofSupplier;
    "ASP Buffer"."Nature of Receipient")
    {
    }
    fieldelement(GSTINofSupplier;
    "ASP Buffer"."GSTIN of Receipient")
    {
    }
    fieldelement(SupplierState;
    "ASP Buffer"."Receipient State")
    {
    }
    fieldelement(SupplierName;
    "ASP Buffer"."Name of the Receipient")
    {
    }
    fieldelement(InvoiceNo;
    "ASP Buffer"."External Document No")
    {
    }
    fieldelement(InvoiceDate;
    "ASP Buffer"."Invoice Date")
    {
    }
    textelement(InvoiceValue)
    {
    }
    fieldelement(RevCharge;
    "ASP Buffer"."Reverse Charge")
    {
    }
    fieldelement(POSState;
    "ASP Buffer"."POS State")
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
    fieldelement(EligibiityofITC;
    "ASP Buffer"."Eligibility of ITC")
    {
    }
    textelement(ITCIGSTAmt)
    {
    }
    textelement(ITCCGSTAmt)
    {
    }
    textelement(ITCSGSTAmt)
    {
    }
    textelement(ITCCessAmt)
    {
    }
    textelement(NatureofExpense)
    {
    }
    fieldelement(Shipfrom;
    "ASP Buffer"."Ship From")
    {
    }
    fieldelement(ShipTo;
    "ASP Buffer"."Ship To")
    {
    }
    fieldelement(WayBillNo;
    "ASP Buffer"."Way Bill No")
    {
    }
    fieldelement(TransporterName;
    "ASP Buffer"."Transporter Name")
    {
    }
    fieldelement(LorryRecptNo;
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
    textelement(AssessableValue)
    {
    }
    textelement(BasicCustomDuty)
    {
    }
    fieldelement(Portcode;
    "ASP Buffer"."Port Code")
    {
    }
    textelement(IsAdvanceAdjust)
    {
    }
    textelement(AdvanceAdjsutInvoice)
    {
    }
    textelement(AdvanceAdjsutInvoiceDate)
    {
    }
    trigger OnAfterGetRecord()
    begin
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
        BasicCustomDuty:=Format("ASP Buffer"."Basic Custom Duty", 0, 1);
        AssessableValue:=Format("ASP Buffer"."Assessable Value Before BCD", 0, 1);
        ITCIGSTAmt:=Format("ASP Buffer"."ITC IGST Amount", 0, 1);
        ITCCGSTAmt:=Format("ASP Buffer"."ITC CGST Amount", 0, 1);
        ITCSGSTAmt:=Format("ASP Buffer"."ITC SGST Amount", 0, 1);
        ITCCessAmt:=Format("ASP Buffer"."ITC Cess Amount", 0, 1);
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
    var Cnt: Integer;
    Gcode: Code[20];
    NoInt: Integer;
    local procedure SetPara(DocCode: Code[20])
    begin
        Gcode:=DocCode;
    end;
    procedure GetPara(): Code[20]begin
        exit(Gcode);
    end;
    procedure SetPara1(FileCount: Integer)
    begin
        NoInt:=FileCount;
    end;
}
