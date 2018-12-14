trigger MaintenanceAccountBook_BeforeInsert on MaintenanceAccountBook__c (before insert) {

    private String getLineNoLink(String sType, String sMonth) {
        
        String sReturn = '';

        try {
                    
            if (sType.trim().length() != 1 || sMonth.trim().length() != 6) {
                return '';        
            }
            
            sReturn = sType.trim();
            
            integer iYear = integer.valueof(sMonth.trim().substring(2, 4));
            integer iMonth = integer.valueof(sMonth.trim().substring(4));
            
            sReturn += ((12 * iYear) + iMonth);

        } catch (Exception ex) {
            sReturn = '';
        }
        
        return sReturn;
    }
    
    List<id> lsModID = new List<id>();
    
    for (MaintenanceAccountBook__c mod : Trigger.New){
        lsModID.add(mod.MaintenanceContractManagement__c);
    }

    List<MaintenanceContractManagement__c> lsls = [SELECT id, Name, MaxOrderDocNumber__c FROM MaintenanceContractManagement__c where id = :lsModID];

    Map<id, MaintenanceContractManagement__c> mpmp = new Map<id, MaintenanceContractManagement__c>();
    
    for (MaintenanceContractManagement__c onerow : lsls) {
        mpmp.put(onerow.id, onerow);
    }
    
    for (MaintenanceAccountBook__c mod : Trigger.New){
        if (!mod.BypassTriggerCheck__c) {
            mod.UniqueKey__c = mpmp.get(mod.MaintenanceContractManagement__c).Name + '_' + getLineNoLink(mod.Type__c, mod.Month__c) + (mod.SalesReturn__c ? '01' : '00');
        }
        mod.BypassTriggerCheck__c = false;
    }

}