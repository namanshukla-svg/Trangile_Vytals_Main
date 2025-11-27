tableextension 50078 "SSD Return Shipment Line" extends "Return Shipment Line"
{
    fields
    {
        field(50007; "Hold Payment"; Boolean)
        {
            Description = 'HP1.0';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Hold Payment';
        }
    }
}
