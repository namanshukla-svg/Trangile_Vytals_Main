TableExtension 50089 "SSD Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {
        field(50067; "Change After Archieve"; Boolean)
        {
            Description = 'CF003 TRUE -> change after Archieve FALSE -> initial and after Archive';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Change After Archieve';
        }
        field(52006; "Document Subtype"; Option)
        {
            Description = 'CF001';
            OptionCaption = ' ,Sales,Contract,Service Contract,Order,Schedule,Invoice,Despatch';
            OptionMembers = " ", Sales, Contract, "Service Contract", "Order", Schedule, Invoice, Despatch;
            DataClassification = CustomerContent;
            Caption = 'Document Subtype';
        }
        field(53011; "Order No."; Code[20])
        {
            Description = 'CF001';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Order No.';
        }
        field(53012; "Order Line No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Order Line No.';
        }
        field(54060; "Schedule Quantity"; Decimal)
        {
            CalcFormula = sum("SSD Sales Schedule Buffer"."Schedule Quantity" where("Document Type"=field("Document Type"), "Document No."=field("Document No."), "Sell-to Customer No."=field("Sell-to Customer No."), "Item No."=field("No."), "Order Line No."=field("Line No.")));
            Description = 'CF001';
            FieldClass = FlowField;
            Caption = 'Schedule Quantity';

            trigger OnLookup()
            var
                SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
                BlanketScheduleBufferForm: Page "Blanket Schedule Buffer";
            begin
            end;
        }
        field(54061; "No of Pack"; Decimal)
        {
            CalcFormula = sum("SSD Sales Schedule Buffer"."No. of Box" where("Document Type"=field("Document Type"), "Document No."=field("Document No."), "Sell-to Customer No."=field("Sell-to Customer No."), "Item No."=field("No."), "Order Line No."=field("Line No.")));
            Description = 'CF001';
            FieldClass = FlowField;
            Caption = 'No of Pack';

            trigger OnLookup()
            var
                SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
                SalesPacketDetailsForm: Page "Sales Packet Details";
            begin
            end;
        }
        field(54062; "Qty Per Pack"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Qty Per Pack';
        }
        field(54063; "Total Schedule Quantity"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Total Schedule Quantity';
        }
        field(54064; "Despatch Slip No."; Code[20])
        {
            Description = 'CF001';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Despatch Slip No.';
        }
        field(54065; "Despatch Slip Line No."; Integer)
        {
            Description = 'CF001';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Despatch Slip Line No.';
        }
        field(60049; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Date';

            trigger OnValidate()
            var
                LocalSalesLine: Record "Sales Line";
            begin
            end;
        }
        field(60050; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiry Date';

            trigger OnValidate()
            var
                LocalSalesLine: Record "Sales Line";
            begin
            end;
        }
        field(70008; "Ammortization Amount"; Decimal)
        {
            Description = 'Ashok Sachdeva for updating SIL 12/11/07';
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Ammortization Amount';
        }
        field(70009; "FOC Value"; Decimal)
        {
            Description = 'Ashok Sachdeva for updating SIL 12/11/07';
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'FOC Value';
        }
    }
}
