page 50165 "Label Printing Role Center"
{
    Caption = 'Label Printing Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(RoleCenter)
        {
            part(Control100; "Headline RC Administrator")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(embedding)
        {
            ToolTip = 'Manage Administrator Processes.';

            action(BarcodeLabel)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Barcode Label';
                RunObject = page "Barcode Label";
            }
            action(SubcontractingOrderList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Subcontracting Order List';
                RunObject = page "Subcontracting Order List";
            }
            action(MaterialReceiptNoteList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Material Receipt Note List';
                RunObject = page "Material Receipt Note List";
            }
            action(PostedWhseReceiptList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Whse. Receipt List';
                RunObject = page "Posted Whse. Receipt List";
            }
            action(ItemList)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Item List';
                RunObject = page "Item List";
            }
            action(IndentList)
            {
                ApplicationArea = Basic, Suites;
                Caption = 'Indent List';
                RunObject = page "Indent List";
            }
        }
    }
}
