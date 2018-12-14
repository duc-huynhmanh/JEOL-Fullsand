trigger MaintenanceContractManagement_AfterInsert on MaintenanceContractManagement__c (After insert) {

    List<id> lsId = new List<id>();
    
    for (MaintenanceContractManagement__c mcm : Trigger.New){
        lsId.add(mcm.id);
    }

    List<MaintenanceContractManagement__c> lsMCM = [SELECT id, Name, UniqueKey__c from MaintenanceContractManagement__c WHERE id in :lsId];
    for (MaintenanceContractManagement__c mcm : lsMCM){
        mcm.BypassTriggerCheck__c = True;
        mcm.UniqueKey__c = mcm.Name;
    }
    
    Update lsMCM;

}