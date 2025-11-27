Page 50048 "Item Ledger Entries-M"
{
    // <changelog>
    //     <change releaseversion="IN6.00"/>
    // </changelog>
    Caption = 'Item Ledger Entries';
    DataCaptionExpression = GetCaption;
    DataCaptionFields = "Item No.";
    Editable = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Shipped Qty. Not Returned"; Rec."Shipped Qty. Not Returned")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sales Amount (Expected)"; Rec."Sales Amount (Expected)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sales Amount (Actual)"; Rec."Sales Amount (Actual)")
                {
                    ApplicationArea = All;
                }
                field("Cost Amount (Expected)"; Rec."Cost Amount (Expected)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cost Amount (Actual)"; Rec."Cost Amount (Actual)")
                {
                    ApplicationArea = All;
                }
                field("Cost Amount (Non-Invtbl.)"; Rec."Cost Amount (Non-Invtbl.)")
                {
                    ApplicationArea = All;
                }
                field("Cost Amount (Expected) (ACY)"; Rec."Cost Amount (Expected) (ACY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cost Amount (Actual) (ACY)"; Rec."Cost Amount (Actual) (ACY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Cost Amount (Non-Invtbl.)(ACY)"; Rec."Cost Amount (Non-Invtbl.)(ACY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Completely Invoiced"; Rec."Completely Invoiced")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = All;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Assemble to Order"; Rec."Assemble to Order")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Applied Entry to Adjust"; Rec."Applied Entry to Adjust")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order Type"; Rec."Order Type")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prod. Order Comp. Line No."; Rec."Prod. Order Comp. Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Lot Blocked"; Rec."Lot Blocked")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;

                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action("&Value Entries")
                {
                    ApplicationArea = All;
                    Caption = '&Value Entries';
                    Image = ValueLedger;
                    RunObject = Page "Value Entries";
                    RunPageLink = "Item Ledger Entry No."=field("Entry No.");
                    RunPageView = sorting("Item Ledger Entry No.");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
            group("&Application")
            {
                Caption = '&Application';
                Image = Apply;

                action("Applied E&ntries")
                {
                    ApplicationArea = All;
                    Caption = 'Applied E&ntries';
                    Image = Approve;

                    trigger OnAction()
                    begin
                        Codeunit.Run(Codeunit::"Show Applied Entries", Rec);
                    end;
                }
                action("Reservation Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;

                    trigger OnAction()
                    begin
                        Rec.ShowReservationEntries(true);
                    end;
                }
                action("Application Worksheet")
                {
                    ApplicationArea = All;
                    Caption = 'Application Worksheet';
                    Image = ApplicationWorksheet;

                    trigger OnAction()
                    var
                        Worksheet: Page "Application Worksheet";
                    begin
                        Clear(Worksheet);
                        Worksheet.SetRecordToShow(Rec);
                        Worksheet.Run;
                    end;
                }
                action("View Posted Quality Order")
                {
                    ApplicationArea = All;
                    Caption = 'View Posted Quality Order';

                    trigger OnAction()
                    var
                        PostedQualityOrderHeader1: Record "SSD Posted Quality Order Hdr";
                        FormPosteQualityOrderList1: Page "Posted Quality Order List";
                    begin
                        //<<<********** ALLE[5.51]
                        PostedQualityOrderHeader1.Reset;
                        PostedQualityOrderHeader1.SetRange(PostedQualityOrderHeader1."Lot No.", Rec."Lot No.");
                        if PostedQualityOrderHeader1.FindFirst then begin
                            Clear(FormPosteQualityOrderList1);
                            FormPosteQualityOrderList1.SetTableview(PostedQualityOrderHeader1);
                            FormPosteQualityOrderList1.RunModal;
                        end;
                    //>>>********** ALLE[5.51]
                    end;
                }
            }
        }
        area(processing)
        {
            action(Action1000000000)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    we: Record "Warehouse Entry";
                    i: Integer;
                begin
                    if not Confirm('create')then exit;
                    i:=1;
                    we.Reset;
                    if we.FindLast then i:=we."Entry No." + 1;
                    we.Init;
                    we."Entry No.":=i;
                    we."Journal Batch Name":='JOBWORK';
                    //WE."Line No." := ILE."";
                    we."Registering Date":=Rec."Posting Date";
                    we."Location Code":=Rec."Location Code";
                    //WE."Zone Code" := ILE."";
                    we."Bin Code":=Rec."Bin Code";
                    //WE."Description" := ILE."";
                    we."Item No.":=Rec."Item No.";
                    we.Quantity:=Rec.Quantity;
                    we."Qty. (Base)":=Rec.Quantity;
                    we."Source Type":=83;
                    we."Source Subtype":=1;
                    we."Source No.":=Rec."Document No.";
                    we."Source Line No.":=10000;
                    //WE."Source Subline No." := ILE."";
                    we."Source Document":=we."source document"::"Reclass. Jnl.";
                    we."Source Code":='ITEMJNL';
                    //WE."Reason Code" := ILE."";
                    //WE."No. Series" := ILE."";
                    //WE."Bin Type Code" := ILE."";
                    //WE."Cubage" := ILE."";
                    //WE."Weight" := ILE."";
                    //WE."Journal Template Name" := ILE."";
                    //WE."Whse. Document No." := ILE."";
                    //WE."Whse. Document Type" := ILE."";
                    //WE."Whse. Document Line No." := ILE."";
                    we."Entry Type":=we."entry type"::Movement;
                    we."Reference Document":=we."reference document"::"Item Journal";
                    we."Reference No.":=Rec."Document No.";
                    //WE."User ID" := ILE."";
                    //WE."Variant Code" := ILE."";
                    we."Qty. per Unit of Measure":=1;
                    we."Unit of Measure Code":=Rec."Unit of Measure Code";
                    //WE."Serial No." := ILE."";
                    //WE."Lot No." := ILE."";
                    //WE."Warranty Date" := ILE."";
                    //WE."Expiration Date" := ILE."";
                    //WE."Phys Invt Counting Period Code" := ILE."";
                    //WE."Phys Invt Counting Period Type" := ILE."";
                    we."Responsibility Center":='BINOLa';
                    we.Insert;
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action("Order &Tracking")
                {
                    ApplicationArea = All;
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;

                    trigger OnAction()
                    var
                        TrackingForm: Page "Order Tracking";
                    begin
                        TrackingForm.SetItemLedgEntry(Rec);
                        TrackingForm.RunModal;
                    end;
                }
            }
            action("&Navigate")
            {
                ApplicationArea = All;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                Visible = NavigateVisible;

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        //CF001 St
        // if UserMgt.GetRespCenterFilter <> '' then begin
        //     Rec.FilterGroup(2);
        //     Rec.SetRange("Responsibility Center", UserMgt.GetRespCenterFilter);
        //     Rec.FilterGroup(0);
        // end;
        //CF001 En
        // >> ALLE NA.DP1.00
        UserSetup.Get(UserId);
        NavigateVisible:=UserSetup."Navigate Visible";
    //IF NOT UserSetup."Drilldown Permission" THEN
    //ERROR('You dont have permission to open this page');
    // << ALLE NA.DP1.00
    end;
    var Navigate: Page Navigate;
    UserMgt: Codeunit "SSD User Setup Management";
    NavigateVisible: Boolean;
    procedure GetCaption(): Text[250]var
        GLSetup: Record "General Ledger Setup";
        ObjTransl: Record "Object Translation";
        Item: Record Item;
        ProdOrder: Record "Production Order";
        Cust: Record Customer;
        Vend: Record Vendor;
        Dimension: Record Dimension;
        DimValue: Record "Dimension Value";
        SourceTableName: Text[100];
        SourceFilter: Text[200];
        Description: Text[100];
    begin
        Description:='';
        case true of Rec.GetFilter("Item No.") <> '': begin
            SourceTableName:=ObjTransl.TranslateObject(ObjTransl."object type"::Table, 27);
            SourceFilter:=Rec.GetFilter("Item No.");
            if MaxStrLen(Item."No.") >= StrLen(SourceFilter)then if Item.Get(SourceFilter)then Description:=Item.Description;
        end;
        (Rec.GetFilter("Order No.") <> '') and (Rec."Order Type" = Rec."order type"::Production): begin
            SourceTableName:=ObjTransl.TranslateObject(ObjTransl."object type"::Table, 5405);
            SourceFilter:=Rec.GetFilter("Order No.");
            if MaxStrLen(ProdOrder."No.") >= StrLen(SourceFilter)then if ProdOrder.Get(ProdOrder.Status::Released, SourceFilter) or ProdOrder.Get(ProdOrder.Status::Finished, SourceFilter)then begin
                    SourceTableName:=StrSubstNo('%1 %2', ProdOrder.Status, SourceTableName);
                    Description:=ProdOrder.Description;
                end;
        end;
        Rec.GetFilter("Source No.") <> '': case Rec."Source Type" of Rec."source type"::Customer: begin
                SourceTableName:=ObjTransl.TranslateObject(ObjTransl."object type"::Table, 18);
                SourceFilter:=Rec.GetFilter("Source No.");
                if MaxStrLen(Cust."No.") >= StrLen(SourceFilter)then if Cust.Get(SourceFilter)then Description:=Cust.Name;
            end;
            Rec."source type"::Vendor: begin
                SourceTableName:=ObjTransl.TranslateObject(ObjTransl."object type"::Table, 23);
                SourceFilter:=Rec.GetFilter("Source No.");
                if MaxStrLen(Vend."No.") >= StrLen(SourceFilter)then if Vend.Get(SourceFilter)then Description:=Vend.Name;
            end;
            end;
        Rec.GetFilter("Global Dimension 1 Code") <> '': begin
            GLSetup.Get;
            Dimension.Code:=GLSetup."Global Dimension 1 Code";
            SourceFilter:=Rec.GetFilter("Global Dimension 1 Code");
            SourceTableName:=Dimension.GetMLName(GlobalLanguage);
            if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter)then if DimValue.Get(GLSetup."Global Dimension 1 Code", SourceFilter)then Description:=DimValue.Name;
        end;
        Rec.GetFilter("Global Dimension 2 Code") <> '': begin
            GLSetup.Get;
            Dimension.Code:=GLSetup."Global Dimension 2 Code";
            SourceFilter:=Rec.GetFilter("Global Dimension 2 Code");
            SourceTableName:=Dimension.GetMLName(GlobalLanguage);
            if MaxStrLen(DimValue.Code) >= StrLen(SourceFilter)then if DimValue.Get(GLSetup."Global Dimension 2 Code", SourceFilter)then Description:=DimValue.Name;
        end;
        Rec.GetFilter("Document Type") <> '': begin
            SourceTableName:=Rec.GetFilter("Document Type");
            SourceFilter:=Rec.GetFilter("Document No.");
            Description:=Rec.GetFilter("Document Line No.");
        end;
        end;
        exit(StrSubstNo('%1 %2 %3', SourceTableName, SourceFilter, Description));
    end;
}
