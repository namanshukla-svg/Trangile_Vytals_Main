Page 50220 "Requision Slip Header Form"
{
    PageType = Document;
    SourceTable = "SSD Requision Slip Header";
    SourceTableView = where("Document Type" = filter("Material Issue"));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer-From Location"; Rec."Transfer-From Location")
                {
                    ApplicationArea = All;
                    Caption = 'Issue-From';
                }
                field("Transfer-To Location"; Rec."Transfer-To Location")
                {
                    ApplicationArea = All;
                    Caption = 'Issue-To';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Branch Code';
                    Editable = true;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Department Code ';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Manual Requisition"; Rec."Manual Requisition")
                {
                    ApplicationArea = All;
                }
                field("Req. Date"; Rec."Req. Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Req. Time"; Rec."Req. Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Description"; Rec."Source Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control1000000001; "Requision Slip Line SubForm")
            {
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';

                action("Get Prod. Order wise Component Requirement")
                {
                    ApplicationArea = All;
                    Caption = 'Get Prod. Order wise Component Requirement';
                    ShortCutKey = 'F7';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Clear(GetMatReq);
                        Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code");
                        Rec.TestField("Responsibility Center");
                        Rec.TestField("Transfer-From Location");
                        Rec.TestField("Transfer-To Location");
                        GetMatReq.SetDefaults(Rec."Req. Slip No.", Rec."Shortcut Dimension 1 Code", Rec."Shortcut Dimension 2 Code", Rec."Responsibility Center", Rec."Transfer-From Location", Rec."Document Type", Rec."Transfer-To Location");
                        GetMatReq.RunModal;
                    end;
                }
                action("Calculate Net Requirement")
                {
                    ApplicationArea = All;
                    Caption = 'Calculate Net Requirement';

                    trigger OnAction()
                    begin
                        Clear(GetNetReq);
                        Rec.TestField("Shortcut Dimension 1 Code");
                        //TESTFIELD("Shortcut Dimension 2 Code");
                        Rec.TestField("Responsibility Center");
                        Rec.TestField("Transfer-From Location");
                        GetNetReq.SetDefaults(Rec."Req. Slip No.", Rec."Shortcut Dimension 1 Code", Rec."Shortcut Dimension 2 Code", Rec."Responsibility Center", Rec."Transfer-From Location", Rec."Document Type", Rec."Transfer-To Location");
                        GetNetReq.RunModal;
                    end;
                }
                separator(Action1000000033)
                {
                }
                action("Send Requision to Store")
                {
                    ApplicationArea = All;
                    Caption = 'Send Requision to Store';
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        if Confirm('Do you want to send the request to Store', false) then begin
                            TransHeader.Init;
                            RespCenter.Get(Rec."Responsibility Center");
                            //NoSeriesMgt.InitSeries(RespCenter."Req. Issue Slip No. Series",TransHeader."No. Series",TransHeader."Posting Date",
                            //TransHeader."No.",TransHeader."No. Series");
                            PReqHead.Init;
                            PReqHead.TransferFields(Rec);
                            PReqHead.Insert;
                            //MESSAGE('%1',RespCenter."Intransit Location");
                            TransHeader."No." := NoSeriesMgt.GetNextNo(RespCenter."Req. Issue Slip No. Series", WorkDate, true);
                            TransHeader.Insert;
                            TransHeader.Validate("Transfer-from Code", Rec."Transfer-From Location");
                            TransHeader.Validate("Transfer-to Code", Rec."Transfer-To Location");
                            TransHeader.Validate("In-Transit Code", RespCenter."Intransit Location");
                            TransHeader.Validate("Shipment Date", Rec."Req. Date");
                            TransHeader."Posting Date" := Rec."Req. Date";
                            TransHeader."Responsibility Center" := Rec."Responsibility Center";
                            TransHeader."Slip No." := Rec."No.";
                            TransHeader."Document Type" := Rec."Document Type";
                            TransHeader.Departments := Rec.Departments;
                            if (Rec."Transfer-From Location" <> 'MSR-MS') and (Rec.Departments <> Rec.Departments::ED) then TransHeader.Departments := TransHeader.Departments::WIP;
                            TransHeader."Prod. Order Source No." := Rec."Source No.";
                            TransHeader."Prod. Order Source Description" := Rec."Source Description";
                            TransHeader."Prod. Order No." := Rec."Prod. Order No.";
                            //TransHeader.INSERT;
                            TransHeader.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                            TransHeader.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                            TransHeader.Modify;
                            ReqLineRec.Reset;
                            ReqLineRec.SetRange("Document Type", Rec."Document Type");
                            ReqLineRec.SetRange("Document No.", Rec."No.");
                            if ReqLineRec.FindFirst then
                                repeat
                                    TransLine.Init;
                                    TransLine."Document No." := TransHeader."No.";
                                    TransLine.Validate("Shipment Date", Rec."Req. Date");
                                    TransLine."Line No." := ReqLineRec."Line No.";
                                    TransLine.Validate("Item No.", ReqLineRec."Item No.");
                                    TransLine.Validate(Quantity, ReqLineRec.Quantity);
                                    TransLine."Responsibility Center" := Rec."Responsibility Center";
                                    TransLine."Slip No." := Rec."No.";
                                    TransLine."Document Type" := Rec."Document Type";
                                    TransLine."Required Qty." := TransLine.Quantity;
                                    TransLine."Prod. Order No." := ReqLineRec."Prod. Order No.";
                                    TransLine."Prod.Order Source No." := ReqLineRec."Prod.Order Source No.";
                                    UpdateComponentLines(ReqLineRec);
                                    //TransLine.VALIDATE("Qty. to Ship",0);
                                    TransLine.Insert;
                                    PreqLine.Init;
                                    PreqLine.TransferFields(ReqLineRec);
                                    PreqLine.Insert;
                                until ReqLineRec.Next = 0;
                            Rec.Delete;
                        end;
                    end;
                }
                separator(Action1000000032)
                {
                }
                action("Import Req. Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Import Req. Lines';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField("Transfer-From Location");
                        //GetReqLines.GetOtions("No.","Transfer-From Location","Responsibility Center","Shortcut Dimension 1 Code", // BIS 1145
                        //"Shortcut Dimension 2 Code","Req. Slip No.","Req. Date"); // BIS 1145
                        //GetReqLines.RUN; // BIS 1145
                        CurrPage.Update;
                    end;
                }
                separator(Action1000000030)
                {
                }
                action(Released)
                {
                    ApplicationArea = All;
                    Caption = 'Released';

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Released;
                        Rec.Modify;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Reopen';
                    Image = ReOpen;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //"Document Type" := DocumentTypeGlb;
        //Departments     :=DepartmentValueGlb;
        Rec."Document Type" := Rec."document type"::"Material Issue";
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("Document Type",DocumentTypeGlb);
        //SETRANGE(Departments,DepartmentValueGlb);
        //ALLE.RC.03 Start
        if UserMgt.GetSalesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FilterGroup(0);
        end;
        //ALLE.RC.03 Start
    end;

    var
        GetMatReq: Report "Requision Slip Line Calculate";
        PReqHead: Record "SSD Posted Req. Slip Header";
        PreqLine: Record "SSD Posted Requision Slip Line";
        ReqLineRec: Record "SSD Requision Slip Line";
        MatIssueSlipHeader: Record "SSD Item Ledger Entry Buffer";
        ProdOrder: Record "Production Order";
        GetNetReq: Report "Requision Slip Net Calculate";
        TransHeader: Record "Transfer Header";
        TransLine: Record "Transfer Line";
        NoSeriesMgt: Codeunit "No. Series";//IG_DS NoSeriesManagement;
        RespCenter: Record "Responsibility Center";
        int: Integer;
        DocumentTypeGlb: Option " ","Material Issue","Material Return","Line Rejection","Floor Rejection",Offer,ReOffer;
        DepartmentValueGlb: Option " ",PPC,AWP,WIP,Conveyor,ED,Store;
        UserMgt: Codeunit "User Setup Management";
        GetReqLines: XmlPort "Update Requisition Lines";

    procedure SetDefaultValues(DocumentType: Option " ","Material Issue","Material Return","Line Rejection","Floor Rejection",Offer,ReOffer; DepartmentValue: Option " ",PPC,AWP,WIP,Conveyor,ED,Store)
    var
        DocumentTypeLocal: Option " ","Material Issue","Material Return","Line Rejection","Floor Rejection",Offer,ReOffer;
        DepartmentValueLocal: Option " ",PPC,AWP,WIP,Conveyor,ED,Store;
    begin
        DocumentTypeGlb := DocumentType;
        DepartmentValueGlb := DepartmentValue;
    end;

    procedure UpdateComponentLines(RequisitionSlipLine02: Record "SSD Requision Slip Line")
    var
        ProdOrderComponent: Record "Prod. Order Component";
    begin
        ProdOrderComponent.Reset;
        ProdOrderComponent.SetRange(ProdOrderComponent.Status, ProdOrderComponent.Status::Released);
        ProdOrderComponent.SetRange("Prod. Order No.", RequisitionSlipLine02."Prod. Order No.");
        ProdOrderComponent.SetRange("Item No.", RequisitionSlipLine02."Item No.");
        if ProdOrderComponent.FindFirst then begin
            ProdOrderComponent."Completely Issued" := true;
            ProdOrderComponent.Modify;
        end;
    end;
}
