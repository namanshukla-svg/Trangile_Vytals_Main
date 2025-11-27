TableExtension 50046 "SSD Location" extends Location
{
    fields
    {
        field(50000; "Excise Invoice Nos."; Code[20])
        {
            Description = 'CF001';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Excise Invoice Nos.';
        }
        field(50010; "Quality Returns"; Boolean)
        {
            Caption = 'Quality Returns';
            Description = 'QLT';
            DataClassification = CustomerContent;
        }
        field(50011; "Quality Rejects"; Boolean)
        {
            Description = 'QLT';
            DataClassification = CustomerContent;
            Caption = 'Quality Rejects';
        }
        field(50028; "RG No. Series"; Code[10])
        {
            Description = 'SM_ML239';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'RG No. Series';
        }
        field(50050; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50051; "Address 3"; Text[30])
        {
            Description = 'CF001';
            DataClassification = CustomerContent;
            Caption = 'Address 3';
        }
        field(50052; "Transfer Receipt No. Series"; Code[20])
        {
            Description = 'CEN004.03';
            TableRelation = "No. Series".Code where("Responsibility Center" = field("Responsibility Center"));
            DataClassification = CustomerContent;
            Caption = 'Transfer Receipt No. Series';
        }
        field(50053; "Transfer Ship No. Series"; Code[20])
        {
            Description = 'CEN004.03';
            TableRelation = "No. Series".Code where("Responsibility Center" = field("Responsibility Center"));
            DataClassification = CustomerContent;
            Caption = 'Transfer Ship No. Series';
        }
        field(54501; "Temp JW Location"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Temp JW Location';
        }
        field(54502; "Temp State Code"; Code[10])
        {
            TableRelation = State;
            DataClassification = CustomerContent;
            Caption = 'Temp State Code';
        }
        field(54503; "Temp GST Registration No."; Code[15])
        {
            Caption = 'GST Registration No.';
            //TableRelation = "GST Registration Nos." where("State Code" = field("Temp State Code")); //SSD Required by Hemant
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                GSTRegistrationNos: Record "GST Registration Nos.";
            begin
            end;
        }
        field(60002; "Trading Sale Excise No. Series"; Code[20])
        {
            Description = 'CE_AA002';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Trading Sale Excise No. Series';
        }
        field(60003; "FG Store"; Boolean)
        {
            Description = 'CE_AA007.08';
            DataClassification = CustomerContent;
            Caption = 'FG Store';
        }
        field(60004; "Trading Rejection Location"; Boolean)
        {
            Description = 'CMLTEST-026';
            DataClassification = CustomerContent;
            Caption = 'Trading Rejection Location';

            trigger OnValidate()
            begin
                if "Trading Rejection Location" then "Trading Location" := false;
            end;
        }
        field(60005; "PAN No."; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'PAN No.';
        }
        field(60006; "Phy. Bin Required"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Phy. Bin Required';
        }
        //IG_DS
        field(60007; "Blocked"; Boolean)
        {
            DataClassification = ToBeClassified;
            // Caption = 'Phy. Bin Required';
        }
        //IG_DS
    }
    trigger OnAfterInsert()
    begin
        //SSD IF "Responsibility Center" = '' THEN
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
    end;

    var
        UserMgt: Codeunit "SSD User Setup Management";
}
