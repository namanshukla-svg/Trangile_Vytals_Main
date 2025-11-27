XmlPort 50003 PostCode
{
    Format = VariableText;

    schema
    {
    textelement(PostCode1)
    {
    tableelement("Post Code";
    "Post Code")
    {
    XmlName = 'PostCode';

    fieldelement(a;
    "Post Code".Code)
    {
    }
    fieldelement(b;
    "Post Code".City)
    {
    }
    fieldelement(c;
    "Post Code"."Search City")
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
