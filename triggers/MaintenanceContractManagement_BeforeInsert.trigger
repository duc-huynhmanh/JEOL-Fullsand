trigger MaintenanceContractManagement_BeforeInsert on MaintenanceContractManagement__c (Before insert) {

    List<id> lsUnitBodyID = new List<id>();
    List<id> lsNewOdrSalesOrderID = new List<id>();
    
    for (MaintenanceContractManagement__c mcm : Trigger.New){
        mcm.FullVersionNumber__c = 1;

        if (mcm.UnitBody__c != NULL) {
            lsUnitBodyID.add(mcm.UnitBody__c);
        }
        if (mcm.NewOdrSalesOrder__c != NULL) {
            lsNewOdrSalesOrderID.add(mcm.NewOdrSalesOrder__c);
        }
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
            
    }
}