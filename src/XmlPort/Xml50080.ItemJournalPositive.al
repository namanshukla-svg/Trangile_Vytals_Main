XmlPort 50080 "Item Journal - Positive"
{
    Format = VariableText;

    schema
    {
    textelement(ItemJournalLine1)
    {
    tableelement("Item Journal Line";
    "Item Journal Line")
    {
    XmlName = 'ItemJournalLine';

    fieldelement(a;
    "Item Journal Line"."Journal Template Name")
    {
    }
    fieldelement(b;
    "Item Journal Line"."Journal Batch Name")
    {
    }
    fieldelement(c;
    "Item Journal Line"."Line No.")
    {
    }
    fieldelement(d;
    "Item Journal Line"."Posting Date")
    {
    }
    fieldelement(e;
    "Item Journal Line"."Item No.")
    {
    }
    fieldelement(f;
    "Item Journal Line"."Entry Type")
    {
    }
    fieldelement(g;
    "Item Journal Line"."Document No.")
    {
    }
    fieldelement(h;
    "Item Journal Line"."Location Code")
    {
    }
    fieldelement(i;
    "Item Journal Line"."Bin Code")
    {
    }
    fieldelement(j;
    "Item Journal Line".Quantity)
    {
    }
    fieldelement(k;
    "Item Journal Line"."Invoiced Quantity")
    {
    }
    fieldelement(l;
    "Item Journal Line"."Unit Amount")
    {
    }
    fieldelement(m;
    "Item Journal Line"."Unit Cost")
    {
    }
    fieldelement(n;
    "Item Journal Line"."Responsibility Center")
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
