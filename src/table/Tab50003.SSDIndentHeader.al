Table 50003 "SSD Indent Header"
{
    // "Document Type"===>6
    // // CF001 09.01.2006 added for responsibility center
    Caption = 'Indent Header';
    LookupPageID = "Indent List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = true;
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    IndentSetup.Get;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                end;
                TestStatusOpen;
            end;
        }
        field(10; Remarks; Text[200])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(12; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen();
                //ALLE 171017
                IndentLine1.Reset;
                IndentLine1.SetRange(IndentLine1."Document No.", "No.");
                if IndentLine1.FindSet then
                    repeat
                        IndentLine1."Due Date" := "Due Date";
                        IndentLine1.Modify;
                    until IndentLine1.Next = 0;
                //ALLE 171017
            end;
        }
        field(15; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen();
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(16; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen();
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(17; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
        }
        field(50; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(50001; "Indent Date"; Date)
        {
            Editable = true;
            Caption = 'Indent Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50002; "Indenter ID"; Code[20])
        {
            Editable = true;
            Caption = 'Indenter ID';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //LoginMgt.LookupUserID("Indenter ID");
            end;

            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(50003; "Posting Date"; Date)
        {
            Editable = true;
            Caption = 'Posting Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50004; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestStatusOpen()
            end;
        }
        field(50005; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Released,Pending for Approval,Reject,Close';
            OptionMembers = Open,Released,"Pending for Approval",Reject,Close;
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(50006; "Send Approval"; Boolean)
        {
            Description = '5.51-22-11-11';
            Caption = 'Send Approval';
            DataClassification = CustomerContent;
        }
        field(50007; "Send for Approval"; Boolean)
        {
            Caption = 'Send for Approval';
            DataClassification = CustomerContent;
        }
        field(50008; Approved; Boolean)
        {
            Caption = 'Approved';
            DataClassification = CustomerContent;
        }
        field(50009; "Sender ID"; Code[30])
        {
            Caption = 'Sender ID';
            DataClassification = CustomerContent;
        }
        field(50010; "Approval ID"; Code[30])
        {
            Caption = 'Approval ID';
            DataClassification = CustomerContent;
        }
        field(50011; Rejected; Boolean)
        {
            Caption = 'Rejected';
            DataClassification = CustomerContent;
        }
        field(50012; Post; Boolean)
        {
            Caption = 'Post';
            DataClassification = CustomerContent;
        }
        field(50013; "Issue Slip No."; Code[20])
        {
            Caption = 'Issue Slip No.';
            DataClassification = CustomerContent;
        }
        field(50014; "Indent Order Type"; Option)
        {
            OptionMembers = " ",Inventory,"Fixed Assets",Services;
            DataClassification = CustomerContent;
        }
        field(50015; Amount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("SSD Indent Line"."Line Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
            AccessByPermission = TableData "SSD Indent Line" = R;
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
    begin
        //ALLE Event start
        // IndentLine.SETRANGE("Document No.", "No.");

        // IF IndentLine.FIND('-') THEN
        // IndentLine.DELETEALL;
        //
        // InvtComnt.SETRANGE("Document Type", InvtComnt."Document Type"::"4");
        // InvtComnt.SETRANGE("No.", "No.");
        // IF InvtComnt.FIND('-') THEN
        // InvtComnt.DELETEALL;
        //ALLE Event End
        /* // BIS 1145 <<
            //Dimension
            DocDim.RESET;
            DocDim.SETRANGE("Table ID",DATABASE::"Indent Header");
            DocDim.SETRANGE("Document Type",6);
            DocDim.SETRANGE("Document No.","No.");
            DocDim.DELETEALL;
            DocDim.SETRANGE("Table ID",DATABASE::"Indent Line");
            DocDim.DELETEALL;
            */
        // BIS 1145 >>
    end;

    trigger OnInsert()
    begin
        "Posting Date" := WorkDate;
        "Indent Date" := WorkDate;
        IndentSetup.Get;
        if "No." = '' then begin
            NoSeriesMgt.GetNextNo(GetNoSeriesCode, WorkDate, True);
        end;
        "Indenter ID" := UserId;
    end;

    trigger OnRename()
    begin
        Error(Text002, TableCaption);
    end;

    var
        LoginMgt: Codeunit "User Management";
        NoSeriesMgt: Codeunit "No. Series";
        IndentSetup: Record "SSD AddOn Setup";
        NoSeriesCode: Code[20];
        IndentLine: Record "SSD Indent Line";
        InvtComnt: Record "Inventory Comment Line";
        Text0001: label 'Status must be Open for Indent %1';
        DimMgt: Codeunit DimensionManagement;
        Text002: label 'You cannot rename a %1.';
        ResponsibilityCenter: Record "Responsibility Center";
        HasIndentSetup: Boolean;
        //SSD UserMgt: Codeunit "SSD User Setup Management";
        GLSetup: Record "General Ledger Setup";
        IndentLine1: Record "SSD Indent Line";

    procedure AssistEdit(OldIndentHeader: Record "SSD Indent Header"): Boolean
    begin
        if NoSeriesMgt.LookupRelatedNoSeries(GetNoSeriesCode, xRec."No. Series", "No. Series") then begin
            NoSeriesMgt.GetNextNo("No.");
            exit(true);
        end;
    end;

    procedure TestStatusOpen()
    begin
        if Status <> Status::Open then Error(Text0001, "No.");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    end;

    procedure GetIndentSetup()
    begin
        if not HasIndentSetup then begin
            IndentSetup.Get;
            HasIndentSetup := true;
        end;
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        if "Responsibility Center" <> '' then begin
            ResponsibilityCenter.Get("Responsibility Center");
            if ResponsibilityCenter."Indent No. Series" <> '' then exit(ResponsibilityCenter."Indent No. Series")
        end;
        GetIndentSetup;
        exit(IndentSetup."Indent No. Series");
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20]; Type5: Integer; No5: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        GLSetup.Get;
        "Shortcut Dimension 1 Code" := GLSetup."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := GLSetup."Shortcut Dimension 2 Code";
        SourceCodeSetup.Get;
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;
        TableID[5] := Type5;
        No[5] := No5;
    end;

    procedure IndentLineExist(): Boolean
    begin
        IndentLine.Reset;
        IndentLine.SetRange(IndentLine."Document No.", "No.");
        exit(IndentLine.FindFirst);
    end;
}
