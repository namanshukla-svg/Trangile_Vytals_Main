Table 50044 "SSD Freight Zone"
{
    LookupPageID = "SSD Freight Zone List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Freight Zone No."; Code[20])
        {
            Caption = 'Freight Zone No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                InventorySetup.Get();
                InventorySetup.TestField("Freight Zone No. Series");
                if "Freight Zone No." <> xRec."Freight Zone No." then begin
                    //PurchSetup.GET;
                    NoSeriesMgt.TestManual(InventorySetup."Freight Zone No. Series");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Creation Date"; Date)
        {
            Editable = false;
            Caption = 'Creation Date';
            DataClassification = CustomerContent;
        }
        field(4; "User ID"; Code[20])
        {
            Editable = false;
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(5; "Freight Zone Rate"; Decimal)
        {
            Caption = 'Freight Zone Rate';
            DataClassification = CustomerContent;
        }
        field(6; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Freight Zone No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        InventorySetup.Get();
        InventorySetup.TestField("Freight Zone No. Series");
        //IG_DS_Before   // if "Freight Zone No." = '' then
        //IG_DS_Before   //     NoSeriesMgt.InitSeries(InventorySetup."Freight Zone No. Series", xRec."No. Series", "Creation Date", "Freight Zone No.", "No. Series");
        if "Freight Zone No." = '' then begin //IG_DS_After
            if NoSeriesMgt.AreRelated(InventorySetup."Freight Zone No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series"
            else
                "No. Series" := InventorySetup."Freight Zone No. Series";
            "Freight Zone No." := NoSeriesMgt.GetNextNo("No. Series", Rec."Creation Date");
        end;
        "Creation Date" := WorkDate;
        "User ID" := UserId;
    end;

    var
        UserSetup: Record "User Setup";
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
    /// <summary>
    /// AssistEdit.
    /// </summary>
    /// <param name="OldFreihtZone">Record "SSD Freight Zone".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure AssistEdit(OldFreihtZone: Record "SSD Freight Zone"): Boolean
    begin
        InventorySetup.Get();
        InventorySetup.TestField("Freight Zone No. Series");
        //IG_DS_Before  // if NoSeriesMgt.SelectSeries(InventorySetup."Freight Zone No. Series", OldFreihtZone."No. Series", "No. Series") then begin
        //     NoSeriesMgt.SetSeries("Freight Zone No.");
        //     exit(true);
        // end;
        if NoSeriesMgt.LookupRelatedNoSeries(InventorySetup."Freight Zone No. Series", OldFreihtZone."No. Series", "No. Series") then begin
            "Freight Zone No." := NoSeriesMgt.GetNextNo("No. Series");
            // if RGPNRGPHeader2.Get(RGPNRGPHeader."No.") then
            //     Error(Text001, RGPNRGPHeader."No.");
            // Rec := RGPNRGPHeader;
            exit(true);
        end;
    end;
}
