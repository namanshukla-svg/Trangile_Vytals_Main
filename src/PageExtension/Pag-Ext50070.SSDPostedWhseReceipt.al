PageExtension 50070 "SSD Posted Whse. Receipt" extends "Posted Whse. Receipt"
{
    layout
    {
        addafter("Document Status")
        {
            field("Gate Entry no."; Rec."Gate Entry no.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Assignment Time")
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Vendor No.1"; Rec."Vendor No.1")
            {
                ApplicationArea = all;
                Caption = 'Vendor No.';
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = all;
            }
        }
        addafter(PostedWhseRcptLines)
        {
            group(Others)
            {
                Caption = 'Others';

                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill Amount"; Rec."Bill Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Trading; Rec.Trading)
                {
                    ApplicationArea = All;
                    Caption = 'Trading';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        //Unsupported feature: Code Modification on ""&Print"(Action 30).OnAction".
        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseDocPrint.PrintPostedRcptHeader(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //WhseDocPrint.PrintPostedRcptHeader(Rec);
        //WhseDocPrint.PrintPostedRcptHeader(Rec);
        SETRECFILTER;
        REPORT.RUNMODAL(REPORT::"Posted MRN",TRUE,FALSE,Rec);
        //WhseDocPrint.PrintPostedRcptHeader(Rec);
        */
        //end;
        addafter("&Print")
        {
            action("Posted MRN Multi Lines")
            {
                ApplicationArea = All;
                Caption = 'Posted MRN Multi Lines';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()
                begin
                    //WhseDocPrint.PrintPostedRcptHeader(Rec);
                    //WhseDocPrint.PrintPostedRcptHeader(Rec);
                    Rec.SetRecfilter;
                    Report.RunModal(Report::"Posted MRN MultiDoc", true, false, Rec);
                    //WhseDocPrint.PrintPostedRcptHeader(Rec);
                end;
            }
        }
    }
    var
        UserMgt: Codeunit "SSD User Setup Management";
    //Unsupported feature: Code Modification on "OnOpenPage".
    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
        ErrorIfUserIsNotWhseEmployee;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
        ErrorIfUserIsNotWhseEmployee;
        //CF001 St
        IF UserMgt.GetRespCenterFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetRespCenterFilter);
          FILTERGROUP(0);
        END;
        //CF001 En
        */
    //end;
}
