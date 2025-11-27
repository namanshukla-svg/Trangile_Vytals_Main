Page 50276 "CCare Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724708)
            {
                part(Control1903012608; "Copy Profile")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = All;
                    Visible = true;
                }
            }
        }
    }
    actions
    {
    }
}
