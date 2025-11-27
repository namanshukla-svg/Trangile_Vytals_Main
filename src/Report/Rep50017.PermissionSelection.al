Report 50017 "Permission Selection"
{
    ProcessingOnly = true;
    UsageCategory = Lists;
    ApplicationArea = All;

    dataset
    {
        dataitem("Code Coverage"; "Code Coverage")
        {
            RequestFilterFields = "Object Type", "Object ID";

            column(ReportForNavId_6087;6087)
            {
            }
            trigger OnAfterGetRecord()
            begin
                PermissionTemp.Reset;
                PermissionTemp.SetRange("Object Type", "Object Type");
                PermissionTemp.SetRange("Object ID", "Object ID");
                if not PermissionTemp.Find('-')then begin
                    PermissionSelection2.Reset;
                    PermissionSelection2.SetCurrentkey("Object Type", "Object ID");
                    PermissionSelection2.SetRange("Object Type", "Object Type");
                    PermissionSelection2.SetRange("Object ID", "Object ID");
                    if not PermissionSelection2.Find('-')then begin
                        PermissionSelection.Init;
                        PermissionSelection."Role ID":=AddToRole;
                        PermissionSelection."Object Type":="Object Type";
                        if PermissionSelection."Object Type" = PermissionSelection."object type"::Table then PermissionSelection."Object Type":=PermissionSelection."object type"::"Table Data";
                        PermissionSelection."Object ID":="Object ID";
                        if PermissionSelection.Insert then;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        PermissionTemp.DeleteAll;
        Permission.Reset;
        Permission.SetRange("Role ID", AddToRole);
        if Permission.Find('-')then begin
            repeat PermissionTemp.Init;
                PermissionTemp.TransferFields(Permission);
                PermissionTemp.Insert;
            until Permission.Next = 0;
        end;
        PermissionAllUsers.Reset;
        if PermissionAllUsers.Find('-')then begin
            repeat Permission.Reset;
                Permission.SetRange("Role ID", PermissionAllUsers."No.");
                if Permission.Find('-')then begin
                    repeat PermissionTemp.Init;
                        PermissionTemp.TransferFields(Permission);
                        PermissionTemp.Insert;
                    until Permission.Next = 0;
                end;
            until PermissionAllUsers.Next = 0;
        end;
    end;
    var LastFieldNo: Integer;
    FooterPrinted: Boolean;
    PermissionTemp: Record Permission temporary;
    PermissionAllUsers: Record "SSD Posted Quality Ord Hdr Ar";
    PermissionSelection: Record "SSD Permission Selection";
    Permission: Record Permission;
    AddToRole: Code[10];
    PermissionSelection2: Record "SSD Permission Selection";
    Text001: label 'You must select Add To Role';
}
