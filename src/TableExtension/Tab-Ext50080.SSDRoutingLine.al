TableExtension 50080 "SSD Routing Line" extends "Routing Line"
{
    fields
    {
        modify("No.")
        {
        trigger OnAfterValidate()
        begin
        //SSD IF "Responsibility Center" = '' THEN
        //SSD "Responsibility Center" := UserMgt.GetRespCenterFilter;
        end;
        }
        field(50001; "Routing Category"; Option)
        {
            Description = 'TR diff for Normal or Tool Room';
            OptionCaption = 'Normal,Tool';
            OptionMembers = Normal, Tool;
            DataClassification = CustomerContent;
            Caption = 'Routing Category';
        }
        field(50002; "Quality Required"; Boolean)
        {
            Caption = 'Quality Required';
            Description = 'QA-013/014';
            DataClassification = CustomerContent;
        }
        field(50010; "Priority Alternative"; Integer)
        {
            Caption = 'Priority Alternative';
            Description = 'QLT';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Type, Type::"Machine Center")end;
        }
        field(50011; "Quality Sampling No."; Code[20])
        {
            Caption = 'Quality Sampling No.';
            Description = 'QLT';
            TableRelation = "SSD Sampling Temp. Header" where("Template Type"=const(Manufacturing));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Quality Sampling No." <> '' then TestField("Quality Required", true);
            end;
        }
        field(50050; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
    }
    var UserMgt: Codeunit "SSD User Setup Management";
}
