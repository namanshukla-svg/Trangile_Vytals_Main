TableExtension 50087 "SSD Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        //Unsupported feature: Property Modification (Data type) on ""Cross-Reference No."(Field 5705)".
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
        field(50005; crminsertflag; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'crminsertflag';
        }
        field(50006; crmupdateflag; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'crmupdateflag';
        }
        field(50007; isCRMexception; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'isCRMexception';
        }
        field(50008; exceptiondetail; Text[200])
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'exceptiondetail';
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
        field(53011; "SSD Order No."; Code[20])
        {
            Description = 'CF002';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Order No.';
        }
        field(53012; "SSD Order Line No."; Integer)
        {
            Description = 'CF002';
            DataClassification = CustomerContent;
            Caption = 'Order Line No.';
        }
        field(53050; "Excise Invoice No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice No.';
        }
        field(53051; "Excise Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice Date';
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
        field(53090; "SSD FOC"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'FOC';
        }
        field(54020; "Amortization Charge Not In Use"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amortization Charge Not In Use';
        }
        field(54021; "Addition/Deduction"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Addition/Deduction';
        }
        field(54022; "Tool Amortization"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Tool Amortization';
        }
        field(54023; "FOC Unit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FOC Unit Amount';
        }
        field(54024; Amortization; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Amortization';
        }
        field(54061; "No of Pack"; Decimal)
        {
            CalcFormula = lookup("SSD Sales Schedule Buffer"."No. of Box" where("Document Type"=filter(Order|Invoice), "Document No."=field("Pre-Assigned No."), "Sell-to Customer No."=field("Sell-to Customer No."), "Order Line No."=field("Line No."), "Item No."=field("No.")));
            Description = 'CF002 For No of Packet';
            FieldClass = FlowField;
            Caption = 'No of Pack';
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
        field(54069; "Pre-Assigned No."; Code[20])
        {
            Caption = 'Pre-Assigned No.';
            Description = 'Coming From Sales Header';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(54070; "Invoicing Date"; Date)
        {
            CalcFormula = lookup("Sales Invoice Header"."Posting Date" where("No."=field("Document No.")));
            FieldClass = FlowField;
            Caption = 'Invoicing Date';
        }
        field(54071; "Invoice Suplemented"; Boolean)
        {
            Description = 'Invoice is suplemented';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Invoice Suplemented';
        }
        field(54072; "No. 2"; Code[20])
        {
            CalcFormula = lookup(Item."No. 2" where("No."=field("No.")));
            Description = 'CEN002';
            FieldClass = FlowField;
            Caption = 'No. 2';
        }
        field(60008; "Direct Debit To PLA"; Boolean)
        {
            Caption = 'Direct Debit To PLA';
            DataClassification = CustomerContent;
        }
        field(60009; "Applied Trading Entry No."; Integer)
        {
            Description = 'CE_AA003';
            DataClassification = CustomerContent;
            Caption = 'Applied Trading Entry No.';
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
        field(70000; "Schedule Month"; Option)
        {
            OptionCaption = ', ,JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC';
            OptionMembers = , " ", JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC;
            DataClassification = CustomerContent;
            Caption = 'Schedule Month';
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
        field(85024; "Actual Wt"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Actual Wt';

            trigger OnLookup()
            var
                SalesScheduleBufferLocal: Record "SSD Sales Schedule Buffer";
                SalesPacketDetailsForm: Page "Sales Packet Details";
            begin
            end;
        }
        field(85025; "Gross Wt"; Decimal)
        {
            Description = 'Alle VPB';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Gross Wt';
        }
        field(85027; "Credit Note Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Credit Note Unit Price';
        }
        field(85028; "Freight Amount"; Decimal)
        {
            Description = 'will come from InvHeader';
            DataClassification = CustomerContent;
            Caption = 'Freight Amount';
        }
        field(85040; "Amazon SKU"; Code[10])
        {
            Description = 'Alle-[Amazon-HG]';
            DataClassification = CustomerContent;
            Caption = 'Amazon SKU';
        }
        field(85041; "Amazon Ship Promo Discount"; Decimal)
        {
            Description = 'Alle-[Amazon-HG]';
            DataClassification = CustomerContent;
            Caption = 'Amazon Ship Promo Discount';
        }
        field(85043; "Amazon Shipping Price"; Decimal)
        {
            Description = 'Alle-[Amazon-HG]';
            DataClassification = CustomerContent;
            Caption = 'Amazon Shipping Price';
        }
        field(85044; "Amazon Invoice/Credit Memo"; Boolean)
        {
            Description = 'Alle-[Amazon-HG]';
            DataClassification = CustomerContent;
            Caption = 'Amazon Invoice/Credit Memo';
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
        // Unsupported feature: Key containing base fields
        // key(Key1;"Sell-to Customer No.","Order No.")
        // {
        // }
        // Unsupported feature: Key containing base fields
        // key(Key2;"No.","Order No.","Document No.")
        // {
        // }
        // Unsupported feature: Key containing base fields
        // key(Key3;"Sell-to Customer No.","No.","Document No.")
        // {
        // }
        key(Key4; "Despatch Slip No.", "Despatch Slip Line No.")
        {
        }
        // Unsupported feature: Key containing base fields
        // key(Key5;Quantity,"Document No.","Line No.")
        // {
        // }
        // Unsupported feature: Key containing base fields
        // key(Key6;"Document No.",Type)
        // {
        // }
        // Unsupported feature: Key containing base fields
        // key(Key7;"Document No.","Sell-to Customer No.",Type)
        // {
        // }
        // Unsupported feature: Key containing base fields
        // key(Key8;"Sell-to Customer No.","Tax %","Form Code","VAT %")
        // {
        // }
        // Unsupported feature: Key containing base fields
        // key(Key9;"Excise Prod. Posting Group",Type,"Posting Date")
        // {
        // SumIndexFields = "BED Amount","eCess Amount","ADE Amount","Excise Base Amount","Assessable Value",Quantity;
        // }
        // Unsupported feature: Key containing base fields
        // key(Key10;"No.",Type,"Posting Group","Posting Date")
        // {
        // SumIndexFields = Quantity;
        // }
        // Unsupported feature: Key containing base fields
        // key(Key11;"Form Code","VAT %","Sell-to Customer No.","Posting Group","Posting Date",Type)
        // {
        // }
        // Unsupported feature: Key containing base fields
        // key(Key12;"Posting Group","Sell-to Customer No.","VAT %","Form Code",Type)
        // {
        // }
        // Unsupported feature: Key containing base fields
        // key(Key13;"Posting Date","Document No.","Line No.")
        // {
        // }
        // Unsupported feature: Key containing base fields
        // key(Key14;"Sell-to Customer No.","No.","Responsibility Center")
        // {
        // }
        // Unsupported feature: Key containing base fields
        // key(Key15;"CT2 Form","CT2 Form Line No.","No.")
        // {
        // SumIndexFields = Quantity;
        // }
        // Unsupported feature: Key containing base fields
        // key(Key16;"CT3 Form","CT3 Form Line No.","No.")
        // {
        // SumIndexFields = Quantity;
        // }
        key(Key17; "Order No.", "Order Line No.")
        {
            SumIndexFields = Quantity;
        }
    }
    var Text037: label 'Despatch No. %1:';
    Text038: label 'The program cannot find this Sales line.';
    Text039: label 'You can not have %1 defined in structure for Export Document';
}
