pageextension 50070 "Business Manager RTC Ext" extends "Business Manager Role Center"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        addbefore("Purchase Quotes")
        {
            action("Purchase Requisition")
            {
                ApplicationArea = All;
                RunObject = page "Req. Worksheet";

            }
            action("Register Vendor Quotes")
            {
                ApplicationArea = All;
                RunObject = page "Purchase Quotes Reg. vendor";
            }
            action("Unregister Vendor Quotes")
            {
                ApplicationArea = All;
                RunObject = page "Purchase Quotes Unreg. vendor";
            }
        }
    }

    var
        myInt: Integer;
}