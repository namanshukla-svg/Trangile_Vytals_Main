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
            Caption = 'crminsertflag';
        }
        field(7; crmupdateflag; Code[20])
        {
            Caption = 'crmupdateflag';
        }
        field(8; isCRMexception; Code[20])
        {
            Caption = 'isCRMexception';
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
