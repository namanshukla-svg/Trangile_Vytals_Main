TableExtension 50034 tableextension70000249 extends "Insurance Journal Template"
{
    fields
    {
        field(50000; "Responsibility Center"; Code[20])
        {
            Description = 'MSI.RC';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
    }
    trigger OnInsert()
    begin
        IF UserSetup.GET(USERID)THEN BEGIN
            UserSetup.TESTFIELD("Responsibility Center");
            IF ResponsibilityCenter.GET(UserSetup."Responsibility Center")THEN "Responsibility Center":=ResponsibilityCenter.Code;
        END;
    end;
    var UserSetup: Record "User Setup";
    ResponsibilityCenter: Record "Responsibility Center";
}
