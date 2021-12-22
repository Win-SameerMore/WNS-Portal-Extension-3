tableextension 50066 "Reqisition Line Ext" extends "Requisition Line"
{
    fields
    {
        // Add changes to table fields here
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                ReqWkshName.Reset();
                ReqWkshName.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
                ReqWkshName.SetRange(Name, "Journal Batch Name");
                if ReqWkshName.FindFirst() then begin
                    rReqisitionLine.Reset();
                    rReqisitionLine.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
                    rReqisitionLine.SetRange("Journal Batch Name", ReqWkshName.Name);
                    if rReqisitionLine.FindFirst() then begin
                        "PR Ref. No." := rReqisitionLine."PR Ref. No.";
                        "Quote Submission Deadline" := rReqisitionLine."Quote Submission Deadline";
                        "Requested Receipt Date" := rReqisitionLine."Requested Receipt Date";
                    end else begin
                        if "PR Ref. No." = '' then
                            "PR Ref. No." := NoSeriesMgt.GetNextNo(ReqWkshName."No. Series", today, true);
                    end;
                end;
                CompanyInfo.get();
                "Location Code" := CompanyInfo."Location Code";
                rItem.Reset();
                if rItem.get("No.") then
                    Description := rItem.Description;
            end;
        }
    }
    var
        rReqisitionLine: Record "Requisition Line";
        rItem: Record Item;
        CompanyInfo: Record "Company Information";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ReqWkshName: Record "Requisition Wksh. Name";
}