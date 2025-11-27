XmlPort 50020 "Update Requisition Lines"
{
    Format = VariableText;

    schema
    {
    textelement(RequisionSlipLine1)
    {
    tableelement("Requision Slip Line";
    "SSD Requision Slip Line")
    {
    XmlName = 'RequisionSlipLine';

    fieldelement(a;
    "Requision Slip Line"."Line No.")
    {
    }
    fieldelement(b;
    "Requision Slip Line"."Item No.")
    {
    }
    fieldelement(c;
    "Requision Slip Line".Quantity)
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
