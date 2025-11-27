Page 50326 "Sales Distribution List"
{
    PageType = List;
    SourceTable = "SSD Distributor Line";
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MRP No"; Rec."MRP No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Forecast Name"; Rec."Forecast Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("SP Order No."; Rec."SP Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Suggested Quantity"; Rec."Suggested Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Required Receipt Date"; Rec."Required Receipt Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Suggested Receipt Date"; Rec."Suggested Receipt Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("SP Price"; Rec."SP Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Stock; Rec.Stock)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Create Sales Order"; Rec."Create Sales Order")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sales Line No."; Rec."Sales Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("SP Remarks"; Rec."SP Remarks")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date Time"; Rec."Created Date Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mail Sent"; Rec."Mail Sent")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';

                    trigger OnValidate()
                    var
                        UserSetup: Record "User Setup";
                    begin
                        UserSetup.Get(UserId);
                        if not UserSetup."SSD Sales Distribution Admin" then Error('you are not authorized person.');
                    end;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Page Error Log")
            {
                ApplicationArea = All;
                RunObject = Page "Salse Distribution error log";
                RunPageLink = "MRP No."=field("MRP No");
            }
            action("Report")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    DistributorLine: Record "SSD Distributor Line";
                begin
                    DistributorLine.Reset;
                    DistributorLine.SetRange("MRP No", Rec."MRP No");
                    Report.RunModal(Report::"Batch Update Sales H & Line_2", true, true, DistributorLine);
                end;
            }
            action(ClearError)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    DistributionHeader_G: Record "SSD Distributor Header";
                begin
                    if DistributionHeader_G.Get(Rec."MRP No")then begin
                        if DistributionHeader_G."Error Text" <> '' then begin
                            DistributionHeader_G."Error Text":='';
                            DistributionHeader_G.Modify;
                        end;
                    end;
                end;
            }
            action("Update Item Block")
            {
                ApplicationArea = All;
                Caption = 'Update Item Block';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Image;

                trigger OnAction()
                var
                    Item: Record Item;
                    DistributionLine: Record "SSD Distributor Line";
                begin
                    DistributionLine.Reset();
                    DistributionLine.SetRange(Updated, false);
                    if DistributionLine.FindSet()then repeat Item.Get(DistributionLine."Item Code");
                            if Item.Blocked then begin
                                DistributionLine.Blocked:=true;
                                DistributionLine.Modify();
                            end;
                        until DistributionLine.Next() = 0;
                end;
            }
        }
    }
}
