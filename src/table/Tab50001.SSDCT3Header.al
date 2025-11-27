Table 50001 "SSD CT3 Header"
{
    LookupPageID = "CT3 List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "CT3 No."; Code[20])
        {
            Caption = 'CT3 No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "CT3 No." <> xRec."CT3 No." then begin
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "CT3 Date"; Date)
        {
            Caption = 'CT3 Date';
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
        field(6; "CT3 Validate Date"; Date)
        {
            Caption = 'CT3 Validate Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "CT3 Validate Date" < "CT3 Date" then Error('CT3 Validate Date must not be less than %1', "CT3 Date");
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
                    TestField("CT3 Validate Date");
                    CT3Line.Reset;
                    CT3Line.SetRange(CT3Line."CT3 Document No.", "CT3 No.");
                    if CT3Line.FindFirst then
                        repeat
                            CT3Line.TestField("Item No.");
                            CT3Line.TestField(Quantity);
                        until CT3Line.Next = 0
                    else
                        Error('No Line Exists');
                end;
            end;
        }
    }
    keys
    {
        key(Key1; "CT3 No.")
        {
            Clustered = true;
        }
        key(Key2; "Customer No.", "CT3 Validate Date")
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
        if "CT3 No." = '' then begin
            TestNoSeries;
            //IG_DS_Before  NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "CT3 Date", "CT3 No.", "No. Series");
            if NoSeriesMgt.AreRelated(GetNoSeriesCode, xRec."No. Series") then
                "No. Series" := xRec."No. Series"
            else
                "No. Series" := GetNoSeriesCode;
            "CT3 No." := NoSeriesMgt.GetNextNo("No. Series");
        end;
        "CT3 Date" := WorkDate;
        "User ID" := UserId;
    end;

    var
        UserSetup: Record "User Setup";
        RespCent: Record "Responsibility Center";
        //IG_DS_Before NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        CT3Line: Record "SSD CT3 Line";

    procedure TestNoSeries(): Boolean
    begin
        RespCent.TestField("CT3 No. Series");
    end;

    procedure GetNoSeriesCode(): Code[10]
    begin
        exit(RespCent."CT3 No. Series");
    end;

    procedure AssistEdit(OldFreihtZone: Record "SSD CT3 Header"): Boolean
    begin
        if UserSetup.Get(UserId) then begin
            if RespCent.Get(UserSetup."Responsibility Center") then;
        end;
        TestNoSeries;
        //IG_DS_Before // if NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldFreihtZone."No. Series", "No. Series") then begin
        //     TestNoSeries;
        //     NoSeriesMgt.SetSeries("CT3 No.");
        //     exit(true);
        // end;
        if NoSeriesMgt.LookupRelatedNoSeries(GetNoSeriesCode, OldFreihtZone."No. Series", Rec."No. Series") then begin
            TestNoSeries;
            Rec."CT3 No." := NoSeriesMgt.GetNextNo(Rec."No. Series");
            exit(true);
        end;
    end;
}
