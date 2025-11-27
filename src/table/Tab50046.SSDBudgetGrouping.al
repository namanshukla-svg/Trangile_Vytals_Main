table 50046 "SSD Budget Grouping"
{
    Caption = 'Template Field';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Budget Group Code"; Code[50])
        {
            Caption = 'Budget Group Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "BS Grouping Code"; Code[50])
        {
            TableRelation = "SSD BS Budget"."BS Code" where("BS Code"=field("BS Grouping Code"));
            Caption = 'BS Grouping Code';
            DataClassification = CustomerContent;
        }
        field(4; "G/L Group Code"; Code[50])
        {
            TableRelation = "SSD G/L Group Code"."G/L Group Code";
            Caption = 'G/L Group Code';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Budget Group Code", Description, "BS Grouping Code", "G/L Group Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var FromTmplField: Record "SSD Budget Grouping";
    ToTmplField: Record "SSD Budget Grouping";
    /// <summary>
    /// CloneTemplate.
    /// </summary>
    /// <param name="FromName">Code[20].</param>
    /// <param name="ToName">Code[20].</param>
    procedure CloneTemplate(FromName: Code[20]; ToName: Code[20])
    var
        FromTmplField: Record "SSD Budget Grouping";
        ToTmplField: Record "SSD Budget Grouping";
    begin
        FromTmplField.SetRange("Budget Group Code", FromName);
        if FromTmplField.Find('-')then repeat ToTmplField.Copy(FromTmplField);
                ToTmplField."Budget Group Code":=ToName;
                ToTmplField.Insert;
            until FromTmplField.Next = 0;
    end;
}
