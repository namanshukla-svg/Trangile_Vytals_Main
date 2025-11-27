tableextension 50122 "SSD Item Charge" extends "Item Charge"
{
    fields
    {
        field(50000; UOM; Code[20])
        {
            Caption = 'UOM';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(50001; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(50002; "Description 3"; Text[300])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 3';
        }
    }
    var Item: Record Item;
}
