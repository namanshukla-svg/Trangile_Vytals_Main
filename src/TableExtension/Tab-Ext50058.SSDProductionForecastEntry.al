TableExtension 50058 "SSD Production Forecast Entry" extends "Production Forecast Entry"
{
    fields
    {
        field(50000; "Customer Code"; Code[30])
        {
            TableRelation = Customer;
            DataClassification = CustomerContent;
            Caption = 'Customer Code';

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Reset;
                if Customer.Get("Customer Code")then "Customer Name":=Customer.Name;
            end;
        }
        field(50001; "Customer Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Name';
        }
        field(50002; "Suggested Dealers PO Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Suggested Dealers PO Qty';
        }
        field(50003; "Actual Dealers PO Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Dealers PO Qty';
        }
        field(50004; "Sales MRP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales MRP';
        }
        field(50005; "Expected Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Receipt Date';
        }
        field(50006; ISCRMInserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ISCRMInserted';
        }
        field(50007; ISUpdated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ISUpdated';
        }
        field(50008; ISCRMException; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ISCRMException';
        }
        field(50009; ExceptionDetails; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ExceptionDetails';
        }
        field(50010; "Suggested Order Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suggested Order Date';
        }
    }
}
