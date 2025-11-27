Table 50034 "SSD Gate Pass Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GateSetup.Get();
                if "No." <> xRec."No." then begin
                    NoSeriesMgt.TestManual(GateSetup."Gate Out Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(3; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
        }
        field(4; "Driver Name"; Text[50])
        {
            Caption = 'Driver Name';
            DataClassification = CustomerContent;
        }
        field(5; "Transporter Code"; Code[20])
        {
            TableRelation = "Shipping Agent".Code;
            Caption = 'Transporter Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ShippingAgent: Record "Shipping Agent";
            begin
                if ShippingAgent.Get("Transporter Code") then "Transporter Name" := ShippingAgent.Name;
            end;
        }
        field(6; "Transporter Name"; Text[50])
        {
            Editable = false;
            FieldClass = Normal;
            Caption = 'Transporter Name';
            DataClassification = CustomerContent;
        }
        field(7; "Bilty No."; Code[50])
        {
            Caption = 'Bilty No.';
            DataClassification = CustomerContent;
        }
        field(8; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(9; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(10; "Responsibility Center"; Code[20])
        {
            Editable = false;
            TableRelation = "Responsibility Center".Code;
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
        }
        field(11; "Mobile No."; Text[10])
        {
            Caption = 'Mobile No.';
            DataClassification = CustomerContent;
        }
        field(12; "Gate Pass Time"; Time)
        {
            Caption = 'Gate Pass Time';
            DataClassification = CustomerContent;
        }
        field(13; "Document Type"; Option)
        {
            OptionCaption = 'Sales Invoice,Transfer Shipment,Purchase Credit Memo,SubCon. Order Shipment,RGP,NRGP';
            OptionMembers = "Sales Invoice","Transfer Shipment","Purchase Credit Memo","SubCon. Order Shipment",RGP,NRGP;
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(14; "User Details"; Text[100])
        {
            Caption = 'User Details';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        GatePassLine: Record "SSD Gate Pass Line";
    begin
        GatePassLine.SetRange("No.", "No.");
        GatePassLine.DeleteAll;
    end;

    trigger OnInsert()
    begin
        if UserId <> '' then begin
            if USERSET.Get(UserId) then begin
                "Responsibility Center" := USERSET."Responsibility Center";
            end;
        end;
        //SalesSetup.GET;
        if "No." = '' then begin
            // TestNoSeries;
            GateSetup.Get();
            "No." := NoSeriesMgt.GetNextNo(GateSetup."Gate Out Nos", WorkDate, true);
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        USERSET: Record "User Setup";
        RESPCENT: Record "Responsibility Center";
        GateSetup: Record "SSD AddOn Setup";

    procedure TestNoSeries(): Boolean
    begin
        if UserId <> '' then begin
            if USERSET.Get(UserId) then begin
                if RESPCENT.Get(USERSET."Responsibility Center") then RESPCENT.TestField(RESPCENT."Gate Pass Nos");
            end;
        end;
    end;

    procedure GetNoSeriesCode(): Code[10]
    begin
        if UserId <> '' then begin
            if USERSET.Get(UserId) then begin
                if RESPCENT.Get(USERSET."Responsibility Center") then exit(RESPCENT."Gate Pass Nos");
            end;
        end;
    end;

    procedure AssistEdit(OldGatePass: Record "SSD Gate Pass Header"): Boolean
    var
        GatePass: Record "SSD Gate Pass Header";
        GatePass2: Record "SSD Gate Pass Header";
        Text012: Label 'The No. %1 %2 already exists.';
    begin
        if UserId <> '' then begin
            if USERSET.Get(UserId) then begin
                if RESPCENT.Get(USERSET."Responsibility Center") then;
            end;
        end;
        GatePass := Rec;
        GatePass.TestNoSeries;
        //IG_DS if NoSeriesMgt.SelectSeries(RESPCENT."Gate Pass Nos", OldGatePass."No. Series", GatePass."No. Series") then begin
        //     NoSeriesMgt.SetSeries(GatePass."No.");
        //     Rec := GatePass;
        //     exit(true);
        // end;
        if NoSeriesMgt.LookupRelatedNoSeries(RESPCENT."Gate Pass Nos", OldGatePass."No. Series", GatePass."No. Series") then begin
            GatePass."No." := NoSeriesMgt.GetNextNo(GatePass."No. Series");
            if GatePass2.Get(GatePass."No.") then
                Error(Text012, GatePass."No.");
            Rec := GatePass;
            exit(true);
        end;
    end;
}
