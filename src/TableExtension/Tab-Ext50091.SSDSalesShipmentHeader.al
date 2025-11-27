TableExtension 50091 "SSD Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        field(50001; "Ref. Doc. Subtype"; Option)
        {
            Description = 'CF002';
            OptionCaption = ' ,Sales Order,Sales Schedule';
            OptionMembers = " ", "Sales Order", "Sales Schedule";
            DataClassification = CustomerContent;
            Caption = 'Ref. Doc. Subtype';
        }
        field(50002; "Amendment Required"; Boolean)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Amendment Required';
        }
        field(50003; "Enquiry No."; Code[20])
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Enquiry No.';
        }
        field(50077; "Vessel/Flight No."; Code[20])
        {
            Description = 'CE001(Change Lenght 10 to 20)';
            DataClassification = CustomerContent;
            Caption = 'Vessel/Flight No.';
        }
        field(50078; "Expected Delivery Date"; Date)
        {
            Description = 'Alle-MS';
            DataClassification = CustomerContent;
            Caption = 'Expected Delivery Date';
        }
        field(50079; "Actual Delivery Date"; Date)
        {
            Description = 'Alle-MS';
            DataClassification = CustomerContent;
            Caption = 'Actual Delivery Date';
        }
        field(50093; "Total Packed Wt."; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Total Packed Wt.';
        }
        field(50100; Subcontracting; Boolean)
        {
            Description = 'CML-034';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting';
        }
        field(52000; "Amendment No."; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Amendment No.';
        }
        field(52001; "Amendment Date"; Date)
        {
            Description = 'CF001';
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
        field(53001; "Insurance By"; Option)
        {
            Description = 'CF001';
            OptionMembers = " ", You, Us;
            DataClassification = CustomerContent;
            Caption = 'Insurance By';
        }
        field(53002; "Date Of Issue"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Date Of Issue';
        }
        field(53003; "Time Of Issue"; Time)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Time Of Issue';
        }
        field(53004; "Date Of Removal"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Date Of Removal';
        }
        field(53005; "Time Of Removals"; Time)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Time Of Removals';
        }
        field(53006; "Vehicle No"; Code[25])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Vehicle No';
        }
        field(53007; Freight; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Freight';
        }
        field(53008; "No. Of Packages"; Decimal)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'No. Of Packages';
        }
        field(53009; "External Doc. Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'External Doc. Date';
        }
        field(53060; "Shop Code"; Code[2])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Shop Code';
        }
        field(53061; "Customer Location"; Code[20])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Customer Location';
        }
        field(53062; "Customer Gate No."; Code[5])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Customer Gate No.';
        }
        field(53063; Container; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Container';
        }
        field(53064; "Stuffing Quantity"; Integer)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Stuffing Quantity';
        }
        field(53065; "Order/Scd. No."; Code[20])
        {
            Description = 'CF002 Ref. Doc No.';
            DataClassification = CustomerContent;
            Caption = 'Order/Scd. No.';
        }
        field(53066; "MRIR No."; Code[10])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'MRIR No.';
        }
        field(53068; "Get Despatch Used"; Boolean)
        {
            Caption = 'Get Despatch Used';
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(53085; "GR No."; Code[10])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'GR No.';
        }
        field(53086; "GR Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'GR Date';
        }
        field(53088; Insurance; Option)
        {
            Description = 'CF001';
            OptionCaption = ',Insurance Prepaid, Insurance Buyer''s Account, Insurance Seller''s Account';
            OptionMembers = , "Insurance Prepaid", " Insurance Buyer's Account", " Insurance Seller's Account";
            DataClassification = CustomerContent;
            Caption = 'Insurance';
        }
        field(53089; "RFQ/Enquiry No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'RFQ/Enquiry No';
        }
        field(53091; "Authorised By"; Text[50])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Authorised By';
        }
        field(53092; "Authenticated By"; Text[50])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Authenticated By';
        }
        field(53105; Remarks; Text[50])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(55006; "RGP Receipt No."; Code[20])
        {
            Description = 'CEN004.05';
            TableRelation = "SSD RGP Receipt Header"."No." where("Party No."=field("Sell-to Customer No."));
            DataClassification = CustomerContent;
            Caption = 'RGP Receipt No.';
        }
        field(60000; "Excise Invoice No."; Code[10])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice No.';
        }
        field(60001; "Excise Invoice Date"; Date)
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice Date';
        }
        field(60002; "Excise Invoice No. Series"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice No. Series';
        }
        field(60006; "DI No."; Code[20])
        {
            Description = 'CE_AA002';
            TableRelation = "SSD NAGARE"."NAGARE No." where("Cusomer Code"=field("Sell-to Customer No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'DI No.';
        }
        field(60007; "DI Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'DI Date';
        }
        field(60008; "Delivery Location"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery Location';
        }
        field(60009; "Delivery Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery Time';
        }
        field(60010; "Usage Location"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Usage Location';
        }
        field(60011; "Nagare Item Type"; Option)
        {
            OptionCaption = ' ,DI SPARES,ENAGARE';
            OptionMembers = " ", "DI SPARES", ENAGARE;
            DataClassification = CustomerContent;
            Caption = 'Nagare Item Type';
        }
        field(60043; Supplementary; Boolean)
        {
            Description = 'Supplementary';
            DataClassification = CustomerContent;
            Caption = 'Supplementary';
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
        field(60048; "Supplementary PO Item"; Code[20])
        {
            Description = 'Supplementary';
            TableRelation = "SSD Supplementary Sales Lines"."Document No.";
            DataClassification = CustomerContent;
            Caption = 'Supplementary PO Item';

            trigger OnValidate()
            var
                SuppSalesHeader: Record "Sales Header";
            begin
            end;
        }
        field(60049; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Date';

            trigger OnValidate()
            var
                LocalSalesLine: Record "Sales Line";
            begin
                //>>All_AA_Supp
                LocalSalesLine.Reset;
                LocalSalesLine.SetCurrentkey("Document Type", "Sell-to Customer No.", "No.");
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
                //>>All_AA_Supp
                LocalSalesLine.Reset;
                LocalSalesLine.SetCurrentkey("Document Type", "Sell-to Customer No.", "No.");
            end;
        }
        field(60080; "Comm. Inv. No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Comm. Inv. No. Series';
        }
        field(60081; "ARE1 No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'ARE1 No. Series';
        }
        field(60082; "Commercial Invoice No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Commercial Invoice No.';
        }
        field(60083; "ARE 1 No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'ARE 1 No.';
        }
        field(70000; "Schedule Month"; Option)
        {
            OptionCaption = ', ,JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC';
            OptionMembers = , " ", JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC;
            DataClassification = CustomerContent;
            Caption = 'Schedule Month';
        }
        field(70010; Freight_2; Option)
        {
            OptionCaption = ',Freight Prepaid, Freight Buyer''s Account, Freight Seller''s Account, Freight to be Paid';
            OptionMembers = , "Freight Prepaid", " Freight Buyer's Account", " Freight Seller's Account", " Freight to be Paid";
            DataClassification = CustomerContent;
            Caption = 'Freight_2';
        }
        field(70011; "PF Charges"; Option)
        {
            OptionMembers = " ", "Inclusive in Price", "Not Inclusive in Price";
            DataClassification = CustomerContent;
            Caption = 'PF Charges';
        }
        field(70013; "JBM Position"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'JBM Position';
        }
        field(70014; "JBM Contract"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'JBM Contract';
        }
        field(70200; "Structure Calculated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Structure Calculated';
        }
        field(70201; "Statistics Checked"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Statistics Checked';
        }
        field(70202; Sapres; Boolean)
        {
            Description = 'CE_AA007.05';
            DataClassification = CustomerContent;
            Caption = 'Sapres';
        }
        field(70203; "Weightment Bill No."; Code[20])
        {
            Description = 'PT - Deepika.V - 26/12/08';
            DataClassification = CustomerContent;
            Caption = 'Weightment Bill No.';
        }
        field(70204; "Weightment Bill Date"; Date)
        {
            Description = 'PT - Deepika.V - 26/12/08';
            DataClassification = CustomerContent;
            Caption = 'Weightment Bill Date';
        }
        field(75000; "Applied to Insurance Policy"; Code[30])
        {
            Description = 'ALLE 2.09';
            DataClassification = CustomerContent;
            Caption = 'Applied to Insurance Policy';
        }
        field(75001; "Freight Zone"; Code[20])
        {
            Description = 'ALLE 3.08';
            Editable = false;
            TableRelation = "SSD Freight Zone";
            DataClassification = CustomerContent;
            Caption = 'Freight Zone';
        }
        field(80000; "Place of Receipt by Pre-carr"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Place of Receipt by Pre-carr';
        }
        field(80001; "Port of Lading"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Port of Lading';
        }
        field(80002; "Port of Discharge"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Port of Discharge';
        }
        field(80003; "Final Destination"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Final Destination';
        }
        field(80004; "57F4 No."; Code[20])
        {
            Description = 'ssd';
            DataClassification = CustomerContent;
            Caption = '57F4 No.';
        }
        field(80005; "57F4 Date"; Date)
        {
            Description = 'ssd';
            DataClassification = CustomerContent;
            Caption = '57F4 Date';
        }
        field(80006; "Job Work Invoice"; Boolean)
        {
            Description = 'ssd';
            DataClassification = CustomerContent;
            Caption = 'Job Work Invoice';
        }
        field(85000; "Completely Closed"; Boolean)
        {
            Description = 'ALLE 3.29';
            DataClassification = CustomerContent;
            Caption = 'Completely Closed';
        }
        field(85001; ARE1; Boolean)
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'ARE1';
        }
        field(85002; "Excise Bus Posting Group(ADE)"; Code[10])
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'Excise Bus Posting Group(ADE)';
        }
        field(85003; CT2; Boolean)
        {
            Description = 'ALLE 3.15';
            DataClassification = CustomerContent;
            Caption = 'CT2';
        }
        field(85004; "CT2 Form"; Code[20])
        {
            Description = 'ALLE 3.15';
            TableRelation = "SSD CT2 Header"."CT2 No." where("CT2 No."=field("CT2 Form"));
            DataClassification = CustomerContent;
            Caption = 'CT2 Form';
        }
        field(85005; "Customer Order Date"; Date)
        {
            Description = 'ALLE 3.15';
            DataClassification = CustomerContent;
            Caption = 'Customer Order Date';
        }
        field(85006; CT3; Boolean)
        {
            Description = 'ALLE 3.16';
            DataClassification = CustomerContent;
            Caption = 'CT3';
        }
        field(85007; "CT3 Form"; Code[20])
        {
            Description = 'ALLE 3.16';
            TableRelation = "SSD CT3 Header"."CT3 No." where("Customer No."=field("Sell-to Customer No."));
            DataClassification = CustomerContent;
            Caption = 'CT3 Form';
        }
        field(85011; "Supplementary Invoice"; Boolean)
        {
            Description = 'ALLE[551]';
            DataClassification = CustomerContent;
            Caption = 'Supplementary Invoice';
        }
        field(85035; "Type of Invoice";Enum "Type Of Invoice Sales")
        {
            Caption = 'Type of Invoice';
        }
    }
}
