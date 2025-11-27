codeunit 50354 "SSD PDF Merge"
{
    /// <summary>
    /// AddReportToMerge.
    /// </summary>
    /// <param name="ReportID">Integer.</param>
    /// <param name="RecRef">RecordRef.</param>
    procedure AddReportToMerge(ReportID: Integer; RecRef: RecordRef)
    var
        Tempblob: Codeunit "Temp Blob";
        Ins: InStream;
        Outs: OutStream;
        Parameters: Text;
        Convert: Codeunit "Base64 Convert";
    begin
        Tempblob.CreateInStream(Ins);
        Tempblob.CreateOutStream(Outs);
        Parameters:='';
        Report.SaveAs(ReportID, Parameters, ReportFormat::Pdf, Outs, RecRef);
        Clear(JObjectPDFToMerge);
        JObjectPDFToMerge.Add('pdf', Convert.ToBase64(Ins));
        JArrayPDFToMerge.Add(JObjectPDFToMerge);
    end;
    /// <summary>
    /// AddBase64pdf.
    /// </summary>
    /// <param name="base64pdf">text.</param>
    procedure AddBase64pdf(base64pdf: text)
    begin
        Clear(JObjectPDFToMerge);
        JObjectPDFToMerge.Add('pdf', base64pdf);
        JArrayPDFToMerge.Add(JObjectPDFToMerge);
    end;
    /// <summary>
    /// ClearPDF.
    /// </summary>
    procedure ClearPDF()
    begin
        Clear(JArrayPDFToMerge);
    end;
    /// <summary>
    /// GetJArray.
    /// </summary>
    /// <returns>Return variable JArrayPDF of type JsonArray.</returns>
    procedure GetJArray()JArrayPDF: JsonArray;
    begin
        JArrayPDF:=JArrayPDFToMerge;
    end;
    var JObjectPDFToMerge: JsonObject;
    JArrayPDFToMerge: JsonArray;
    JObjectPDF: JsonObject;
}
