Table 50064 "SSD Quality Setup"
{
    Caption = 'Quality Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center Code';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(2; "Rcvd. Sampling Temp. No."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Rcvd. Sampling Temp. No.';
        }
        field(3; "Rcvd. Quality Ord No."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Rcvd. Quality Ord No.';
        }
        field(4; "Manf. Sampling Temp. No."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Manf. Sampling Temp. No.';
        }
        field(5; "Manf. Sub Quality Ord No."; Code[10])
        {
            Caption = 'Manufacturing Sub Quality Ord No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(6; "Routing Sampling Temp. No."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Routing Sampling Temp. No.';
        }
        field(7; "Vendor Eval. Nos."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Vendor Eval. Nos.';
        }
        field(10; "Manf. Quality Ord. No."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Manf. Quality Ord. No.';
        }
        field(12; "Vendor Eval. Temp. Nos."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Vendor Eval. Temp. Nos.';
        }
        field(13; "Sample Test Nos."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Sample Test Nos.';
        }
        field(48; "Rework Location Code"; Code[10])
        {
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
            Caption = 'Rework Location Code';
        }
        field(49; "Scrap Location Code"; Code[10])
        {
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
            Caption = 'Scrap Location Code';
        }
        field(50; "Rejection Location Code"; Code[10])
        {
            TableRelation = Location where("Quality Rejects"=const(true));
            DataClassification = CustomerContent;
            Caption = 'Rejection Location Code';
        }
        field(51; "Return Location Code"; Code[10])
        {
            TableRelation = Location where("Quality Returns"=const(true));
            DataClassification = CustomerContent;
            Caption = 'Return Location Code';
        }
        field(52; "Units Nongoods Insp."; Code[10])
        {
            Caption = 'Units Nongoods Insp.';
            TableRelation = "SSD Amazon Staging";
            DataClassification = CustomerContent;
        }
        field(53; "Units to Scrapping"; Code[10])
        {
            TableRelation = "SSD Amazon Staging";
            DataClassification = CustomerContent;
            Caption = 'Units to Scrapping';
        }
        field(54; "Units to Reclass."; Code[10])
        {
            TableRelation = "SSD Amazon Staging";
            DataClassification = CustomerContent;
            Caption = 'Units to Reclass.';
        }
        field(55; "Units to Reprocess"; Code[10])
        {
            TableRelation = "SSD Amazon Staging";
            DataClassification = CustomerContent;
            Caption = 'Units to Reprocess';
        }
        field(56; "Units to Wrongs"; Code[10])
        {
            Caption = 'Units to Wrongs';
            TableRelation = "SSD Amazon Staging";
            DataClassification = CustomerContent;
        }
        field(59; "Resupply in Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Resupply in Order';
        }
        field(60; "Requisition Worksheet"; Code[10])
        {
            TableRelation = "Req. Wksh. Template" where(Type=const("Req."));
            DataClassification = CustomerContent;
            Caption = 'Requisition Worksheet';
        }
        field(61; "Requisition Sheet Batch"; Code[10])
        {
            TableRelation = "Requisition Wksh. Name".Name where("Worksheet Template Name"=field("Requisition Worksheet"));
            DataClassification = CustomerContent;
            Caption = 'Requisition Sheet Batch';
        }
        field(62; "Quality Source Code"; Code[10])
        {
            TableRelation = "Source Code";
            DataClassification = CustomerContent;
            Caption = 'Quality Source Code';
        }
        field(63; "Return Source Code"; Code[10])
        {
            TableRelation = "Source Code";
            DataClassification = CustomerContent;
            Caption = 'Return Source Code';
        }
        field(64; "Reclass. Location Code"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Reclass. Location Code';
        }
        field(100; "Activate Quality Control Man."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Activate Quality Control Man.';
        }
        field(101; "Rcvd. Sub Quality Ord No."; Code[10])
        {
            Caption = 'Received Sub Quality Ord No.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50000; "Trading Rejection Location"; Code[20])
        {
            TableRelation = Location.Code where("Trading Rejection Location"=filter(true));
            DataClassification = CustomerContent;
            Caption = 'Trading Rejection Location';
        }
    }
    keys
    {
        key(Key1; "Responsibility Center")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    //SSD if "Responsibility Center" = '' then
    //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
    end;
    var
//SSD UserMgt: Codeunit "SSD User Setup Management";
}
