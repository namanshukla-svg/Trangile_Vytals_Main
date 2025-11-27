XmlPort 50075 "Quality req. on routing Line"
{
    Format = VariableText;

    schema
    {
    textelement(RoutingLine1)
    {
    tableelement("Routing Line";
    "Routing Line")
    {
    XmlName = 'RoutingLine';

    fieldelement(a;
    "Routing Line"."Routing No.")
    {
    }
    fieldelement(b;
    "Routing Line"."Operation No.")
    {
    }
    fieldelement(c;
    "Routing Line"."Quality Required")
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
