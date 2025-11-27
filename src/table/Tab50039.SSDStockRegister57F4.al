Table 50039 "SSD Stock Register 57F4"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; "Challan No."; Code[20])
        {
            TableRelation = if("Challan Type"=filter(Transfer))"Transfer Shipment Header"
            else if("Challan Type"=filter(Subcon))"Delivery Challan Header"
            else if("Challan Type"=filter("Purchase Receipt"))"SSD Stock Register 57F4"."Challan No." where("Challan Type"=filter("Purchase Receipt"));
            DataClassification = CustomerContent;
            Caption = 'Challan No.';

            trigger OnValidate()
            begin
                if "Challan Type" = "challan type"::Transfer then begin
                    TransferShipmentLine.Reset;
                    TransferShipmentLine.SetRange("Document No.", "Challan No.");
                    if TransferShipmentLine.FindFirst then begin
                        "Challan Date":=TransferShipmentLine."Shipment Date";
                        "Responsibility Center":=TransferShipmentLine."Responsibility Center";
                        Validate("Item No.", '');
                        Vendor.Reset;
                        Vendor.SetRange("Vendor Location", TransferShipmentLine."Transfer-to Code");
                        if Vendor.FindFirst then;
                        "Vendor No.":=Vendor."No.";
                        "Vendor Name":=Vendor.Name;
                        "Vendor GST Registration No.":=Vendor."GST Registration No.";
                    end;
                end
                else if "Challan Type" = "challan type"::Subcon then begin
                        Validate("Item No.", '');
                        if DeliveryChallanHeader.Get("Challan No.")then begin
                            "Vendor No.":=DeliveryChallanHeader."Vendor No.";
                            DeliveryChallanHeader.CalcFields("Vendor Name");
                            "Vendor Name":=DeliveryChallanHeader."Vendor Name";
                            Vendor.Reset;
                            Vendor.SetRange("No.", DeliveryChallanHeader."Vendor No.");
                            if Vendor.FindFirst then;
                            "Vendor GST Registration No.":=Vendor."GST Registration No.";
                            "Challan Date":=DeliveryChallanHeader."Posting Date";
                            "Responsibility Center":=DeliveryChallanHeader."Responsibility Center";
                        end;
                    end
                    else if "Challan Type" = "challan type"::"Purchase Receipt" then begin
                            StockRegister57F4Grec.Reset;
                            StockRegister57F4Grec.SetRange("Challan No.", Rec."Challan No.");
                            if StockRegister57F4Grec.FindFirst then;
                            Rec."Challan Date":=StockRegister57F4Grec."Challan Date";
                            Rec."Responsibility Center":=StockRegister57F4Grec."Responsibility Center";
                        //    Rec.VALIDATE("Item No.",StockRegister57F4Grec."No.");
                        //    PurchRcptLineGRec.RESET;
                        //    PurchRcptLineGRec.SETRANGE("Document No.",Rec."Challan No.");
                        // //    PurchRcptLineGRec.SETRANGE("Line No.",Rec."Source Doc. Line No.");
                        //    IF PurchRcptLineGRec.FINDFIRST THEN;
                        //    Rec."Challan Date" := PurchRcptLineGRec."Posting Date";
                        //    Rec."Responsibility Center" := PurchRcptLineGRec."Responsibility Center";
                        //    Rec.VALIDATE("Item No.",PurchRcptLineGRec."No.");
                        //
                        //    IF LocationGRec.GET(PurchRcptLineGRec."Location Code") THEN;
                        //    Rec."Vendor No." := LocationGRec."Subcontractor No.";
                        //    Rec."Vendor Name" := LocationGRec.Name;
                        //    Rec."Vendor GST Registration No." := LocationGRec."Temp GST Registration No.";
                        /*Vendor.RESET;
                            Vendor.SETRANGE("Vendor Location",PurchRcptLineGRec."Location Code");
                            IF Vendor.FINDFIRST THEN;
                            "Vendor No." := Vendor."No.";
                            "Vendor Name" := Vendor.Name;
                            "Vendor GST Registration No." := Vendor."GST Registration No.";*/
                        end
                        else
                        begin
                            "Challan Date":=0D;
                            "Responsibility Center":='';
                            "Vendor No.":='';
                            "Vendor Name":='';
                            "Vendor GST Registration No.":='';
                            Validate("Item No.", '');
                        end;
            end;
        }
        field(3; "Challan Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Challan Date';
        }
        field(4; "Item No."; Code[20])
        {
            //SSD Comment Start _SSD Sunil Use
            TableRelation = if("Challan Type"=filter(Transfer))"Transfer Shipment Line"."Item No." where("Document No."=field("Challan No."))
            else if("Challan Type"=filter(Subcon))"Delivery Challan Line"."Item No." where("Delivery Challan No."=field("Challan No."))
            else if("Challan Type"=filter("Purchase Receipt"))"Purch. Rcpt. Line"."No." where("Document No."=field("Purchase Receipt No."));
            ValidateTableRelation = false;
            //SSD Comment End
            DataClassification = CustomerContent;
            Caption = 'Item No.';

            trigger OnValidate()
            var
                PurchRcptLine: Record "Purch. Rcpt. Line";
            begin
                if "Item No." <> '' then TestField("Challan No.");
                if "Challan Type" = "challan type"::Transfer then begin
                    Item.Reset;
                    Item.SetRange("No.", "Item No.");
                    if Item.FindFirst then begin
                        TransferShipmentLine.Reset;
                        TransferShipmentLine.SetRange("Document No.", "Challan No.");
                        TransferShipmentLine.SetRange("Item No.", "Item No.");
                        if TransferShipmentLine.FindFirst then;
                        "Item Description 1":=TransferShipmentLine.Description;
                        "Item Description 2":=TransferShipmentLine."Description 2";
                        "Unit of Measure Code":=TransferShipmentLine."Unit of Measure Code";
                        "GST Group Code":=TransferShipmentLine."GST Group Code";
                        "HSN Code":=TransferShipmentLine."HSN/SAC Code";
                        "Source Doc. Line No.":=TransferShipmentLine."Line No.";
                        "Actual Shipped Quantity":=TransferShipmentLine.Quantity;
                        Validate("Unit Cost", Item."Unit Cost");
                        StockRegister57F4.Reset;
                        StockRegister57F4.SetRange("Challan No.", "Challan No.");
                        StockRegister57F4.SetRange("Item No.", "Item No.");
                        StockRegister57F4.SetRange("Source Doc. Line No.", "Source Doc. Line No.");
                        StockRegister57F4.SetFilter("Entry No.", '<>%1', "Entry No.");
                        if not StockRegister57F4.FindFirst then Validate("Quantity Shipped", TransferShipmentLine.Quantity);
                    end;
                end
                else if "Challan Type" = "challan type"::Subcon then begin
                        DeliveryChallanLine.Reset;
                        //SSD DeliveryChallanLine.SetRange("Deliver Challan No.", "Challan No.");
                        DeliveryChallanLine.SetRange("Item No.", "Item No.");
                        if DeliveryChallanLine.FindFirst then begin
                            "Item Description 1":=DeliveryChallanLine.Description;
                            "Unit of Measure Code":=DeliveryChallanLine."Unit of Measure";
                            "GST Group Code":=DeliveryChallanLine."GST Group Code";
                            "HSN Code":=DeliveryChallanLine."HSN/SAC Code";
                            "Source Doc. Line No.":=DeliveryChallanLine."Line No.";
                            "Actual Shipped Quantity":=DeliveryChallanLine.Quantity;
                            if Item.Get("Item No.")then Validate("Unit Cost", Item."Unit Cost");
                            "Item Description 2":=Item."Description 2";
                            StockRegister57F4.Reset;
                            StockRegister57F4.SetRange("Challan No.", "Challan No.");
                            StockRegister57F4.SetRange("Item No.", "Item No.");
                            StockRegister57F4.SetRange("Source Doc. Line No.", "Source Doc. Line No.");
                            StockRegister57F4.SetFilter("Entry No.", '<>%1', "Entry No.");
                            if not StockRegister57F4.FindFirst then Validate("Quantity Shipped", DeliveryChallanLine.Quantity);
                        end;
                    end
                    else if "Challan Type" = "challan type"::"Purchase Receipt" then begin
                            TestField("Source Doc. Line No.");
                            Item.Reset;
                            Item.SetRange("No.", "Item No.");
                            if Item.FindFirst then begin
                                PurchRcptLine.Reset;
                                PurchRcptLine.SetRange("Document No.", "Purchase Receipt No.");
                                PurchRcptLine.SetRange("Line No.", "Source Doc. Line No.");
                                PurchRcptLine.SetRange(Type, PurchRcptLine.Type::Item);
                                PurchRcptLine.SetRange("No.", "Item No.");
                                if PurchRcptLine.FindFirst then;
                                "Item Description 1":=PurchRcptLine.Description;
                                "Item Description 2":=PurchRcptLine."Description 2";
                                "Unit of Measure Code":=PurchRcptLine."Unit of Measure Code";
                                "GST Group Code":=PurchRcptLine."GST Group Code";
                                "HSN Code":=PurchRcptLine."HSN/SAC Code";
                                "Actual Shipped Quantity":=PurchRcptLine.Quantity;
                                Validate("Unit Cost", Item."Unit Cost");
                                StockRegister57F4.Reset;
                                StockRegister57F4.SetRange("Challan No.", "Challan No.");
                                StockRegister57F4.SetRange("Item No.", "Item No.");
                                StockRegister57F4.SetRange("Source Doc. Line No.", "Source Doc. Line No.");
                                StockRegister57F4.SetFilter("Entry No.", '<>%1', "Entry No.");
                                if not StockRegister57F4.FindFirst then Validate("Quantity Shipped", PurchRcptLine.Quantity);
                            end;
                        end
                        else
                        begin
                            "Item Description 1":='';
                            "Item Description 2":='';
                            "Unit of Measure Code":='';
                            "GST Group Code":='';
                            "HSN Code":='';
                            Validate("Quantity Shipped", 0);
                            Validate("Unit Cost", 0);
                            "Source Doc. Line No.":=0;
                            "Quantity Received":=0;
                            "Wastage Quantity":=0;
                            "Balance Quantity":=0;
                            "Actual Shipped Quantity":=0;
                            Validate("Line Closed Date", 0D);
                        end;
            end;
        }
        field(5; "Item Description 1"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Description 1';
        }
        field(6; "Item Description 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Description 2';
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No."=field("Item No."));
            DataClassification = CustomerContent;
        }
        field(8; "GST Group Code"; Code[20])
        {
            Caption = 'GST Group Code';
            Editable = false;
            TableRelation = "GST Group";
            DataClassification = CustomerContent;
        }
        field(9; "HSN Code"; Code[8])
        {
            DataClassification = CustomerContent;
            Caption = 'HSN Code';
        }
        field(10; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor No.';
        }
        field(11; "Vendor Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Name';
        }
        field(12; "Vendor Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Document No.';
        }
        field(13; "Quantity Shipped"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Quantity Shipped';

            trigger OnValidate()
            begin
                "Shipped Value":="Quantity Shipped" * "Unit Cost";
            end;
        }
        field(14; "Quantity Received"; Decimal)
        {
            DecimalPlaces = 4: 4;
            DataClassification = CustomerContent;
            Caption = 'Quantity Received';

            trigger OnValidate()
            begin
                TestField("Item No.");
                CalculateBalanceQty('Receive');
                "Received Value":="Quantity Received" * "Unit Cost";
            end;
        }
        field(15; "Wastage Quantity"; Decimal)
        {
            DecimalPlaces = 4: 4;
            DataClassification = CustomerContent;
            Caption = 'Wastage Quantity';

            trigger OnValidate()
            begin
                TestField("Item No.");
                CalculateBalanceQty('Wastage');
            end;
        }
        field(16; "Balance Quantity"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Balance Quantity';

            trigger OnValidate()
            begin
                if "Balance Quantity" <> 0 then Validate("Line Closed Date", 0D)
                else
                    Validate("Line Closed Date", Today);
            end;
        }
        field(17; "Line Closed Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Closed Date';

            trigger OnValidate()
            begin
                if "Line Closed Date" <> 0D then "Challan Age":="Line Closed Date" - "Challan Date"
                else
                    "Challan Age":=0;
                Modify;
                if "Line Closed Date" <> 0D then begin
                    StockRegister57F4.Reset;
                    StockRegister57F4.SetRange("Challan No.", "Challan No.");
                    StockRegister57F4.SetFilter("Line Closed Date", '<>%1', 0D);
                    if StockRegister57F4.FindSet then;
                    if "Challan Type" = "challan type"::Subcon then begin
                        DeliveryChallanLine.Reset;
                        //SSD DeliveryChallanLine.SetRange("Deliver Challan No.", "Challan No.");
                        if DeliveryChallanLine.FindSet then begin
                            //IF DeliveryChallanLine.COUNT = StockRegister57F4.COUNT THEN//Alle 04122020
                            "Challan Closed Date":=Today;
                        //ELSE
                        //"Challan Closed Date" := 0D;
                        end;
                    end
                    else if "Challan Type" = "challan type"::Transfer then begin
                            TransferShipmentLine.Reset;
                            TransferShipmentLine.SetRange("Document No.", "Challan No.");
                            if TransferShipmentLine.FindSet then begin
                                if TransferShipmentLine.Count = StockRegister57F4.Count then "Challan Closed Date":=Today
                                else
                                    "Challan Closed Date":=0D;
                            end;
                        end;
                end
                else
                    "Challan Closed Date":=0D;
            end;
        }
        field(18; "Challan Age"; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Challan Age';
        }
        field(19; "Received by"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Received by';

            trigger OnValidate()
            begin
                TestField("Item No.");
            end;
        }
        field(20; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(21; "Source Doc. Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Doc. Line No.';
        }
        field(22; "Actual Shipped Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Shipped Quantity';
        }
        field(23; "Nature of Jobworker"; Option)
        {
            OptionCaption = ' ,Lamination,Aerosolization,Pouch Making,Cutting,Daubrite Mfg.,Printing,Rewinding,W/O Process Return,Consumable,Others';
            OptionMembers = " ", Lamination, Aerosolization, "Pouch Making", Cutting, "Daubrite Mfg.", Printing, Rewinding, "W/O Process Return", Consumable, Others;
            DataClassification = CustomerContent;
            Caption = 'Nature of Jobworker';
        }
        field(24; "57 F4 Received Copy"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = '57 F4 Received Copy';
        }
        field(25; "57 F4 Received Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = '57 F4 Received Date';
        }
        field(26; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Cost';

            trigger OnValidate()
            begin
                "Shipped Value":="Quantity Shipped" * "Unit Cost";
                "Received Value":="Quantity Received" * "Unit Cost";
            end;
        }
        field(27; "Vendor Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Document Date';
        }
        field(28; "Shipped Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipped Value';
        }
        field(29; "Received Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Received Value';
        }
        field(30; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Posted';
        }
        field(31; "Challan Type"; Option)
        {
            OptionCaption = 'Transfer,Subcon,Purchase Receipt';
            OptionMembers = Transfer, Subcon, "Purchase Receipt";
            DataClassification = CustomerContent;
            Caption = 'Challan Type';

            trigger OnValidate()
            begin
                TestField("Challan No.", '');
            end;
        }
        field(32; "Vendor GST Registration No."; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor GST Registration No.';
        }
        field(33; "Challan Closed Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Challan Closed Date';
        }
        field(50; "Purchase Receipt No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Receipt No.';
        }
        field(51; "Job Work Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Work Location Code';
        }
        field(52; "Purchase Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Vendor No.';
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Challan No.", "Challan Type", "Entry No.")
        {
        }
    }
    trigger OnDelete()
    begin
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then;
        if Posted and not UserSetup."57F4 Edit" then Error('You cannot change or modify saved data')
        else if UserSetup."57F4 Edit" then begin
                if "Challan Type" = "challan type"::Transfer then begin
                    TransferShipmentLine.Reset;
                    TransferShipmentLine.SetRange("Document No.", "Challan No.");
                    TransferShipmentLine.SetRange("Item No.", "Item No.");
                    TransferShipmentLine.SetRange("Line No.", "Source Doc. Line No.");
                    if TransferShipmentLine.FindFirst then begin
                        TransferShipmentLine."57 F4 Posted":=false;
                        TransferShipmentLine.Modify;
                    end;
                end
                else if "Challan Type" = "challan type"::Subcon then begin
                        DeliveryChallanLine.Reset;
                        //SSD DeliveryChallanLine.SetRange("Deliver Challan No.", "Challan No.");
                        DeliveryChallanLine.SetRange("Item No.", "Item No.");
                        DeliveryChallanLine.SetRange("Line No.", "Source Doc. Line No.");
                        if DeliveryChallanLine.FindFirst then begin
                            DeliveryChallanLine."57 F4 Posted":=false;
                            DeliveryChallanLine.Modify;
                        end;
                    end;
            end;
    end;
    trigger OnModify()
    begin
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then;
        if Posted and not UserSetup."57F4 Edit" then Error('You cannot change or modify saved data')
        else if UserSetup."57F4 Edit" then begin
                if "Challan Type" = "challan type"::Transfer then begin
                    TransferShipmentLine.Reset;
                    TransferShipmentLine.SetRange("Document No.", "Challan No.");
                    TransferShipmentLine.SetRange("Item No.", "Item No.");
                    TransferShipmentLine.SetRange("Line No.", "Source Doc. Line No.");
                    if TransferShipmentLine.FindFirst then begin
                        TransferShipmentLine."57 F4 Posted":=false;
                        TransferShipmentLine.Modify;
                    end;
                end
                else if "Challan Type" = "challan type"::Subcon then begin
                        DeliveryChallanLine.Reset;
                        //SSD DeliveryChallanLine.SetRange("Deliver Challan No.", "Challan No.");
                        DeliveryChallanLine.SetRange("Item No.", "Item No.");
                        DeliveryChallanLine.SetRange("Line No.", "Source Doc. Line No.");
                        if DeliveryChallanLine.FindFirst then begin
                            DeliveryChallanLine."57 F4 Posted":=false;
                            DeliveryChallanLine.Modify;
                        end;
                    end;
            end;
    end;
    trigger OnRename()
    begin
        UserSetup.Reset;
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst then;
        if Posted and not UserSetup."57F4 Edit" then Error('You cannot change or modify saved data')
        else if UserSetup."57F4 Edit" then begin
                if "Challan Type" = "challan type"::Transfer then begin
                    TransferShipmentLine.Reset;
                    TransferShipmentLine.SetRange("Document No.", "Challan No.");
                    TransferShipmentLine.SetRange("Item No.", "Item No.");
                    TransferShipmentLine.SetRange("Line No.", "Source Doc. Line No.");
                    if TransferShipmentLine.FindFirst then begin
                        TransferShipmentLine."57 F4 Posted":=false;
                        TransferShipmentLine.Modify;
                    end;
                end
                else if "Challan Type" = "challan type"::Subcon then begin
                        DeliveryChallanLine.Reset;
                        //SSD DeliveryChallanLine.SetRange("Deliver Challan No.", "Challan No.");
                        DeliveryChallanLine.SetRange("Item No.", "Item No.");
                        DeliveryChallanLine.SetRange("Line No.", "Source Doc. Line No.");
                        if DeliveryChallanLine.FindFirst then begin
                            DeliveryChallanLine."57 F4 Posted":=false;
                            DeliveryChallanLine.Modify;
                        end;
                    end;
            end;
    end;
    var TransferShipmentLine: Record "Transfer Shipment Line";
    Item: Record Item;
    StockRegister57F4: Record "SSD Stock Register 57F4";
    Vendor: Record Vendor;
    DeliveryChallanLine: Record "Delivery Challan Line";
    DeliveryChallanHeader: Record "Delivery Challan Header";
    UserSetup: Record "User Setup";
    PurchRcptLineGRec: Record "Purch. Rcpt. Line";
    LocationGRec: Record Location;
    StockRegister57F4Grec: Record "SSD Stock Register 57F4";
    local procedure CalculateBalanceQty(BalanceCheckFor: Text)
    var
        StockRegister57F4: Record "SSD Stock Register 57F4";
        TotalReceivedQty: Decimal;
        TotalWastageQty: Decimal;
        QtyErr: label 'You cannot insert more than %1 Quantity.';
    begin
        Clear(TotalReceivedQty);
        Clear(TotalWastageQty);
        StockRegister57F4.Reset;
        StockRegister57F4.SetRange("Challan No.", "Challan No.");
        StockRegister57F4.SetRange("Item No.", "Item No.");
        StockRegister57F4.SetRange("Source Doc. Line No.", "Source Doc. Line No.");
        StockRegister57F4.SetFilter("Entry No.", '<>%1', "Entry No.");
        if StockRegister57F4.FindSet then repeat TotalReceivedQty+=StockRegister57F4."Quantity Received";
                TotalWastageQty+=StockRegister57F4."Wastage Quantity";
            until StockRegister57F4.Next = 0;
        if BalanceCheckFor = 'Receive' then begin
            if "Actual Shipped Quantity" < TotalReceivedQty + "Quantity Received" + TotalWastageQty + "Wastage Quantity" then Error(QtyErr, Abs((TotalReceivedQty + TotalWastageQty + "Wastage Quantity") - "Actual Shipped Quantity"));
        end
        else if BalanceCheckFor = 'Wastage' then begin
                if "Actual Shipped Quantity" < TotalReceivedQty + "Quantity Received" + TotalWastageQty + "Wastage Quantity" then Error(QtyErr, Abs((TotalReceivedQty + "Quantity Received" + TotalWastageQty) - "Actual Shipped Quantity"));
            end;
        Validate("Balance Quantity", "Actual Shipped Quantity" - (TotalReceivedQty + "Quantity Received" + TotalWastageQty + "Wastage Quantity"));
        Modify;
    end;
}
