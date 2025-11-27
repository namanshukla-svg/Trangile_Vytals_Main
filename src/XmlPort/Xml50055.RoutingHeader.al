XmlPort 50055 "Routing Header"
{
    Format = VariableText;

    schema
    {
    textelement(RoutingHeader1)
    {
    tableelement("Routing Header";
    "Routing Header")
    {
    XmlName = 'RoutingHeader';

    fieldelement(a;
    "Routing Header"."No.")
    {
    }
    fieldelement(b;
    "Routing Header".Description)
    {
    }
    fieldelement(c;
    "Routing Header"."Description 2")
    {
    }
    fieldelement(d;
    "Routing Header"."Search Description")
    {
    }
    fieldelement(e;
    "Routing Header".Type)
    {
    }
    fieldelement(f;
    "Routing Header".Status)
    {
    }
    fieldelement(g;
    "Routing Header"."Responsibility Center")
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
