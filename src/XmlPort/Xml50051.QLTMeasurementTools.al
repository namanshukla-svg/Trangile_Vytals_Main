XmlPort 50051 "QLT Measurement Tools"
{
    Format = VariableText;

    schema
    {
    textelement(MeasurementTools1)
    {
    tableelement("Measurement Tools";
    "SSD Measurement Tools")
    {
    XmlName = 'MeasurementTools';

    fieldelement(a;
    "Measurement Tools".Code)
    {
    }
    fieldelement(b;
    "Measurement Tools".Description)
    {
    }
    fieldelement(c;
    "Measurement Tools"."Measure Value Type")
    {
    }
    fieldelement(d;
    "Measurement Tools"."Unit of Measure Code")
    {
    }
    fieldelement(e;
    "Measurement Tools"."Responsibility Center")
    {
    }
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
}
