pageextension 50086 "Extended Text Ext" extends "Extended Text"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            group("Product Overview")
            {
                Caption = 'Product Overview';
                field(ProductOverview; ProductOverview)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the Product Overview.';

                    trigger OnValidate()
                    begin
                        rec.SetProductOverview(ProductOverview);
                    end;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        ProductOverview := Rec.GetProductOverview();
    end;

    var
        ProductOverview: Text;
}