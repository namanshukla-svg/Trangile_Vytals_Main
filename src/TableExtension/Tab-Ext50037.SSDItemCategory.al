TableExtension 50037 "SSD Item Category" extends "Item Category"
{
    fields
    {
        field(50002; "Default Storage Location"; Code[10])
        {
            Description = 'CF001';
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
            Caption = 'Default Storage Location';
        }
    }
}
