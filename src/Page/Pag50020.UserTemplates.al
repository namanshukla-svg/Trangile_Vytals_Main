Page 50020 "User Templates"
{
    Editable = false;
    PageType = List;
    SourceTable = "SSD User Template Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Template Code"; Rec."Template Code")
                {
                    ApplicationArea = All;
                    Lookup = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        DescriptionOnFormat(Format(Description));
    end;
    var Description: Text[30];
    GenJnlTemplate: Record "Gen. Journal Template";
    ItemJnlTemplate: Record "Item Journal Template";
    ReqWorksheetTemplate: Record "Req. Wksh. Template";
    local procedure DescriptionOnFormat(Text: Text[1024])
    begin
        case Rec.Type of Rec.Type::General: begin
            GenJnlTemplate.Get(Rec."Template Code");
            Text:=GenJnlTemplate.Description;
        end;
        Rec.Type::Item: begin
            ItemJnlTemplate.Get(Rec."Template Code");
            Text:=ItemJnlTemplate.Description;
        end;
        Rec.Type::Requisition: begin
            ReqWorksheetTemplate.Get(Rec."Template Code");
            Text:=ReqWorksheetTemplate.Description;
        end;
        end;
    end;
}
