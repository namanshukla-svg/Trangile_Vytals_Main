Table 50033 "SSD Invoice Frieght Amount"
{
    Permissions = TableData "Sales Invoice Header"=rim;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if SalesInvoiceHeader.Get("Invoice No.")then begin
                    "Frieght Amount":=SalesInvoiceHeader."Freight Amount";
                    "Calculated Freight Amount":=SalesInvoiceHeader."Calculated Freight Amount";
                end end;
        }
        field(2; "Frieght Amount"; Decimal)
        {
            Caption = 'Frieght Amount';
            DataClassification = CustomerContent;
        }
        field(3; "Calculated Freight Amount"; Decimal)
        {
            Editable = false;
            Caption = 'Calculated Freight Amount';
            DataClassification = CustomerContent;
        }
        field(4; "Freight Amount Volume Mark"; Boolean)
        {
            Caption = 'Freight Amount Volume Mark';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if SalesInvoiceHeader.Get("Invoice No.")then begin
                    SalesInvoiceHeader."Freight Amount Volume Mark":="Freight Amount Volume Mark";
                    SalesInvoiceHeader.Modify;
                end;
            end;
        }
        field(5; "Validate"; Boolean)
        {
            Caption = 'Validate';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Invoice No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var SalesInvoiceHeader: Record "Sales Invoice Header";
}
