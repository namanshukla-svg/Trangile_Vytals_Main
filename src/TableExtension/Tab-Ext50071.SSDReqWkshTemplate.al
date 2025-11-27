TableExtension 50071 "SSD Req. Wksh. Template" extends "Req. Wksh. Template"
{
    fields
    {
        field(50001; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
    }
    trigger OnAfterDelete()
    var
        UserTemplateSetupLocal: record "SSD User Template Setup";
    begin
        UserTemplateSetupLocal.RESET;
        UserTemplateSetupLocal.SETRANGE(Type, UserTemplateSetupLocal.Type::Requisition);
        UserTemplateSetupLocal.SETRANGE("Template Code", Name);
        UserTemplateSetupLocal.DELETEALL;
    end;
}
