table 50353 "SSD Terms Line"
{
    Caption = 'Terms Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Terms Code"; Code[20])
        {
            Caption = 'Terms Code';
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
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
        key(PK; "Terms Code", "Line No.")
        {
            Clustered = true;
        }
    }
    /// <summary>
    /// ResequenceLines.
    /// </summary>
    /// <param name="TermsCode">Code[20].</param>
    procedure ResequenceLines(TermsCode: Code[20])
    var
        TermsLine: Record "SSD Terms Line";
        SNo: Integer;
        SubSNo: Integer;
    begin
        SNo:=1;
        TermsLine.Reset();
        TermsLine.SetRange("Terms Code", TermsCode);
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
