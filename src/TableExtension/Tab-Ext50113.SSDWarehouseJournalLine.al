TableExtension 50113 "SSD Warehouse Journal Line" extends "Warehouse Journal Line"
{
    fields
    {
        field(50001; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center".Code;
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
    }
    trigger OnAfterInsert()
    begin
    //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
    end;
    var UserMgt: Codeunit "SSD User Setup Management";
}
