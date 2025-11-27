Table 50043 "SSD Insurance Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Insurance Policy No."; Code[30])
        {
            Caption = 'Insurance Policy No.';
            DataClassification = CustomerContent;
        }
        field(2; "Insurance Vendor No."; Code[30])
        {
            TableRelation = Vendor;
            Caption = 'Insurance Vendor No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Vendor.Get("Insurance Vendor No.")then "Insurance Vendor Name":=Vendor.Name;
            end;
        }
        field(3; "Insurance Vendor Name"; Text[100])
        {
            Editable = false;
            Caption = 'Insurance Vendor Name';
            DataClassification = CustomerContent;
        }
        field(4; "Insurance Starting Date"; Date)
        {
            Caption = 'Insurance Starting Date';
            DataClassification = CustomerContent;
        }
        field(5; "Insurance Expiry Date"; Date)
        {
            Caption = 'Insurance Expiry Date';
            DataClassification = CustomerContent;
        }
        field(6; "Insurance Amount"; Decimal)
        {
            Caption = 'Insurance Amount';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //if "Balance Amount" = 0 then
                TestField("Applied Amount", 0);
                "Balance Amount":="Insurance Amount" end;
        }
        field(7; "Applied Amount"; Decimal)
        {
            Editable = false;
            Caption = 'Applied Amount';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                SInvHeader.Reset;
                SInvHeader.SetRange("Applied to Insurance Policy", "Insurance Policy No.");
                if SInvHeader.FindFirst then begin
                    if Page.RunModal(Page::"Posted Sales Invoices", SInvHeader, SInvHeader."No.") = Action::LookupOK then;
                end;
            end;
        }
        field(8; "Balance Amount"; Decimal)
        {
            Editable = false;
            Caption = 'Balance Amount';
            DataClassification = CustomerContent;
        }
        field(9; "Policy Status"; Option)
        {
            OptionMembers = " ", Active, Expired;
            Caption = 'Policy Status';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Policy Status" = "policy status"::Active then begin
                    TestField("Insurance Vendor No.");
                    TestField("Insurance Starting Date");
                    TestField("Insurance Expiry Date");
                    TestField("Insurance Amount");
                end;
            end;
        }
    }
    keys
    {
        key(Key1; "Insurance Policy No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
        }
        key(Key2; "Policy Status", "Insurance Starting Date", "Insurance Expiry Date")
        {
        }
    }
    fieldgroups
    {
    }
    var Vendor: Record Vendor;
    SInvHeader: Record "Sales Invoice Header";
}
