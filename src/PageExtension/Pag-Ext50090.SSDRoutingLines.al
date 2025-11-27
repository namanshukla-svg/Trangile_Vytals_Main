PageExtension 50090 "SSD Routing Lines" extends "Routing Lines"
{
    layout
    {
        addafter("No.")
        {
            field("Work Center No."; Rec."Work Center No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Routing Link Code")
        {
            field("Quality Required"; Rec."Quality Required")
            {
                ApplicationArea = All;
            }
            field("Quality Sampling No."; Rec."Quality Sampling No.")
            {
                ApplicationArea = All;
            }
        }
    }
    var RoutingHeader: Record "Routing Header";
    UserMgt: Codeunit "SSD User Setup Management";
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type:=xRec.Type;
        IF RoutingHeader.GET(Rec."Routing No.")then Rec."Routing Category":=RoutingHeader."Routing Category";
    end;
}
