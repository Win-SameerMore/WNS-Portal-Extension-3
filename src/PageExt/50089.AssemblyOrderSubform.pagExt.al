pageextension 50089 "Assembly Order Subform Ext" extends "Assembly Order Subform"
{
    layout
    {
        // Add changes to page layout here
        modify("Quantity per")
        {
            trigger OnBeforeValidate()
            begin
                if rec."Quantity per" > 1 then
                    Error('Quantity per can''t be greater then 1.');
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}