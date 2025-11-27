Table 50056 "SSD ASP Buffer"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry ID"; Guid)
        {
            Caption = 'Entry ID';
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Invoice/Debit Note/ Credit Note / Receipt Voucher/ Refund Voucher';
            DataClassification = CustomerContent;
        }
        field(3; "Company Code"; Code[50])
        {
            Caption = 'Company Code';
            DataClassification = CustomerContent;
        }
        field(4; "Company Name"; Text[100])
        {
            Caption = 'Company Name';
            DataClassification = CustomerContent;
        }
        field(5; State; Code[50])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(6; GSTIN; Code[20])
        {
            Caption = 'GSTIN';
            DataClassification = CustomerContent;
        }
        field(7; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(8; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(9; "Accounting Document No."; Code[20])
        {
            Caption = 'Accounting Document No.';
            DataClassification = CustomerContent;
        }
        field(10; "Accounting Document Date"; Date)
        {
            Caption = 'Accounting Document Date';
            DataClassification = CustomerContent;
        }
        field(11; "Transaction Count"; Integer)
        {
            Caption = 'Transaction Count';
            DataClassification = CustomerContent;
        }
        field(12; Currency; Code[10])
        {
            Caption = 'Currency';
            DataClassification = CustomerContent;
        }
        field(13; "Document Type"; Text[30])
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(14; Taxability; Text[30])
        {
            Caption = 'Taxability';
            DataClassification = CustomerContent;
        }
        field(15; "Supply Type"; Text[30])
        {
            Caption = 'Supply Type';
            DataClassification = CustomerContent;
        }
        field(16; "Customer Code"; Code[20])
        {
            Caption = 'Customer Code';
            DataClassification = CustomerContent;
        }
        field(17; "Nature of Receipient"; Text[30])
        {
            Caption = 'Nature of Receipient';
            DataClassification = CustomerContent;
        }
        field(18; "GSTIN of Receipient"; Text[30])
        {
            Caption = 'GSTIN/UIN of Receipient';
            DataClassification = CustomerContent;
        }
        field(19; "Receipient State"; Code[30])
        {
            Caption = 'Receipient State';
            DataClassification = CustomerContent;
        }
        field(20; "Invoice Date"; Date)
        {
            Caption = 'Invoice/Debit Note/ Credit Note / Receipt Voucher/ Refund Voucher';
            DataClassification = CustomerContent;
        }
        field(21; "Invoice Value"; Decimal)
        {
            Caption = 'Invoice/Debit Note/ Credit Note / Receipt Voucher/ Refund Voucher';
            DataClassification = CustomerContent;
        }
        field(22; "Line Item"; Integer)
        {
            Caption = 'Line Item';
            DataClassification = CustomerContent;
        }
        field(23; "Item Code"; Code[20])
        {
            Caption = 'Item Code';
            DataClassification = CustomerContent;
        }
        field(24; Category; Text[30])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
        }
        field(25; "HSN/SAC Code"; Code[20])
        {
            Caption = 'HSN/SAC Code';
            DataClassification = CustomerContent;
        }
        field(26; UQC; Code[10])
        {
            Caption = 'UQC';
            DataClassification = CustomerContent;
        }
        field(27; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(28; "Taxable Value"; Decimal)
        {
            Caption = 'Taxable Value';
            DataClassification = CustomerContent;
        }
        field(29; "Total GST Rate"; Decimal)
        {
            Caption = 'Total GST Rate';
            DataClassification = CustomerContent;
        }
        field(30; "IGST Rate"; Decimal)
        {
            Caption = 'IGST Rate';
            DataClassification = CustomerContent;
        }
        field(31; "IGST Amount"; Decimal)
        {
            Caption = 'IGST Amount';
            DataClassification = CustomerContent;
        }
        field(32; "CGST Rate"; Decimal)
        {
            Caption = 'CGST Rate';
            DataClassification = CustomerContent;
        }
        field(33; "CGST Amount"; Decimal)
        {
            Caption = 'CGST Amount';
            DataClassification = CustomerContent;
        }
        field(34; "SGST Rate"; Decimal)
        {
            Caption = 'SGST Rate';
            DataClassification = CustomerContent;
        }
        field(35; "SGST Amount"; Decimal)
        {
            Caption = 'SGST Amount';
            DataClassification = CustomerContent;
        }
        field(36; "Credit Note Document No."; Code[20])
        {
            Caption = 'Credit Note / Debit Note/ Refund Voucher';
            DataClassification = CustomerContent;
        }
        field(37; "Credit Note Date"; Text[10])
        {
            Caption = 'Credit Note / Debit Note/ Refund Voucher';
            DataClassification = CustomerContent;
        }
        field(38; "Entry DateTime"; DateTime)
        {
            Caption = 'Entry DateTime';
            DataClassification = CustomerContent;
        }
        field(39; "Created By"; Code[22])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(40; "GL Account"; Code[10])
        {
            Caption = 'GL Account';
            DataClassification = CustomerContent;
        }
        field(41; "Nature of exemption"; Text[10])
        {
            Caption = 'Nature of exemption';
            DataClassification = CustomerContent;
        }
        field(42; "Name of the Receipient"; Text[50])
        {
            Caption = 'Name of the Receipient';
            DataClassification = CustomerContent;
        }
        field(43; "Reverse Charge"; Text[2])
        {
            Caption = 'Supply attract reverse Charge';
            DataClassification = CustomerContent;
        }
        field(44; "POS State"; Text[30])
        {
            Caption = 'POS State';
            DataClassification = CustomerContent;
        }
        field(45; "GSTIN of e-commerce"; Code[20])
        {
            Caption = 'GSTIN of e-commerce portal';
            DataClassification = CustomerContent;
        }
        field(46; "Product Description"; Text[50])
        {
            Caption = 'Product Description';
            DataClassification = CustomerContent;
        }
        field(47; "Sales Price"; Decimal)
        {
            Caption = 'Sales Price';
            DataClassification = CustomerContent;
        }
        field(48; Discount; Decimal)
        {
            Caption = 'Discount';
            DataClassification = CustomerContent;
        }
        field(49; "Net Sales Price"; Decimal)
        {
            Caption = 'Net Sales Price';
            DataClassification = CustomerContent;
        }
        field(50; VAT; Decimal)
        {
            Caption = 'VAT';
            DataClassification = CustomerContent;
        }
        field(51; "Central Excise"; Decimal)
        {
            Caption = 'Central Excise';
            DataClassification = CustomerContent;
        }
        field(52; "State Excise"; Decimal)
        {
            Caption = 'State Excise';
            DataClassification = CustomerContent;
        }
        field(53; "Ship From"; Code[10])
        {
            Caption = 'Ship From';
            DataClassification = CustomerContent;
        }
        field(54; "Ship To"; Code[10])
        {
            Caption = 'Ship To';
            DataClassification = CustomerContent;
        }
        field(55; "Way Bill No"; Code[20])
        {
            Caption = 'Way Bill No';
            DataClassification = CustomerContent;
        }
        field(56; "Transporter Name"; Text[30])
        {
            Caption = 'Transporter Name';
            DataClassification = CustomerContent;
        }
        field(57; "Lorry Receipt Number"; Code[10])
        {
            Caption = 'Lorry Receipt Number';
            DataClassification = CustomerContent;
        }
        field(58; "Lorry Receipt Date"; Text[10])
        {
            Caption = 'Lorry Receipt Date';
            DataClassification = CustomerContent;
        }
        field(59; "Reason for Issuing"; Text[30])
        {
            Caption = 'Reason for Issuing';
            DataClassification = CustomerContent;
        }
        field(60; "Advance Adjustment Date"; Text[10])
        {
            Caption = 'Advance Adjustment Date';
            DataClassification = CustomerContent;
        }
        field(61; "Cess Rate"; Decimal)
        {
            Caption = 'Cess Rate';
            DataClassification = CustomerContent;
        }
        field(62; "Cess Amount"; Decimal)
        {
            Caption = 'Cess Amount';
            DataClassification = CustomerContent;
        }
        field(63; "Eligibility of ITC"; Code[2])
        {
            Caption = 'Eligibility of ITC';
            DataClassification = CustomerContent;
        }
        field(64; "ITC IGST Amount"; Decimal)
        {
            Caption = 'ITC IGST Amount';
            DataClassification = CustomerContent;
        }
        field(65; "ITC CGST Amount"; Decimal)
        {
            Caption = 'ITC CGST Amount';
            DataClassification = CustomerContent;
        }
        field(66; "ITC SGST Amount"; Decimal)
        {
            Caption = 'ITC SGST Amount';
            DataClassification = CustomerContent;
        }
        field(67; "ITC Cess Amount"; Decimal)
        {
            Caption = 'ITC Cess Amount';
            DataClassification = CustomerContent;
        }
        field(68; "Assessable Value Before BCD"; Decimal)
        {
            Caption = 'Assessable Value Before BCD';
            DataClassification = CustomerContent;
        }
        field(69; "Basic Custom Duty"; Decimal)
        {
            Caption = 'Basic Custom Duty';
            DataClassification = CustomerContent;
        }
        field(70; "Port Code"; Code[10])
        {
            Caption = 'Port Code';
            DataClassification = CustomerContent;
        }
        field(71; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Sale,Purchase,Transfer Receipt,Transfer Shipment';
            OptionMembers = " ", Sale, Purchase, "Transfer Receipt", "Transfer Shipment";
            Caption = 'Transaction Type';
            DataClassification = CustomerContent;
        }
        field(72; "External Document No"; Code[35])
        {
            Caption = 'External Document No';
            DataClassification = CustomerContent;
        }
        field(73; "Actual HSN Code"; Code[20])
        {
            Caption = 'Actual HSN Code';
            DataClassification = CustomerContent;
        }
        field(74; Nos; Integer)
        {
            Caption = 'Nos';
            DataClassification = CustomerContent;
        }
        field(75; "Application Document No"; Code[20])
        {
            Caption = 'Application Document No';
            DataClassification = CustomerContent;
        }
        field(76; "Total Value"; Decimal)
        {
            Caption = 'Total Value';
            DataClassification = CustomerContent;
        }
        field(77; IBT; Code[20])
        {
            Caption = 'IBT';
            DataClassification = CustomerContent;
        }
        field(78; "Source Type"; Option)
        {
            Editable = false;
            OptionMembers = " ", Customer, Vendor;
            Caption = 'Source Type';
            DataClassification = CustomerContent;
        }
        field(79; "Source No."; Code[20])
        {
            Editable = false;
            TableRelation = if("Source Type"=const(Customer))Customer
            else if("Source Type"=const(Vendor))Vendor;
            Caption = 'Source No.';
            DataClassification = CustomerContent;
        }
        field(80; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = CustomerContent;
        }
        field(81; Exempted; Boolean)
        {
            Caption = 'Exempted';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Entry ID")
        {
            Clustered = true;
        }
        key(Key2; Nos)
        {
        }
    }
    fieldgroups
    {
    }
}
