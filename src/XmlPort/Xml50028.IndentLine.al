XmlPort 50028 IndentLine
{
    UseDefaultNamespace = true;

    schema
    {
    textelement(Root)
    {
    tableelement("Posted Indent Line";
    "SSD Posted Indent Line")
    {
    XmlName = 'IndentLine';
    SourceTableView = where("Created Doc. No."=filter(=''));

    fieldelement(DocumentNo;
    "Posted Indent Line"."Document No.")
    {
    }
    fieldelement(LineNo;
    "Posted Indent Line"."Line No.")
    {
    }
    fieldelement(No;
    "Posted Indent Line"."No.")
    {
    }
    fieldelement(Description;
    "Posted Indent Line".Description)
    {
    }
    fieldelement(Description2;
    "Posted Indent Line"."Description 2")
    {
    }
    fieldelement(Quantity;
    "Posted Indent Line".Quantity)
    {
    }
    fieldelement(Remarks;
    "Posted Indent Line".Remarks)
    {
    }
    fieldelement(VariantCode;
    "Posted Indent Line"."Variant Code")
    {
    }
    fieldelement(UnitOfMeasureCode;
    "Posted Indent Line"."Unit Of Measure Code")
    {
    }
    fieldelement(QuantityBase;
    "Posted Indent Line"."Quantity (Base)")
    {
    }
    fieldelement(ItemCatagoryCode;
    "Posted Indent Line"."Item Category Code")
    {
    }
    fieldelement(IndentDate;
    "Posted Indent Line"."Indent Date")
    {
    }
    }
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
}
