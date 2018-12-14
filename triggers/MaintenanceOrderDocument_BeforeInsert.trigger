trigger MaintenanceOrderDocument_BeforeInsert on MaintenanceOrderDocument__c (before insert) {

    List<id> lsModID = new List<id>();
    
    for (MaintenanceOrderDocument__c mod : Trigger.New){
        lsModID.add(mod.MaintenanceContractManagement__c);
    }

    List<MaintenanceContractManagement__c> lsls = [SELECT id, Name, MaxOrderDocNumber__c FROM MaintenanceContractManagement__c where id = :lsModID];

    Map<id, MaintenanceContractManagement__c> mpmp = new Map<id, MaintenanceContractManagement__c>();
    
    for (MaintenanceContractManagement__c onerow : lsls) {
        mpmp.put(onerow.id, onerow);
    }
    
    for (MaintenanceOrderDocument__c mod : Trigger.New){
        if (!mod.BypassTriggerCheck__c) {    
            if (mpmp.get(mod.MaintenanceContractManagement__c).MaxOrderDocNumber__c != null) {
                mod.SerialNumber__c = mpmp.get(mod.MaintenanceContractManagement__c).MaxOrderDocNumber__c + 1;
            } else {
                mod.SerialNumber__c = 1;
            }
            mod.UniqueKey__c = mpmp.get(mod.MaintenanceContractManagement__c).Name + '_' + ('' + mod.SerialNumber__c).leftPad(8).replace(' ', '0');
            mod.AccountingValidation__c = false;
            mod.AccountingApprovalDate__c = null;
        }
        mod.BypassTriggerCheck__c = false;
    }

    

}