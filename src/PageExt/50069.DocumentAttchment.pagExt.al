pageextension 50069 "Document Attachment Ext" extends "Document Attachment Details"
{

    layout
    {
        // Add changes to page layout here
        addafter("Attached Date")
        {
            field("FileBase64"; AttachmentDocument.ConvertMediaIntoBase64(Rec))
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here

        //Testing Purpose WIN504>>
        // addlast(Creation)
        // {
        //     action("Test Preview Attachment Portal")
        //     {
        //         ApplicationArea = All;

        //         trigger OnAction()
        //         var
        //             AttachmentPreviewPortal: Codeunit "Attachment Preview";
        //         begin
        //             AttachmentPreviewPortal.AttachmentPreviewPortal(Rec."Table ID", Rec."No.");
        //         end;
        //     }

        //     action(testImport)
        //     {
        //         ApplicationArea = All;

        //         trigger OnAction()
        //         begin
        //             AttachmentDocument.ConvertBase64IntoMedia(AttachmentDocument.ConvertMediaIntoBase64(Rec), rec."Table ID", 0, rec."No.", Rec."File Name", rec."File Extension");
        //         end;
        //     }
        // }
        //Testing Purpose WIN504<<

    }
    var
        AttachmentDocument: Codeunit "Attachment Preview";
}