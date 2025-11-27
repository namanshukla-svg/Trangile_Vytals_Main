table 50029 "SSD AddOn Setup"
{
    Caption = 'RGP Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Gate In Nos"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Gate In Nos';
        }
        field(3; "Gate Out Nos"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Gate Out Nos';
        }
        field(54000; "Indent No. Series"; Code[20])
        {
            Description = 'MAC_PP002';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Indent No. Series';
        }
        field(54001; "Indent Template Name"; Code[10])
        {
            Description = 'MAC_PP002';
            TableRelation = "Req. Wksh. Template" where("Page ID"=const(291), Recurring=const(false), Type=const("Req."));
            DataClassification = CustomerContent;
            Caption = 'Indent Template Name';
        }
        field(54002; "Indent Batch Name"; Code[10])
        {
            Description = 'MAC_PP002';
            TableRelation = "Requisition Wksh. Name".Name where("Worksheet Template Name"=field("Indent Template Name"));
            DataClassification = CustomerContent;
            Caption = 'Indent Batch Name';
        }
        field(54010; "RGP Out Nos"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'RGP Out Nos';
        }
        field(54011; "RGP In Nos"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'RGP In Nos';
        }
        field(54012; "Posted RGP Shipment Nos"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted RGP Shipment Nos';
        }
        field(54013; "Posted RGP Receipt Nos"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted RGP Receipt Nos';
        }
        field(54014; "NRGP Out Nos"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'NRGP Out Nos';
        }
        field(54015; "NRGP In Nos"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'NRGP In Nos';
        }
        field(54016; sTARTLINE; Integer)
        {
            Description = 'CE_AA002';
            DataClassification = CustomerContent;
            Caption = 'sTARTLINE';
        }
        field(54017; "Subcon MRN Nos"; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Subcon MRN Nos';
        }
        field(54018; "Requisition Slip Template"; Code[20])
        {
            TableRelation = "Item Journal Template";
            DataClassification = CustomerContent;
            Caption = 'Requisition Slip Template';
        }
        field(54019; "Requisition Slip Batch"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition Slip Batch';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name"=field("Requisition Slip Template"));
        }
        field(54020; "ARE1 No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'ARE1 No. Series';
        }
        field(54021; "Commercial Invoice No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Commercial Invoice No. Series';
        }
        field(54025; "Issue Slip No"; Code[10])
        {
            Description = '20';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Issue Slip No';
        }
        //SSD Sunil 
        field(54030; "Posted RGP OUT Shipment Nos"; Code[20])
        {
            Caption = 'Posted RGP OUT Shipment Nos';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(54031; "Posted RGP OUT Receipt Nos"; Code[20])
        {
            Caption = 'Posted RGP OUT Receipt Nos';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(54032; "Posted RGP IN Shipment Nos"; Code[20])
        {
            Caption = 'Posted RGP IN Shipment Nos';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(54033; "Posted RGP IN Receipt Nos"; Code[20])
        {
            Caption = 'Posted RGP IN Receipt Nos';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var ItemLedgEntry: Record "Item Ledger Entry";
}
