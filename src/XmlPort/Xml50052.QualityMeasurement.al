XmlPort 50052 "Quality Measurement"
{
    Format = VariableText;

    schema
    {
    textelement(QualityMeasurements1)
    {
    tableelement("Quality Measurements";
    "SSD Quality Measurements")
    {
    XmlName = 'QualityMeasurements';

    fieldelement(a;
    "Quality Measurements".Code)
    {
    }
    fieldelement(b;
    "Quality Measurements".Description)
    {
    }
    fieldelement(c;
    "Quality Measurements"."Responsibility Center")
    {
    }
    fieldelement(d;
    "Quality Measurements"."Measurement Tool Code")
    {
    }
    fieldelement(e;
    "Quality Measurements"."Measurement Tool Descr.")
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
