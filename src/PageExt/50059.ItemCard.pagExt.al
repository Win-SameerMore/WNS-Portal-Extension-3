pageextension 50059 "Item Card Ext" extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Blocked)
        {
            // field(ZipFileName; ZipFileName)
            // {
            //     ApplicationArea = All;
            //     AssistEdit = true;
            //     Caption = 'Select a ZIP file';
            //     Editable = false;
            //     ToolTip = 'Specified a ZIP file';
            //     Width = 60;
            //     trigger OnAssistEdit()
            //     var
            //         importAttchment: Codeunit "Import Bulk Attachment";
            //         ReplaceMode: Boolean;
            //         TotalCount: Integer;
            //     begin
            //         if ZipFileName <> '' then begin
            //             ZipFileName := importAttchment.ImportBulkAttachment('', TotalCount, ReplaceMode);
            //         end;
            //     end;
            // }
            field("Manufucturing Item Code"; rec."Manufucturing Item Code")
            {
                ApplicationArea = All;
            }
            field("ETA Available Remarks"; rec."ETA Available Remarks")
            {
                ApplicationArea = All;
            }
            field("ETA Not Available Remarks"; rec."ETA Not Available Remarks")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                Caption = 'Brand';
                ApplicationArea = All;
            }
            field(Dimension; Rec.Dimension)
            {
                ApplicationArea = All;
            }
            field("Portal Item Description"; Rec."Portal Item Description")
            {
                ApplicationArea = All;
            }
        }
        addlast(InventoryGrp)
        {
            field("Qty. on Trf. Shipment"; Rec."Qty. on Trf. Shipment")
            {
                ApplicationArea = All;
            }
            field("Qty. on Trf. Receipt"; Rec."Qty. on Trf. Receipt")
            {
                ApplicationArea = All;
            }
        }
        modify("Base Unit of Measure")
        {
            ApplicationArea = all;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        ZipFileName: Text;
}