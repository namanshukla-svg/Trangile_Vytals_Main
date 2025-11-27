table 50218 "SSD Daywise Inv. & Return"
{
    Caption = 'SSD Daywise Inv. & Return';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryType; Text[10])
        {
            Caption = 'No';
            DataClassification = CustomerContent;
        }
        field(2; No; Code[20])
        {
            Caption = 'No';
            DataClassification = CustomerContent;
        }
        field(3; LineNo; Integer)
        {
            Caption = 'LineNo';
            DataClassification = CustomerContent;
        }
        field(4; Posting_Date; Date)
        {
            Caption = 'Posting_Date';
            DataClassification = CustomerContent;
        }
        field(5; BilltoCustomerNo; Code[20])
        {
            Caption = 'BilltoCustomerNo';
            DataClassification = CustomerContent;
        }
        field(6; BilltoName; Text[150])
        {
            Caption = 'BilltoName';
            DataClassification = CustomerContent;
        }
        field(7; SalespersonCode; Code[20])
        {
            Caption = 'SalespersonCode';
            DataClassification = CustomerContent;
        }
        field(8; ItemCategoryCode; Code[20])
        {
            Caption = 'ItemCategoryCode';
            DataClassification = CustomerContent;
        }
        field(9; ItemNo; Code[20])
        {
            Caption = 'ItemNo';
            DataClassification = CustomerContent;
        }
        field(10; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(11; Description2; Text[250])
        {
            Caption = 'Description2';
            DataClassification = CustomerContent;
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(13; UnitPrice; Decimal)
        {
            Caption = 'UnitPrice';
            DataClassification = CustomerContent;
        }
        field(14; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(15; Category; Code[20])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
        }
        field(16; LinkedInvoice; Code[20])
        {
            Caption = 'LinkedInvoice';
            DataClassification = CustomerContent;
        }
        field(17; LinkedInvoiceDate; Date)
        {
            Caption = 'LinkedInvoiceDate';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; No, LineNo)
        {
            Clustered = true;
        }
    }
}
