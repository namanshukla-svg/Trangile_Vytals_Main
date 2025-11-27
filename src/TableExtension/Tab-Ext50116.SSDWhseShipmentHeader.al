TableExtension 50116 "SSD Whse Shipment Header" extends "Warehouse Shipment Header"
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
    trigger OnAfterInsert()
    begin
    //SSD "Responsibility Center":= UserMgt.GetRespCenterFilter;
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
    ResponsibilityCenter: Record "Responsibility Center";
}
