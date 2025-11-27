tableextension 50070 "SSD Purchases & Payables Setup" extends "Purchases & Payables Setup"
/// <summary>
/// TableExtension SSD Purchases Payables Setup (ID 50070) extends Record Purchases Payables Setup.
/// </summary>
{
    fields
    {
        field(50000; "Create RG23D at Receipt"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Create RG23D at Receipt';
        }
        field(50001; "Create RG 23 A or C at receipt"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Create RG 23 A or C at receipt';
        }
        field(50002; "Import PO"; Code[10])
        {
            Description = 'ALLE';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Import PO';
        }
        field(50003; "Item Charge No."; Code[10])
        {
            Description = 'ALLE-AT';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Item Charge No.';
        }
        field(53500; "SSD Service Grace Period"; DateFormula)
        {
            Caption = 'Service Grace Period';
            DataClassification = CustomerContent;
        }
        field(53501; "SSD SPO Alert Mail"; Text[250])
        {
            Caption = 'Default SPO Alert Mail';
            DataClassification = CustomerContent;
        }
        field(54500; "Receipt Challan Nos."; Code[10])
        {
            Caption = 'Receipt Challan Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(71000; "GSTR 2 Client ID"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR 2 Client ID';
        }
        field(71001; "GSTR 1 Client ID"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR 1 Client ID';
        }
        field(71002; "GSTR 2 Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR 2 Start Date';
        }
        field(71003; "GSTR 1 Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR 1 Start Date';
        }
        field(71004; "FTP User ID"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'FTP User ID';
        }
        field(71005; "FTP User Password"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'FTP User Password';
        }
        field(71006; "GSTR Local Folder"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR Local Folder';
        }
        field(71007; "GSTR FTP Input"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'GSTR FTP Input';
        }
    }
}
