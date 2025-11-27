PageExtension 50074 pageextension70000269 extends "Production BOM Lines"
{
    layout
    {
        addafter(Description)
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
            field("Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Where-Used")
        {
            action(BOM)
            {
                ApplicationArea = All;
                Caption = 'BOM';

                trigger OnAction()
                begin
                    //This functionality was copied from page #99000786. Unsupported part was commented. Please check it.
                    /*CurrPage.ProdBOMLine.PAGE.*/
                    ShowBOM;
                end;
            }
        }
    }
    var ProdBOMHeader: Record "Production BOM Header";
    UserMgt: Codeunit "SSD User Setup Management";
    ProdBOMHeader2: Record "Production BOM Header";
    ProductionBOM: Page "Production BOM";
    //Unsupported feature: Code Modification on "OnNewRecord".
    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Type := xRec.Type;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //CF001 St
    Type := xRec.Type;

    IF ProdBOMHeader.GET("Production BOM No.") THEN
      BEGIN
        "Responsibility Center" :=ProdBOMHeader."Responsibility Center";
        "BOM Category":=ProdBOMHeader."BOM Category";
      END;
    //CF001 En
    */
    //end;
    //Unsupported feature: Code Insertion on "OnOpenPage".
    //trigger OnOpenPage()
    //begin
    /*
    //CF001 St
    IF UserMgt.GetRespCenterFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetRespCenterFilter);
      FILTERGROUP(0);
    END;
    //CF001 En
    */
    //end;
    procedure ShowBOM()
    begin
        ProdBOMHeader2.Reset;
        ProdBOMHeader2.SetCurrentkey("Source No.");
        ProdBOMHeader2.SetRange(ProdBOMHeader2."Source No.", Rec."No.");
        ProductionBOM.SetTableview(ProdBOMHeader2);
        ProductionBOM.Run;
    end;
}
