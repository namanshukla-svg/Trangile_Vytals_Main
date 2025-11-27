Codeunit 50045 "Prod.OrderStatusManagement5407"
{
    var v: Codeunit "Prod. Order Status Management";
    trigger OnRun()
    begin
    //  OBJECT Modification "Prod. Order Status Management"(Codeunit 5407)
    //  {
    //    OBJECT-PROPERTIES
    //    {
    //      Date=08092021D;
    //      Time=102927T;
    //      Modified=Yes;
    //      Version List=NAVW19.00.00.51685,NAVIN9.00.00.51685,Alle221020;
    //    }
    //    PROPERTIES
    //    {
    //      Target="Prod. Order Status Management"(Codeunit 5407);
    //    }
    //    CHANGES
    //    {
    //      { CodeModification  ;OriginalCode=BEGIN
    //                                          ChangeStatusForm.Set(Rec);
    //                                          IF ChangeStatusForm.RUNMODAL = ACTION::Yes THEN BEGIN
    //                                            ChangeStatusForm.ReturnPostingInfo(NewStatus,NewPostingDate,NewUpdateUnitCost);
    //                                            ChangeStatusOnProdOrder(Rec,NewStatus,NewPostingDate,NewUpdateUnitCost);
    //                                            COMMIT;
    //                                            MESSAGE(Text000,Status,TABLECAPTION,"No.",ToProdOrder.Status,ToProdOrder.TABLECAPTION,ToProdOrder."No.")
    //                                          END;
    //                                        END;
    //  
    //                           ModifiedCode=BEGIN
    //                                          ChangeStatusForm.Set(Rec);
    //                                          IF ChangeStatusForm.RUNMODAL = ACTION::Yes THEN BEGIN
    //                                            ChangeStatusForm.ReturnPostingInfo(NewStatus,NewPostingDate,NewUpdateUnitCost,VarianceCause,Remarks);
    //                                             //Alle 13012021
    //                                            IF NewStatus = NewStatus::Released THEN
    //                                              CheckValidaion(Rec);
    //                                            //ALLe 13012021
    //  
    //                                           Rec."Variance Cause" := VarianceCause; //Alle dp 18-02-21
    //                                           Rec.Remarks := Remarks; //23062021
    //                                            Rec.MODIFY;
    //                                          #4..7
    //                                        END;
    //  
    //                           Target=OnRun }
    //      { CodeModification  ;OriginalCode=BEGIN
    //                                          SetPostingInfo(NewStatus,NewPostingDate,NewUpdateUnitCost);
    //                                          IF NewStatus = NewStatus::Finished THEN BEGIN
    //                                            CheckBeforeFinishProdOrder(ProdOrder);
    //                                            FlushProdOrder(ProdOrder,NewStatus,NewPostingDate);
    //                                            ProdOrder.HandleItemTrackingDeletion;
    //                                            ErrorIfUnableToClearWIP(ProdOrder);
    //                                            TransProdOrder(ProdOrder);
    //  
    //                                            InvtSetup.GET;
    //                                          #10..23
    //                                          COMMIT;
    //  
    //                                          CLEAR(InvtAdjmt);
    //                                        END;
    //  
    //                           ModifiedCode=BEGIN
    //                                          #1..5
    //                                            IF USERID <> 'ZDI\AGUPTA' THEN // ALLE
    //                                              ErrorIfUnableToClearWIP(ProdOrder);
    //                                          #7..26
    //                                        END;
    //  
    //                           Target=ChangeStatusOnProdOrder(PROCEDURE 10) }
    //      { CodeModification  ;OriginalCode=BEGIN
    //                                          WITH FromProdOrder DO BEGIN
    //                                            ToProdOrderLine.LOCKTABLE;
    //  
    //                                          #4..31
    //                                            ToProdOrder."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
    //                                            ToProdOrder."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
    //                                            ToProdOrder."Dimension Set ID" := "Dimension Set ID";
    //                                            ToProdOrder.MODIFY;
    //  
    //                                            TransProdOrderLine(FromProdOrder);
    //                                          #38..46
    //                                            DELETE;
    //                                            FromProdOrder := ToProdOrder;
    //                                          END;
    //                                        END;
    //  
    //                           ModifiedCode=BEGIN
    //                                          #1..34
    //  
    //                                            ToProdOrder."Manufacturing Date" := NewPostingDate; //Alle- 221020
    //  
    //                                          #35..49
    //                                        END;
    //  
    //                           Target=TransProdOrder(PROCEDURE 1) }
    //      { Insertion         ;InsertAfter=SetTimeAndQuantityOmItemJnlLine(PROCEDURE 8);
    //                           ChangedElements=PROCEDURECollection
    //                           {
    //                             LOCAL PROCEDURE "--Alle"@1170000000();
    //                             BEGIN
    //                             END;
    //  
    //                             PROCEDURE CheckValidaion@1170000001(ProductionOrder@1170000000 : Record "Production Order");
    //                             VAR
    //                               Item@1170000001 : Record Item;
    //                               RoutingLine@1170000002 : Record "Routing Line";
    //                               WorkCenter@1170000003 : Record "Work Center";
    //                               ProductionQtytime@1170000004 : Decimal;
    //                             BEGIN
    //  
    //                               // IF Item.GET(ProductionOrder."Source No.") THEN BEGIN
    //                               //  RoutingLine.RESET;
    //                               //  RoutingLine.SETRANGE("Routing No.",Item."Routing No.");
    //                               //  IF RoutingLine.FINDFIRST THEN BEGIN
    //                               //    ProductionQtytime := (ProductionOrder.Quantity*RoutingLine."Run Time");
    //                               //    WorkCenter.GET(RoutingLine."Work Center No.");
    //                               //    IF WorkCenter."Shop Calendar Code" = 'ZD-CAL' THEN BEGIN
    //                               //      IF ProductionQtytime > 465 THEN
    //                               //        ERROR('Please Split the Production Order in 2 or 3 Production order')
    //                               //    END ELSE IF WorkCenter."Shop Calendar Code" = 'UC-CAL' THEN BEGIN
    //                               //       IF ProductionQtytime > 1410 THEN
    //                               //        ERROR('Please Split the Production Order in 2 or 3 Production order')
    //                               //    END
    //                               //  END;
    //                               // END
    //                             END;
    //  
    //                           }
    //                            }
    //      { Insertion         ;InsertAfter=SubcontractErr(Variable 1500002);
    //                           ChangedElements=VariableCollection
    //                           {
    //                             VarianceCause@1170000000 : '" ","DN-PPC","DN-PPC FIELD","DN-BOM","DN-SALES","DN-SUBCON","DN-QA CORRECTION","DN-VENDOR","NO LOSS","DN-SCM"';
    //                             Remarks@1170000001 : Text[100];
    //                           }
    //                            }
    //      { PropertyModification;
    //                           Property=Version List;
    //                           OriginalValue=NAVW19.00.00.51685,NAVIN9.00.00.51685;
    //                           ModifiedValue=NAVW19.00.00.51685,NAVIN9.00.00.51685,Alle221020 }
    //    }
    //    CODE
    //    {
    //  
    //      BEGIN
    //      END.
    //    }
    //  }
    //  
    //  
    end;
}
