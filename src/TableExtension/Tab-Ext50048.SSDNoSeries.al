TableExtension 50048 "SSD No. Series" extends "No. Series"
{
    fields
    {
        field(50050; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(50051; NRGP; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NRGP';
        }
    }
}
