codeunit 50000 "WorkCenter Block Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::"Work Center", OnAfterModifyEvent, '', false, false)]
    local procedure OnWorkCenterModify(var Rec: Record "Work Center"; xRec: Record "Work Center"; RunTrigger: Boolean)
    var
        Log: Record "Center Change Log";
    begin
        if Rec.Blocked <> xRec.Blocked then begin
            Log.Init();
            Log."Center Type" := Log."Center Type"::"Work Center";
            Log."Center No." := Rec."No.";
            Log."Center Name" := Rec.Name;
            Log.Action := (Log.Action::Blocked);
            if not Rec.Blocked then
                Log.Action := Log.Action::Unblocked;
            Log."Effective Date-Time" := CurrentDateTime();
            Log."Changed By" := UserId();
            Log.Insert(true);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Machine Center", OnAfterModifyEvent, '', false, false)]
    local procedure OnAfterModifyEvent(var Rec: Record "Machine Center"; var xRec: Record "Machine Center"; RunTrigger: Boolean)
    var
        Log: Record "Center Change Log";
    begin
        if Rec.Blocked <> xRec.Blocked then begin
            Log.Init();
            Log."Center Type" := Log."Center Type"::"Machine Center";
            Log."Center No." := Rec."No.";
            Log."Center Name" := Rec.Name;
            Log.Action := (Log.Action::Blocked);
            if not Rec.Blocked then
                Log.Action := Log.Action::Unblocked;
            Log."Effective Date-Time" := CurrentDateTime();
            Log."Changed By" := UserId();
            Log.Insert(true);
        end;
    end;
}