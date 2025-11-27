TableExtension 50015 "SSD Entry Summary" extends "Entry Summary"
{
    fields
    {
        field(50056; "Rejected Qty."; Decimal)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Rejected Qty.';
        }
        field(50057; Sample; Boolean)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Sample';
        }
        field(50058; "Sample Quantity"; Decimal)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Sample Quantity';
        }
        field(50059; "Sampled By"; Code[20])
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Sampled By';
        }
        field(50060; "Sampling Date"; Date)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Sampling Date';
        }
        field(50061; "MRN No."; Code[20])
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'MRN No.';
        }
        field(50062; "MRN Line No."; Integer)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'MRN Line No.';
        }
        field(50063; "No. of Container"; Integer)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'No. of Container';
        }
        field(50064; "Pack Quantity"; Decimal)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Pack Quantity';
        }
        field(50065; "Manufacturing date"; Date)
        {
            Description = 'PQA-003';
            DataClassification = CustomerContent;
            Caption = 'Manufacturing date';
        }
        field(50066; "Unused Field 1"; Code[1])
        {
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
            Caption = 'Unused Field 1';
        }
        field(50067; "Unused Field 2"; Code[1])
        {
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
            Caption = 'Unused Field 2';
        }
        field(50068; "Unused Field 3"; Code[1])
        {
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
            Caption = 'Unused Field 3';
        }
        field(50069; "Unused Field 4"; Code[1])
        {
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
            Caption = 'Unused Field 4';
        }
        field(50070; "Unused Field 5"; Code[1])
        {
            Description = 'PQA-003 UNUSED FIELDS : ADDED FOR FUTURE REQUIRMENT : REASON - ADDING FIELD FOR THIS FUNCTIONALITY TAKES TIME';
            DataClassification = CustomerContent;
            Caption = 'Unused Field 5';
        }
        field(50071; "Appl.-to Item Entry"; Integer)
        {
            Description = 'TAX-087';
            DataClassification = CustomerContent;
            Caption = 'Appl.-to Item Entry';
        }
        //IG_DS>>
        field(50072; "From Package"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50073; "To Package"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //IG_DS<<
    }
    keys
    {
        key(Key2; "Appl.-to Item Entry")
        {
        }
    }
}
