Report 50311 "Batch SP Insertion"
{
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Price Stagging"; "SSD Sales Price Stagging")
        {
            DataItemTableView = where("Sales Price Inserted" = filter(false));

            column(ReportForNavId_1120174000; 1120174000)
            {
            }
            trigger OnAfterGetRecord()
            var
                CustomerCode: Code[20];
                CPG: Code[20];
            begin
                if "Sales Price Stagging"."Sales Type" = "Sales Price Stagging"."sales type"::Customer then
                    CustomerCode := "Sales Price Stagging"."Sales Code"
                else
                    CPG := "Sales Price Stagging"."Sales Code";
                FindSalesPrice(SalesPrice, CustomerCode, '', CPG, '', "Sales Price Stagging"."Item No.",
                "Sales Price Stagging"."Variant Code", "Sales Price Stagging"."Unit of Measure Code",
                 "Sales Price Stagging"."Currency Code", "Sales Price Stagging"."Starting Date", true);
                SalesPrice.ModifyAll("Ending Date", "Sales Price Stagging"."Starting Date" - 1);
                SalesPrice2.Init;
                //SalesPrice2.TransferFields("Sales Price Stagging");
                //  IG_DS
                SalesPrice2.Validate("Price List Code", 'S00001');
                if "Sales Price Stagging"."Sales Type" = "Sales Price Stagging"."Sales Type"::"All Customers" then
                    SalesPrice2.Validate("Source Type", SalesPrice2."Source Type"::"All Customers")
                else
                    if "Sales Price Stagging"."Sales Type" = "Sales Price Stagging"."Sales Type"::Customer then
                        SalesPrice2.Validate("Source Type", SalesPrice2."Source Type"::Customer)
                    else
                        if "Sales Price Stagging"."Sales Type" = "Sales Price Stagging"."Sales Type"::Campaign then
                            SalesPrice2.Validate("Source Type", SalesPrice2."Source Type"::Campaign)
                        else
                            if "Sales Price Stagging"."Sales Type" = "Sales Price Stagging"."Sales Type"::"Customer Price Group" then
                                SalesPrice2.Validate("Source Type", SalesPrice2."Source Type"::"Customer Price Group");
                SalesPrice2.Validate("Source No.", "Sales Price Stagging"."Sales Code");
                // SalesPrice2.Validate("Parent Source No.",
                // SalesPrice2.Validate("Source ID",
                SalesPrice2.Validate("Asset Type", SalesPrice2."Asset Type"::Item);
                SalesPrice2.Validate("Asset No.", "Sales Price Stagging"."Item No.");
                SalesPrice2.Validate("Variant Code", "Sales Price Stagging"."Variant Code");
                SalesPrice2.Validate("Currency Code", "Sales Price Stagging"."Currency Code");
                // SalesPrice2.Validate("Work Type Code",
                SalesPrice2.Validate("Starting Date", "Sales Price Stagging"."Starting Date");
                SalesPrice2.Validate("Ending Date", "Sales Price Stagging"."Ending Date");
                SalesPrice2.Validate("Minimum Quantity", "Sales Price Stagging"."Minimum Quantity");
                SalesPrice2.Validate("Unit of Measure Code", "Sales Price Stagging"."Unit of Measure Code");
                SalesPrice2.Validate("Amount Type", SalesPrice2."Amount Type"::Price);
                SalesPrice2.Validate("Assign-to No.", "Sales Price Stagging"."Sales Code");
                SalesPrice2.Validate("Unit Price", "Sales Price Stagging"."Unit Price");
                // SalesPrice2.Validate("Cost Factor",
                // SalesPrice2.Validate("Unit Cost",
                // SalesPrice2.Validate("Line Discount %",
                SalesPrice2.Validate("Allow Invoice Disc.", "Sales Price Stagging"."Allow Invoice Disc.");
                SalesPrice2.Validate("Price Includes VAT", "Sales Price Stagging"."Price Includes VAT");
                SalesPrice2.Validate("VAT Bus. Posting Gr. (Price)", "Sales Price Stagging"."VAT Bus. Posting Gr. (Price)");
                // SalesPrice2.Validate("VAT Prod. Posting Group",
                // SalesPrice2.Validate("Asset ID",
                // SalesPrice2.Validate("Line Amount",
                SalesPrice2.Validate("Price Type", SalesPrice2."Price Type"::Sale);
                // SalesPrice2.Validate(Description,
                SalesPrice2.Validate(Status, SalesPrice2.Status::Active);
                // SalesPrice2.Validate("Direct Unit Cost",
                SalesPrice2.Validate("Source Group", SalesPrice2."Source Group"::Customer);
                SalesPrice2.Validate("Product No.", "Sales Price Stagging"."Item No.");
                // SalesPrice2.Validate("Assign-to Parent No.",
                // SalesPrice2.Validate("Variant Code Lookup",
                SalesPrice2.Validate("Unit of Measure Code Lookup", "Sales Price Stagging"."Unit of Measure Code");
                SalesPrice2.Validate("Price Inclusive of Tax", "Sales Price Stagging"."Price Inclusive of Tax");
                //IG_DS
                SalesPrice2.Insert;
                "Sales Price Stagging"."Sales Price Inserted" := true;
                "Sales Price Stagging".Modify;
                Commit;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var
        SalesPrice: Record "Price List Line";//IG_DS "Sales Price";
        SalesPrice2: Record "Price List Line";//IG_DS "Sales Price";

    procedure FindSalesPrice(var ToSalesPrice: Record "Price List Line"; CustNo: Code[20]; ContNo: Code[20]; CustPriceGrCode: Code[10]; CampaignNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean)
    var
        FromSalesPrice: Record "Price List Line";//IG_DS "Sales Price";
    begin
        ToSalesPrice.SetRange("Product No.", ItemNo);
        ToSalesPrice.SetFilter("Variant Code", '%1|%2', VariantCode, '');
        ToSalesPrice.SetFilter("Ending Date", '%1|>=%2', 0D, StartingDate);
        if not ShowAll then begin
            ToSalesPrice.SetFilter("Currency Code", '%1|%2', CurrencyCode, '');
            if UOM <> '' then ToSalesPrice.SetFilter("Unit of Measure Code", '%1|%2', UOM, '');
            ToSalesPrice.SetRange("Starting Date", 0D, StartingDate);
        end;
        ToSalesPrice.SetRange("Source Type", ToSalesPrice."Source Type"::"All Customers");
        ToSalesPrice.SetRange("Assign-to No.");
        if CustNo <> '' then begin
            ToSalesPrice.SetRange("Source Type", ToSalesPrice."Source Type"::Customer);
            ToSalesPrice.SetRange("Assign-to No.", CustNo);
        end;
        if CustPriceGrCode <> '' then begin
            ToSalesPrice.SetRange("Source Type", ToSalesPrice."Source Type"::"Customer Price Group");
            ToSalesPrice.SetRange("Assign-to No.", CustPriceGrCode);
        end;
    end;
}
