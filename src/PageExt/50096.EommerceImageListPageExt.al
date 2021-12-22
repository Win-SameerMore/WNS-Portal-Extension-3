pageextension 50096 "EcommerceImageListExt" extends "ECommerce Image Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Image Type")
        {
            field(PictureURL; Rec.PictureURL)
            {
                ApplicationArea = All;
                Caption = 'Image URL';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}