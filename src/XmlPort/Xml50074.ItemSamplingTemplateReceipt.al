XmlPort 50074 "Item Sampling Template-Receipt"
{
    Format = VariableText;

    schema
    {
    textelement(ItemSamplingTemplate1)
    {
    tableelement("Item Sampling Template";
    "Item Sampling Template")
    {
    XmlName = 'ItemSamplingTemplate';

    fieldelement(a;
    "Item Sampling Template"."Item Code")
    {
    }
    fieldelement(b;
    "Item Sampling Template"."Sampling Temp. No.")
    {
    }
    fieldelement(c;
    "Item Sampling Template"."Template Type")
    {
    }
    fieldelement(d;
    "Item Sampling Template"."Responsibility Center")
    {
    }
    fieldelement(e;
    "Item Sampling Template".Active)
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
