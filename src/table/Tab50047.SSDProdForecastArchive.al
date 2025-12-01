Table 50047 "SSD Prod Forecast Archive"
{
    Caption = 'Production Forecast Archive';
    DrillDownPageID = "Demand Forecast Entries";
    LookupPageID = "Demand Forecast Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Production Forecast Name"; Code[10])
        {
            Caption = 'Production Forecast Name';
            TableRelation = "Production Forecast Name";
            DataClassification = CustomerContent;
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(4; "Forecast Date"; Date)
        {
            Caption = 'Forecast Date';
            DataClassification = CustomerContent;
        }
        field(5; "Forecast Quantity"; Decimal)
        {
            Caption = 'Forecast Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Forecast Quantity (Base)" := "Forecast Quantity" * "Qty. per Unit of Measure";
            end;
        }
        field(6; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ItemUnitofMeasure.Get("Item No.", "Unit of Measure Code");
                "Qty. per Unit of Measure" := ItemUnitofMeasure."Qty. per Unit of Measure";
                "Forecast Quantity" := "Forecast Quantity (Base)" / "Qty. per Unit of Measure";
            end;
        }
        field(7; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "Forecast Quantity (Base)"; Decimal)
        {
            Caption = 'Forecast Quantity (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Unit of Measure Code" = '' then begin
                    Item.Get("Item No.");
                    "Unit of Measure Code" := Item."Sales Unit of Measure";
                    ItemUnitofMeasure.Get("Item No.", "Unit of Measure Code");
                    "Qty. per Unit of Measure" := ItemUnitofMeasure."Qty. per Unit of Measure";
                end;
                Validate("Unit of Measure Code");
            end;
        }
        field(10; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(12; "Component Forecast"; Boolean)
        {
            Caption = 'Component Forecast';
            DataClassification = CustomerContent;
        }
        field(13; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(14; "Suggested Dealers PO Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Suggested Dealers PO Qty';
        }
        field(15; "Actual Dealers PO Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Dealers PO Qty';
        }
        field(16; "Sales MRP"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales MRP';
        }
        field(17; "Expected Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Receipt Date';
        }
        field(18; ISCRMInserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ISCRMInserted';
        }
        field(19; ISUpdated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ISUpdated';
        }
        field(20; ISCRMException; Boolean)
        {
            DataClassification = CustomerContent;
            //Atul::01122025
            Caption = 'Exception Occurred';
            //Atul::01122025
        }
        field(21; ExceptionDetails; Text[30])
        {
            DataClassification = CustomerContent;
            //Atul::01122025
            Caption = 'Exception Details';
            //Atul::01122025
        }
        field(22; "Suggested Order Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Suggested Order Date';
        }
        field(23; "Version No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Version No.';
        }
        field(24; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Date';
        }
        field(25; "Customer Code"; Code[30])
        {
            TableRelation = Customer;
            DataClassification = CustomerContent;
            Caption = 'Customer Code';

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Reset;
                if Customer.Get("Customer Code") then "Customer Name" := Customer.Name;
            end;
        }
        field(26; "Customer Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Name';
        }
    }
    keys
    {
        key(Key1; "Production Forecast Name", "Entry No.", "Version No.")
        {
            Clustered = true;
        }
        key(Key2; "Production Forecast Name", "Item No.", "Location Code", "Forecast Date", "Component Forecast")
        {
            SumIndexFields = "Forecast Quantity (Base)";
        }
        key(Key3; "Production Forecast Name", "Item No.", "Component Forecast", "Forecast Date", "Location Code")
        {
            SumIndexFields = "Forecast Quantity (Base)";
        }
        key(Key4; "Production Forecast Name", "Version No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    var
        ForecastEntry: Record "Production Forecast Entry";
    begin
        TestField("Forecast Date");
        TestField("Production Forecast Name");
        LockTable;
        if "Entry No." = 0 then if ForecastEntry.FindLast then "Entry No." := ForecastEntry."Entry No." + 1;
        PlanningAssignment.AssignOne("Item No.", '', "Location Code", "Forecast Date");
    end;

    trigger OnModify()
    begin
        PlanningAssignment.AssignOne("Item No.", '', "Location Code", "Forecast Date");
    end;

    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Item: Record Item;
        PlanningAssignment: Record "Planning Assignment";
}
