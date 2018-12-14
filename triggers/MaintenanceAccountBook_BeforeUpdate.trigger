trigger MaintenanceAccountBook_BeforeUpdate on MaintenanceAccountBook__c (before update) {

    for (MaintenanceAccountBook__c row : trigger.new) {
        
        if (!row.BypassTriggerCheck__c) {
            
            if (row.AlreadyBilled__c != trigger.oldMap.get(row.id).AlreadyBilled__c ||
                row.Type__c != trigger.oldMap.get(row.id).Type__c ||
                row.Month__c != trigger.oldMap.get(row.id).Month__c ||
                row.Name != trigger.oldMap.get(row.id).Name ||
                row.UniqueKey__c != trigger.oldMap.get(row.id).UniqueKey__c ||
                row.SalesReturn__c != trigger.oldMap.get(row.id).SalesReturn__c ||
                row.SalesAmountReal__c != trigger.oldMap.get(row.id).SalesAmountReal__c ||
                row.MaintenanceContractManagement__c != trigger.oldMap.get(row.id).MaintenanceContractManagement__c  ||
                row.MaintenanceContractManagement1__c != trigger.oldMap.get(row.id).MaintenanceContractManagement1__c ||
                row.MaintenanceContractManagement2__c != trigger.oldMap.get(row.id).MaintenanceContractManagement2__c ||
                row.MaintenanceContractManagement3__c != trigger.oldMap.get(row.id).MaintenanceContractManagement3__c ||
                row.MaintenanceContractManagement4__c != trigger.oldMap.get(row.id).MaintenanceContractManagement4__c ) {

                row.adderror('この変更は禁止です。（ある行は変更不可になったかもしれません）');   

            }
            
            if (row.AlreadyBilled__c || row.SalesReturn__c) {

                if (row.SalesAuto__c != trigger.oldMap.get(row.id).SalesAuto__c ||
                    row.ItemName__c != trigger.oldMap.get(row.id).ItemName__c ||
                    row.TaxCode__c != trigger.oldMap.get(row.id).TaxCode__c ||
                    row.SalesAmountEstimate__c != trigger.oldMap.get(row.id).SalesAmountEstimate__c
                    ) {
    
                    row.adderror('この変更は禁止です。（ある行は変更不可になったかもしれません）');   
    
                }
                
            }
            
            if (row.SalesReturn__c) {

                if (row.BillingDone__c != trigger.oldMap.get(row.id).BillingDone__c ||
                    row.BillingAmountEstimate__c != trigger.oldMap.get(row.id).BillingAmountEstimate__c ||
                    row.Inspection__c != trigger.oldMap.get(row.id).Inspection__c ||
                    row.InspectionDone__c != trigger.oldMap.get(row.id).InspectionDone__c
                    ) {
    
                    row.adderror('この変更は禁止です。（ある行は変更不可になったかもしれません）');   
    
                }
                
            }
    
                
        }

        row.BypassTriggerCheck__c = false;

    }

}