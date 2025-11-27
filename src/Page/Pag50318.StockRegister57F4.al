Page 50318 "Stock Register 57F4"
{
    PageType = List;
    SourceTable = "SSD Stock Register 57F4";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Challan Type"; Rec."Challan Type")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Challan No."; Rec."Challan No.")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Challan Date"; Rec."Challan Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Item Description 1"; Rec."Item Description 1")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Description 2"; Rec."Item Description 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("HSN Code"; Rec."HSN Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor GST Registration No."; Rec."Vendor GST Registration No.")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Document No."; Rec."Vendor Document No.")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Wastage Quantity"; Rec."Wastage Quantity")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Balance Quantity"; Rec."Balance Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line Closed Date"; Rec."Line Closed Date")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Challan Age"; Rec."Challan Age")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Challan Closed Date"; Rec."Challan Closed Date")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Received by"; Rec."Received by")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Nature of Jobworker"; Rec."Nature of Jobworker")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("57 F4 Received Copy"; Rec."57 F4 Received Copy")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("57 F4 Received Date"; Rec."57 F4 Received Date")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Vendor Document Date"; Rec."Vendor Document Date")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Shipped Value"; Rec."Shipped Value")
                {
                    ApplicationArea = All;
                    Editable = DynamicEdit;
                }
                field("Received Value"; Rec."Received Value")
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Work Location Code"; Rec."Job Work Location Code")
                {
                    ToolTip = 'Specifies the value of the Job Work Location Code field.';
                }
                field("Purchase Vendor No."; Rec."Purchase Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Purchase Vendor No. field.';
                }
            }
        }
    }
    actions
    {
        area(creation)
        {
            action(Print)
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;

                trigger OnAction()
                begin
                    StockRegister57F4.SetRange("Challan No.", Rec."Challan No.");
                    Report.Run(50267, true, false, StockRegister57F4);
                end;
            }
            action("Stock Register (Shipment)")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;

                trigger OnAction()
                begin
                    StockRegister57F4.SetRange("Challan No.", Rec."Challan No.");
                    Report.Run(Report::"Stock Register(Shipment)", true, false, StockRegister57F4);
                end;
            }
            action(Post)
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Do you want to post?', true)then begin
                        Rec.TestField("Challan No.");
                        Rec.TestField("Challan Date");
                        Rec.TestField("Item No.");
                        Rec.TestField("Vendor No.");
                        Rec.TestField("Vendor Name");
                        Rec.TestField("Vendor Document No.");
                        Rec.TestField("Vendor Document Date");
                        Rec.TestField("Quantity Received");
                        Rec.TestField("Received by");
                        Rec.TestField("Nature of Jobworker");
                        Rec.Posted:=true;
                        Rec.Modify;
                        if Rec."Challan Type" = Rec."challan type"::Transfer then begin
                            TransferShipmentLine.Reset;
                            TransferShipmentLine.SetRange("Document No.", Rec."Challan No.");
                            TransferShipmentLine.SetRange("Item No.", Rec."Item No.");
                            TransferShipmentLine.SetRange("Line No.", Rec."Source Doc. Line No.");
                            if TransferShipmentLine.FindFirst then begin
                                TransferShipmentLine."57 F4 Posted":=true;
                                TransferShipmentLine.Modify;
                            end;
                        end
                        else if Rec."Challan Type" = Rec."challan type"::Subcon then begin
                                DeliveryChallanLine.Reset;
                                DeliveryChallanLine.SetRange("Delivery Challan No.", Rec."Challan No.");
                                DeliveryChallanLine.SetRange("Item No.", Rec."Item No.");
                                DeliveryChallanLine.SetRange("Line No.", Rec."Source Doc. Line No.");
                                if DeliveryChallanLine.FindFirst then begin
                                    DeliveryChallanLine."57 F4 Posted":=true;
                                    DeliveryChallanLine.Modify;
                                end;
                            end;
                        Message('Data Posted Successfully');
                    end;
                end;
            }
            action("Stock Register Detail")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    StockRegister57F4.Reset;
                    StockRegister57F4.SetRange("Challan No.", Rec."Challan No.");
                    if StockRegister57F4.FindFirst then Report.Run(50267, true, false, StockRegister57F4);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetEditable();
    end;
    trigger OnOpenPage()
    begin
        SetEditable();
    end;
    procedure SetEditable()
    begin
        if Rec.Posted then DynamicEdit:=false
        else
            DynamicEdit:=true;
    end;
    var StockRegister57F4: Record "SSD Stock Register 57F4";
    DynamicEdit: Boolean;
    TransferShipmentLine: Record "Transfer Shipment Line";
    DeliveryChallanLine: Record "Delivery Challan Line";
}
