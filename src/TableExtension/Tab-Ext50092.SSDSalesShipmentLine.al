TableExtension 50092 "SSD Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {
        field(50003; "Enquiry No."; Code[20])
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Enquiry No.';
        }
        field(50004; "Enquiry Line No."; Integer)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Enquiry Line No.';
        }
        field(50023; "MRP No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'MRP No.';
        }
        field(50030; "Revised Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Shipment Date';
        }
        field(50084; "Old Document No."; Code[20])
        {
            Description = 'CF001.05 -> Sales Invoice Doc No from where suple. Invoice is copied';
            Editable = false;
            TableRelation = if("Document Subtype"=const("Suplementary Invoice"))"Sales Invoice Line"."Document No.";
            DataClassification = CustomerContent;
            Caption = 'Old Document No.';
        }
        field(50085; "Old Document Line No."; Integer)
        {
            Description = 'CF001.05 -> Sales Invoice Line No from where suple. Invoice is copied';
            Editable = false;
            TableRelation = if("Document Subtype"=const("Suplementary Invoice"))"Sales Invoice Line"."Line No." where("Document No."=field("Old Document No."));
            DataClassification = CustomerContent;
            Caption = 'Old Document Line No.';
        }
        field(50087; "Sales Line No."; Code[30])
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'Sales Line No.';
        }
        field(52000; "Amendment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Amendment No.';
        }
        field(52001; "Amendment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Amendment Date';
        }
        field(52006; "Document Subtype"; Option)
        {
            Description = 'CF001';
            OptionCaption = ' ,Sales,Contract,Service Contract,Order,Schedule,Invoice,Despatch,Suplementary Invoice';
            OptionMembers = " ", Sales, Contract, "Service Contract", "Order", Schedule, Invoice, Despatch, "Suplementary Invoice";
            DataClassification = CustomerContent;
            Caption = 'Document Subtype';
        }
        field(53001; "Maintain RG I Register"; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'Maintain RG I Register';
        }
        field(53009; "Customer Order Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Order Date';
        }
        field(53010; "Customer Order"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Order';
        }
        field(53060; "Shop Code"; Code[2])
        {
            DataClassification = CustomerContent;
            Caption = 'Shop Code';
        }
        field(53061; "Customer Location"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Location';
        }
        field(53062; "Customer Gate No."; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Gate No.';
        }
        field(53063; Container; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Container';
        }
        field(53064; "Stuffing Quantity"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Stuffing Quantity';
        }
        field(53066; "MRIR No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'MRIR No.';
        }
        field(53080; "Schedule No."; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Schedule No.';
        }
        field(53081; "Position No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Position No.';
        }
        field(53082; "Planned Delivery DT"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Planned Delivery DT';
        }
        field(53083; "Reason Code"; Code[10])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Reason Code';
        }
        field(54061; "No of Pack"; Decimal)
        {
            CalcFormula = sum("SSD Sales Schedule Buffer"."No. of Box" where("Document Type"=filter(Order|Invoice), "Document No."=field("Document No."), "Sell-to Customer No."=field("Sell-to Customer No."), "Item No."=field("No."), "Order Line No."=field("Line No.")));
            Description = 'CF002 For No of Packet';
            FieldClass = FlowField;
            Caption = 'No of Pack';
        }
        field(54062; "Qty Per Pack"; Decimal)
        {
            Description = 'CF001-Item Qty per packet';
            DataClassification = CustomerContent;
            Caption = 'Qty Per Pack';
        }
        field(54063; "Total Schedule Quantity"; Decimal)
        {
            Description = 'CF001 Total Schedule Quantity during Despatch';
            DataClassification = CustomerContent;
            Caption = 'Total Schedule Quantity';
        }
        field(54064; "Despatch Slip No."; Code[20])
        {
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Despatch Slip No.';
        }
        field(54065; "Despatch Slip Line No."; Integer)
        {
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Despatch Slip Line No.';
        }
        field(54066; "Quatation No."; Code[20])
        {
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Quatation No.';
        }
        field(54067; "Quotation Line No."; Integer)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Quotation Line No.';
        }
        field(54068; "Quotation Date"; Date)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Quotation Date';
        }
        field(54069; "Pre-Assigned No."; Code[20])
        {
            Caption = 'Pre-Assigned No.';
            Description = 'Coming From Sales Header';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60044; "Supplementary Rate"; Decimal)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Supplementary Rate';
        }
        field(60045; "Supplementary Item"; Code[20])
        {
            Description = 'Supplementary';
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Supplementary Item';
        }
        field(60046; "Supplementary Start Date"; Date)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Supplementary Start Date';
        }
        field(60047; "Supplementary End Date"; Date)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Supplementary End Date';
        }
        field(60048; "Last Updated Cost"; Decimal)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Last Updated Cost';
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
        field(85020; "CT2 Form"; Code[20])
        {
            Description = 'ALLE 3.15';
            DataClassification = CustomerContent;
            Caption = 'CT2 Form';
        }
        field(85021; "CT2 Form Line No."; Integer)
        {
            Description = 'ALLE 3.15';
            DataClassification = CustomerContent;
            Caption = 'CT2 Form Line No.';
        }
        field(85022; "CT3 Form"; Code[20])
        {
            Description = 'ALLE 3.16';
            DataClassification = CustomerContent;
            Caption = 'CT3 Form';
        }
        field(85023; "CT3 Form Line No."; Integer)
        {
            Description = 'ALLE 3.16';
            DataClassification = CustomerContent;
            Caption = 'CT3 Form Line No.';
        }
        field(85027; "Credit Note Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Unit Price';
        }
        field(85045; "MOQ Quantity"; Decimal)
        {
            Description = 'Alle-[Amazon-HG]';
            DataClassification = CustomerContent;
            Caption = 'MOQ Quantity';
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Despatch Slip No.", "Despatch Slip Line No.")
        {
        }
    }
}
