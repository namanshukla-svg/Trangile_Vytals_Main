XmlPort 50004 PaymentTermCode
{
    Format = VariableText;

    schema
    {
    textelement(PaymentTermCode1)
    {
    tableelement("Payment Terms";
    "Payment Terms")
    {
    XmlName = 'PaymentTermCode';

    fieldelement(a;
    "Payment Terms".Code)
    {
    }
    fieldelement(b;
    "Payment Terms"."Due Date Calculation")
    {
    }
    fieldelement(c;
    "Payment Terms"."Discount Date Calculation")
    {
    }
    fieldelement(d;
    "Payment Terms"."Discount %")
    {
    }
    fieldelement(e;
    "Payment Terms".Description)
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
