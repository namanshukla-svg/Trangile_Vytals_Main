table 50354 "SSD PO Terms"
{
    Caption = 'SSD PO Terms';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type";Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
            Editable = false;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(10; "TC Code"; Code[20])
        {
            Caption = 'TC Code';
            Editable = false;
        }
        field(11; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(20; "Sequence No."; Integer)
        {
            Caption = 'Sequence No.';
            Blankzero = true;
        }
        field(25; "Sub Sequence No."; Text[5])
        {
            Caption = 'Sub Sequence No.';

            trigger OnValidate()
            var
                Position: Integer;
                OnlyNumericErr: Label 'Only Numeric is allowed in the position %1.', Comment = '%1 = Position';
            begin
                for Position:=1 to StrLen("Sub Sequence No.")do begin
                    if not(CopyStr("Sub Sequence No.", Position)in['0' .. '9'])then Error(OnlyNumericErr, Position);
                end;
            end;
        }
        field(30; Description; Text[2000])
        {
            Caption = 'Description';
        }
        field(35; "Is Header"; Boolean)
        {
            Caption = 'Is Header';
        }
        field(40; "Print on PO"; Boolean)
        {
            Caption = 'Print on PO';
        }
        field(50; "Check List"; Boolean)
        {
            Caption = 'SRN Check List';

            trigger OnValidate()
            begin
                TestField("Is Header", false);
                if not "Check List" then begin
                    "Attachment Required":=false;
                    "SSD Attachment Type":='';
                end;
            end;
        }
        field(60; "Attachment Required"; Boolean)
        {
            Caption = 'Attachment Required';

            trigger OnValidate()
            begin
                TestField("Is Header", false);
                TestField("Check List");
            end;
        }
        field(70; "SSD Attachment Type"; Code[20])
        {
            Caption = 'Attachment Type';
            DataClassification = CustomerContent;
            TableRelation = "SSD Attachment Type";

            trigger OnValidate()
            begin
                TestField("Is Header", false);
                TestField("Check List");
            end;
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "TC Code", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        CheckPOStatus();
    end;
    trigger OnDelete()
    begin
        CheckPOStatus();
    end;
    trigger OnModify()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."SSD TC Admin" then error('You are not authourized to modify PO terms');
        CheckPOStatus();
    end;
    trigger OnRename()
    begin
        Error('');
    end;
    local procedure CheckPOStatus()
    var
        Purchaseheader: Record "Purchase Header";
    begin
        if not Purchaseheader.Get("Document Type", "Document No.")then Error('Purchase Order does not Exists')
        else
            Purchaseheader.TestField(Status, Purchaseheader.Status::Open);
    end;
    /// <summary>
    /// ResequenceLines.
    /// </summary>
    /// <param name="DocType">Enum "Purchase Document Type".</param>
    /// <param name="DocNo">Code[20].</param>
    /// <param name="TCCode">Code[20].</param>
    procedure ResequenceLines(DocType: Enum "Purchase Document Type"; DocNo: Code[20]; TCCode: Code[20])
    var
        TermsLine: Record "SSD PO Terms";
        SNo: Integer;
        SubSNo: Integer;
    begin
        SNo:=1;
        TermsLine.Reset();
        TermsLine.SetRange("Document Type", DocType);
        TermsLine.SetRange("Document No.", DocNo);
        TermsLine.SetRange("TC Code", TCCode);
        if TermsLine.FindSet()then repeat if TermsLine."Is Header" then begin
                    TermsLine."Sequence No.":=SNo;
                    SNo+=1;
                    SubSNo:=0;
                    TermsLine.Modify();
                end
                else
                begin
                    if TermsLine."Sub Sequence No." <> '' then begin
                        SubSNo+=1;
                        TermsLine."Sub Sequence No.":=format(SubSNo);
                        TermsLine.Modify();
                    end;
                end;
            until TermsLine.Next() = 0;
    end;
}
