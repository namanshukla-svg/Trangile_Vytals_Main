Page 50153 "Sales Order Dashboard"
{
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = sorting("Document Type", "Document No.", "Line No.")order(ascending)where("Document Type"=const(Order), Type=const(Item), "Outstanding Quantity"=filter(>0), "Document Subtype"=const(Order), "Sales Area"=const(true));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Ship to Name"; Customer.Name)
                {
                    ApplicationArea = All;
                }
                field("Bill to Name"; Customer2.Name)
                {
                    ApplicationArea = All;
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
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
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Comments CC"; Rec."Comments CC")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    MultiLine = true;

                    trigger OnAssistEdit()
                    begin
                        UserSetup.Reset;
                        UserSetup.Get(UserId);
                        if UserSetup."Comments Dept" in[UserSetup."comments dept"::CC, UserSetup."comments dept"::ALL]then Rec.ShowLineCommentsCC;
                    end;
                }
                field("Comments SCM"; Rec."Comments SCM")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    MultiLine = true;

                    trigger OnAssistEdit()
                    begin
                        UserSetup.Reset;
                        UserSetup.Get(UserId);
                        if UserSetup."Comments Dept" in[UserSetup."comments dept"::SCM, UserSetup."comments dept"::ALL]then Rec.ShowLineCommentsSCM;
                    end;
                }
                field("Comments PPC"; Rec."Comments PPC")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    MultiLine = true;

                    trigger OnAssistEdit()
                    begin
                        UserSetup.Reset;
                        UserSetup.Get(UserId);
                        if UserSetup."Comments Dept" in[UserSetup."comments dept"::PPC, UserSetup."comments dept"::ALL]then Rec.ShowLineCommentsPPC;
                    end;
                }
                field("Comments Management"; Rec."Comments Management")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    MultiLine = true;

                    trigger OnAssistEdit()
                    begin
                        UserSetup.Reset;
                        UserSetup.Get(UserId);
                        if UserSetup."Comments Dept" in[UserSetup."comments dept"::MGMT, UserSetup."comments dept"::ALL]then Rec.ShowLineCommentsMGMT;
                    end;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("&Report")
            {
                ApplicationArea = All;
                Caption = '&Report';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    SalesLine.Reset;
                    SalesLine.SetFilter(SalesLine."Document No.", Rec."Document No.");
                    SalesLine.SetFilter(SalesLine."Line No.", '%1', Rec."Line No.");
                    if SalesLine.FindFirst then;
                    Report.RunModal(50144, true, true, SalesLine);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SalesDsbComment.Reset;
        SalesDsbComment.SetRange(SalesDsbComment."Document Type", Rec."Document Type");
        SalesDsbComment.SetRange(SalesDsbComment."No.", Rec."Document No.");
        SalesDsbComment.SetRange(SalesDsbComment."Document Line No.", Rec."Line No.");
        SalesDsbComment.SetFilter(SalesDsbComment.Code, '%1', 'CC');
        if SalesDsbComment.FindLast then Rec."Comments CC":=SalesDsbComment.Comment;
        SalesDsbComment.Reset;
        SalesDsbComment.SetRange(SalesDsbComment."Document Type", Rec."Document Type");
        SalesDsbComment.SetRange(SalesDsbComment."No.", Rec."Document No.");
        SalesDsbComment.SetRange(SalesDsbComment."Document Line No.", Rec."Line No.");
        SalesDsbComment.SetFilter(SalesDsbComment.Code, '%1', 'SCM');
        if SalesDsbComment.FindLast then Rec."Comments SCM":=SalesDsbComment.Comment;
        SalesDsbComment.Reset;
        SalesDsbComment.SetRange(SalesDsbComment."Document Type", Rec."Document Type");
        SalesDsbComment.SetRange(SalesDsbComment."No.", Rec."Document No.");
        SalesDsbComment.SetRange(SalesDsbComment."Document Line No.", Rec."Line No.");
        SalesDsbComment.SetFilter(SalesDsbComment.Code, '%1', 'PPC');
        if SalesDsbComment.FindLast then Rec."Comments PPC":=SalesDsbComment.Comment;
        SalesDsbComment.Reset;
        SalesDsbComment.SetRange(SalesDsbComment."Document Type", Rec."Document Type");
        SalesDsbComment.SetRange(SalesDsbComment."No.", Rec."Document No.");
        SalesDsbComment.SetRange(SalesDsbComment."Document Line No.", Rec."Line No.");
        SalesDsbComment.SetFilter(SalesDsbComment.Code, '%1', 'MGMT');
        if SalesDsbComment.FindLast then Rec."Comments Management":=SalesDsbComment.Comment;
        Customer.Reset;
        if Customer.Get(Rec."Sell-to Customer No.")then;
        Customer2.Reset;
        if Customer2.Get(Rec."Bill-to Customer No.")then;
    end;
    var SalesHeader: Record "Sales Header";
    SalesComentLine: Record "SSD SalesDashBoardCommentLine";
    UserSetup: Record "User Setup";
    SalesDsbComment: Record "SSD SalesDashBoardCommentLine";
    SalesLine: Record "Sales Line";
    DashboardReport: Report "Sales Dash Board";
    Customer: Record Customer;
    Customer2: Record Customer;
}
