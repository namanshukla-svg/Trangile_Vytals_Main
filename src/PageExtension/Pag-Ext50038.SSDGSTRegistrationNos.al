PageExtension 50038 "SSD GST Registration Nos." extends "GST Registration Nos."
{
    actions
    {
        addlast(Processing)
        {
            action("Export Purchase Data")
            {
                ApplicationArea = All;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Export GSTR 2 Reco. Data";
            }
            action("Export Sales Data")
            {
                ApplicationArea = All;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Export GSTR 1 Data";
            }
        }
    }
}
