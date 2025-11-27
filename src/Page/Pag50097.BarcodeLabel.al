Page 50097 "Barcode Label"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = List;
    SourceTable = "SSD Barcode Labelpp";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(SrNo; Rec.SrNo)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = true;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
                field(Barcode; Rec.Barcode)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Barcode Reports")
            {
                Caption = 'Barcode Reports';

                action("Barcode Lable 1X2(4X1)")
                {
                    ApplicationArea = All;
                    Caption = 'Barcode Lable 1X2(4X1)';

                    trigger OnAction()
                    begin
                        Label1x2.RunModal;
                        Rec.Barcode:=true;
                    end;
                }
                action("Barcode Label Rcpt(4x3)")
                {
                    ApplicationArea = All;
                    Caption = 'Barcode Label Rcpt(4x3)';

                    trigger OnAction()
                    begin
                        Label4x3.RunModal;
                    end;
                }
                action("Barcode Label Mfg(4x6)")
                {
                    ApplicationArea = All;
                    Caption = 'Barcode Label Mfg(4x6)';

                    trigger OnAction()
                    begin
                        Label4x6.RunModal;
                    end;
                }
                action("Barcode Label Rcpt Post(4x3)")
                {
                    ApplicationArea = All;
                    Caption = 'Barcode Label Rcpt Post(4x3)';

                    trigger OnAction()
                    begin
                        Label4x3Post.RunModal;
                    end;
                }
                action("Barcode Label Mfg Post(4x6)")
                {
                    ApplicationArea = All;
                    Caption = 'Barcode Label Mfg Post(4x6)';

                    trigger OnAction()
                    begin
                        Label4x6Post.RunModal;
                        Rec.Barcode:=true;
                    end;
                }
                action("ILE QR Label  A5")
                {
                    ApplicationArea = All;
                    Caption = 'ILE QR Label  A5';

                    trigger OnAction()
                    begin
                        A5.RunModal;
                    end;
                }
                action("ILE QR Label  A5 Automation")
                {
                    ApplicationArea = All;
                    Caption = 'ILE QR Label  A5 Automation';

                    trigger OnAction()
                    begin
                        A5Automation.RunModal;
                    end;
                }
                action("ILE QR Label 175 x 220")
                {
                    ApplicationArea = All;
                    Caption = 'ILE QR Label 175 x 220';

                    trigger OnAction()
                    begin
                        "175x220".RunModal;
                    end;
                }
                action("ILE QR Label 3 x 2")
                {
                    ApplicationArea = All;
                    Caption = 'ILE QR Label 3 x 2';

                    trigger OnAction()
                    begin
                        "3x2".RunModal;
                    end;
                }
                action("ILE QR Label 2 x 1")
                {
                    ApplicationArea = All;
                    Caption = 'ILE QR Label 2 x 1';

                    trigger OnAction()
                    begin
                        "2x1".RunModal;
                    end;
                }
                action("RPO QR Label  A5")
                {
                    ApplicationArea = All;
                    Caption = 'RPO QR Label  A5';

                    trigger OnAction()
                    begin
                        RPOA5.RunModal;
                        Rec.Barcode:=true;
                    end;
                }
                action("RPO QR Label 175 x 220")
                {
                    ApplicationArea = All;
                    Caption = 'RPO QR Label 175 x 220';

                    trigger OnAction()
                    begin
                        RPO175x220.RunModal;
                    end;
                }
                action("RPO QR Label 3 x 2")
                {
                    ApplicationArea = All;
                    Caption = 'RPO QR Label 3 x 2';

                    trigger OnAction()
                    begin
                        RPO3x2.RunModal;
                    end;
                }
                action("RPO QR Label 2 x 1")
                {
                    ApplicationArea = All;
                    Caption = 'RPO QR Label 2 x 1';

                    trigger OnAction()
                    begin
                        RPO2x1.RunModal;
                    end;
                }
                action("Label - A5 - RPO 2")
                {
                    ApplicationArea = All;
                    Caption = 'Label - A5 - RPO 2';

                    trigger OnAction()
                    begin
                        LabelA5RPO2.RunModal;
                    end;
                }
                action("Label - A5 --2")
                {
                    ApplicationArea = All;
                    Caption = 'Label - A5 --2';

                    trigger OnAction()
                    begin
                        LabelA52.RunModal;
                    end;
                }
                action("Sampling Testing Label")
                {
                    ApplicationArea = All;
                    Caption = 'Sampling Testing Label';

                    trigger OnAction()
                    begin
                        SampleTestLabel.Run;
                    end;
                }
                action("Sampling Testing Lebel  02")
                {
                    ApplicationArea = All;
                    Caption = 'Sampling Testing Lebel  02';

                    trigger OnAction()
                    begin
                        SampleTestLabel2.RunModal;
                    end;
                }
                action("BARCODE LEBEL RECEIPT 4x6-Post")
                {
                    ApplicationArea = All;
                    Caption = 'BARCODE LEBEL RECEIPT 4x6-Post';

                    trigger OnAction()
                    var
                        BARCODELEBELRECEIPT4x6Post: Report "BARCODE LEBEL RECEIPT 4x6-Post";
                    begin
                        BARCODELEBELRECEIPT4x6Post.Run;
                    end;
                }
                action("Label Report")
                {
                    ApplicationArea = All;
                    Caption = 'Label Report';
                    RunObject = Report "Label - 175 * 220 New";
                }
            }
            group("Barcode Reports New")
            {
                Caption = 'Barcode Reports New';
                Visible = false;

                action("Barcode Lable 1X2(4X1) New")
                {
                    ApplicationArea = All;
                    Caption = 'Barcode Lable 1X2(4X1) New';
                    Image = "Action";

                    trigger OnAction()
                    begin
                        Clear(BARCODELEBEL1x2New);
                        BARCODELEBEL1x2New.RunModal;
                        Rec.Barcode:=true;
                    end;
                }
                action("Barcode Label Rcpt(4x3) New")
                {
                    ApplicationArea = All;
                    Caption = 'Barcode Label Rcpt(4x3) New';
                    Image = Action;

                    trigger OnAction()
                    begin
                        BARCODELEBELRECEIPT4x3New.RunModal;
                    end;
                }
                action("Barcode Label Mfg(4x6) New")
                {
                    ApplicationArea = All;
                    Caption = 'Barcode Label Mfg(4x6) New';
                    Image = Action;

                    trigger OnAction()
                    begin
                        BARCODELEBMANUFACTURING4x6N.RunModal;
                    end;
                }
                action("Barcode Label Rcpt Post(4x3) New")
                {
                    ApplicationArea = All;
                    Caption = 'Barcode Label Rcpt Post(4x3) New';
                    Image = "Action";

                    trigger OnAction()
                    begin
                        BARCODELEBRECEIPT4x3PostN.RunModal;
                    end;
                }
                action("Barcode Label Mfg Post(4x6) New")
                {
                    ApplicationArea = All;
                    Caption = 'Barcode Label Mfg Post(4x6) New';
                    Image = "Action";

                    trigger OnAction()
                    begin
                        Label4x6Post.RunModal;
                        Rec.Barcode:=true;
                    end;
                }
                action("ILE QR Label  A5 New")
                {
                    ApplicationArea = All;
                    Caption = 'ILE QR Label  A5 New';
                    Image = Action;

                    trigger OnAction()
                    begin
                        Clear(LabelA5New);
                        LabelA5New.RunModal;
                    end;
                }
                action("ILE QR Label 175 x 220 New")
                {
                    ApplicationArea = All;
                    Caption = 'ILE QR Label 175 x 220 New';
                    Image = Action;

                    trigger OnAction()
                    begin
                        Label175220New2.RunModal;
                    end;
                }
                action(Action1170000013)
                {
                    ApplicationArea = All;
                    Caption = 'ILE QR Label 3 x 2';

                    trigger OnAction()
                    begin
                        "3x2".RunModal;
                    end;
                }
                action(Action1170000012)
                {
                    ApplicationArea = All;
                    Caption = 'ILE QR Label 2 x 1';

                    trigger OnAction()
                    begin
                        "2x1".RunModal;
                    end;
                }
                action(Action1170000011)
                {
                    ApplicationArea = All;
                    Caption = 'RPO QR Label  A5';

                    trigger OnAction()
                    begin
                        RPOA5.RunModal;
                        Rec.Barcode:=true;
                    end;
                }
                action(Action1170000010)
                {
                    ApplicationArea = All;
                    Caption = 'RPO QR Label 175 x 220';

                    trigger OnAction()
                    begin
                        RPO175x220.RunModal;
                    end;
                }
                action(Action1170000009)
                {
                    ApplicationArea = All;
                    Caption = 'RPO QR Label 3 x 2';

                    trigger OnAction()
                    begin
                        RPO3x2.RunModal;
                    end;
                }
                action(Action1170000008)
                {
                    ApplicationArea = All;
                    Caption = 'RPO QR Label 2 x 1';

                    trigger OnAction()
                    begin
                        RPO2x1.RunModal;
                    end;
                }
                action("Label - A5 - RPO 2 New")
                {
                    ApplicationArea = All;
                    Caption = 'Label - A5 - RPO 2 New';
                    Image = "Action";

                    trigger OnAction()
                    begin
                        Clear(LabelA5RPOTest2New);
                        LabelA5RPOTest2New.RunModal;
                    end;
                }
                action(Action1170000006)
                {
                    ApplicationArea = All;
                    Caption = 'Label - A5 --2';

                    trigger OnAction()
                    begin
                        LabelA52.RunModal;
                    end;
                }
                action(Action1170000005)
                {
                    ApplicationArea = All;
                    Caption = 'Sampling Testing Label';

                    trigger OnAction()
                    begin
                        SampleTestLabel.Run;
                    end;
                }
                action(Action1170000004)
                {
                    ApplicationArea = All;
                    Caption = 'Sampling Testing Lebel  02';

                    trigger OnAction()
                    begin
                        SampleTestLabel2.RunModal;
                    end;
                }
                action(Action1170000003)
                {
                    ApplicationArea = All;
                    Caption = 'BARCODE LEBEL RECEIPT 4x6-Post';

                    trigger OnAction()
                    var
                        BARCODELEBELRECEIPT4x6Post: Report "BARCODE LEBEL RECEIPT 4x6-Post";
                    begin
                        BARCODELEBELRECEIPT4x6Post.Run;
                    end;
                }
                action(Action1170000002)
                {
                    ApplicationArea = All;
                    Caption = 'Label Report';
                    RunObject = Report "Label - 175 * 220 New";
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."User Id":=UserId;
    end;
    var Label1x2: Report "BARCODE LEBEL... 1x2";
    Label4x3: Report "BARCODE LEBEL RECEIPT 4x3";
    Label4x6: Report "BARCODE LEBEL MANUFACTURING4x6";
    Label4x3Post: Report "BARCODE LEBEL RECEIPT 4x3-Post";
    Label4x6Post: Report BARCODELEBELMANUFACTURINGP4x6;
    A5: Report "Label - A5";
    A5Automation: Report "Label - A5 Automation";
    "175x220": Report "Label - 175 * 220";
    "3x2": Report "Label - 3 * 2";
    "2x1": Report "Label - 2 * 1";
    RPOA5: Report "Label - A5 - RPO";
    RPO175x220: Report "Label - 175 * 220 - RPO";
    RPO3x2: Report "Label - 3 * 2 - RPO";
    RPO2x1: Report "Label - 2 * 1 - RPO";
    LabelA5RPO2: Report "Label - A5 - RPO Test 2";
    LabelA52: Report "Label - A5 --2";
    SampleTestLabel: Report "Label - 3 * 5";
    SampleTestLabel2: Report "Label - 175 * 220 - RPO NEW";
    BARCODELEBEL1x2New: Report "BARCODE LEBEL... 1x2 New";
    BARCODELEBELRECEIPT4x3New: Report "BARCODE LEBEL RECEIPT 4x3 New";
    LabelA5New: Report "Label - A5 New";
    Label175220New2: Report "Label - 175 * 220 New2";
    BARCODELEBMANUFACTURING4x6N: Report "BARCODE LEB. MANUFACTURING4x6N";
    BARCODELEBRECEIPT4x3PostN: Report "BARCODE LEB. RECEIPT 4x3-PostN";
    LabelA5RPOTest2New: Report "Label - A5 - RPO Test 2 New";
}
