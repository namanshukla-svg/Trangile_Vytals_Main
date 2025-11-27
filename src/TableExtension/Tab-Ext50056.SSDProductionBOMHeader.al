TableExtension 50056 "SSD Production BOM Header" extends "Production BOM Header"
{
    fields
    {
        modify(Status)
        {
        trigger OnBeforeValidate()
        begin
            UserSetup.Get(UserId);
            IF NOT UserSetup."Prod.BOM Approval Permission" THEN Error(Text50001);
        end;
        }
        field(50001; "BOM Category"; Option)
        {
            Description = 'TR diff for Normal or Tool Room';
            NotBlank = true;
            OptionCaption = 'Normal,Tool';
            OptionMembers = Normal, Tool;
            DataClassification = CustomerContent;
            Caption = 'BOM Category';

            trigger OnValidate()
            var
                CapacityLdgrEntryLocal: Record "Capacity Ledger Entry";
                ProductionBOMLineLocal: Record "Production BOM Line";
            begin
                if "Version Nos." <> '' then Error(Text003)
                else
                begin
                    ProductionBOMLineLocal.Reset;
                    ProductionBOMLineLocal.SetRange(ProductionBOMLineLocal."Production BOM No.", "No.");
                    if ProductionBOMLineLocal.Find('-')then repeat ProductionBOMLineLocal."BOM Category":="BOM Category";
                            ProductionBOMLineLocal.Modify;
                        until ProductionBOMLineLocal.Next = 0;
                end;
            end;
        }
        field(50050; "Responsibility Center"; Code[20])
        {
            Description = 'CF001';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center';
        }
        field(50051; "Source No."; Code[20])
        {
            Description = 'CEN001';
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Source No.';

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if xRec.Status <> xRec.Status::Certified then begin
                    Item.SetRange(Item."No.", "Source No.");
                    if Item.Find('-')then begin
                        Description:=Item.Description;
                        "Description 2":=Item."No. 2";
                        "Search Name":=Item.Description;
                        "Unit of Measure Code":=Item."Base Unit of Measure";
                    end;
                end
                else
                begin
                    "Source No.":=xRec."Source No.";
                    Message('Status must not be Certified');
                end;
            end;
        }
    }
    keys
    {
        key(Key1; "Source No.")
        {
        }
    }
    var UserMgt: Codeunit "SSD User Setup Management";
    ResponsibilityCenter: Record "Responsibility Center";
    UserSetup: Record "User Setup";
    Text003: label 'One or more Versions are available; Modification is not possible';
    Text004: label 'One or more Ledger Entries are available; Modification is not possible';
    Text50001: label 'You don''t have permission to change status of Prod. BOM.';
}
