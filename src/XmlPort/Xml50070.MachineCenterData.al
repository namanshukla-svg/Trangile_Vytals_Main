XmlPort 50070 "Machine Center Data"
{
    Format = VariableText;

    schema
    {
    textelement(MachineCenter1)
    {
    tableelement("Machine Center";
    "Machine Center")
    {
    XmlName = 'MachineCenter';

    fieldelement(a;
    "Machine Center"."No.")
    {
    }
    fieldelement(b;
    "Machine Center".Name)
    {
    }
    fieldelement(c;
    "Machine Center"."Search Name")
    {
    }
    fieldelement(d;
    "Machine Center"."Work Center No.")
    {
    }
    fieldelement(e;
    "Machine Center".Capacity)
    {
    }
    fieldelement(f;
    "Machine Center".Efficiency)
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
