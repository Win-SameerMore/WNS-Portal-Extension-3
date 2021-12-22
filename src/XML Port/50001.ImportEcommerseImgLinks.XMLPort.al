xmlport 50001 "Import EComm. Img Record Link"
{
    Format = VariableText;
    //Direction = Import;
    TextEncoding = UTF8;
    UseRequestPage = false;
    schema
    {
        textelement(ImportRecordLinks)
        {
            tableelement(Ecommerce_Images; "Ecommerce Images")
            {
                fieldattribute(ImageURL; Ecommerce_Images.PictureURL) { }
                fieldattribute(Sequence; Ecommerce_Images."Item Display Sequence") { }
                fieldattribute(Itemtype; Ecommerce_Images."Image Type") { }
                fieldattribute(ItemNoE; Ecommerce_Images."Item No.")
                {
                    trigger OnAfterAssignField()
                    begin
                        ItemNo := Ecommerce_Images."Item No.";
                    end;
                }

                trigger OnBeforeInsertRecord()
                begin
                    rItem.Reset();
                    if rItem.get(ItemNo) then begin
                        if ItemNo <> '' then begin
                            EcommerceImanges.Reset();
                            EcommerceImanges.SetRange("Item No.", ItemNo);
                            EcommerceImanges.SetRange("Item Display Sequence", Ecommerce_Images."Item Display Sequence");
                            EcommerceImanges.SetRange("Image Type", EcommerceImanges."Image Type"::Zoom);
                            if not EcommerceImanges.Find() then begin
                                EcommerceImanges.Init();
                                EcommerceImanges."Item No." := Ecommerce_Images."Item No.";
                                EcommerceImanges."Item Display Sequence" := Ecommerce_Images."Item Display Sequence";
                                EcommerceImanges."Image Type" := Ecommerce_Images."Image Type"::Zoom;
                                EcommerceImanges.PictureURL := Ecommerce_Images.PictureURL;
                                if EcommerceImanges."Item No." <> Ecommerce_Images."Item No." then
                                    EcommerceImanges.Insert(true);
                            end;
                        end;
                    end else begin
                        Error('Item Not found %1', ItemNo);
                    end;
                end;

            }
        }
    }
    var
        EcommerceImanges: Record "Ecommerce Images";
        rItem: Record Item;
        ItemRecordFilter: RecordId;
        IntSequence: Integer;
        ImageURL: Text[2048];
        ItemNo: Code[20];
}

