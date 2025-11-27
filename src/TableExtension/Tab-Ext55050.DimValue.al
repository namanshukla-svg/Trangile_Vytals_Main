tableextension 55050 DimValue extends "Dimension Value"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Budgeted Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Incurred Amount"; Decimal)
        {
            Caption = 'Incurred Amount';
            FieldClass = FlowField;
            CalcFormula = sum("G/L Entry".Amount
            where("Posting Date" = filter('2025-04-01 .. 2026-03-31'), "Document No." = filter('@ZDPPDINV*'), "Global Dimension 1 Code" = field(code), Amount = filter(> 0), Ignored = filter(false)));
        }
        field(50002; "Period Start"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Period End"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Calculated Incurred Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        startdate: text;
        enddate: text;
}