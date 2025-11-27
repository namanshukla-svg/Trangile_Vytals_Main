PageExtension 50031 "SSD General Journal" extends "General Journal"
{
    layout
    {
        addafter("External Document No.")
        {
            field("GST TDS/TCS %"; Rec."GST TDS/TCS %")
            {
                ApplicationArea = All;
            }
            field("GST TDS/TCS Base Amount (LCY)"; Rec."GST TDS/TCS Base Amount (LCY)")
            {
                ApplicationArea = All;
            }
            field("GST TDS/TCS Amount (LCY)"; Rec."GST TDS/TCS Amount (LCY)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Party Type")
        {
            field("GST Place of Supply"; Rec."GST Place of Supply")
            {
                ApplicationArea = All;
            }
            field("GST Customer Type"; Rec."GST Customer Type")
            {
                ApplicationArea = All;
            }
            field("GST Jurisdiction Type"; Rec."GST Jurisdiction Type")
            {
                ApplicationArea = All;
            }
            field("Adv. Pmt. Adjustment"; Rec."Adv. Pmt. Adjustment")
            {
                ApplicationArea = All;
            }
            field("GST Bill-to/BuyFrom State Code"; Rec."GST Bill-to/BuyFrom State Code")
            {
                ApplicationArea = All;
            }
            field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
            {
                ApplicationArea = All;
            }
            field("GST Input Service Distribution"; Rec."GST Input Service Distribution")
            {
                ApplicationArea = All;
            }
            field("GST Reverse Charge"; Rec."GST Reverse Charge")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(Application)
        {
            group("Payroll")
            {
                Caption = 'Payroll';

                action("Import Payroll Data")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        PayrollStaging: XMLport "Payroll Staging";
                    begin
                        // PayrollStaging.Import();
                        Xmlport.Run(50032);
                    end;
                }
                action("Create Payroll Data")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        CUImport: Codeunit CreateGenJnlEmpPayroll;
                    begin
                        CUImport.CreateGenJnlEmpPayroll;
                    end;
                }
                action("Import Emp Contribution Data")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                    begin
                        Xmlport.Run(50033);
                    end;
                }
                action("Create Emp Contribution Data")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        CUImport: Codeunit CreateGenJnlEmpPayroll;
                    begin
                        CUImport.EmployeeContribution();
                    end;
                }
                action("Create Line Narration")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        CUImport: Codeunit CreateGenJnlEmpPayroll;
                    begin
                        IF UserSetup.GET(USERID)THEN IF NOT UserSetup."HRMS Permission" = TRUE THEN ERROR('You do not have permission to access this action');
                        LineNo:=10000;
                        Genjou.RESET;
                        Genjou.SETRANGE("Document No.", Rec."Document No.");
                        IF Genjou.FINDFIRST THEN REPEAT Recgennaratn.INIT;
                                Recgennaratn."Journal Template Name":=Rec."Journal Template Name";
                                Recgennaratn."Journal Batch Name":=Rec."Journal Batch Name";
                                Recgennaratn."Line No.":=LineNo;
                                Recgennaratn."Document No.":=Rec."Document No.";
                                Recgennaratn."Gen. Journal Line No.":=LineNo;
                                Month:=DATE2DMY(rec."Posting Date", 2);
                                IF Month = 1 THEN monthname:='January';
                                IF Month = 2 THEN monthname:='February';
                                IF Month = 3 THEN monthname:='March';
                                IF Month = 4 THEN monthname:='April';
                                IF Month = 5 THEN monthname:='May';
                                IF Month = 6 THEN monthname:='June';
                                IF Month = 7 THEN monthname:='July';
                                IF Month = 8 THEN monthname:='August';
                                IF Month = 9 THEN monthname:='September';
                                IF Month = 10 THEN monthname:='October';
                                IF Month = 11 THEN monthname:='November';
                                IF Month = 12 THEN monthname:='December';
                                Year:=DATE2DMY(rec."Posting Date", 3);
                                Recgennaratn.Narration:='Salary posted for the' + ' ' + monthname + ' ' + '&' + FORMAT(Year);
                                Recgennaratn.INSERT;
                                LineNo+=10000;
                            UNTIL Genjou.NEXT = 0 end;
                }
            }
        }
    }
    var Month: Integer;
    Year: Integer;
    MonthName: Text[50];
    UserSetup: Record "User Setup";
    Recgennaratn: Record "Gen. Journal Narration";
    LineNo: Integer;
    Genjou: Record "Gen. Journal Line";
}
