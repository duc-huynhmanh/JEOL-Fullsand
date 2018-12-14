trigger MaintenanceContractManagement_BeforeUpdate on MaintenanceContractManagement__c (Before update) {

    List<id> lsIdLinkBaan = new List<id>();
    Set<id> lsIdUpdatedByBatch = new Set<id>();
    List<id> lsIdUpdatedByBatchSalesOrder = new List<id>();
    List<id> lsUnitBodyID = new List<id>();
    List<id> lsNewOdrSalesOrderID = new List<id>();
    
    for (MaintenanceContractManagement__c mcm : Trigger.New){

        mcm.FullVersionNumber__c = Trigger.oldMap.get(mcm.id).FullVersionNumber__c + 1;
        
        if (mcm.UnitBody__c != NULL) {
            lsUnitBodyID.add(mcm.UnitBody__c);
        }
        if (mcm.NewOdrSalesOrder__c != NULL) {
            lsNewOdrSalesOrderID.add(mcm.NewOdrSalesOrder__c);
        }

        if (mcm.IncrementVersionNumber__c) {
            mcm.VersionNumber__c = (Trigger.oldMap.get(mcm.id).VersionNumber__c == null) ? 1 : (Trigger.oldMap.get(mcm.id).VersionNumber__c + 1);
        } else {
            mcm.VersionNumber__c = (Trigger.oldMap.get(mcm.id).VersionNumber__c == null) ? 1 : (Trigger.oldMap.get(mcm.id).VersionNumber__c);
            mcm.IncrementVersionNumber__c = true;
        }        

        
        if (!mcm.BypassTriggerCheck__c) {
            
            if (mcm.Name != trigger.oldMap.get(mcm.id).Name ||
                mcm.UniqueKey__c != trigger.oldMap.get(mcm.id).UniqueKey__c ||
                mcm.TechnicalAlways1__c != trigger.oldMap.get(mcm.id).TechnicalAlways1__c ||
                mcm.TechnicalAlwaysFalse__c != trigger.oldMap.get(mcm.id).TechnicalAlwaysFalse__c ||
                mcm.PreviousYearOrder__c != trigger.oldMap.get(mcm.id).PreviousYearOrder__c ||
                mcm.PreviousYearPipeline__c != trigger.oldMap.get(mcm.id).PreviousYearPipeline__c ||
                mcm.LastLinkBaaN__c != trigger.oldMap.get(mcm.id).LastLinkBaaN__c ||
                mcm.NewOdrSalesOrder__c != trigger.oldMap.get(mcm.id).NewOdrSalesOrder__c) {

                mcm.adderror('この変更は禁止です。');   

            }
            
            if (trigger.oldMap.get(mcm.id).LastLinkBaaN__c != null) {
                lsIdLinkBaan.add(trigger.oldMap.get(mcm.id).LastLinkBaaN__c);
            }
        } else {
            // BypassTriggerCheck__c = true, we should update SalesAccount & dependant fields if there was a change in the SalesOrder data
            if (mcm.NewOdrSalesOrder__c != null) {
                lsIdUpdatedByBatch.add(mcm.id);
                lsIdUpdatedByBatchSalesOrder.add(mcm.NewOdrSalesOrder__c);
            }
        }
        
        mcm.BypassTriggerCheck__c = false;

    }
    
    // Make the update of SalesAccount__c and dependant fields when having a new account
    List<SalesOrder__c> lsSO = [SELECT id, SalesAccount__c, SalesContactPosition__c, SalesContactPost__c, SalesTantoshya__c, SalesContactTel__c, SalesContactFax__c FROM SalesOrder__c WHERE id IN :lsIdUpdatedByBatchSalesOrder];
    Map<id, SalesOrder__c> mpSO = new Map<id, SalesOrder__c>();
    for (SalesOrder__c so : lsSO) {
        mpSO.put(so.id, so);
    }

    // Get the list of the Names of UnitBody
    List<UnitBody__c> lsUB = [SELECT id, Name FROM UnitBody__c WHERE id IN :lsUnitBodyID];
    Map<id, String> mpUnitBodyID = new Map<id, String>();
    for (UnitBody__c so : lsUB) {
        mpUnitBodyID.put(so.id, so.Name);
    }

    // Get the list of the Names of SalesOrder
    List<SalesOrder__c> lsSO2 = [SELECT id, Name FROM SalesOrder__c WHERE id IN :lsNewOdrSalesOrderID];
    Map<id, String> mpNewOdrSalesOrderID = new Map<id, String>();
    for (SalesOrder__c so : lsSO2) {
        mpNewOdrSalesOrderID.put(so.id, so.Name);
    }

    for (MaintenanceContractManagement__c mcm : Trigger.New){

        if ((mcm.UnitBody__c != NULL) && mpUnitBodyID.containsKey(mcm.UnitBody__c)) {
            mcm.UnitBodyLabel__c = mpUnitBodyID.get(mcm.UnitBody__c);
        } else {
            mcm.UnitBodyLabel__c = '';
        }

        if ((mcm.NewOdrSalesOrder__c != NULL) && mpNewOdrSalesOrderID.containsKey(mcm.NewOdrSalesOrder__c)) {
            mcm.NewOdrSalesOrderLabel__c = mpNewOdrSalesOrderID.get(mcm.NewOdrSalesOrder__c);
        } else {
            mcm.NewOdrSalesOrderLabel__c = '';
        }
            
        if (lsIdUpdatedByBatch.contains(mcm.id) && mpSO.containsKey(mcm.NewOdrSalesOrder__c)) {
            SalesOrder__c so = mpSO.get(mcm.NewOdrSalesOrder__c);
            if (so.SalesAccount__c != null && so.SalesAccount__c != mcm.NewOdrSalesAccount__c) {
                mcm.NewOdrSalesAccount__c = so.SalesAccount__c;
                mcm.NewOdrSalesContactPosition__c = so.SalesContactPosition__c;
                mcm.NewOdrSalesContactPost__c = so.SalesContactPost__c;
                mcm.NewOdrSalesTantoshya__c = so.SalesTantoshya__c;
                mcm.NewOdrSalesContactTel__c = so.SalesContactTel__c;
                mcm.NewOdrSalesContactFax__c = so.SalesContactFax__c;
            }
        }
    }

    Map<id, MaintenanceLinkOrder__c> mpLinkBaan = new Map<id, MaintenanceLinkOrder__c>();
    if (lsIdLinkBaan != null && lsIdLinkBaan.size() > 0) {
        List<MaintenanceLinkOrder__c> lsLinkBaan = [Select id, clyn__c, ifst__c from MaintenanceLinkOrder__c where id = :lsIdLinkBaan];
        if (lsLinkBaan != null && lsLinkBaan.size() > 0) {
            for (MaintenanceLinkOrder__c row : lsLinkBaan) {
                mpLinkBaan.put(row.id, row);
            }
        }
    }
    
    if (mpLinkBaan != null && mpLinkBaan.size() > 0) {

        for (MaintenanceContractManagement__c mcm : Trigger.New){
            
            if (trigger.oldMap.get(mcm.id).LastLinkBaaN__c != null) {


                id idLinkBaan = trigger.oldMap.get(mcm.id).LastLinkBaaN__c;
                MaintenanceLinkOrder__c mlo = null;
                if (mpLinkBaan.containsKey(idLinkBaan)) {
                    mlo = mpLinkBaan.get(idLinkBaan);
                }

                if (mlo != null) {

                    if (mlo.clyn__c == null || mlo.clyn__c != '1' ||
                        mlo.ifst__c == null || (mlo.ifst__c != '2' && mlo.ifst__c != '5')) {
                
                        if (mcm.NewOdrFiscalYear__c != trigger.oldMap.get(mcm.id).NewOdrFiscalYear__c ||
                            mcm.NewOdrNetMaintenance__c != trigger.oldMap.get(mcm.id).NewOdrNetMaintenance__c ||
                            mcm.NewOdrSeries__c != trigger.oldMap.get(mcm.id).NewOdrSeries__c ||
                            mcm.NewOdrSalesAccount__c != trigger.oldMap.get(mcm.id).NewOdrSalesAccount__c ||
                            mcm.NewOdrDepartment__c != trigger.oldMap.get(mcm.id).NewOdrDepartment__c ||
                            mcm.NewOdrRegion__c != trigger.oldMap.get(mcm.id).NewOdrRegion__c ||
                            mcm.NewOdrOrderDate__c != trigger.oldMap.get(mcm.id).NewOdrOrderDate__c ||
                            (trigger.oldMap.get(mcm.id).UnitBody__c != null && mcm.UnitBody__c != trigger.oldMap.get(mcm.id).UnitBody__c) ||
                            mcm.ProductNumber__c != trigger.oldMap.get(mcm.id).ProductNumber__c) {
            
                            mcm.adderror('連携済みのため、変更できません。');   
            
                        }        
                    }
                }                
            }                
        }
    }
}