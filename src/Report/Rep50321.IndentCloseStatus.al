Report 50321 "Indent Close Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Indent Close Status.rdl';
    UsageCategory = ReportsandAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Indent Header"; "SSD Indent Header")
        {
            column(ReportForNavId_1170000000;1170000000)
            {
            }
            trigger OnAfterGetRecord()
            var
                CancelInd: Boolean;
                RecIndH: Record "SSD Indent Header";
                RecIndL: Record "SSD Indent Line";
            begin
                CancelInd:=false;
                RecIndH.Reset;
                RecIndH.SetRange("No.", "Indent Header"."No.");
                RecIndH.SetFilter("Indent Date", '<=%1', 20220331D);
                // IF "Indent Header".Status = "Indent Header".Status::Open THEN
                // RecIndH.SETRANGE(Status,"Indent Header".Status::Open);
                // IF "Indent Header".Status ="Indent Header".Status::Released THEN
                //  RecIndH.SETRANGE(Status,"Indent Header".Status::Released);
                if RecIndH.FindFirst then begin
                    //  RecIndL.RESET;
                    //  RecIndL.SETRANGE("Document No.",RecIndH."No.");
                    //  IF RecIndL.FINDFIRST THEN
                    //    REPEAT
                    //      IF (RecIndL."Qty. on Req. Line"=0)AND(RecIndL."Qty. on Purchase Order"=0) THEN
                    //        CancelInd:=TRUE
                    //      ELSE
                    //       CancelInd:=FALSE;
                    //    UNTIL RecIndL.NEXT=0;
                    //   IF CancelInd THEN BEGIN
                    //   IF RecIndH.Status=RecIndH.Status::Open THEN BEGIN
                    //        IF NOT (USERID = FORMAT("Indenter ID")) THEN
                    //           ERROR('Your User ID does not match with IndenterID')
                    //           ELSE BEGIN
                    RecIndH.Status:=RecIndH.Status::Close;
                    RecIndH.Modify();
                //         END;
                //         IF RecIndH.Status=RecIndH.Status::Released THEN BEGIN
                //           RecIndH.Status:=RecIndH.Status::Close;
                //           RecIndH.MODIFY();
                //           END;
                //    END ELSE BEGIN
                //      ERROR('You cannot close this Indent');
                //      END;
                end;
            //END;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
}
