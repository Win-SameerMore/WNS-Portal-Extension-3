xmlport 50000 "Import Record Link"
{
    Format = VariableText;
    //Direction = Import;
    TextEncoding = UTF8;
    UseRequestPage = false;
    schema
    {
        textelement(ImportRecordLinks)
        {
            tableelement(Record_Link; "Record Link")
            {
                fieldattribute(Description; Record_Link.Description) { }
                fieldattribute(URL1; Record_Link.URL1) { }
                textelement(ItemRecordID)
                {
                    trigger OnAfterAssignVariable()
                    var
                        rItem: Record Item;
                        ItemRecordFilter: RecordId;
                    begin
                        rItem.Reset();
                        if rItem.get(ItemRecordID) then begin
                            Evaluate(ItemRecordFilter, 'Item: ' + rItem."No.");
                            Record_Link."Record ID" := ItemRecordFilter;
                            Record_Link.Created := CurrentDateTime;
                            Record_Link."User ID" := UserId;
                            Record_Link.Company := CompanyName;
                            Record_Link.Type := Record_Link.Type::Link;
                        end else begin
                            Error('item Not found %1', ItemRecordID);
                        end;
                    end;
                }
                // trigger OnBeforeInsertRecord()
                // var
                //     rRecordLink: Record "Record Link";
                //     RecordLink: Record "Record Link";
                // begin
                //     rRecordLink.Reset();
                //     if rRecordLink.FindLast() then;
                //     RecordLink.Init();
                //     RecordLink."Link ID" := rRecordLink."Link ID" + 1;
                //     RecordLink.Description := Record_Link.Description;
                //     record
                // end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }
}