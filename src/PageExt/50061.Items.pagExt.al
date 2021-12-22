pageextension 50061 "Item List Ext" extends "Item List"
{

    layout
    {
        // Add changes to page layout here
        addafter("Vendor/Manufacturer item code")
        {
            field("Image URL"; Rec."Image URL")
            {
                ApplicationArea = all;
            }
            field("Search Item"; Rec."Search Item")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addlast(Functions)
        {
            action("Update ETA Remarks")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    rItem: Record Item;
                    rSalesRecSetup: Record "Sales & Receivables Setup";
                begin
                    if confirm('Do you want to update ETA Remarks from Sales & Receivable Setup', false) then begin
                        rSalesRecSetup.Reset();
                        rSalesRecSetup.get();
                        rSalesRecSetup.TestField(rSalesRecSetup."ETA Available Remarks");
                        rSalesRecSetup.TestField(rSalesRecSetup."ETA Not Available Remarks");
                        rItem.Reset();
                        if ritem.FindSet(true, false) then
                            repeat
                                if ritem."ETA Available Remarks" = '' then
                                    rItem."ETA Available Remarks" := rSalesRecSetup."ETA Available Remarks";
                                if ritem."ETA not Available Remarks" = '' then
                                    rItem."ETA Not Available Remarks" := rSalesRecSetup."ETA Not Available Remarks";
                                rItem.Modify(true);
                            until ritem.next = 0;
                        Message('ETA Remarks Updated Successfully.');
                    end;
                end;
            }
            action("Import Attachment")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    FileName: Text;
                    ImportAttachment: Codeunit "import bulk attachment";
                    TotalCount: Integer;
                    replacemode: Boolean;
                begin
                    //FileName := FileMgt.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);

                    ImportAttachment.ImportBulkAttachment(FileName, TotalCount, replacemode);
                    if TotalCount <> 0 then
                        Message('%1 - File Attached', TotalCount);
                end;
            }
            action("Get Child Category")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Codeu: Codeunit "Auto Archive Document";
                begin
                    Message(codeu.GetChildItemCategoryTest(rec."Item Category Code"));
                end;
            }
            action("Get Child Category Old")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Codeu: Codeunit "Auto Archive Document";
                begin
                    Message(codeu.GetChildItemCategory(rec."Item Category Code"));
                end;
            }
            // action("Test API")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'test API';
            //     trigger OnAction()
            //     var
            //         APITEst: Codeunit "API Integration Codeunit";
            //     begin
            //         APITEst.GetauthorizationCode();
            //     end;
            // }
            action("Import Item Record Links")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50000, false, true);
                end;
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        ItemNo := Rec."No.";

        if rec."Manufucturing Item Code" <> '' then
            ManuCode := '|' + Rec."Manufucturing Item Code";

        if rec."Portal Item Description" <> '' then
            PortalDes := '|' + Rec."Portal Item Description";

        Rec."Search Item" := UpperCase(ItemNo + ManuCode + PortalDes);
        // Rec.Modify();
    end;

    /*   trigger OnQueryClosePage(CloseAction: Action): Boolean
      begin
          ItemNo := Rec."No.";

          if rec."Manufucturing Item Code" <> '' then
              ManuCode := '|' + Rec."Manufucturing Item Code";

          if rec."Portal Item Description" <> '' then
              PortalDes := '|' + Rec."Portal Item Description";

          Rec."Search Item" := UpperCase(ItemNo + ManuCode + PortalDes);
      end; */

    var
        ItemNo: code[20];
        ManuCode: Code[110];
        PortalDes: Text[150];
}