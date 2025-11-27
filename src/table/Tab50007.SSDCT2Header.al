Table 50007 "SSD CT2 Header"
{
    LookupPageID = "CT2 List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "CT2 No."; Code[20])
        {
            Caption = 'CT2 No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "CT2 No." <> xRec."CT2 No." then begin
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "CT2 Date"; Date)
        {
            Caption = 'CT2 Date';
            DataClassification = CustomerContent;
        }
        field(3; "Customer No."; Code[20])
        {
            TableRelation = Customer;
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(4; "Customer PO No."; Code[20])
        {
            Caption = 'Customer PO No.';
            DataClassification = CustomerContent;
        }
        field(5; "Customer PO Date"; Date)
        {
            Caption = 'Customer PO Date';
            DataClassification = CustomerContent;
        }
        field(6; "CT2 Validate Date"; Date)
        {
            Caption = 'CT2 Validate Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "CT2 Validate Date" < "CT2 Date" then Error('CT2 Validate Date must not be less than %1', "CT2 Date");
            end;
        }
        field(7; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(8; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(9; Status; Option)
        {
            OptionMembers = " ",Certified,Expired;
            Caption = 'Status';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Status = Status::Certified then begin
                    TestField("Customer No.");
                    TestField("Customer PO No.");
                    TestField("Customer PO Date");
                    TestField("CT2 Validate Date");
                    CT2Line.Reset;
                    CT2Line.SetRange(CT2Line."CT2 Document No.", "CT2 No.");
                    if CT2Line.FindFirst then
                        repeat
                            CT2Line.TestField("Item No.");
                            CT2Line.TestField(Quantity);
                        until CT2Line.Next = 0
                    else
                        Error('No Line Exists');
                end;
            end;
        }
    }
    keys
    {
        key(Key1; "CT2 No.")
        {
            Clustered = true;
        }
        key(Key2; "Customer No.", "CT2 Validate Date")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if UserSetup.Get(UserId) then begin
            if RespCent.Get(UserSetup."Responsibility Center") then;
        end;
        if "CT2 No." = '' then begin
            TestNoSeries;
            //IG_DS_Before  NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "CT2 Date", "CT2 No.", "No. Series");
            if NoSeriesMgt.AreRelated(GetNoSeriesCode, xRec."No. Series") then
                "No. Series" := xRec."No. Series"
            else
                "No. Series" := GetNoSeriesCode;
            "CT2 No." := NoSeriesMgt.GetNextNo("No. Series");
        end;
        "CT2 Date" := WorkDate;
        "User ID" := UserId;
    end;

    var
        UserSetup: Record "User Setup";
        RespCent: Record "Responsibility Center";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        CT2Line: Record "SSD CT2 Line";

    procedure TestNoSeries(): Boolean
    begin
        RespCent.TestField("CT2 No. Series");
    end;

    procedure GetNoSeriesCode(): Code[10]
    begin
        exit(RespCent."CT2 No. Series");
    end;

    procedure AssistEdit(OldFreihtZone: Record "SSD CT2 Header"): Boolean
    begin
        if UserSetup.Get(UserId) then begin
            if RespCent.Get(UserSetup."Responsibility Center") then;
        end;
        TestNoSeries;
        //IG_DS_Before  // if NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldFreihtZone."No. Series", "No. Series") then begin
        //     TestNoSeries;
        //  NoSeriesMgt.SetSeries("CT2 No.");
        //     exit(true);
        // end;
        if NoSeriesMgt.LookupRelatedNoSeries(GetNoSeriesCode, OldFreihtZone."No. Series", Rec."No. Series") then begin
            TestNoSeries;
            Rec."CT2 No." := NoSeriesMgt.GetNextNo(Rec."No. Series");
            exit(true);
        end;
    end;
}
