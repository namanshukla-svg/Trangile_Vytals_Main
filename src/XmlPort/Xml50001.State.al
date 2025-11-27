XmlPort 50001 State
{
    Format = VariableText;

    schema
    {
    textelement(STATE1)
    {
    tableelement(State;
    State)
    {
    XmlName = 'STATE';

    fieldelement(a;
    State.Code)
    {
    }
    fieldelement(b;
    State.Description)
    {
    }
    fieldelement(c;
    State."State Code for eTDS/TCS")
    {
    }
    fieldelement(d;
    State."State Code (GST Reg. No.)")
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
