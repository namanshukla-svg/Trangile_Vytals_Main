Page 50198 "Production BOM List View Only"
{
    Caption = 'Production BOM List';
    CardPageID = "Production BOM";
    DataCaptionFields = "No.";
    Editable = false;
    PageType = List;
    SourceTable = "Production BOM Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Version Nos."; Rec."Version Nos.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Prod. BOM")
            {
                Caption = '&Prod. BOM';
                Image = BOM;

                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Manufacturing Comment Sheet";
                    RunPageLink = "Table Name"=const("Production BOM Header"), "No."=field("No.");
                }
                action(Versions)
                {
                    ApplicationArea = All;
                    Caption = 'Versions';
                    Image = BOMVersions;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "Prod. BOM Version List";
                    RunPageLink = "Production BOM No."=field("No.");
                }
                action("Ma&trix per Version")
                {
                    ApplicationArea = All;
                    Caption = 'Ma&trix per Version';
                    Image = ProdBOMMatrixPerVersion;

                    trigger OnAction()
                    var
                        BOMMatrixForm: Page "Prod. BOM Matrix per Version";
                    begin
                        BOMMatrixForm.Set(Rec);
                        BOMMatrixForm.Run;
                    end;
                }
                action("Where-used")
                {
                    ApplicationArea = All;
                    Caption = 'Where-used';
                    Image = "Where-Used";

                    trigger OnAction()
                    begin
                        ProdBOMWhereUsed.SetProdBOM(Rec, WorkDate);
                        ProdBOMWhereUsed.Run;
                    end;
                }
            }
        }
        area(processing)
        {
            action("Exchange Production BOM Item")
            {
                ApplicationArea = All;
                Caption = 'Exchange Production BOM Item';
                Image = ExchProdBOMItem;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Exchange Production BOM Item";
            }
            action("Delete Expired Components")
            {
                ApplicationArea = All;
                Caption = 'Delete Expired Components';
                Image = DeleteExpiredComponents;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Delete Expired Components";
            }
        }
        area(reporting)
        {
            action("Where-Used (Top Level)")
            {
                ApplicationArea = All;
                Caption = 'Where-Used (Top Level)';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Where-Used (Top Level)";
            }
            action("Quantity Explosion of BOM")
            {
                ApplicationArea = All;
                Caption = 'Quantity Explosion of BOM';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Quantity Explosion of BOM";
            }
            action("Compare List")
            {
                ApplicationArea = All;
                Caption = 'Compare List';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Compare List";
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        I: Integer;
    begin
    // >> ALLE NA.DP1.00
    /*UserSetup.GET(USERID);
        NavigateVisible := UserSetup."Navigate Visible";
        
        IF UserSetup."Bom & Routing" THEN
         I := 0
        ELSE
         ERROR('You dont have permission to open this page for Bom & Routing');   */
    // << ALLE NA.DP1.00
    end;
    var ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
    NavigateVisible: Boolean;
}
