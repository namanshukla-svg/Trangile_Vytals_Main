TableExtension 50001 "SSD Bank Account" extends "Bank Account"
{
    fields
    {
        modify(Blocked)
        {
        trigger OnAfterValidate()
        begin
            if not Blocked then begin
                UserSetup.Get(UserId);
                if not UserSetup."Bank UnBlock Rights" then error(BlockErr);
            end;
        end;
        }
        field(50001; "SSD Responsibility Center"; Code[20])
        {
            Description = 'MSI.RC';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50002; "SSD Bank Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Code';
        }
    }
    trigger OnAfterInsert()
    begin
        begin
            Blocked:=true;
            UpdateRespCenter();
        end;
    end;
    trigger OnBeforeModify()
    begin
        if Blocked = xRec.Blocked then Blocked:=true;
    end;
    /// <summary>
    /// UpdateRespCenter.
    /// </summary>
    procedure UpdateRespCenter()
    begin
        if UserSetup.Get(UserId)then if ResponsibilityCenter.Get(UserSetup."Responsibility Center")then "SSD Responsibility Center":=ResponsibilityCenter.Code;
    end;
    var UserSetup: Record "User Setup";
    ResponsibilityCenter: Record "Responsibility Center";
    BlockErr: Label 'You are not authourized to unblock Bank Account. Contact Administrator';
}
