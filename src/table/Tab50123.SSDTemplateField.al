Table 50123 "SSD Template Field"
{
    // *** Matriks Doc Version 3 ***
    // By Tim Ahrentl¢v for Matriks A/S.
    // Visit www.matriks.com for news and updates.
    // 
    // 3.04 (2005.10.23):
    // Removal of unecessary call to a calcfield that requires a more elaboate security role setup.
    // 
    // 3.03 (2004.06.17):
    // Bugfix in RefreshTemplate function's while loop that did not process the last field.
    // 
    // 3.02 (2003.07.25):
    // RefreshTemplate() parameter change to facillitate special templates.
    // Special template logic added to RefreshTemplate();
    // 
    // 3.01 (2003.07.01):
    // New function "CloneTemplate" created.
    Caption = 'Template Field';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Template Name"; Code[20])
        {
            Caption = 'Template Name';
            Editable = false;
            TableRelation = "SSD Document"."No." where("Document Type"=const(Template));
            DataClassification = CustomerContent;
        }
        field(2; "Field Index"; Integer)
        {
            Caption = 'Field Index';
            DataClassification = CustomerContent;
        }
        field(3; "Field No"; Integer)
        {
            Caption = 'Field No.';
            DataClassification = CustomerContent;
        }
        field(4; "Field Caption"; Text[128])
        {
            Caption = 'Field Caption';
            DataClassification = CustomerContent;
        }
        field(7; RelationTableNo; Integer)
        {
            Caption = 'RelationTableNo';
            DataClassification = CustomerContent;
        }
        field(8; RelationTableFieldNo; Integer)
        {
            Caption = 'RelationTableFieldNo';
            DataClassification = CustomerContent;
        }
        field(9; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
        }
        field(10; "Use description"; Boolean)
        {
            Caption = 'Use Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if RelationTableNo = 0 then "Use description":=false;
            end;
        }
    }
    keys
    {
        key(Key1; "Template Name", "Field Index")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var FromTmplField: Record "SSD Template Field";
    ToTmplField: Record "SSD Template Field";
    procedure RefreshTemplate(var TemplateRec: Record "SSD Document"; WithDelete: Boolean)
    var
        OK: Boolean;
        i: Integer;
        "Field": Record "Field";
        TemplateField: Record "SSD Template Field";
        Template: Record "SSD Document";
        SpclTmplMgt: Report "Vendor Eval. Creation";
        TableRecord: RecordRef;
        TableField: FieldRef;
        FCLS: Text[20];
        Names: array[100]of Text[128];
    begin
        if WithDelete then begin
            TemplateField.SetRange("Template Name", TemplateRec."No.");
            TemplateField.DeleteAll;
        end;
        if(TemplateRec."Table No." = 0) and (not TemplateRec.Special)then exit;
        if not TemplateRec.Special then begin
            // Open instance of a table with the tableno from document record
            TableRecord.Open(TemplateRec."Table No.");
            i:=1;
            // Loop over fields in record
            while i <= TableRecord.FieldCount do begin
                // Prepare Record
                Clear(TemplateField);
                // Get field based on index
                TableField:=TableRecord.FieldIndex(i);
                // On
                FCLS:=Format(TableField.CLASS);
                if(FCLS <> 'FlowFilter') and TableField.Active then begin
                    TemplateField."Template Name":=TemplateRec."No.";
                    TemplateField."Field Index":=i;
                    TemplateField."Field No":=TableField.Number;
                    TemplateField."Field Caption":=TableField.Caption;
                    TemplateField.Active:=false;
                    if Field.Get(TemplateRec."Table No.", TableField.Number)then begin
                        TemplateField.RelationTableNo:=Field.RelationTableNo;
                        TemplateField.RelationTableFieldNo:=Field.RelationFieldNo;
                    end;
                    OK:=TemplateField.Insert;
                end;
                i:=i + 1;
            end;
            // Close table instance
            TableRecord.Close();
        end
        else
        begin
            //FOR i := 1 TO SpclTmplMgt.GetNames(TemplateRec, Names) DO BEGIN
            // Prepare Record
            Clear(TemplateField);
            TemplateField."Template Name":=TemplateRec."No.";
            TemplateField."Field Index":=i;
            TemplateField."Field No":=i;
            TemplateField."Field Caption":=Names[i];
            TemplateField.Active:=false;
            OK:=TemplateField.Insert;
        //END;
        end;
    end;
    procedure CloneTemplate(FromName: Code[20]; ToName: Code[20])
    var
        FromTmplField: Record "SSD Template Field";
        ToTmplField: Record "SSD Template Field";
    begin
        FromTmplField.SetRange("Template Name", FromName);
        if FromTmplField.Find('-')then repeat ToTmplField.Copy(FromTmplField);
                ToTmplField."Template Name":=ToName;
                ToTmplField.Insert;
            until FromTmplField.Next = 0;
    end;
}
