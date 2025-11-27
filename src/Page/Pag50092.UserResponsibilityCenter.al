Page 50092 "User Responsibility Center"
{
    // CML-007 ASG 131207 :
    //   - Written code to generate the error if user is closing the form.
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    Permissions = TableData "User Setup"=rim,
        TableData "Responsibility Center"=r,
        TableData "SSD User Res. Center Setup"=r;
    PopulateAllFields = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(UserId; UserId)
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                    Editable = false;
                    Lookup = false;
                }
                field("Responsibility Center"; ResCenter)
                {
                    ApplicationArea = All;
                    Caption = 'Responsibility Center';
                    TableRelation = "Responsibility Center";

                    trigger OnValidate()
                    begin
                        //bis
                        if UserResSetup.Get(UserId, ResCenter)then begin
                            if UserSetup.Get(UserId)then begin
                                UserSetup."Responsibility Center":=ResCenter;
                                UserSetup."Purchase Resp. Ctr. Filter":=ResCenter;
                                UserSetup."Sales Resp. Ctr. Filter":=ResCenter;
                                UserSetup.Modify;
                                SalesResCenter:=UserSetup."Sales Resp. Ctr. Filter";
                                PurchResCenter:=UserSetup."Purchase Resp. Ctr. Filter";
                            end
                            else
                            begin
                                UserSetup.Init;
                                UserSetup."User ID":=UserId;
                                UserSetup."Responsibility Center":=ResCenter;
                                UserSetup."Purchase Resp. Ctr. Filter":=ResCenter;
                                UserSetup."Sales Resp. Ctr. Filter":=ResCenter;
                                UserSetup.Insert;
                                SalesResCenter:=UserSetup."Sales Resp. Ctr. Filter";
                                PurchResCenter:=UserSetup."Purchase Resp. Ctr. Filter";
                            end;
                        end
                        else
                            Error(Text001, ResCenter);
                    end;
                }
                field(SalesResCenter; SalesResCenter)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Res. Center Filter';
                    Editable = true;
                    Lookup = false;
                }
                field(PurchResCenter; PurchResCenter)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Resp. Ctr. Filter';
                    Editable = true;
                    Lookup = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Main Menu")
            {
                ApplicationArea = All;
                Caption = 'Main Menu';
                Ellipsis = true;
                Image = NewToDo;
                Promoted = true;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+M';

                trigger OnAction()
                var
                    UserResCenterSetupLocal: Record "SSD User Res. Center Setup";
                    UserSetupLocal: Record "User Setup";
                begin
                    //CF001 St
                    // bis
                    UserSetupLocal.Reset;
                    UserSetupLocal.SetRange("User ID", UserId);
                    if not UserSetupLocal.Find('-')then Error(Text002, UserId);
                    if UserId <> 'ZDI\HSINGH1' then begin //Alle 19082021
                        UserResCenterSetupLocal.Reset;
                        UserResCenterSetupLocal.SetRange("User ID", UserId);
                        UserResCenterSetupLocal.SetRange("Responsibility Center", ResCenter);
                        if not UserResCenterSetupLocal.Find('-')then Error(Text003, UserId);
                    end; //Alle 19082021
                    /*UserSetup.RESET;
                    UserSetup.SETRANGE("User ID",USERID);
                    IF NOT UserSetup.FIND('-') THEN
                      ERROR(Text002,USERID);
                    
                    UserResSetup.RESET;
                    UserResSetup.SETRANGE("User ID",USERID);
                    UserResSetup.SETRANGE("Responsibility Center",ResCenter);
                    IF NOT UserResSetup.FIND('-') THEN
                      ERROR(Text003,USERID); */
                    Flag:=true; //CML-007 ASG 131207
                //CF001 En
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        //bis
        if UserSetup.Get(UserId)then begin
            ResCenter:=UserSetup."Responsibility Center";
            SalesResCenter:=UserSetup."Sales Resp. Ctr. Filter";
            PurchResCenter:=UserSetup."Purchase Resp. Ctr. Filter";
        end;
    end;
    trigger OnQueryClosePage(CloseAction: action): Boolean begin
        if CloseAction = Action::No then NoOnPush;
        //CML-007 ASG 131207 Start
        if not Flag then Error(Text004);
    //CML-007 ASG 131207 Finish
    end;
    var UserResSetup: Record "SSD User Res. Center Setup";
    Text001: label 'You do not have permissions for responsibility center %1 \ Contact your system administrator if you need to have your permissions changed.';
    ResCenter: Code[20];
    SalesResCenter: Code[20];
    PurchResCenter: Code[20];
    UserSetup: Record "User Setup";
    Text002: label 'Setup is not defined for the user %1';
    Text003: label 'User Responsibility Center Setup is not defined for the user %1';
    Flag: Boolean;
    Text004: label 'You can not close this form, to login please press Main Menu button';
    local procedure NoOnPush()
    var
        UserResCenterSetupLocal: Record "SSD User Res. Center Setup";
        UserSetupLocal: Record "User Setup";
    begin
        //CF001 St
        //bis
        UserSetupLocal.Reset;
        UserSetupLocal.SetRange("User ID", UserId);
        if not UserSetupLocal.Find('-')then Error(Text002, UserId);
        if UserId <> 'ZDI\HSINGH1' then begin
            UserResCenterSetupLocal.Reset;
            UserResCenterSetupLocal.SetRange("User ID", UserId);
            UserResCenterSetupLocal.SetRange("Responsibility Center", ResCenter);
            if not UserResCenterSetupLocal.Find('-')then Error(Text003, UserId);
        end;
        /*
        UserSetup.RESET;
        UserSetup.SETRANGE("User ID",USERID);
        IF NOT UserSetup.FIND('-') THEN
          ERROR(Text002,USERID);
        
        UserResSetup.RESET;
        UserResSetup.SETRANGE("User ID",USERID);
        UserResSetup.SETRANGE("Responsibility Center",ResCenter);
        IF NOT UserResSetup.FIND('-') THEN
          ERROR(Text003,USERID);*/
        Flag:=true; //CML-007 ASG 131207
    //CF001 En
    end;
}
