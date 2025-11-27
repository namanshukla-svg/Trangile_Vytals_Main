TableExtension 50049 "SSD Posted Whse. Rcpt Header" extends "Posted Whse. Receipt Header"
{
    fields
    {
        field(50001; IsMRN; Boolean)
        {
            Description = 'CF001.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'IsMRN';
        }
        field(50002; "Gate Entry no."; Code[20])
        {
            Description = 'CF001.01';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry no.';
        }
        field(50003; "Gate Entry Date"; Date)
        {
            Description = 'CF001.01';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry Date';
        }
        field(50004; Subcontracting; Boolean)
        {
            Description = 'CF001.02';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Subcontracting';
        }
        field(50006; "QC Report Received"; Boolean)
        {
            Description = 'Alle VPB as per Manish Request Informative field only';
            DataClassification = CustomerContent;
            Caption = 'QC Report Received';
        }
        field(50007; "Transporter Copy Received"; Boolean)
        {
            Description = 'Alle VPB as per Manish Request Informative field only';
            DataClassification = CustomerContent;
            Caption = 'Transporter Copy Received';
        }
        field(50050; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001.01';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50051; "Bill No."; Code[20])
        {
            CalcFormula = lookup("SSD Posted Gate Header"."Bill No." where("No." = field("Gate Entry no.")));
            Description = 'CEN004.06';
            FieldClass = FlowField;
            Caption = 'Bill No.';
        }
        field(50054; "Subcontracting Transfer Order"; Boolean)
        {
            Description = 'ALLEAA CML-033 080508';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting Transfer Order';
        }
        field(50055; "Bill Amount"; Decimal)
        {
            CalcFormula = lookup("SSD Posted Gate Header"."Bill Amount" where("No." = field("Gate Entry no.")));
            Description = 'CEN004.06';
            FieldClass = FlowField;
            Caption = 'Bill Amount';
        }
        field(60003; Trading; Boolean)
        {
            Caption = 'Trading';
            Description = 'CE_AA004';
            DataClassification = CustomerContent;
        }
        field(60004; "Vendor No."; Code[20])
        {
            CalcFormula = lookup("SSD Posted Gate Header"."Party No." where("No." = field("Gate Entry no.")));
            Description = 'ALLE';
            FieldClass = FlowField;
            Caption = 'Vendor No.';
        }
        field(60005; "Vendor No.1"; Code[20])
        {
            Description = 'IG';
            Editable = false;
        }
        field(60006; "Vendor Name"; Text[100])
        {
            Description = 'IG';
            Caption = 'Vendor Name';
            Editable = false;
        }
    }
}
