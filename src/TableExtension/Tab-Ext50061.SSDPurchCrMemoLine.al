TableExtension 50061 "SSD Purch. Cr. Memo Line" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50007; "Hold Payment"; Boolean)
        {
            Description = 'HP1.0';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Hold Payment';
        }
        field(50050; "MRP Qty."; Decimal)
        {
            Description = 'Alle 290916';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'MRP Qty.';
        }
        field(50350; "SSD Receipt Remarks"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Remarks';
        }
        field(50351; "SSD Deduction Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Deduction Amount with GST';
            DecimalPlaces = 2: 2;
        }
        field(50352; "SSD Deduction Remarks"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Deduction Remarks';
        }
        field(54025; "Customer No."; Code[20])
        {
            Description = 'ALLE-TRA1.0';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
        }
        field(54026; "SalesPerson Code"; Code[10])
        {
            Description = 'ALLE-TRA1.0';
            TableRelation = "Salesperson/Purchaser".Code;
            DataClassification = CustomerContent;
            Caption = 'SalesPerson Code';
        }
        //SSD Sunil
        field(75021; "Last Landed Cost"; Decimal)
        {
            Description = 'Last Landed Cost';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Last Landed Cost';
        }
        field(75022; "Last PO Price"; Decimal)
        {
            Description = 'Last PO Price';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Last PO Price';
        }
        //SSD Sunil
        field(75023; "Vendor Item Description"; Text[100])
        {
            Description = 'Vendor Item Description';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Vendor Item Description';
        }
    }
}
