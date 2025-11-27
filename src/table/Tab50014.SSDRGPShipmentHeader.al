Table 50014 "SSD RGP Shipment Header"
{
    // CML-024 ALLEAG 180208 :
    //   - Created a new function Navigate(), to add the Navigate functionality.
    // ALLE 6.12.....57F4 Customisation
    DataCaptionFields = "No.", "Party Name";
    //SSD DrillDownPageID = "Posted RGP Shipment List";
    //SSD LookupPageID = "Posted RGP Shipment List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(3; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        field(4; "Party Shipment/Rect. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Party Shipment/Rect. No.';
        }
        field(5; "Party Shipment/Rect. Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Party Shipment/Rect. Date';
        }
        field(6; "Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Date';
        }
        field(7; "Advising Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
            DataClassification = CustomerContent;
            Caption = 'Advising Department';
        }
        field(8; "Advising Employee"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('EMPLOYEE'));
            DataClassification = CustomerContent;
            Caption = 'Advising Employee';
        }
        field(9; "Party Type"; Option)
        {
            OptionMembers = Vendor,Customer,Employee;
            DataClassification = CustomerContent;
            Caption = 'Party Type';
        }
        field(10; "Party No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Party No.';
        }
        field(11; "Party Name"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Party Name';
        }
        field(12; "Party Address"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Party Address';
        }
        field(13; "Party Address 2"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Party Address 2';
        }
        field(14; "Party City"; Text[30])
        {
            TableRelation = "Post Code";
            DataClassification = CustomerContent;
            Caption = 'Party City';
        }
        field(15; "Party PostCode"; Code[20])
        {
            TableRelation = "Post Code";
            DataClassification = CustomerContent;
            Caption = 'Party PostCode';
        }
        field(16; "Party State"; Text[30])
        {
            TableRelation = State;
            DataClassification = CustomerContent;
            Caption = 'Party State';
        }
        field(17; "Party Country"; Text[30])
        {
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
            Caption = 'Party Country';
        }
        field(18; "Delivery Mode"; Option)
        {
            OptionMembers = "Own Vehical","By Hand Party",Transporter;
            DataClassification = CustomerContent;
            Caption = 'Delivery Mode';
        }
        field(19; "Vehical No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Vehical No.';
        }
        field(20; "Transporter No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Transporter No.';
        }
        field(21; "Transporter Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Transporter Name';
        }
        field(22; "LR No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'LR No.';
        }
        field(23; "GR No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'GR No.';
        }
        field(24; "Bearer Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Bearer Name';
        }
        field(25; "Bearer Department"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bearer Department';
        }
        field(26; "MRR No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'MRR No.';
        }
        field(27; "Purpose Code"; Code[20])
        {
            TableRelation = "Reason Code".Code;
            DataClassification = CustomerContent;
            Caption = 'Purpose Code';
        }
        field(28; "Purpose Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Purpose Description';
        }
        field(29; Remarks; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;
        }
        field(32; "Document Type"; Option)
        {
            OptionMembers = "RGP Inbound","RGP Outbound";
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(34; "External Document No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'External Document No.';
        }
        field(36; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(39; "Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipment Date';
        }
        field(50; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(60; "Pre-Assigned No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pre-Assigned No.';
        }
        field(100; NRGP; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NRGP';
        }
        field(102; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(103; "Location Code"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Location Code';
        }
        field(105; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            Description = 'Alle-[E-Way API]';
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;
        }
        field(16512; "LR/RR Date"; Date)
        {
            Caption = 'LR/RR Date';
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
        }
        field(50100; "E-Way Bill No."; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill No.';
        }
        field(50101; "E-Way Bill Date"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill Date';
        }
        field(50102; "E-Way Bill Validity"; Text[30])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Bill Validity';
        }
        field(50103; "E-Way-to generate"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way-to generate';
        }
        field(50104; "E-Way Generated"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Generated';
        }
        field(50105; "New Vechile No."; Code[10])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'New Vechile No.';
        }
        field(50106; "Vechile No. Update Remark"; Text[250])
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'Vechile No. Update Remark';
        }
        field(50107; "E-Way Canceled"; Boolean)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'E-Way Canceled';
        }
        field(50108; "Transportation Distance"; Integer)
        {
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
            Caption = 'Transportation Distance';
        }
        field(50109; "Transport Method"; Code[10])
        {
            Description = 'Alle-[E-Way API]';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
            Caption = 'Transport Method';
        }
        field(50113; "Mode of Transport"; Text[15])
        {
            Caption = 'Mode of Transport';
            Description = 'Alle-[E-Way API]';
            DataClassification = CustomerContent;
        }
        field(55000; "Gate Out Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Gate Out Date';
        }
        field(55001; "Gate Out Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Gate Out Time';
        }
        field(55002; "Gate Out Remarks"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Gate Out Remarks';
        }
        field(55003; "Gate Out User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Gate Out User ID';
        }
        field(55004; "Gate Out No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Gate Out No.';
        }
        field(55005; "Gate Out Posted"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Gate Out Posted';
        }
        field(55006; "Bin Code"; Code[20])
        {
            Description = 'CEN003';
            DataClassification = CustomerContent;
            Caption = 'Bin Code';
        }
        field(55007; Remark2; Text[80])
        {
            Description = 'PK CGN 005 (FOR WRITING NOTE ON "RGP")';
            DataClassification = CustomerContent;
            Caption = 'Remark2';
        }
        field(55010; "Posted RGP Inbound"; Code[20])
        {
            Description = 'CEN004.05';
            DataClassification = CustomerContent;
            Caption = 'Posted RGP Inbound';
        }
        field(60013; "Document SubType"; Option)
        {
            Description = 'ALLE 6.12';
            OptionCaption = ' ,57F4';
            OptionMembers = " ","57F4";
            DataClassification = CustomerContent;
            Caption = 'Document SubType';
        }
        field(60016; "Freight Amount"; Decimal)
        {
            Description = 'ALLE 3.24';
            DataClassification = CustomerContent;
            Caption = 'Freight Amount';

            trigger OnValidate()
            var
                TotalWaight: Decimal;
            begin
                RGPShipmentLine.Reset;
                RGPShipmentLine.SetRange("Document Type", "Document Type");
                RGPShipmentLine.SetRange("Document No.", "No.");
                TotalWaight := 0;
                if RGPShipmentLine.Find('-') then
                    repeat
                        TotalWaight += RGPShipmentLine.Quantity;
                    until RGPShipmentLine.Next = 0;
                RGPShipmentLine.Reset;
                RGPShipmentLine.SetRange("Document Type", "Document Type");
                RGPShipmentLine.SetRange("Document No.", "No.");
                if RGPShipmentLine.Find('-') then
                    repeat
                        if TotalWaight <> 0 then
                            RGPShipmentLine."Freight Amount" := ROUND("Freight Amount" * RGPShipmentLine.Quantity / TotalWaight)
                        else
                            RGPShipmentLine."Freight Amount" := 0;
                        RGPShipmentLine.Modify;
                    until RGPShipmentLine.Next = 0;
            end;
        }
        field(60017; "Firm Freight"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Firm Freight';
        }
        field(60018; "Gate Pass"; Boolean)
        {
            CalcFormula = exist("SSD Gate Pass Line" where("Invoice No." = field("No.")));
            Description = 'ALLE-GP001';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Gate Pass';
        }
        field(60051; "Gate Out"; Code[20])
        {
            TableRelation = "Posted Gate Entry Header"."No." where("Entry Type" = const(Outward));
            DataClassification = CustomerContent;
            Editable = false;
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
    var
        RGPShipmentLine: Record "SSD RGP Shipment Line";

    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        //CML-024 ALLEAG 180208 Start
        NavigateForm.SetDoc("Posting Date", "Pre-Assigned No.");
        NavigateForm.Run;
        //CML-024 ALLEAG 180208 Finish
    end;
}
