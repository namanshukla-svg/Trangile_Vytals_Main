tableextension 50109 "SSD Vendor" extends Vendor
{
    fields
    {
        modify(Name)
        {
        trigger OnAfterValidate()
        begin
            "Vendor Cheque Name":=Name;
        end;
        }
        modify("Vendor Posting Group")
        {
        trigger OnBeforeValidate()
        begin
            CheckEntryExist();
        end;
        }
        modify(Blocked)
        {
        trigger OnBeforeValidate()
        begin
            if Blocked = Blocked::" " then begin
                UserSetup.GET(USERID);
                if(not UserSetup."Vendor UnBlock Rights")then ERROR('YOU CANNOT BLOCK/UNBLOCK THIS VENDOR, KINDLY CONTACT ADMINISTRATOR');
            //if not "First Release" then
            //    ERROR('YOU CANNOT BLOCK/UNBLOCK THIS VENDOR, KINDLY CONTACT ADMINISTRATOR');
            end;
        end;
        trigger OnAfterValidate()
        begin
            if not "First Release" then ERROR('YOU CANNOT BLOCK/UNBLOCK THIS VENDOR, KINDLY CONTACT ADMINISTRATOR');
        end;
        }
        modify("Gen. Bus. Posting Group")
        {
        trigger OnBeforeValidate()
        begin
            CheckEntryExist();
            VendorBankAccount.RESET();
            VendorBankAccount.SETRANGE("Vendor No.", Rec."No.");
            if not VendorBankAccount.FINDFIRST()then ERROR('Please enter Bank details for this Vendor')
            else
            begin
                if VendorBankAccount.Code = '' then ERROR('Please enter Bank Code for this Vendor');
                if VendorBankAccount.Name = '' then ERROR('Please enter Bank Name for this Vendor');
                if VendorBankAccount."Bank Account No." = '' then ERROR('Please enter Bank Account No. for this Vendor');
                if VendorBankAccount."Beneficiary Name" = '' then ERROR('Please enter Bank Beneficiary Name for this Vendor');
                if VendorBankAccount."NEFT/RTGS Code" = '' then ERROR('Please enter Bank NEFT/RTGS Code for this Vendor');
            end;
        end;
        }
        modify("P.A.N. No.")
        {
        trigger OnBeforeValidate()
        var
            Vend: Record Vendor;
        begin
            Vend.RESET();
            Vend.SETRANGE("P.A.N. No.", "P.A.N. No.");
            Vend.SetFilter("No.", '<>%1', "No.");
            if Vend.FINDFIRST()then if not CONFIRM(STRSUBSTNO(TxtConfirm, Vend."No.", Vend."P.A.N. No."))then "P.A.N. No.":='';
        end;
        }
        modify("GST Registration No.")
        {
        trigger OnBeforeValidate()
        begin
            Vendor.RESET();
            Vendor.SETRANGE("GST Registration No.", "GST Registration No.");
            Vendor.SetFilter("No.", '<>%1', "No.");
            IF Vendor.FINDFIRST()THEN IF NOT CONFIRM(STRSUBSTNO(TxtConfirm1, Vendor."No.", Vendor."GST Registration No."))THEN "GST Registration No.":='';
        end;
        }
        field(50000; "Registered Vendor"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Registered Vendor';
        }
        field(50001; "Calculate TDS/TCS"; Boolean)
        {
            Description = 'CML-028';
            DataClassification = CustomerContent;
            Caption = 'Calculate TDS/TCS';
        }
        field(50010; "Vendor Eval. Template"; Code[10])
        {
            Caption = 'Vendor Eval. Template';
            Description = 'QTY';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50011; "Sub. Vendor Bin Code"; Code[20])
        {
            Caption = 'Subcon. Vendor Bin Code';
            Description = 'CF001 Sub Contractor Vendor Bin Code';
            TableRelation = Bin.Code where("Location Code"=field("Vendor Location"));
            DataClassification = CustomerContent;
        }
        field(50012; "Form Code"; Code[10])
        {
            Caption = 'Form Code';
            DataClassification = CustomerContent;
        }
        field(50013; "C Form"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'C Form';
        }
        field(50014; "C.S.T. Date"; Date)
        {
            Description = 'CE003 For GNOida';
            DataClassification = CustomerContent;
            Caption = 'C.S.T. Date';
        }
        field(50015; "Vendor Cheque Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Cheque Name';
        }
        field(50016; "Address 3"; Text[100])
        {
            Description = 'SSD Field Added';
            DataClassification = CustomerContent;
            Caption = 'Address 3';
        }
        field(50017; "Vendor Due Basis"; Option)
        {
            Description = 'ALLE 2.10';
            OptionMembers = " ", "Document date", "Vendor Invoice Date";
            DataClassification = CustomerContent;
            Caption = 'Vendor Due Basis';
        }
        field(50018; "Inter Unit Vendor"; Boolean)
        {
            Description = 'Alle VPB';
            DataClassification = CustomerContent;
            Caption = 'Inter Unit Vendor';
        }
        field(50019; "Inter Unit Vendor Location"; Code[10])
        {
            Description = 'Alle VPB';
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Inter Unit Vendor Location';
        }
        field(50020; "Special Remarks"; Text[50])
        {
            Description = 'ZD RS';
            DataClassification = CustomerContent;
            Caption = 'Special Remarks';
        }
        field(50021; "Email For PO Sending"; Text[100])
        {
            Description = 'Alle Sank';
            DataClassification = CustomerContent;
            Caption = 'Email For PO Sending';
        }
        field(50022; "MSME Registerd"; Boolean)
        {
            Description = 'ALLE-NM';
            DataClassification = CustomerContent;
            Caption = 'MSME Registerd';

            trigger OnValidate()
            begin
                if not "MSME Registerd" then begin
                    "MSME Activity":="MSME Activity"::" ";
                    "MSME Category":="MSME Category"::" ";
                    "MSME Classification Year":='';
                    "Udhyam Registration Number":='';
                end;
            end;
        }
        field(50023; "Exclude from Suggest Report"; Boolean)
        {
            Description = 'ALLE- 221020';
            DataClassification = CustomerContent;
            Caption = 'Exclude from Suggest Report';
        }
        field(50024; "PWM Registered"; Boolean)
        {
            Description = 'ALLE- 221020';
            DataClassification = CustomerContent;
            Caption = 'PWR Registered';
        }
        field(50025; "REACH/ROHS Declaration"; Boolean)
        {
            Description = 'ALLE- 221020';
            DataClassification = CustomerContent;
            Caption = 'REACH/ROHS Declaration';
        }
        field(50030; "First Release"; Boolean)
        {
            Description = 'First Release';
            DataClassification = CustomerContent;
            Caption = 'First Release';
        }
        field(50350; "SSD Skip Mail"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Skip PO Mail';
        }
        field(50398; "SSD Exclude Mail"; Boolean)
        {
            Caption = 'Exclude from Mail Alert';
            DataClassification = CustomerContent;
        }
        field(50399; "SSD Exclude SPO Confirmation"; Boolean)
        {
            Caption = 'Exclude SPO Confirmation';
            DataClassification = CustomerContent;
        }
        field(50400; "MSME Category";Enum "MSME Category")
        {
            Caption = 'MSME Category';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "MSME Category" <> "MSME Category"::" " then TestField("MSME Registerd", true);
            end;
        }
        field(50401; "MSME Activity";Enum "MSME Activity")
        {
            Caption = 'MSME Activity';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "MSME Activity" <> "MSME Activity"::" " then TestField("MSME Registerd", true);
            end;
        }
        field(50402; "MSME Classification Year"; Code[10])
        {
            Caption = 'MSME Classification Year';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "MSME Classification Year" <> '' then TestField("MSME Registerd", true);
            end;
        }
        field(50403; "Udhyam Registration Number"; Code[19])
        {
            Caption = 'Udhyam Registration Number';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "Udhyam Registration Number" <> '' then TestField("MSME Registerd", true);
            end;
        }
    }
    trigger OnInsert()
    begin
        "Responsibility Center":=UserMgt.GetPurchasesFilter;
        Blocked:=Blocked::All;
    end;
    trigger OnBeforeModify()
    begin
        IF(Rec.Blocked = Rec.Blocked::" ")THEN BEGIN
            VendorBankAccount.RESET;
            VendorBankAccount.SETRANGE("Vendor No.", Rec."No.");
            IF NOT VendorBankAccount.FINDFIRST THEN ERROR('Please enter Bank details for this Vendor')
            ELSE
            BEGIN
                IF VendorBankAccount.Code = '' THEN ERROR('Please enter Bank Code for this Vendor');
                IF VendorBankAccount.Name = '' THEN ERROR('Please enter Bank Name for this Vendor');
                IF VendorBankAccount."Bank Account No." = '' THEN ERROR('Please enter Bank Account No. for this Vendor');
                IF VendorBankAccount."Beneficiary Name" = '' THEN ERROR('Please enter Bank Beneficiary Name for this Vendor');
                IF VendorBankAccount."NEFT/RTGS Code" = '' THEN ERROR('Please enter Bank NEFT/RTGS Code for this Vendor');
            END;
        END;
    end;
    procedure CheckBlockedAll()
    begin
        TestField(Name);
        TestField(Address);
        TestField(City);
        TestField("Vendor Posting Group");
        TestField("Payment Terms Code");
        TestField("Country/Region Code");
        TestField("Gen. Bus. Posting Group");
        TestField("Post Code");
        //TESTFIELD("Tax Area Code");
        TestField("Tax Liable");
        TestField("VAT Bus. Posting Group");
        TestField("Responsibility Center");
        TestField("Location Code");
        if "GST Vendor Type" <> "gst vendor type"::Import then TestField("State Code");
    end;
    procedure CheckEntryExist()
    var
        lrec_VendLedger: Record "Vendor Ledger Entry";
        ltext_50000: label 'Posting Group cannot be changed because vendor ledger entry exist for Vendor %1 %2';
    begin
        lrec_VendLedger.SETRANGE(lrec_VendLedger."Vendor No.", "No.");
        IF NOT lrec_VendLedger.ISEMPTY THEN ERROR(ltext_50000, "No.", Name);
    end;
    var UserSetup: Record "User Setup";
    VendorBankAccount: Record "Vendor Bank Account";
    Vendor: Record Vendor;
    UserMgt: Codeunit "User Setup Management";
    TxtConfirm: label 'This PAN No. already exist for Customer  %1  and PAN No. %2';
    TxtConfirm1: label 'This GSTIN No. already exist for Customer  %1  and GSTIN No. %2';
}
