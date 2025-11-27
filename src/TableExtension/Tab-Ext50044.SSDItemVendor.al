TableExtension 50044 "SSD Item Vendor" extends "Item Vendor"
{
    fields
    {
        field(50001; "Concerted Quality"; Boolean)
        {
            Caption = 'Concerted Quality';
            Description = 'QTY';
            DataClassification = CustomerContent;
        }
        field(50010; "Item %"; Decimal)
        {
            Description = 'SOB';
            DataClassification = CustomerContent;
            Caption = 'Item %';

            trigger OnValidate()
            begin
                TotalPer:=0;
                ItemVendor.Reset();
                ItemVendor.SetFilter(ItemVendor."Vendor No.", '<>%1', "Vendor No.");
                ItemVendor.SetRange(ItemVendor."Item No.", "Item No.");
                ItemVendor.SetRange(ItemVendor."Variant Code", "Variant Code");
                if ItemVendor.FindFirst()then repeat TotalPer+=ItemVendor."Item %";
                    until ItemVendor.Next = 0;
                if TotalPer + "Item %" > 100 then Error(Text001, ItemVendor.FieldCaption(ItemVendor."Item %"));
            end;
        }
        field(50011; "Scrap Qty. Per Unit"; Decimal)
        {
            Description = 'ALLEAA CML-033 190408';
            DataClassification = CustomerContent;
            Caption = 'Scrap Qty. Per Unit';
        }
        field(50012; "Scrap Item"; Code[20])
        {
            Description = 'ALLEAA CML-033 190408';
            DataClassification = CustomerContent;
            Caption = 'Scrap Item';
        }
        field(50015; "Validity Period Start Date"; Date)
        {
            Caption = 'Validity Period Start Date';
            DataClassification = ToBeClassified;
        }
        field(50016; "Validity Period End Date"; Date)
        {
            Caption = 'Validity Period End Date';
            DataClassification = ToBeClassified;
        }
        field(50017; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = ToBeClassified;
        }
        field(50018; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            DataClassification = ToBeClassified;
        }
        field(50019; "Attached Doc Count"; Integer)
        {
            BlankNumbers = DontBlank;
            FieldClass = FlowField;
            CalcFormula = count("Document Attachment" where("Table ID"=const(99), "No."=field("Vendor No."), "Item No."=field("Item No."), "Variant No."=field("Variant Code")));
            Caption = 'Attached Doc Count';
        }
        field(50020; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        modify("Vendor No.")
        {
        trigger OnAfterValidate()
        var
            Vendor: Record Vendor;
        begin
            if Vendor.Get("Vendor No.")then "Vendor Name":=Vendor.Name
            else
                "Vendor Name":='';
        end;
        }
    }
    // keys
    // {
    //     key(CustomKey; "Item No.", "Vendor No.", "Variant Code", "Validity Period Start Date", "Validity Period End Date")
    //     {
    //     }
    // }
    trigger OnInsert()
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Item Vendor Permission" then Error(ItemVendorError);
    end;
    trigger OnModify()
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Item Vendor Permission" then Error(ItemVendorError);
    end;
    var ItemVendor: Record "Item Vendor";
    TotalPer: Decimal;
    Text001: label 'Total of %1 can not be greater than 100.';
    ItemVendorError: Label 'You do not have a permission.';
    UserSetup: Record "User Setup";
}
