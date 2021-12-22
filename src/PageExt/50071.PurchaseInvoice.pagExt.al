pageextension 50071 "Purchase Invoice Ext" extends "Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(processing)
        {
            action(Links)
            {
                ApplicationArea = all;
                Image = Links;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    RLink: Record "Record Link";
                    str: RecordID;
                begin
                    EVALUATE(str, 'Purchase Header: Invoice,' + Rec."No.");
                    RLink.RESET();
                    RLink.SETRANGE("Record ID", str);
                    //if RLink.FindSet() then
                    PAGE.RUN(50004, RLink);
                end;
            }
        }
    }

    var
        myInt: Integer;
}