table 50138 "SSD Update Item"
{
    Caption = 'SSD Update Item';
    DataClassification = ToBeClassified;

    fields
    {
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
        }
        field(6; crminsertflag; Code[20])
        {
            //Atul::01122025
            Caption = 'Insert Status';
            //Atul::01122025;
        }
        field(7; crmupdateflag; Code[20])
        {
            //Atul::01122025
            Caption = 'Update Status';
            //Atul::01122025
        }
        field(8; isCRMexception; Code[20])
        {
            //Atul::01122025
            Caption = 'Exception Occurred';
            //Atul::01122025
        }
        field(9; crmfgproduct; Code[20])
        {
            Caption = 'crmfgproduct';
        }
    }
    keys
    {
        key(PK; "Item No.")
        {
            Clustered = true;
        }
    }
}
