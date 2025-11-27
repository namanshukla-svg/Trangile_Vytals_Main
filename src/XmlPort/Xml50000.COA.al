XmlPort 50000 COA
{
    Format = VariableText;

    schema
    {
    textelement(COA1)
    {
    tableelement("G/L Account";
    "G/L Account")
    {
    XmlName = 'COA';

    fieldelement(A;
    "G/L Account"."No.")
    {
    }
    fieldelement(B;
    "G/L Account".Name)
    {
    }
    fieldelement(C;
    "G/L Account"."Search Name")
    {
    }
    fieldelement(D;
    "G/L Account"."Income/Balance")
    {
    }
    fieldelement(E;
    "G/L Account"."Account Type")
    {
    }
    fieldelement(F;
    "G/L Account".Totaling)
    {
    }
    fieldelement(G;
    "G/L Account"."Direct Posting")
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
