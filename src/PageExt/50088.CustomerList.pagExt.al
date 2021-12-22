pageextension 50088 "Customer List Ext" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(reporting)
        {
            action("SOA Mail")
            {
                ApplicationArea = All;
                Image = SendMail;
                trigger OnAction()
                var
                    AutoMail: Codeunit "Auto Mail";
                    Customer: Record Customer;
                begin
                    Customer.Reset();
                    CurrPage.SetSelectionFilter(Customer);
                    AutoMail.SOAAutoMail(Customer);
                end;
            }
        }
    }
    var

}

