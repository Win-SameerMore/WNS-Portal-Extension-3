pageextension 50083 "Ecommerce Images Ext" extends "Ecommerce Images List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Image Type")
        {
            field(Image; Rec.Image)
            {
                ApplicationArea = All;
            }
            field("Image String"; AttachmentPreview.ConvertMediaIntoBase64Image(Rec))
            {
                ApplicationArea = All;
            }
            field(PictureURL; Rec.PictureURL)
            {
                ApplicationArea = All;
                Caption = 'Image URL';
            }
        }
        addlast(FactBoxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
        addlast(Creation)
        {
            action("Import Bulk Images")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    BulkImport: Codeunit "Import Bulk Attachment";
                    FileName: Text;
                    TotalCount: Integer;
                    replacemode: Boolean;

                begin
                    BulkImport.ImportBulkImages(FileName, TotalCount, replacemode);
                    Message('%1 - File Imported', TotalCount);
                end;
            }
            // action("Export Links")
            // {
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     begin
            //         Xmlport.Run(50001, true, false);
            //     end;
            // }
            action("Import Links")
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Xmlport.Run(50001, false, true);
                end;
            }
        }

    }

    var
        AttachmentPreview: Codeunit "Attachment Preview";
}
