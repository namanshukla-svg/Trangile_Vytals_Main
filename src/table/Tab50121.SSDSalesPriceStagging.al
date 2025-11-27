table 50121 "SSD Sales Price Stagging"
{
    Caption = 'Sales Price Stagging';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                if Item.Get("Item No.")then Validate("Unit of Measure Code", Item."Base Unit of Measure");
            end;
        }
        field(2; "Sales Code"; Code[20])
        {
            Caption = 'Sales Code';
            DataClassification = CustomerContent;
        }
        field(3; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = CustomerContent;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                SalesPrice: Record "Sales Price";
            begin
            end;
        }
        field(5; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(7; "Price Includes VAT"; Boolean)
        {
            Caption = 'Price Includes VAT';
            DataClassification = CustomerContent;
        }
        field(10; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(11; "VAT Bus. Posting Gr. (Price)"; Code[10])
        {
            Caption = 'VAT Bus. Posting Gr. (Price)';
            DataClassification = CustomerContent;
        }
        field(13; "Sales Type"; Option)
        {
            Caption = 'Sales Type';
            OptionCaption = 'Customer,Customer Price Group,All Customers,Campaign';
            OptionMembers = Customer, "Customer Price Group", "All Customers", Campaign;
            DataClassification = CustomerContent;
        }
        field(14; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            DecimalPlaces = 0: 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(15; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                SalesPrice: Record "Sales Price";
            begin
            end;
        }
        field(5400; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;
        }
        field(5700; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            DataClassification = CustomerContent;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(16500; "MRP Price"; Decimal)
        {
            Caption = 'MRP Price';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(16501; MRP; Boolean)
        {
            Caption = 'MRP';
            DataClassification = CustomerContent;
        }
        field(16502; "Abatement %"; Decimal)
        {
            Caption = 'Abatement %';
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(16503; "PIT Structure"; Code[10])
        {
            Caption = 'PIT Structure';
            DataClassification = CustomerContent;
        }
        field(16504; "Price Inclusive of Tax"; Boolean)
        {
            Caption = 'Price Inclusive of Tax';
            DataClassification = CustomerContent;
        }
        field(50000; Remarks; Text[200])
        {
            Description = 'ALLE 3.05';
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(50001; "Credit Note"; Decimal)
        {
            Description = 'ALLE 3.05';
            DataClassification = CustomerContent;
            Caption = 'Credit Note';
        }
        field(50002; "Special Price"; Decimal)
        {
            Description = 'Alle[Z]';
            DataClassification = CustomerContent;
            Caption = 'Special Price';
        }
        field(50003; "MSL Qty"; Decimal)
        {
            Description = 'ALLE NV';
            DataClassification = CustomerContent;
            Caption = 'MSL Qty';
        }
        field(50004; "ROL Qty"; Decimal)
        {
            Description = 'ALLE NV';
            DataClassification = CustomerContent;
            Caption = 'ROL Qty';
        }
        field(50005; "Unit Price As Per CRM"; Decimal)
        {
            Description = 'Alle NV';
            DataClassification = CustomerContent;
            Caption = 'Unit Price As Per CRM';
        }
        field(50006; "Entry No."; Guid)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
        }
        field(50007; "CRM Entry No."; Guid)
        {
            Editable = true;
            DataClassification = CustomerContent;
            Caption = 'CRM Entry No.';
        }
        field(50008; "Sales Price Inserted"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Price Inserted';
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Sales Type", "Sales Code", "Item No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity")
        {
        }
        key(Key3; "Starting Date", "Ending Date", "Item No.", "Sales Code", "Sales Type")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        "Entry No.":=CreateGuid;
    end;
    var CustPriceGr: Record "Customer Price Group";
    Text000: label '%1 cannot be after %2';
    Cust: Record Customer;
    Text001: label '%1 must be blank.';
    Campaign: Record Campaign;
    Item: Record Item;
    Text002: label 'If Sales Type = %1, then you can only change Starting Date and Ending Date from the Campaign Card.';
    ItemRec: Record Item;
    ItemUOM: Record "Item Unit of Measure";
    local procedure UpdateValuesFromItem()
    begin
        if Item.Get("Item No.")then begin
            "Allow Invoice Disc.":=Item."Allow Invoice Disc.";
            if "Sales Type" = "sales type"::"All Customers" then begin
                "Price Includes VAT":=Item."Price Includes VAT";
                "VAT Bus. Posting Gr. (Price)":=Item."VAT Bus. Posting Gr. (Price)";
            end;
        end;
    end;
    procedure CopySalesPriceToCustomersSalesPrice(var SalesPrice: Record "Sales Price"; CustNo: Code[20])
    var
        NewSalesPrice: Record "Sales Price";
    begin
        if SalesPrice.FindSet then repeat NewSalesPrice:=SalesPrice;
                NewSalesPrice."Sales Type":=NewSalesPrice."sales type"::Customer;
                NewSalesPrice."Sales Code":=CustNo;
                if NewSalesPrice.Insert then;
            until SalesPrice.Next = 0;
    end;
}
