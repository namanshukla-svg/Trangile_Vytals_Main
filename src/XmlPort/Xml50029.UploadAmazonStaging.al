XmlPort 50029 "Upload Amazon Staging"
{
    // Alle-[Amazon-HG]-Created a new XMLPort for Amazon Sales Invoice Staging.
    Direction = Import;
    Format = VariableText;
    UseRequestPage = true;

    schema
    {
    textelement(Root)
    {
    tableelement("Amazon Staging";
    "SSD Amazon Staging")
    {
    XmlName = 'AS';
    UseTemporary = false;

    fieldelement(azorderid;
    "Amazon Staging"."Amazon OrderId")
    {
    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."Amazon OrderId" = '' then Error('Amazon Order Id. must have a value %1', "Amazon Staging"."Amazon OrderId");
    end;
    }
    fieldelement(azinvoceno;
    "Amazon Staging"."Amazon Posted Invoice No.")
    {
    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."Entry Type" = "Amazon Staging"."entry type"::Invoice then begin
            if "Amazon Staging"."Amazon Posted Invoice No." = '' then Error('Amazon Invoice No. must have a value it is Mandatory %1', "Amazon Staging"."Amazon Posted Invoice No.");
        end
        else if "Amazon Staging"."Entry Type" = "Amazon Staging"."entry type"::"Credit Memo" then begin
                if "Amazon Staging"."Amazon Posted Invoice No." <> '' then Error('In case of Entry type as Credit Memo Amazone Invoice No. must be Blank');
            end;
    end;
    }
    fieldelement(postingdate;
    "Amazon Staging"."Posting Date")
    {
    MinOccurs = Zero;

    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."Posting Date" = 0D then Error('Posting Date must have a value %1', "Amazon Staging"."Posting Date");
    end;
    }
    fieldelement(zdcustomercode;
    "Amazon Staging"."ZD Customer Code")
    {
    MinOccurs = Zero;

    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."ZD Customer Code" = '' then Error('Customer No. must have a value for ZD Customer Code %1', "Amazon Staging"."ZD Customer Code");
    end;
    }
    fieldelement(endcustname;
    "Amazon Staging"."End Customer Name")
    {
    MinOccurs = Zero;

    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."End Customer Name" = '' then Error('End Customer Name. must have a value %1', "Amazon Staging"."End Customer Name");
    end;
    }
    fieldelement(endcustnameaddress;
    "Amazon Staging"."End Customer Name Address")
    {
    MinOccurs = Zero;

    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."End Customer Name Address" = '' then Error('End Customer Name Address. must have a value %1', "Amazon Staging"."End Customer Name Address");
    end;
    }
    fieldelement(zdfgcode;
    "Amazon Staging"."ZD FG Code")
    {
    MinOccurs = Zero;

    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."ZD FG Code" = '' then Error('ZD FG Code. must have a value %1', "Amazon Staging"."ZD FG Code");
    end;
    }
    fieldelement(sku;
    "Amazon Staging".SKU)
    {
    MinOccurs = Zero;

    trigger OnAfterAssignField()
    begin
        if "Amazon Staging".SKU = '' then Error('SKU. must have a value %1', "Amazon Staging".SKU);
    end;
    }
    fieldelement(qtyshipped;
    "Amazon Staging"."Quantity Shipped")
    {
    MinOccurs = Zero;

    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."Quantity Shipped" = 0 then Error('Quantity Shipped. must have a value %1', "Amazon Staging"."Quantity Shipped");
    end;
    }
    fieldelement(itemprice;
    "Amazon Staging"."Item Price")
    {
    MinOccurs = Zero;

    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."Item Price" = 0 then Error('Item Price must have a value %1', "Amazon Staging"."Item Price");
    end;
    }
    fieldelement(shippingprice;
    "Amazon Staging"."Shipping Price")
    {
    MinOccurs = Zero;
    }
    fieldelement(shippingpromodisc;
    "Amazon Staging"."Ship Promotion Discount")
    {
    }
    fieldelement(Custshiptocode;
    "Amazon Staging"."Customer Ship-to-Code")
    {
    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."Customer Ship-to-Code" = '' then Error('Ship-to Code must have a value %1', "Amazon Staging"."Customer Ship-to-Code");
    end;
    }
    fieldelement(entrytype;
    "Amazon Staging"."Entry Type")
    {
    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."Entry Type" = "Amazon Staging"."entry type"::" " then Error('Entry Type must have a value %1', "Amazon Staging"."Entry Type");
    end;
    }
    fieldelement(originalinvoiceno;
    "Amazon Staging"."Original Invoice No.")
    {
    trigger OnAfterAssignField()
    begin
        if "Amazon Staging"."Entry Type" = "Amazon Staging"."entry type"::"Credit Memo" then begin
            if "Amazon Staging"."Original Invoice No." = '' then Error('In case of Entry type as Credit Memo Original Invoice No. must have a value');
        end
        else if "Amazon Staging"."Entry Type" = "Amazon Staging"."entry type"::Invoice then begin
                if "Amazon Staging"."Original Invoice No." <> '' then Error('In case of Entry type as Invoice  Original Invoice No. must be Blank');
            end;
    end;
    }
    trigger OnAfterInitRecord()
    begin
        if firstline then begin
            firstline:=false;
            currXMLport.Skip;
        end;
    end;
    trigger OnBeforeInsertRecord()
    begin
        AZ.Reset;
        AZ.SetRange("Entry Type", "Amazon Staging"."Entry Type");
        AZ.SetRange("Amazon OrderId", "Amazon Staging"."Amazon OrderId");
        if AZ.FindSet then repeat if AZ."Invoice/Credit Memo Created" = true then currXMLport.Skip;
            until AZ.Next = 0;
    end;
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
    trigger OnPostXmlPort()
    begin
        Message('Amazon Invoice Data Import is Complete');
    end;
    trigger OnPreXmlPort()
    begin
        firstline:=true;
    end;
    var Text0001: label 'Line Already Exist For  Item %1';
    firstline: Boolean;
    AZ: Record "SSD Amazon Staging";
}
