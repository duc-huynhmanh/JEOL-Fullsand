trigger MaintenanceAccountBook_BeforeDelete on MaintenanceAccountBook__c (before delete) {

    for (MaintenanceAccountBook__c row : trigger.old) {
        if (!row.BypassTriggerCheck__c) {
            if (row.AlreadyBilled__c) {
                row.adderror('売上済の行のため、削除できません。');                                        
            } else if (row.SalesAmountReal__c != null) {
                row.adderror('売上（実績）のため、削除できません。');                                        
            } else if (row.SalesReturn__c) {
                row.adderror('売上戻しの行のため、削除できません。');                                        
            }
        }
    }

}