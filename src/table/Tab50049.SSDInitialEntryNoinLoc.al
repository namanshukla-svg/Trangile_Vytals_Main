Table 50049 "SSD Initial Entry No. in Loc"
{
    Caption = 'Initial Entry No. in Loc.';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObj."Object ID" where("Object Type"=const(Table));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalcFields("Table Name");
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Distrib. Loc. Code"; Code[10])
        {
            Caption = 'Distrib. Loc. Code';
            TableRelation = Location;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalcFields("Distrib. Loc. Descr.");
            end;
        }
        field(4; "Initial Entry No."; Integer)
        {
            Caption = 'Initial Entry No.';
            DataClassification = CustomerContent;
        }
        field(5; "Table Name"; Text[30])
        {
            CalcFormula = lookup(AllObj."Object Name" where("Object Type"=const(Table), "Object ID"=field("Table ID")));
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Distrib. Loc. Descr."; Text[30])
        {
            CalcFormula = lookup(Location.Name where(Code=field("Distrib. Loc. Code")));
            Caption = 'Distrib. Loc. Descr.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Primary Key"; Text[50])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Primary Key":=CombineTableKey(2, IntegerToStr("Table ID"), IntegerToStr("Line No."), '', '', '');
            end;
        }
    }
    keys
    {
        key(Key1; "Table ID", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Table ID", "Distrib. Loc. Code", "Line No.")
        {
        }
        key(Key3; "Table ID", "Initial Entry No.")
        {
        }
        key(Key4; "Distrib. Loc. Code")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Line No." = 0 then begin
            Clear(InitEntryNoInLoc);
            InitEntryNoInLoc.SetRange("Table ID", "Table ID");
            if InitEntryNoInLoc.Find('+')then "Line No.":=InitEntryNoInLoc."Line No." + 10000
            else
                "Line No.":=10000;
        end;
    end;
    var InitEntryNoInLoc: Record "SSD Initial Entry No. in Loc";
    Text008: label 'A primary table key can only have 5 fields.';
    procedure GetCurrLocInitEntryNo(TableID: Integer): Integer var
        BackOfficeSetup: Record "Company Information";
    begin
        BackOfficeSetup.Get;
        Clear(InitEntryNoInLoc);
        InitEntryNoInLoc.SetCurrentkey("Table ID", "Distrib. Loc. Code");
        InitEntryNoInLoc.SetRange("Table ID", TableID);
        InitEntryNoInLoc.SetRange("Distrib. Loc. Code", BackOfficeSetup."Location Code");
        if InitEntryNoInLoc.Find('-')then if InitEntryNoInLoc."Initial Entry No." <> 0 then exit(InitEntryNoInLoc."Initial Entry No.");
        exit(1);
    end;
    procedure CombineTableKey(NoOfValues: Integer; Val1: Text[250]; Val2: Text[250]; Val3: Text[250]; Val4: Text[250]; Val5: Text[250]): Text[250]var
        SeparateChr: Text[1];
    begin
        SeparateChr:='±';
        case NoOfValues of 0: exit('');
        1: exit(Val1);
        2: exit(Val1 + SeparateChr + Val2);
        3: exit(Val1 + SeparateChr + Val2 + SeparateChr + Val3);
        4: exit(Val1 + SeparateChr + Val2 + SeparateChr + Val3 + SeparateChr + Val4);
        5: exit(Val1 + SeparateChr + Val2 + SeparateChr + Val3 + SeparateChr + Val4 + SeparateChr + Val5);
        else
            Error(Text008);
        end;
    end;
    procedure IntegerToStr(Int: Integer): Text[50]begin
        exit(DelChr(Format(Int), '=', ',.'));
    end;
}
