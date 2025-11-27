TableExtension 50079 "SSD Routing Header" extends "Routing Header"
{
    fields
    {
        field(50001; "Routing Category"; Option)
        {
            Description = 'TR for diff Normal or Tool Room';
            OptionCaption = 'Normal,Tool';
            OptionMembers = Normal, Tool;
            DataClassification = CustomerContent;
            Caption = 'Routing Category';

            trigger OnValidate()
            var
                RoutingLineLocal: Record "Routing Line";
                CapacityLdgrEntryLocal: Record "Capacity Ledger Entry";
            begin
                //CF001 St
                if "Version Nos." <> '' then Error(Text003)
                else
                begin
                    CapacityLdgrEntryLocal.Reset;
                    CapacityLdgrEntryLocal.SetRange("Routing No.", "No.");
                    if CapacityLdgrEntryLocal.Find('-')then Error(Text004);
                    RoutingLineLocal.Reset;
                    RoutingLineLocal.SetRange("Routing No.", "No.");
                    if RoutingLineLocal.Find('-')then repeat RoutingLineLocal."Routing Category":="Routing Category";
                            RoutingLineLocal.Modify;
                        until RoutingLineLocal.Next = 0;
                end;
            //CF001 En
            end;
        }
        field(50050; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50051; "Work Center"; Code[20])
        {
            Description = 'CEN001';
            TableRelation = "Work Center";
            DataClassification = CustomerContent;
            Caption = 'Work Center';
        }
        field(50052; "Source No."; Code[20])
        {
            Description = 'CEN002';
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Source No.';

            trigger OnValidate()
            begin
                if Status <> 1 then begin
                    Item.SetRange(Item."No.", "Source No.");
                    if Item.Find('-')then begin
                        "Search Description":=Item.Description;
                        Description:=Item.Description;
                        "Description 2":=Item."No. 2";
                    end;
                end
                else
                begin
                    "Source No.":=xRec."Source No.";
                    Message('Status must not be Certified');
                end;
            end;
        }
    }
    //Unsupported feature: Code Modification on "OnInsert".
    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    MfgSetup.GET;
    IF "No." = '' THEN BEGIN
      MfgSetup.TESTFIELD("Routing Nos.");
      NoSeriesMgt.InitSeries(MfgSetup."Routing Nos.",xRec."No. Series",0D,"No.","No. Series");
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    MfgSetup.GET;
    //CF001 St
    "Responsibility Center":=UserMgt.GetRespCenterFilter;
    //CF001 En

    //CF001 St
    {
    #2..5
    }
    IF "Responsibility Center"<>'' THEN
      BEGIN
        ResponsibilityCenter.GET("Responsibility Center");
        IF "No." = '' THEN
          ResponsibilityCenter.TESTFIELD("Routing Nos.");
        NoSeriesMgt.InitSeries(ResponsibilityCenter."Routing Nos.",xRec."No. Series",0D,"No.","No. Series");
      END
    ELSE BEGIN
      IF "No." = '' THEN BEGIN
        MfgSetup.TESTFIELD("Routing Nos.");
        NoSeriesMgt.InitSeries(MfgSetup."Routing Nos.",xRec."No. Series",0D,"No.","No. Series");
      END;
                END;
    */
    //end;
    var Text003: label 'One or more Versions are available; Modification is not possible';
    Text004: label 'One or more Ledger Entries are available; Modification is not possible';
    UserMgt: Codeunit "SSD User Setup Management";
    ResponsibilityCenter: Record "Responsibility Center";
    Item: Record Item;
}
