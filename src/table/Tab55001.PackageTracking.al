table 55001 "Package Tracking"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Source ID"; Code[20])
        {
            Caption = 'Source ID';
        }
        field(4; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Lot No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Package No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                WarehouseRcptLine: Record "Warehouse Receipt Line";
                PackingTracking: Record "Package Tracking";
                PackingTrackingXRec: Record "Package Tracking";
                TotalQuantity: Decimal;
                TotalQuantityA: Decimal;
                TotalQuantityB: Decimal;
            begin
                Clear(TotalQuantity);
                Clear(TotalQuantityA);
                PackingTrackingXRec.Reset();
                PackingTrackingXRec.SetRange("Entry Type", PackingTrackingXRec."Entry Type"::Purchase);
                PackingTrackingXRec.SetRange("Document No.", Rec."Document No.");
                PackingTrackingXRec.SetRange("Item No.", Rec."Item No.");
                PackingTrackingXRec.SetFilter(Quantity, '>%1', 0);
                if PackingTrackingXRec.FindFirst() then begin
                    PackingTrackingXRec.CalcSums(Quantity);
                    TotalQuantityA := PackingTrackingXRec.Quantity;
                end;

                Clear(TotalQuantityB);
                PackingTrackingXRec.Reset();
                PackingTrackingXRec.SetRange("Entry Type", PackingTrackingXRec."Entry Type"::Purchase);
                PackingTrackingXRec.SetRange("Document No.", Rec."Document No.");
                PackingTrackingXRec.SetRange("Item No.", Rec."Item No.");
                PackingTrackingXRec.SetFilter(Quantity, '>%1', 0);
                if PackingTrackingXRec.FindFirst() then
                    repeat
                        if PackingTrackingXRec."Entry No." = Rec."Entry No." then
                            TotalQuantityB := TotalQuantityA - PackingTrackingXRec.Quantity;
                    until PackingTrackingXRec.Next() = 0;

                TotalQuantity := TotalQuantityB + Rec.Quantity;

                PackingTracking.Reset();
                PackingTracking.SetRange("Entry Type", PackingTracking."Entry Type"::Purchase);
                PackingTracking.SetRange("Document No.", Rec."Document No.");
                PackingTracking.SetRange("Item No.", Rec."Item No.");
                PackingTracking.SetFilter(Quantity, '>%1', 0);
                if PackingTracking.FindFirst() then begin
                    WarehouseRcptLine.Reset();
                    WarehouseRcptLine.SetRange("Source No.", PackingTracking."Source ID");
                    WarehouseRcptLine.SetRange("Item No.", PackingTracking."Item No.");
                    WarehouseRcptLine.SetRange("Line No.", PackingTracking."Source Ref. No.");
                    if WarehouseRcptLine.FindFirst() then
                        if ((WarehouseRcptLine."Qty. to Receive") * (WarehouseRcptLine."Qty. per Unit of Measure")) <> TotalQuantity then
                            Error('Pack quantity cannot exceed original total quantity');
                end;

            end;
        }
        field(8; "Pack Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Gross Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Source Ref. No."; Integer)
        {
            Caption = 'Source Ref. No.';
        }
        field(12; "Location Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Entry Type"; Enum "Item Ledger Entry Type")
        {
            Caption = 'Entry Type';
        }
        field(14; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(15; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(16; "Utilized"; Boolean)
        {
            Caption = 'Utilized';
            Editable = false;
        }
        field(17; "Assign packet"; Boolean)
        {
            Caption = 'Assign Packet';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."Assign packet" then
                    Rec."User ID" := UserId
                else
                    Rec."User ID" := '';
            end;
        }
        field(18; "User ID"; Text[100])
        {
            Caption = 'User ID';
            Editable = false;
        }
        field(19; "Document No."; Code[20])
        {
            Editable = false;
        }
    }

    keys
    {
        key(PK1; "Entry No.")
        {
            Clustered = true;
        }
        key(pk2; "Lot No.", "Package No.")
        {

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
        fieldgroup(DropDown; "Package No.", "Lot No.")
        {

        }
        fieldgroup(Brick; "Package No.", "Lot No.")
        {

        }

    }

    var
        r: Record 337;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}