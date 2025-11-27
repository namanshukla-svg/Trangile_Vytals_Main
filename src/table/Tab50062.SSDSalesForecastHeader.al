table 50062 "SSD Sales Forecast Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sales Planning No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Planning No.';

            trigger OnValidate()
            begin
                if "Sales Planning No." <> xRec."Sales Planning No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Sales Forecast Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            Caption = 'Customer No.';

            trigger OnValidate()
            begin
                //MESSAGE('ok');
                // SalesForecastLine.RESET;
                // SalesForecastLine.SETRANGE("Sales Document No.","Sales Planning No.");
                // IF SalesForecastLine.FINDFIRST THEN
                //  SalesForecastLine."Customer Code":="Customer No.";
                //SalesForecastLine.VALIDATE("Sales Document No.");
            end;
        }
        field(3; "Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(4; "User Id"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User Id';
        }
        field(5; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
    }
    keys
    {
        key(Key1; "Sales Planning No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Sales Planning No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField("Sales Forecast Nos.");
            //IG_DS_Before  NoSeriesMgt.InitSeries(SalesSetup."Sales Forecast Nos.", xRec."No. Series", 0D, "Sales Planning No.", "No. Series");
            if NoSeriesMgt.AreRelated(SalesSetup."Sales Forecast Nos.", xRec."No. Series") then
                "No. Series" := xRec."No. Series"
            else
                "No. Series" := SalesSetup."Sales Forecast Nos.";
            "Sales Planning No." := NoSeriesMgt.GetNextNo("No. Series");
        end;
        //Date:=WORKDATE;
        "User Id" := UserId;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        SalesForecastLine: Record "SSD Sales Forecast Line";
}
