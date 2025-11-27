page 50091 "SSD Update Item"
{
    ApplicationArea = All;
    Caption = 'SSD Update Item';
    PageType = List;
    SourceTable = "SSD Update Item";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(crminsertflag; Rec.crminsertflag)
                {
                    ToolTip = 'Specifies the value of the crminsertflag field.';
                }
                field(crmupdateflag; Rec.crmupdateflag)
                {
                    ToolTip = 'Specifies the value of the crmupdateflag field.';
                }
                field(crmfgproduct; Rec.crmfgproduct)
                {
                    ToolTip = 'Specifies the value of the crmfgproduct field.';
                }
                field(isCRMexception; Rec.isCRMexception)
                {
                    ToolTip = 'Specifies the value of the isCRMexception field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update Data")
            {
                ApplicationArea = All;
                Caption = 'Update Data';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateShipment;

                trigger OnAction()
                var
                    UpdateItem: Record "SSD Update Item";
                    Item: Record Item;
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    IF not UserSetup."Item Vendor Permission" then Error('You do not have a permission.');
                    if UpdateItem.FindSet()then repeat Item.Get(UpdateItem."Item No.");
                            IF UpdateItem.crmfgproduct <> '' then begin
                                if UpdateItem.crmfgproduct = 'TRUE' then Item.crmfgproduct:=TRUE
                                else
                                    Item.crmfgproduct:=FALSE;
                            end;
                            IF UpdateItem.crminsertflag <> '' then begin
                                if UpdateItem.crminsertflag = 'TRUE' then Item.crminsertflag:=TRUE
                                else
                                    Item.crminsertflag:=FALSE;
                            end;
                            IF UpdateItem.crmupdateflag <> '' then begin
                                if UpdateItem.crmupdateflag = 'TRUE' then Item.crmupdateflag:=TRUE
                                else
                                    Item.crmupdateflag:=FALSE;
                            end;
                            IF UpdateItem.isCRMexception <> '' then begin
                                if UpdateItem.isCRMexception = 'TRUE' then Item.isCRMexception:=TRUE
                                else
                                    Item.isCRMexception:=FALSE;
                            end;
                            Item.Modify();
                        until UpdateItem.Next() = 0;
                    Message('Done');
                end;
            }
            action("Delete All")
            {
                ApplicationArea = All;
                Caption = 'Delete All';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Delete;

                trigger OnAction()
                var
                    UpdateItem: Record "SSD Update Item";
                begin
                    if UpdateItem.FindSet()then UpdateItem.DeleteAll();
                    Message('Deleted');
                end;
            }
        }
    }
}
