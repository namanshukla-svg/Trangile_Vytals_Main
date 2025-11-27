XmlPort 50081 "Item Journal - postive-Lot"
{
    Format = VariableText;

    schema
    {
    textelement(ItemJournalLine1)
    {
    tableelement("Reservation Entry";
    "Reservation Entry")
    {
    XmlName = 'ItemJournalLine';

    fieldelement(a;
    "Reservation Entry"."Source ID")
    {
    }
    fieldelement(b;
    "Reservation Entry".Positive)
    {
    }
    fieldelement(c;
    "Reservation Entry"."Source Ref. No.")
    {
    }
    fieldelement(d;
    "Reservation Entry"."Creation Date")
    {
    }
    fieldelement(e;
    "Reservation Entry"."Item No.")
    {
    }
    fieldelement(f;
    "Reservation Entry"."Source Batch Name")
    {
    }
    fieldelement(g;
    "Reservation Entry"."Location Code")
    {
    }
    fieldelement(h;
    "Reservation Entry"."Bin Code")
    {
    }
    fieldelement(i;
    "Reservation Entry"."Quantity (Base)")
    {
    }
    fieldelement(j;
    "Reservation Entry"."Lot No.")
    {
    }
    fieldelement(k;
    "Reservation Entry"."Reservation Status")
    {
    }
    fieldelement(l;
    "Reservation Entry"."Responsibility Center")
    {
    }
    fieldelement(m;
    "Reservation Entry"."Source Type")
    {
    }
    fieldelement(n;
    "Reservation Entry"."Source Subtype")
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
