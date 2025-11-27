Report 50151 Temp
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Quality Order Header"; "SSD Quality Order Header")
        {
            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                "Quality Order Header"."Time of Creation":="Quality Order Header"."Time of Creation";
                "Quality Order Header"."Time Of Posting":="Quality Order Header"."Time Of Posting";
                "Quality Order Header"."Time of Creation":=0T;
                "Quality Order Header"."Time Of Posting":=0T;
                Modify;
            end;
        }
        dataitem("Posted Quality Order Header"; "SSD Posted Quality Order Hdr")
        {
            column(ReportForNavId_1000000001;1000000001)
            {
            }
            trigger OnAfterGetRecord()
            begin
                "Posted Quality Order Header"."Time of Creation":="Posted Quality Order Header"."Time of Creation";
                "Posted Quality Order Header"."Time Of Posting":="Posted Quality Order Header"."Time Of Posting";
                "Posted Quality Order Header"."Time of Creation":=0T;
                "Posted Quality Order Header"."Time Of Posting":=0T;
                Modify;
            end;
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
    labels
    {
    }
}
