trigger MaintenanceContractManagement_BeforeDelete on MaintenanceContractManagement__c (Before delete) {

    List<id> lsId = new List<id>();
    
    // Forbid the deletion if already sent to BaaN
    for (MaintenanceContractManagement__c mcm : Trigger.Old){
        if (!mcm.BypassTriggerCheck__c) {
            if (mcm.LastLinkBaaN__c != null) {
                if (mcm.LastLinkBaaN__r.clyn__c == null || mcm.LastLinkBaaN__r.clyn__c != '1' ||
                    mcm.LastLinkBaaN__r.ifst__c == null || (mcm.LastLinkBaaN__r.ifst__c != '2' && mcm.LastLinkBaaN__r.ifst__c != '5')) {
            
                    mcm.adderror('連携済みのため、削除できません。');

                }
            }
            lsId.add(mcm.id);
        }
    }
    
    // Forbid the deletion if any account book row has already been billed
    Set<id> lsIdForbidden = new Set<id>();
    if (lsId != null && lsId.size() > 0) {
    
        List<MaintenanceAccountBook__c> lsLinesFirbidden = [SELECT id, MaintenanceContractManagement__c FROM MaintenanceAccountBook__c
                                                            WHERE MaintenanceContractManagement__c = :lsId AND ((AlreadyBilled__c = true) OR (SalesAmountReal__c != NULL AND SalesAmountReal__c <> 0))];
    
        if (lsLinesFirbidden != null && lsLinesFirbidden.size() > 0) {
            for (MaintenanceAccountBook__c row : lsLinesFirbidden) {
                lsIdForbidden.add(row.MaintenanceContractManagement__c);
            }
        }
    
    }
    
    if (lsIdForbidden != null && lsIdForbidden.size() > 0) {
        
        for (MaintenanceContractManagement__c mcm : Trigger.Old){
            if (lsIdForbidden.contains(mcm.id)) {
                mcm.adderror('売上済みのため、削除できません。');                
            }            
        }
        
    }
    
}