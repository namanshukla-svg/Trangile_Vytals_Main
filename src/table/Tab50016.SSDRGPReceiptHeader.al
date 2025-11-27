Table 50016 "SSD RGP Receipt Header"
{
    // CML-024 ALLEAG 180208 :
    //   Created a new function Navigate(), to add the Navigate functionality.
    // ALLE 6.12.....57F4 Customisation
    DataCaptionFields = "No.", "Party Name";
    DrillDownPageID = "Posted Receipt List";
    LookupPageID = "Posted Receipt List";
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
            DataClassification = CustomerContent;
            Caption = 'Party City';
        }
        field(15; "Party PostCode"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Party PostCode';
        }
        field(16; "Party State"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Party State';
        }
        field(17; "Party Country"; Text[30])
        {
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
        field(37; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'No. Series';
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
        field(60013; "Document SubType"; Option)
        {
            Description = 'ALLE 6.12';
            OptionCaption = ' ,57F4';
            OptionMembers = " ","57F4";
            DataClassification = CustomerContent;
            Caption = 'Document SubType';
        }
        field(60052; "Gate IN IG"; Code[20])
        {
            TableRelation = "Posted Gate Entry Header"."No." where("Entry Type" = const(Inward));//, "Location Code" = field("Location Code"));
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Party Type")
        {
        }
        key(Key3; "Party Type", "Document Type")
        {
        }
    }
    fieldgroups
    {
    }
    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        //CML-024 ALLEAG 180208 Start
        NavigateForm.SetDoc("Posting Date", "Pre-Assigned No.");
        NavigateForm.Run;
        //CML-024 ALLEAG 180208 End
    end;
}
