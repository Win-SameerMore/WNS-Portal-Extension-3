tableextension 50064 "Item Amount Ext" extends "Item Amount"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Sales Order No."; COde[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Sales Person"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Sales Quote No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Customer Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Project Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "End User Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Customer PO No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Item Desciption"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Customer PO Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Customer Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "SSE Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Customer Shipping Term"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Supplier Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "PO Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Order Ack No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Order Ack Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(500017; "Supp. Org. Com. date(Ex-works)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Supp. Re-sch. Completion date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "SO Status"; Enum "Sales Order Status")
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "VAS Task"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "VAS Sub-Vendor Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "VAS Time Allocated"; text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Sales Est Freight Cost"; Decimal)
        {
            Caption = 'Sales Est Freight Cost';
            DataClassification = ToBeClassified;
        }
        field(50025; "Sales Order Qty"; Decimal)
        {
            Caption = 'Sales Order Qty';
            DataClassification = ToBeClassified;
        }
        field(50026; "Shipped Qty"; Decimal)
        {
            Caption = 'Shipped Qty';
            DataClassification = ToBeClassified;
        }
        field(50027; "Invoiced Qty"; Decimal)
        {
            Caption = 'Invoiced Qty';
            DataClassification = ToBeClassified;
        }
        field(50028; "PO Item No."; Code[20])
        {
            Caption = 'PO Item No.';
            DataClassification = ToBeClassified;
        }
        field(50029; "PO Line Order Qty"; Decimal)
        {
            Caption = 'PO Line Order Qty';
            DataClassification = ToBeClassified;
        }
        field(50030; "PO Line Remarks"; text[200])
        {
            caption = 'PO Line Remarks';
            DataClassification = ToBeClassified;
        }
        field(50031; "PO Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = ,"On time","Potential Delay",Late;
            DataClassification = ToBeClassified;
        }

        field(50032; "AO Item No."; Code[20])
        {
            Caption = 'AO Item No.';
            DataClassification = ToBeClassified;
        }
        field(50033; "AO Start Date"; Date)
        {
            Caption = 'AO Start Date';
            DataClassification = ToBeClassified;
        }
        field(50034; "AO End Date"; Date)
        {
            Caption = 'AO Start Date';
            DataClassification = ToBeClassified;
        }
        field(50035; "AO Qty"; Decimal)
        {
            Caption = 'AO Qty';
            DataClassification = ToBeClassified;
        }
        field(50036; "AO Assembled Qty"; Decimal)
        {
            Caption = 'AO Assembled Qty';
            DataClassification = ToBeClassified;
        }
        field(50037; "AO Remaining Qty"; Decimal)
        {
            Caption = 'AO Remaining Qty';
            DataClassification = ToBeClassified;
        }
        field(50038; "Freight Estimated Days"; DateFormula)
        {
            Caption = 'Freight Estimated Days';
            DataClassification = ToBeClassified;
        }
        field(50039; "Freight Fwder Name"; Code[10])
        {
            Caption = 'Freight Fwder Name';
            DataClassification = ToBeClassified;
        }
        field(50040; "Actual Freight Cost"; Decimal)
        {
            Caption = 'Actual Freight Cost';
            DataClassification = ToBeClassified;
        }
        field(50041; "SO Line No."; Integer)
        {
            Caption = 'SO Line No.';
            DataClassification = ToBeClassified;
        }
        field(50042; "AO Line No."; Integer)
        {
            Caption = 'AO Line No.';
            DataClassification = ToBeClassified;
        }
        field(50043; "AO Document No."; Code[20])
        {
            Caption = 'AO Document No.';
            DataClassification = ToBeClassified;
        }
        field(50044; "PO Line No."; Integer)
        {
            Caption = 'PO Line No.';
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}