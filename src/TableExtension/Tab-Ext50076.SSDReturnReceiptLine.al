tableextension 50076 "SSD Return Receipt Line" extends "Return Receipt Line"
{
    fields
    {
        field(50030; "Revised Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Revised Shipment Date';
        }
    }
}
