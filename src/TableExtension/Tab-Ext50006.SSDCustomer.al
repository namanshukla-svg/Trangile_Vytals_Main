TableExtension 50006 "SSD Customer" extends Customer
{
    fields
    {
        modify("Currency Code")
        {
        TableRelation = Currency where(Code=filter(<>'INR'));
        }
        modify("Currency Filter")
        {
        TableRelation = Currency where(Code=filter(<>'INR'));
        }
        modify(Name)
        {
        trigger OnAfterValidate()
        begin
            Name:=UpperCase(Name);
        end;
        }
        modify("Name 2")
        {
        trigger OnAfterValidate()
        begin
            "Name 2":=UpperCase("Name 2");
        end;
        }
        modify(Address)
        {
        trigger OnAfterValidate()
        begin
            Address:=UpperCase(Address);
        end;
        }
        modify(Blocked)
        {
        trigger OnBeforeValidate()
        begin
            if Blocked = Blocked::" " THEN BEGIN
                UserSetup.GET(USERID);
                if NOT UserSetup."Customer UnBlock Rights" THEN ERROR(BlockErr);
                if "Salesperson Code" = '' THEN ERROR(SalesPersonErr);
            end;
        end;
        trigger OnAfterValidate()
        var
            Alle: Codeunit "Alle Events";
        begin
            if not "First Release" then ERROR('YOU CANNOT BLOCK/UNBLOCK THIS VENDOR, KINDLY CONTACT ADMINISTRATOR');
            Alle.SendMailForCustomerBlk(Rec);
        END;
        }
        modify("Shipping Time")
        {
        trigger OnAfterValidate()
        begin
            EVALUATE(Text1, FORMAT("Shipping Time"));
            Var2:=STRLEN(Text1);
            Var1:=COPYSTR(Text1, Var2, Var2);
            Var3:=COPYSTR(Text1, 1, Var2 - 1);
            EVALUATE(Int1, Var3);
            IF Var1 = 'D' THEN "Shipping Time In Days":=Int1 * 1
            ELSE IF Var1 = 'M' THEN "Shipping Time In Days":=Int1 * 30
                ELSE IF Var1 = 'Q' THEN "Shipping Time In Days":=Int1 * 90
                    ELSE
                        "Shipping Time In Days":=Int1 * 7;
        end;
        }
        modify("P.A.N. No.")
        {
        trigger OnAfterValidate()
        begin
            IF STRLEN("P.A.N. No.") <> 10 THEN ERROR('P.A.N. No. need to be of length 10');
            Customer.Reset();
            Customer.SETRANGE("P.A.N. No.", "P.A.N. No.");
            IF Customer.FINDFIRST THEN IF NOT CONFIRM(STRSUBSTNO(TxtConfirm, Customer."No.", Customer."P.A.N. No."))THEN "P.A.N. No.":='';
        end;
        }
        modify("GST Registration No.")
        {
        trigger OnAfterValidate()
        begin
            Customer.Reset();
            Customer.SETRANGE("GST Registration No.", "GST Registration No.");
            IF Customer.FINDFIRST THEN IF NOT CONFIRM(STRSUBSTNO(TxtConfirm1, Customer."No.", Customer."GST Registration No."))THEN "GST Registration No.":='';
        end;
        }
        field(50000; "Freight Zone"; Code[20])
        {
            Description = 'ALLE 3.08';
            TableRelation = "SSD Freight Zone";
            DataClassification = CustomerContent;
            Caption = 'Freight Zone';
        }
        field(50001; "Excise Bus Posting Group(ADE)"; Code[10])
        {
            Description = 'ALLE 3.14';
            DataClassification = CustomerContent;
            Caption = 'Excise Bus Posting Group(ADE)';
        }
        field(50002; "LUT Code"; Code[20])
        {
            Description = 'ALLE 3.03 V1.7';
            DataClassification = CustomerContent;
            Caption = 'LUT Code';
        }
        field(50003; "LUT Date"; Date)
        {
            Description = 'ALLE 3.03 V1.7';
            DataClassification = CustomerContent;
            Caption = 'LUT Date';
        }
        field(50004; "Form Code"; Code[10])
        {
            Description = 'ALLE 3.03 V1.11';
            DataClassification = CustomerContent;
            Caption = 'Form Code';
        }
        field(50005; "Print Ship to Addr. on Inv."; Boolean)
        {
            Description = 'Alle VPB';
            DataClassification = CustomerContent;
            Caption = 'Print Ship to Addr. on Inv.';
        }
        field(50006; "NSM Code"; Text[20])
        {
            Description = 'ALE[5.51]Dt-3-2-12';
            TableRelation = "Dimension Value".Code where("Dimension Code"=const('EMPLOYEE'));
            DataClassification = CustomerContent;
            Caption = 'NSM Code';

            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                DimensionValue.Reset();
                DimensionValue.SetRange(DimensionValue."Dimension Code", 'EMPLOYEE');
                DimensionValue.SetRange(DimensionValue.Code, "NSM Code");
                if DimensionValue.FindFirst()then "NSM Name":=DimensionValue.Name;
            end;
        }
        field(50007; "NSM Name"; Text[50])
        {
            Description = 'ALE[5.51]dt-3-2-12';
            DataClassification = CustomerContent;
            Caption = 'NSM Name';
        }
        field(50008; "Shipping Agent Code 1"; Code[10])
        {
            Caption = 'Shipping Agent Code 1';
            Description = 'ALLE[Z]';
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Shipping Agent Code" <> xRec."Shipping Agent Code" then Validate("Shipping Agent Service Code", '');
            end;
        }
        field(50009; "Address 3"; Text[50])
        {
            Description = 'RS - ZD';
            DataClassification = CustomerContent;
            Caption = 'Address 3';
        }
        field(50010; crminsertflag; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'crminsertflag';
        }
        field(50011; crmupdateflag; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'crmupdateflag';
        }
        field(50012; "CRM Temp Id"; Text[30])
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'CRM Temp Id';
        }
        field(50013; isCRMexception; Boolean)
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'isCRMexception';
        }
        field(50014; exceptiondetail; Text[200])
        {
            Description = 'TRI';
            DataClassification = CustomerContent;
            Caption = 'exceptiondetail';
        }
        field(50020; "QR Code"; Blob)
        {
            SubType = Bitmap;
            DataClassification = CustomerContent;
            Caption = 'QR Code';
        }
        field(50021; "CTC for ST Form"; Text[50])
        {
            Description = 'Alle 190916';
            DataClassification = CustomerContent;
            Caption = 'CTC for ST Form';
        }
        field(50022; "Email for ST Form"; Text[250])
        {
            Description = 'Alle 190916';
            DataClassification = CustomerContent;
            Caption = 'Email for ST Form';
        }
        field(50023; "CTC for Payment"; Text[50])
        {
            Description = 'Alle 220916';
            DataClassification = CustomerContent;
            Caption = 'CTC for Payment';
        }
        field(50024; "Email for Payment"; Text[250])
        {
            Description = 'Alle 220916';
            DataClassification = CustomerContent;
            Caption = 'Email for Payment';
        }
        field(50025; "Delivery Resp. Name"; Text[30])
        {
            Description = 'BS20122016';
            DataClassification = CustomerContent;
            Caption = 'Delivery Resp. Name';
        }
        field(50026; "Delivery Resp. Contact No."; Text[40])
        {
            Description = 'BS20122016';
            DataClassification = CustomerContent;
            Caption = 'Delivery Resp. Contact No.';
        }
        field(50027; "Payment Cycle 1"; Integer)
        {
            Description = '//Alle';
            DataClassification = CustomerContent;
            Caption = 'Payment Cycle 1';
        }
        field(50028; "Payment Cycle 2"; Integer)
        {
            Description = '//Alle';
            DataClassification = CustomerContent;
            Caption = 'Payment Cycle 2';
        }
        field(50029; "Payment Cycle 3"; Integer)
        {
            Description = '//Alle';
            DataClassification = CustomerContent;
            Caption = 'Payment Cycle 3';
        }
        field(50030; "Payment Cycle 4"; Integer)
        {
            Description = '//Alle';
            DataClassification = CustomerContent;
            Caption = 'Payment Cycle 4';
        }
        field(50031; "Shipping Time In Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Shipping Time In Days';
        }
        field(50032; Sync; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sync';
        }
        field(50033; "Last Modified User ID"; Code[50])
        {
            Caption = 'Last Modified User ID';
            Editable = false;
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(50034; "Payment Advise Mail Sent"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Advise Mail Sent';
        }
        field(50035; "DDC as Per Invoice Date"; Boolean)
        {
            Description = 'ALLE-210121';
            DataClassification = CustomerContent;
            Caption = 'DDC as Per Invoice Date';
        }
        field(50036; "CTC for Technical/QC"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'CTC for Technical/QC';
        }
        field(50037; "E-mail ID for Technical/QC"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'E-mail ID for Technical/QC';
        }
        field(50050; "SSD Sample Customer"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sample Customer';
        }
        field(50051; "SSD PWM EPR No. "; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'PWM EPR No. ';
        }
        field(50055; "First Release"; Boolean)
        {
            Description = 'First Release';
            DataClassification = CustomerContent;
            Caption = 'First Release';
        }
    }
    trigger OnAfterModify()
    var
        UserSetup: Record "User Setup";
        TextLocal50001: Label 'You don''t have editing permission to modify this. Contact System Administrator.';
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Master Editing Permission" then Error(TextLocal50001);
        crmupdateflag:=true;
        Sync:=false;
    end;
    trigger OnInsert()
    begin
        Blocked:=Blocked::All;
    end;
    /// <summary>
    /// CheckBlockedCustOnDocsForDisOrd.
    /// </summary>
    /// <param name="Cust2">Record Customer.</param>
    /// <param name="DocType">Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order".</param>
    /// <param name="Shipment">Boolean.</param>
    /// <param name="Transaction">Boolean.</param>
    procedure CheckBlockedCustOnDocsForDisOrd(Cust2: Record Customer; DocType: Enum "Sales Document Type"; Shipment: Boolean; Transaction: Boolean)
    begin
        if((Cust2.Blocked = Cust2.Blocked::All) or ((Cust2.Blocked = Cust2.Blocked::Invoice) and (DocType in[Doctype::Quote, Doctype::Order, Doctype::Invoice, Doctype::"Blanket Order"]))) or ((Cust2.Blocked = Cust2.Blocked::Ship) and (DocType in[Doctype::Quote, Doctype::Order, Doctype::"Blanket Order"]) and (not Transaction)) or ((Cust2.Blocked = Cust2.Blocked::Ship) and (DocType in[Doctype::Quote, Doctype::Order, Doctype::Invoice, Doctype::"Blanket Order"]) and Shipment and Transaction)then Cust2.CustBlockedErrorMessage(Cust2, Transaction);
    end;
    var Customer: Record Customer;
    UserSetup: Record "User Setup";
    BlockErr: Label 'You are not authourized to unblock Customer. Contact Administrator';
    SalesPersonErr: Label 'Salesperson Code must not be Blank';
    Var1: Text;
    Var2: Integer;
    Var3: Text;
    Text1: Text;
    Int1: Integer;
    TxtConfirm: label 'This PAN No. already exist for Customer  %1  and PAN No. %2';
    TxtConfirm1: label 'This GSTIN No. already exist for Customer  %1  and GSTIN No. %2';
}
