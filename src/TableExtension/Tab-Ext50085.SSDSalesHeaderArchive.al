TableExtension 50085 "SSD Sales Header Archive" extends "Sales Header Archive"
{
    fields
    {
        field(50001; "Ref. Doc. Subtype"; Option)
        {
            Description = 'CF001';
            OptionCaption = ' ,Sales Order,Sales Schedule';
            OptionMembers = " ", "Sales Order", "Sales Schedule";
            DataClassification = CustomerContent;
            Caption = 'Ref. Doc. Subtype';
        }
        field(50002; "Amendment Required"; Boolean)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Amendment Required';
        }
        field(52006; "Document Subtype"; Option)
        {
            Description = 'CF001';
            OptionCaption = ' ,Sales,Contract,Service Contract,Order,Schedule,Invoice,Despatch';
            OptionMembers = " ", Sales, Contract, "Service Contract", "Order", Schedule, Invoice, Despatch;
            DataClassification = CustomerContent;
            Caption = 'Document Subtype';
        }
        field(53065; "Order/Scd. No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Order/Scd. No.';
        }
        field(53068; "Get Despatch Used"; Boolean)
        {
            Caption = 'Get Despatch Used';
            Description = 'CF001';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85035; "Type of Invoice";Enum "Type Of Invoice Sales")
        {
            Caption = 'Type of Invoice';
        }
    }
}
