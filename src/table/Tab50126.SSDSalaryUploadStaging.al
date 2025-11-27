Table 50126 "SSD Salary Upload Staging"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(2; SeqID; Guid)
        {
            DataClassification = CustomerContent;
            Caption = 'SeqID';
        }
        field(3; "Company Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Company Name';
        }
        field(4; "Employee Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Code';
        }
        field(5; "Employee Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Name';
        }
        field(6; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date';
        }
        field(7; "Employee Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active, Inactive;
            Caption = 'Employee Status';
        }
        field(8; Department; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Department';
        }
        field(9; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(10; "Cost Center Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Cost Center Name';
        }
        field(11; "PAN Number"; Code[11])
        {
            DataClassification = CustomerContent;
            Caption = 'PAN Number';
        }
        field(12; "Bank Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Name';
        }
        field(13; "Bank Account Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Account Number';
        }
        field(14; "Salary Hold"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Salary Hold';
        }
        field(15; Basic; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Basic';
        }
        field(16; HRA; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'HRA';
        }
        field(17; LTA; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'LTA';
        }
        field(18; "SPL ALLOW"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'SPL ALLOW';
        }
        field(19; "DVR REIM"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'DVR REIM';
        }
        field(20; "Veh REIM"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Veh REIM';
        }
        field(21; "Fuel REIM"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Fuel REIM';
        }
        field(22; "GWA OT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'GWA OT';
        }
        field(23; "ATT Award"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ATT Award';
        }
        field(24; "Other Earn"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Earn';
        }
        field(25; "Gross Earn"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Gross Earn';
        }
        field(26; PF; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PF';
        }
        field(27; "VPF SAL"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VPF SAL';
        }
        field(28; ESI; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'ESI';
        }
        field(29; EECLWF; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'EECLWF';
        }
        field(30; IT; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'IT';
        }
        field(31; "SAL ADV"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'SAL ADV';
        }
        field(32; "MEALS REC"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'MEALS REC';
        }
        field(33; "GROSS DED"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'GROSS DED';
        }
        field(34; "NET PAY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'NET PAY';
        }
        field(35; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Success,Fail';
            OptionMembers = Open, Success, Fail;
            Caption = 'Status';
        }
        field(36; Designation; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Designation';
        }
        field(37; DOJ; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'DOJ';
        }
        field(38; DOL; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'DOL';
        }
        field(39; Location; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Location';
        }
        field(40; Grade; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Grade';
        }
        field(41; Female; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Female';
        }
        field(42; Paymode; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Paymode';
        }
        field(43; "Beneficiary Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Beneficiary Name';
        }
        field(44; "IFSE code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'IFSE code';
        }
        field(45; "Bank Branch"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Branch';
        }
        field(46; "Emp Location"; Option)
        {
            OptionCaption = ' ,Corporate,Plant';
            OptionMembers = " ", Corporate, Plant;
            DataClassification = CustomerContent;
            Caption = 'Emp Location';
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    var
        SalaryUplodeStaging: Record "SSD Document Setup";
    begin
        // SalaryUplodeStaging.RESET;
        // IF SalaryUplodeStaging.FINDLAST THEN
        //  LastEntryNo := SalaryUplodeStaging."Entry No." + 1
        // ELSE
        //  LastEntryNo := 1;
        //
        // "Entry No." := LastEntryNo;
        SeqID:=CreateGuid;
    end;
    var DimMgt: Codeunit DimensionManagement;
    LastEntryNo: Integer;
    RecSal: Record "SSD Document Setup";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    end;
}
