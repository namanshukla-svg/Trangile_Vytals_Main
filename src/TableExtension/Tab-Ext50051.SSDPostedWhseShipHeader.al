TableExtension 50051 "SSD Posted Whse. Ship Header" extends "Posted Whse. Shipment Header"
{
    fields
    {
        field(50050; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
    }
}
