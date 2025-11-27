pageextension 50135 "Whse. Receipt Subform" extends "Whse. Receipt Subform"
{
    layout
    {
        addafter("Qty. per Unit of Measure")
        {
            field("Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Direct Unit Cost field.', Comment = '%';
            }
        }
    }
}
