enum 55003 "SRN Approval"
{
    Extensible = true;

    // value(0; " ")
    // {
    //     Caption = ' ';
    // }
    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; "Pending For Approval")
    {
        Caption = 'Pending For Approval';
    }
    value(2; Released)
    {
        Caption = 'Released';
    }
}