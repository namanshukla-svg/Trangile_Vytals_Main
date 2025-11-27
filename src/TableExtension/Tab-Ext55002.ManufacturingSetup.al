tableextension 55002 ManufacturingSetup extends "Manufacturing Setup"
{
    fields
    {
        // Add changes to table fields here
        field(55001; "Label QR Code"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}