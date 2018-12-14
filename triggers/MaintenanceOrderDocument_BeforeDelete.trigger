trigger MaintenanceOrderDocument_BeforeDelete on MaintenanceOrderDocument__c (before delete) {

    for (MaintenanceOrderDocument__c row : trigger.old) {
        if (!row.BypassTriggerCheck__c) {
            if (row.AccountingValidation__c) {
                row.adderror('経理確認済みのため、削除できません。');            
            }
        }
    }

}