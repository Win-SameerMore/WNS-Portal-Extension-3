pageextension 50095 "SalesInvoiceExt" extends "Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        modify("External Document No.")
        {
            Caption = 'Customer PO number';
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}