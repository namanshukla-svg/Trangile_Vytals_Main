Table 50010 "SSD RGP Header"
{
    // // CF001 05.01.2006 added for responsibility center
    // //CP001
    // CEN004.05 Ankit Agarwal For testing the Fields
    // ALLEAA CML-033 280308
    //   - Some New Fields Added
    // ALLEAA CML-033 280308
    //   -- Code added OnValidate of "Location Code" and "To Loccation"
    // ALLEAA CML-033 180408
    //  -- Code Added to flow dimension in the lines of document.
    // ALLEAA CML-033 250408
    //   - New Field Added
    // ALLE 6.12.....57F4 Customisation
    DataCaptionFields = "No.", "Party Name";
    DrillDownPageID = "RGP List";
    LookupPageID = "RGP List";
    Permissions = TableData "Purch. Rcpt. Header" = rimd,
        TableData "Purch. Rcpt. Line" = rimd;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    RGPSetup.Get();
                    NoSeriesMgt.TestManual(GetNoSeriesCode); //SSD_Sunil Uncomment
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                if not Shipped then "Document Date" := "Posting Date";
                if xRec."Posting Date" <> "Posting Date" then if Shipped = true then if "Shipment Date" > "Posting Date" then Error('Receipt Date can not be earlier than Shipment Date');
            end;
        }
        field(3; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';

            trigger OnValidate()
            begin
                if Shipped then Error('You cann''t change the document date');
            end;
        }
        field(4; "Party Shipment/Rect. No."; Code[20])
        {
            CaptionClass = GetFieldCaption(FIELDNO("Party Shipment/Rect. No."));
            DataClassification = CustomerContent;
            Caption = 'Party Shipment/Rect. No.';
        }
        field(5; "Party Shipment/Rect. Date"; Date)
        {
            CaptionClass = GetFieldCaption(FIELDNO("Party Shipment/Rect. Date"));
            DataClassification = CustomerContent;
            Caption = 'Party Shipment/Rect. Date';
        }
        field(6; "Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Date';

            trigger OnValidate()
            begin
                //alle vpb TestStatusOpen;
                //alle vpb TESTIFSHIPPED;
                if RGPLineExist then begin
                    if Confirm(Text002) then begin
                        RGPLine.SetRange("Document Type", "Document Type");
                        RGPLine.SetRange("Document No.", "No.");
                        if RGPLine.Find('-') then begin
                            repeat
                                RGPLine."Expected Receipt Date" := "Receipt Date";
                                RGPLine."Requested Receipt Date" := "Receipt Date";
                                RGPLine.Modify;
                            until RGPLine.Next = 0;
                        end
                        else
                            exit;
                    end;
                end;
            end;
        }
        field(7; "Advising Department"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('DEPARTMENT'));
            DataClassification = CustomerContent;
            Caption = 'Advising Department';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
            end;
        }
        field(8; "Advising Employee"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('EMPLOYEE'));
            DataClassification = CustomerContent;
            Caption = 'Advising Employee';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
            end;
        }
        field(9; "Party Type"; Option)
        {
            OptionMembers = Vendor,Customer,Employee;
            DataClassification = CustomerContent;
            Caption = 'Party Type';

            trigger OnValidate()
            var
                RGPLine: Record "SSD RGP Line";
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
                if "Party No." <> '' then begin
                    if xRec."Party Type" <> "Party Type" then begin
                        if Confirm('Do you want to change Party Type') then begin
                            RGPLine.SetRange("Document Type", "Document Type");
                            RGPLine.SetRange("Document No.", "No.");
                            if RGPLine.Find('-') then begin
                                repeat
                                    if (RGPLine."Quantity Shipped" <> 0) or (RGPLine."Quantity Received" <> 0) then begin
                                        Error('Party Type cann''t be changed');
                                    end
                                    else begin
                                        RGPLine."Party Type" := "Party Type";
                                        RGPLine."Party No." := '';
                                        RGPLine.Modify;
                                    end;
                                until RGPLine.Next = 0;
                            end;
                            "Party No." := '';
                            "Party Name" := '';
                            "Party Address" := '';
                            "Party Address 2" := '';
                            "Party City" := '';
                            "Party PostCode" := '';
                            "Party State" := '';
                            "Party Country" := '';
                        end
                        else
                            "Party Type" := xRec."Party Type";
                    end;
                end
                else begin
                    RGPLine.SetRange("Document Type", "Document Type");
                    RGPLine.SetRange("Document No.", "No.");
                    if RGPLine.Find('-') then begin
                        repeat
                            if (RGPLine."Quantity Shipped" <> 0) or (RGPLine."Quantity Received" <> 0) then begin
                                Error('Party Type cann''t be changed');
                            end
                            else begin
                                RGPLine."Party Type" := "Party Type";
                                RGPLine."Party No." := '';
                                RGPLine.Modify;
                            end;
                        until RGPLine.Next = 0;
                    end;
                end;
            end;
        }
        field(10; "Party No."; Code[20])
        {
            TableRelation = if ("Party Type" = const(Vendor)) Vendor
            else if ("Party Type" = const(Customer)) Customer
            else if ("Party Type" = const(Employee)) "Dimension Value".Code where("Dimension Code" = const('EMPLOYEE'));
            DataClassification = CustomerContent;
            Caption = 'Party No.';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
                case Rec."Party Type" of
                    Rec."party type"::Vendor:
                        begin
                            Vendor.Get(Rec."Party No.");
                            Rec."Party Name" := Vendor.Name;
                            Rec."Party Address" := Vendor.Address;
                            Rec."Party Address 2" := Vendor."Address 2";
                            Rec."Party City" := Vendor.City;
                            Rec."Party PostCode" := Vendor."Post Code";
                            Rec."Party State" := Vendor."State Code";
                            Rec."Party Country" := Vendor."Country/Region Code";
                            //>>Alle VPB 27-Aug-10 Add Start
                            Rec."Inter Unit Transfer" := Vendor."Inter Unit Vendor";
                            if Rec."Inter Unit Transfer" then Vendor.TestField("Inter Unit Vendor Location");
                            Rec.Validate("Inter Unit Transfer Location", Vendor."Inter Unit Vendor Location");
                            //<<Alle VPB 27-Aug-10 Add Stop
                        end;
                    Rec."party type"::Customer:
                        begin
                            Customer.Get(Rec."Party No.");
                            Rec."Party Name" := Customer.Name;
                            Rec."Party Address" := Customer.Address;
                            Rec."Party Address 2" := Customer."Address 2";
                            Rec."Party City" := Customer.City;
                            Rec."Party PostCode" := Customer."Post Code";
                            Rec."Party State" := Customer."State Code";
                            Rec."Party Country" := Customer."Country/Region Code";
                        end;
                    Rec."party type"::Employee:
                        begin
                            DimensionValue.SetRange(DimensionValue."Dimension Code", 'EMPLOYEE');
                            DimensionValue.SetRange(Code, Rec."Party No.");
                            if DimensionValue.Find('-') then;
                            Message('%1', DimensionValue.Name);
                            // Employee.GET("Party No.");
                            Rec."Party Name" := DimensionValue.Name;
                            /* "Party Address":=Employee.Address;
                                         "Party Address 2":=Employee."Address 2";
                                         "Party City":=Employee.City;
                                         "Party PostCode":=Employee."Post Code";
                                         "Party Country":=Employee."Country Code";*/
                        end;
                end;
                if RGPLineExist then begin
                    RGPLine.SetRange("Document Type", "Document Type");
                    RGPLine.SetRange("Document No.", "No.");
                    if RGPLine.Find('-') then begin
                        repeat
                            RGPLine."Party Type" := "Party Type";
                            RGPLine."Party No." := "Party No.";
                            RGPLine.Modify;
                        until RGPLine.Next = 0;
                    end;
                end;
                NoSeries.Reset;
                NoSeries.SetRange(NoSeries.Code, "No. Series");
                NoSeries.SetRange(NoSeries.NRGP, true);
                if NoSeries.FindFirst then NRGP := true;
            end;
        }
        field(11; "Party Name"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Party Name';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
            end;
        }
        field(12; "Party Address"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Party Address';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
            end;
        }
        field(13; "Party Address 2"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Party Address 2';
        }
        field(14; "Party City"; Text[30])
        {
            TableRelation = "Post Code".City;
            DataClassification = CustomerContent;
            Caption = 'Party City';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
                //Postcode.ValidateCityByCity("Party City","Party PostCode");
            end;
        }
        field(15; "Party PostCode"; Code[20])
        {
            TableRelation = "Post Code";
            DataClassification = CustomerContent;
            Caption = 'Party PostCode';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
                //Postcode.ValidatePostCode("Party City","Party PostCode");
            end;
        }
        field(16; "Party State"; Text[30])
        {
            TableRelation = State;
            DataClassification = CustomerContent;
            Caption = 'Party State';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
                PartyStateExist("Party Type", "Party No.");
            end;
        }
        field(17; "Party Country"; Text[30])
        {
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
            Caption = 'Party Country';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
                PartyCountryExist("Party Type", "Party No.");
            end;
        }
        field(18; "Delivery Mode"; Option)
        {
            OptionMembers = "Own Vehical","By Hand Party",Transporter;
            DataClassification = CustomerContent;
            Caption = 'Delivery Mode';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
            end;
        }
        field(19; "Vehical No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Vehical No.';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
            end;
        }
        field(20; "Transporter No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Transporter No.';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
            end;
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

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
            end;
        }
        field(25; "Bearer Department"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bearer Department';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
            end;
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

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
                ReasonCodes.Get("Purpose Code");
                "Purpose Description" := ReasonCodes.Description;
            end;
        }
        field(28; "Purpose Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Purpose Description';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
            end;
        }
        field(29; "Ship Remarks"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Ship Remarks';
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
                //ALLEAA CML-033 180408 Start >>
                ModifyRGPLine.SetRange("Document No.", "No.");
                if ModifyRGPLine.Find('-') then
                    repeat
                        ModifyRGPLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                        ModifyRGPLine.Modify;
                    until ModifyRGPLine.Next = 0;
                //ALLEAA CML-033 180408 End <<
            end;
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
                //ALLEAA CML-033 180408 Start >>
                ModifyRGPLine.SetRange("Document No.", "No.");
                if ModifyRGPLine.Find('-') then
                    repeat
                        ModifyRGPLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
                        ModifyRGPLine.Modify;
                    until ModifyRGPLine.Next = 0;
                //ALLEAA CML-033 180408 End <<
            end;
        }
        field(32; "Document Type"; Option)
        {
            OptionMembers = "RGP Inbound","RGP Outbound";
            DataClassification = CustomerContent;
            Caption = 'Document Type';
        }
        field(33; Status; Option)
        {
            OptionMembers = Open,Released,"Pending for Approval";
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(34; "External Document No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'External Document No.';

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(35; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(36; "Posted Shpmt. No Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted Shpmt. No Series';
        }
        field(37; "Posted Rect. No Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Posted Rect. No Series';
        }
        field(38; "Expected Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Shipment Date';
        }
        field(39; "Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipment Date';

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
            end;
        }
        field(40; "Posted Shipment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Shipment No.';
        }
        field(41; "Posted Receipt No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posted Receipt No.';
        }
        field(42; Shipped; Boolean)
        {
            Description = 'Devinder';
            DataClassification = CustomerContent;
            Caption = 'Shipped';
        }
        field(43; "User ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
        }
        field(100; NRGP; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NRGP';
        }
        field(101; "Receipt Remarks"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Remarks';
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

            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTIFSHIPPED;
                //ALLEAA CML-033 280308 Start >>
                ModifyRGPLine.SetRange("Document No.", "No.");
                if ModifyRGPLine.Find('-') then
                    repeat
                        ModifyRGPLine."Location Code" := "Location Code";
                        ModifyRGPLine.Modify;
                    until ModifyRGPLine.Next = 0;
                //ALLEAA CML-033 280308 End <<
            end;
        }
        field(104; "NRGP Inbound"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NRGP Inbound';
        }
        field(50012; "NRGP Created From RGP"; Boolean)
        {
            Description = 'CEN004.06';
            DataClassification = CustomerContent;
            Caption = 'NRGP Created From RGP';
        }
        field(50013; "Batch Receipt"; Boolean)
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Batch Receipt';
        }
        field(50014; "To Location"; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'To Location';

            trigger OnValidate()
            var
                WarehouseEmployee: Record "Warehouse Employee";
            begin
                TestStatusOpen; //ALLEAA CML-033 290408
                //ALLEAA CML-033 280308 Start >>
                // ssd
                //WarehouseEmployee.RESET;
                //WarehouseEmployee.GET(USERID,"To Location");
                //IF NOT WarehouseEmployee.Default THEN
                //  ERROR('Please Select Same as Default Location in Warehouse Employee');
                // ssd
                ModifyRGPLine.SetRange("Document No.", "No.");
                if ModifyRGPLine.Find('-') then
                    repeat
                        ModifyRGPLine."New Location Code" := "To Location";
                        ModifyRGPLine.Modify;
                    until ModifyRGPLine.Next = 0;
                //ALLEAA CML-033 280308 End <<
            end;
        }
        field(50015; "Send to Approval"; Boolean)
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'Send to Approval';
        }
        field(50016; Approved; Boolean)
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'Approved';
        }
        field(50017; "Sender ID"; Code[30])
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'Sender ID';
        }
        field(50018; "Approval ID"; Code[30])
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'Approval ID';
        }
        field(50019; "NRGP Send to Approval"; Boolean)
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'NRGP Send to Approval';
        }
        field(50020; "NRGP Approved"; Boolean)
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'NRGP Approved';
        }
        field(50021; "NRGP Sender ID"; Code[30])
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'NRGP Sender ID';
        }
        field(50022; "NRGP Approval ID"; Code[30])
        {
            Description = 'Alle';
            DataClassification = CustomerContent;
            Caption = 'NRGP Approval ID';
        }
        field(55006; "Bin Code"; Code[20])
        {
            Description = 'CEN004';
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));
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
            TableRelation = "SSD RGP Receipt Header"."No." where("Party No." = field("Party No."));
            DataClassification = CustomerContent;
            Caption = 'Posted RGP Inbound';
        }
        field(55011; "Reference No."; Code[20])
        {
            Description = 'CEN004.06';
            DataClassification = CustomerContent;
            Caption = 'Reference No.';
        }
        field(60000; Subcontracting; Boolean)
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Subcontracting';
        }
        field(60001; "Gate Entry No."; Code[20])
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry No.';
        }
        field(60002; "Gate Entry Line No."; Integer)
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Gate Entry Line No.';
        }
        field(60003; "Completely Received"; Boolean)
        {
            CalcFormula = min("SSD RGP Line".Completed where("Document Type" = field("Document Type"), "Document No." = field("No."), Type = filter(<> " ")));
            Caption = 'Completely Received';
            Description = 'ALLEAA CML-033 280308';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60004; Posted; Boolean)
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Posted';
        }
        field(60005; "Bill No."; Code[10])
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Bill No.';
        }
        field(60006; "Bill Date"; Date)
        {
            Description = 'ALLEAA CML-033 280308';
            DataClassification = CustomerContent;
            Caption = 'Bill Date';
        }
        field(60007; TrasferOrderPost; Boolean)
        {
            Description = 'ALLEAA CML-033 250408';
            DataClassification = CustomerContent;
            Caption = 'TrasferOrderPost';
        }
        field(60008; "OutPut Post"; Boolean)
        {
            Description = 'ALLEAA CML-033 250408';
            DataClassification = CustomerContent;
            Caption = 'OutPut Post';
        }
        field(60009; "Scrap Posted"; Boolean)
        {
            Description = 'ALLEAA CML-033 250408';
            DataClassification = CustomerContent;
            Caption = 'Scrap Posted';
        }
        field(60010; "Shipment Posted"; Boolean)
        {
            Description = 'ALLEAA CML-033 250408';
            DataClassification = CustomerContent;
            Caption = 'Shipment Posted';
        }
        field(60011; "Subcon Posted"; Boolean)
        {
            Description = 'ALLEAA CML-033 250408';
            DataClassification = CustomerContent;
            Caption = 'Subcon Posted';
        }
        field(60012; "Delivery Challan No."; Code[20])
        {
            Description = 'ssd';
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan No.';
        }
        field(60013; "Document SubType"; Option)
        {
            Description = 'ALLE 6.12';
            OptionCaption = ' ,57F4';
            OptionMembers = " ","57F4";
            DataClassification = CustomerContent;
            Caption = 'Document SubType';
        }
        field(60014; "Inter Unit Transfer"; Boolean)
        {
            Description = 'Alle VPB';
            DataClassification = CustomerContent;
            Caption = 'Inter Unit Transfer';
        }
        field(60015; "Inter Unit Transfer Location"; Code[10])
        {
            Description = 'Alle VPB';
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Inter Unit Transfer Location';
        }
        field(60050; "Gate In"; Code[20])
        {
            Description = 'ALLE GI 291015';
            TableRelation = "SSD Posted Gate Header"."No." where("Ref. Document Type" = filter("RGP Inbound"), "Ref. Document No." = field("No."), "RGP Posted" = filter(false));
            DataClassification = CustomerContent;
            Caption = 'Gate In';

            trigger OnValidate()
            begin
                RGPLine1.SetRange("Document Type", "Document Type");
                RGPLine1.SetRange("Document No.", "No.");
                if RGPLine1.Find('-') then
                    repeat
                        PostedGateLine.SetFilter("Ref. Document Type", '%1', PostedGateLine."ref. document type"::"RGP Inbound");
                        PostedGateLine.SetRange("Ref. Document No.", RGPLine1."Document No.");
                        PostedGateLine.SetRange("Line No.", RGPLine1."Line No.");
                        if PostedGateLine.FindFirst then begin
                            RGPLine1.Validate("Quantity to Ship", PostedGateLine."Challan Quantity");
                            RGPLine1.Modify;
                        end;
                    until RGPLine1.Next = 0;
            end;
        }
        field(60051; "Gate Out"; Code[20])
        {
            TableRelation = "Posted Gate Entry Header"."No." where("Entry Type" = const(Outward), "Location Code" = field("Location Code"));
            DataClassification = CustomerContent;
        }
        field(60052; "Gate IN IG"; Code[20])
        {
            TableRelation = "Posted Gate Entry Header"."No." where("Entry Type" = const(Inward), "Location Code" = field("Location Code"));
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; NRGP)
        {
        }
        key(Key3; "No.", NRGP)
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        TestStatusOpen;
        //Alle Event start
        // IF RGPLineExist THEN BEGIN
        //   RGPLine.SETRANGE("Document Type","Document Type");
        //   RGPLine.SETRANGE("Document No.","No.");
        //   IF RGPLine.FIND('-') THEN BEGIN
        //    REPEAT
        //     RGPLine.DELETE;
        //    UNTIL RGPLine.NEXT=0;
        //   END;
        // END;
        //ALLE Event end
    end;

    trigger OnInsert()
    begin
        //GetRGPSetup;
        RGPSetup.Get();
        if "No." = '' then begin
            TestNoSeries;
            //IG_DS_Before  NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", WorkDate, "No.", "No. Series"); //SSD Sunil Uncomment
            if NoSeriesMgt.AreRelated(GetNoSeriesCode, xRec."No. Series") then
                "No. Series" := xRec."No. Series"
            else
                "No. Series" := GetNoSeriesCode;
            "No." := NoSeriesMgt.GetNextNo("No. Series", WorkDate);
        end;
        InitRecord;
        //VALIDATE("Shipment Date",WORKDATE);
    end;

    trigger OnRename()
    begin
        FieldError("No.", 'can''t be renamed');
    end;

    var
        Text000: label 'Partys Receipt Date';
        Text001: label 'Party''s Shipment Date';
        RGPSetup: Record "SSD AddOn Setup";
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        HasRGPSetup: Boolean;
        ReasonCodes: Record "Reason Code";
        Vendor: Record Vendor;
        Customer: Record Customer;
        Employee: Record Employee;
        Postcode: Record "Post Code";
        Text002: label 'You have changed Expected Receipt Date . \ you want to change in RGP Lines.';
        RGPLine: Record "SSD RGP Line";
        DimensionValue: Record "Dimension Value";
        ResponsibilityCenter: Record "Responsibility Center";
        //SSD UserMgt: Codeunit "SSD User Setup Management";
        ModifyRGPLine: Record "SSD RGP Line";
        PostedGateLine: Record "SSD Posted Gate Line";
        RGPLine1: Record "SSD RGP Line";
        NoSeries: Record "No. Series";

    procedure GetFieldCaption(FieldNumber: Integer): Text[80]
    var
        RGPHeader: Record "SSD RGP Header";
    begin
        if "Document Type" = "document type"::"RGP Inbound" then begin
            case FieldNumber of
                FieldNo("Party Shipment/Rect. No."):
                    exit('6,1');
                FieldNo("Party Shipment/Rect. Date"):
                    exit('4,1');
            end;
        end
        else if "Document Type" = "document type"::"RGP Outbound" then begin
            case FieldNumber of
                FieldNo("Party Shipment/Rect. No."):
                    exit('5,1');
                FieldNo("Party Shipment/Rect. Date"):
                    exit('3,1');
            end;
        end;
    end;

    procedure AssistEdit(RGPHeader: Record "SSD RGP Header"): Boolean
    var
        Text012: Label 'The No. %1 %2 already exists.';
        RGPHeader2: Record "SSD RGP Header";
    begin
        RGPHeader := Rec;
        GetRGPSetup;
        RGPSetup.Get();
        //TestNoSeries;
        //SSD Comment Start Sunil uncomment
        //IG_DS_Before if NoSeriesMgt.SelectSeries(GetNoSeriesCode, RGPHeader."No. Series", "No. Series") then begin
        //     NoSeriesMgt.SetSeries("No.");
        //     Rec := RGPHeader;
        //     exit(true);
        // end;
        if NoSeriesMgt.LookupRelatedNoSeries(GetNoSeriesCode, RGPHeader."No. Series", "No. Series") then begin
            "No." := NoSeriesMgt.GetNextNo("No. Series");
            if RGPHeader2.Get("No.") then
                Error(Text012, "No.");
            Rec := RGPHeader;
            exit(true);
        end;
        //SSD Comment End
    end;

    local procedure GetRGPSetup()
    begin
        if not HasRGPSetup then begin
            RGPSetup.Get;
            HasRGPSetup := true;
        end;
    end;

    local procedure TestNoSeries(): Boolean
    begin
        //CF001 St
        /*
            IF NRGP THEN
              RGPSetup.TESTFIELD("NRGP Out Nos")
            ELSE
              RGPSetup.TESTFIELD("RGP Out Nos");
            */
        /*IF "Responsibility Center"<>'' THEN
              BEGIN
                ResponsibilityCenter.GET("Responsibility Center");
                IF NRGP THEN
                  ResponsibilityCenter.TESTFIELD("NRGP Out Nos")
                ELSE
                  ResponsibilityCenter.TESTFIELD("RGP Out Nos");
              END
            ELSE
              BEGIN
                IF NRGP THEN
                  RGPSetup.TESTFIELD("NRGP Out Nos")
                ELSE
                  RGPSetup.TESTFIELD("RGP Out Nos");
              END;
            */
        //CF001 En
        //if ResponsibilityCenter.Get("Responsibility Center") then;//SSD Sunil Remove
        //ALLE 6.12
        //     if ("Document Type" = "document type"::"RGP Outbound") then begin
        //         // if "Responsibility Center" <> '' then begin
        //         //     if NRGP then
        //         //         ResponsibilityCenter.TestField("NRGP Out Nos")
        //         //     else begin
        //         //         if ("Document SubType" = "document subtype"::"57F4") then
        //         //             ResponsibilityCenter.TestField("57F4 Nos")
        //         //         else
        //         //             ResponsibilityCenter.TestField("RGP Out Nos");
        //         //     end;
        //         // end
        //         RGPSetup.TestField("RGP Out Nos");
        //     end else begin
        //             // if NRGP then
        //             //     RGPSetup.TestField("NRGP Out Nos")
        //             // else
        //             //     RGPSetup.TestField("RGP Out Nos");
        //         //end;
        //     // end
        //     // else
        //     //     if ("Document Type" = "document type"::"RGP Inbound") then begin
        //     //         if "Responsibility Center" <> '' then begin
        //     //             if NRGP then
        //     //                 ResponsibilityCenter.TestField("NRGP In Nos")
        //     //             else
        //     //                 ResponsibilityCenter.TestField("RGP In Nos");
        //     //         end
        //     //         else begin
        //     //             if NRGP then
        //     //                 RGPSetup.TestField("NRGP In Nos")
        //     //             else
        //     //                 RGPSetup.TestField("RGP In Nos");
        //     //         end;
        //     //     end;
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        //CF001 St
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
        //CF001 En
        //     case "Document Type" of
        //         "document type"::"RGP Outbound":
        //             begin
        //                 if not NRGP then begin
        //                     if "Responsibility Center" <> '' then begin
        //                         ResponsibilityCenter.Get("Responsibility Center");
        //                         // //ALLE 6.12
        //                         // if ("Document SubType" = "document subtype"::"57F4") then begin
        //                         //     if ResponsibilityCenter."57F4 Nos" <> '' then
        //                         //         exit(ResponsibilityCenter."57F4 Nos");
        //                         // end
        //                         //ALLE 6.12
        //                         // else begin
        //                         //     if ResponsibilityCenter."RGP Out Nos" <> '' then
        //                         //         exit(ResponsibilityCenter."RGP Out Nos");
        //                         // end;
        //                     end;
        //                     GetRGPSetup;
        //                     exit(RGPSetup."RGP Out Nos");
        //                 end else begin
        //                     if "Responsibility Center" <> '' then begin
        //                         ResponsibilityCenter.Get("Responsibility Center");
        //                         if ResponsibilityCenter."NRGP Out Nos" <> '' then
        //                             exit(ResponsibilityCenter."NRGP Out Nos")
        //                     end;
        //                     GetRGPSetup;
        //                     exit(RGPSetup."NRGP Out Nos");
        //                 end;
        //             end;
        //         "document type"::"RGP Inbound":
        //             begin
        //                 if not NRGP then begin
        //                     if "Responsibility Center" <> '' then begin
        //                         ResponsibilityCenter.Get("Responsibility Center");
        //                         if ResponsibilityCenter."RGP In Nos" <> '' then
        //                             exit(ResponsibilityCenter."RGP In Nos")
        //                     end;
        //                     GetRGPSetup;
        //                     exit(RGPSetup."RGP In Nos");
        //                 end else begin
        //                     if "Responsibility Center" <> '' then begin
        //                         ResponsibilityCenter.Get("Responsibility Center");
        //                         if ResponsibilityCenter."NRGP In Nos" <> '' then
        //                             exit(ResponsibilityCenter."NRGP In Nos")
        //                     end;
        //                     GetRGPSetup;
        //                     exit(RGPSetup."NRGP In Nos");
        //                 end;
        //             end;
        //     end;
        RGPSetup.Get();
        if not NRGP then begin
            if "Document Type" = "Document Type"::"RGP Outbound" then
                exit(RGPSetup."RGP Out Nos")
            else if ("Document Type" = "Document Type"::"RGP Inbound") then exit(RGPSetup."RGP In Nos");
        end
        else begin
            if "Document Type" = "Document Type"::"RGP Outbound" then
                exit(RGPSetup."NRGP Out Nos")
            else if ("Document Type" = "Document Type"::"RGP Inbound") then exit(RGPSetup."NRGP In Nos");
        end;
    end;

    procedure InitRecord()
    begin
        if ("Posting Date" = 0D) then Validate("Posting Date", WorkDate);
        Validate("Document Date", WorkDate);
        Validate("Shipment Date", WorkDate);
        //CF001 St
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
        //CF001 En
        //GetRGPSetup;
        //SSD Comment Start
        if "Document Type" = "document type"::"RGP Outbound" then begin
            //if ResponsibilityCenter.Get("Responsibility Center") then begin
            //ALLE 6.12
            //if "Document SubType" = "document subtype"::"57F4" then begin
            // if ResponsibilityCenter."57F4 Shpt Nos" <> '' then
            //     NoSeriesMgt.SetDefaultSeries("Posted Shpmt. No Series", ResponsibilityCenter."57F4 Shpt Nos")
            // else
            //IG_DS_Before  NoSeriesMgt.SetDefaultSeries("Posted Shpmt. No Series", RGPSetup."Posted RGP Shipment Nos");
            Validate("Posted Shpmt. No Series", RGPSetup."Posted RGP Shipment Nos");

            // if ResponsibilityCenter."57F4 Rcpt Nos" <> '' then
            //     NoSeriesMgt.SetDefaultSeries("Posted Rect. No Series", ResponsibilityCenter."57F4 Rcpt Nos")
            // else
            //IG_DS_Before  NoSeriesMgt.SetDefaultSeries("Posted Rect. No Series", RGPSetup."Posted RGP Receipt Nos");
            Validate("Posted Rect. No Series", RGPSetup."Posted RGP Receipt Nos");

            //end
            //ALLE 6.12
            // else begin
            //     if ResponsibilityCenter."Posted RGP OUT Shipment Nos" <> '' then
            //         NoSeriesMgt.SetDefaultSeries("Posted Shpmt. No Series", ResponsibilityCenter."Posted RGP OUT Shipment Nos")
            //     else
            //         NoSeriesMgt.SetDefaultSeries("Posted Shpmt. No Series", RGPSetup."Posted RGP Shipment Nos");
            //     if ResponsibilityCenter."Posted RGP OUT Receipt Nos" <> '' then
            //         NoSeriesMgt.SetDefaultSeries("Posted Rect. No Series", ResponsibilityCenter."Posted RGP OUT Receipt Nos")
            //     else
            //         NoSeriesMgt.SetDefaultSeries("Posted Rect. No Series", RGPSetup."Posted RGP Receipt Nos");
            // end;
            // end else begin
            //     NoSeriesMgt.SetDefaultSeries("Posted Shpmt. No Series", RGPSetup."Posted RGP Shipment Nos");
            //     NoSeriesMgt.SetDefaultSeries("Posted Rect. No Series", RGPSetup."Posted RGP Receipt Nos");
            // end;
            //Rec."Posted Shpmt. No Series" := 'I-PRGPS';
            // rec."Posted Rect. No Series" := 'I-PRGPR';
        end
        else if ("Document Type" = "Document Type"::"RGP Inbound") then begin
            //IG_DS_Before     // NoSeriesMgt.SetDefaultSeries("Posted Shpmt. No Series", RGPSetup."Posted RGP Shipment Nos");
            //IG_DS_Before     // NoSeriesMgt.SetDefaultSeries("Posted Rect. No Series", RGPSetup."Posted RGP Receipt Nos");
            Validate("Posted Shpmt. No Series", RGPSetup."Posted RGP Shipment Nos");
            Validate("Posted Rect. No Series", RGPSetup."Posted RGP Receipt Nos");
        end;
        //SSD Sunil
        if "Document Type" = "document type"::"RGP Inbound" then begin
            //IG_DS_Before  // NoSeriesMgt.SetDefaultSeries("Posted Shpmt. No Series", RGPSetup."Posted RGP IN Shipment Nos");
            //IG_DS_Before // NoSeriesMgt.SetDefaultSeries("Posted Rect. No Series", RGPSetup."Posted RGP IN Receipt Nos");
            Validate("Posted Shpmt. No Series", RGPSetup."Posted RGP IN Shipment Nos");
            Validate("Posted Rect. No Series", RGPSetup."Posted RGP IN Receipt Nos");
        end
        else begin
            //IG_DS_Before   // NoSeriesMgt.SetDefaultSeries("Posted Shpmt. No Series", RGPSetup."Posted RGP OUT Shipment Nos");
            //IG_DS_Before   // NoSeriesMgt.SetDefaultSeries("Posted Rect. No Series", RGPSetup."Posted RGP OUT Receipt Nos")
            Validate("Posted Shpmt. No Series", RGPSetup."Posted RGP OUT Shipment Nos");
            Validate("Posted Rect. No Series", RGPSetup."Posted RGP OUT Receipt Nos")
        end;
        //CP001
        /*
            if "Document Type" = "document type"::"RGP Inbound" then begin
                if "Responsibility Center" <> '' then begin
                    ResponsibilityCenter.Get("Responsibility Center");
                    if ResponsibilityCenter."Posted RGP IN Shipment Nos" <> '' then
                        NoSeriesMgt.SetDefaultSeries("Posted Shpmt. No Series", ResponsibilityCenter."Posted RGP IN Shipment Nos");
                    if ResponsibilityCenter."Posted RGP IN Receipt Nos" <> '' then
                        NoSeriesMgt.SetDefaultSeries("Posted Rect. No Series", ResponsibilityCenter."Posted RGP IN Receipt Nos");
                end
                else begin
                    GetRGPSetup;
                    if "Posted Shpmt. No Series" = '' then
                        NoSeriesMgt.SetDefaultSeries("Posted Shpmt. No Series", RGPSetup."Posted RGP Shipment Nos");
                    if "Posted Rect. No Series" = '' then
                        NoSeriesMgt.SetDefaultSeries("Posted Rect. No Series", RGPSetup."Posted RGP Receipt Nos");
                end;
                //NRGP:=TRUE;
            end;
            */
        //SSD Comment End
        //CP001
        //Alle VPB "Shortcut Dimension 1 Code":="Responsibility Center";
    end;

    procedure RGPLineExist(): Boolean
    var
        RGPLines: Record "SSD RGP Line";
        P: Record "Purchase Header";
    begin
        RGPLines.SetRange("Document Type", "Document Type");
        RGPLines.SetRange("Document No.", "No.");
        exit(RGPLines.Find('-'));
    end;

    procedure PartyStateExist("Party Type": Option Vendor,Customer,Employee; "Party No.": Code[20]): Boolean
    begin
        case "Party Type" of
            "party type"::Vendor:
                begin
                    Vendor.Get("Party No.");
                    if (Vendor."State Code" <> '') then Error('You can not change it because it alredy exist.');
                end;
            "party type"::Customer:
                begin
                    Customer.Get("Party No.");
                    if (Customer."State Code" <> '') then Error('You can not change it because it alredy exist.');
                end;
        end;
    end;

    procedure PartyCountryExist("Party Type": Option Vendor,Customer,Employee; "Party No.": Code[20]): Boolean
    begin
        case "Party Type" of
            "party type"::Vendor:
                begin
                    Vendor.Get("Party No.");
                    if (Vendor."Country/Region Code" <> '') then Error('You can not change it because it alredy exist.');
                end;
            "party type"::Customer:
                begin
                    Customer.Get("Party No.");
                    if (Customer."Country/Region Code" <> '') then Error('You can not change it because it alredy exist.');
                end;
            "party type"::Employee:
                begin
                    Employee.Get("Party No.");
                    if (Employee."Country/Region Code" <> '') then Error('You can not change it because it alredy exist.');
                end;
        end;
    end;

    local procedure TestStatusOpen()
    begin
        TestField(Status, Status::Open);
    end;

    procedure Release()
    var
        RGPLine: Record "SSD RGP Line";
        Location: Record Location;
    begin
        //*************CEN004.05***********
        TestField("Shortcut Dimension 1 Code");
        //TESTFIELD("Shortcut Dimension 2 Code");
        TestField("Location Code");
        //*************CEN004.05***********
        Status := Status::Released;
        //SSD Sunil New Requirement
        Location.Get("Location Code");
        //SSD Sunil
        //ssd
        RGPLine.Reset;
        RGPLine.SetRange(RGPLine."Document Type", "Document Type");
        RGPLine.SetRange(RGPLine."Document No.", "No.");
        if RGPLine.FindSet then
            repeat
                if Location."Bin Mandatory" then RGPLine.TestField(RGPLine."Bin Code");
            //  RGPLine.TESTFIELD(RGPLine."New Bin Code");
            until RGPLine.Next = 0;
        //ssd
        Modify;
    end;

    procedure Reopen()
    begin
        if Shipped then Error('Ledger entries Already exist');
        Status := Status::Open;
        Modify;
    end;

    procedure TESTIFSHIPPED()
    begin
        TestField(Shipped, false);
    end;
}
