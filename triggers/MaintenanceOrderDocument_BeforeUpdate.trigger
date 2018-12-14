trigger MaintenanceOrderDocument_BeforeUpdate on MaintenanceOrderDocument__c (before update) {

    for (MaintenanceOrderDocument__c row : trigger.new) {
        
        if (!row.BypassTriggerCheck__c) {
            
            if (row.AccountingValidation__c != trigger.oldMap.get(row.id).AccountingValidation__c ||
                row.AccountingApprovalDate__c != trigger.oldMap.get(row.id).AccountingApprovalDate__c ||
                row.SerialNumber__c != trigger.oldMap.get(row.id).SerialNumber__c ||
                row.UniqueKey__c != trigger.oldMap.get(row.id).UniqueKey__c) {

                row.adderror('この変更は禁止です。');   

            }
            
            if (row.AccountingValidation__c) {

                if (row.SightDays__c != trigger.oldMap.get(row.id).SightDays__c ||
                    row.Factoring__c != trigger.oldMap.get(row.id).Factoring__c ||
                    row.PenaltyFlg__c != trigger.oldMap.get(row.id).PenaltyFlg__c ||
                    row.PenaltyRatio__c != trigger.oldMap.get(row.id).PenaltyRatio__c ||
                    row.Price__c != trigger.oldMap.get(row.id).Price__c ||
                    row.ContractFlg__c != trigger.oldMap.get(row.id).ContractFlg__c ||
                    row.ContractDate__c != trigger.oldMap.get(row.id).ContractDate__c ||
                    row.InspectionDeadlineDivision__c != trigger.oldMap.get(row.id).InspectionDeadlineDivision__c ||
                    row.AcceptanceDeadline__c != trigger.oldMap.get(row.id).AcceptanceDeadline__c ||
                    row.CashPromissoryDivision__c != trigger.oldMap.get(row.id).CashPromissoryDivision__c ||
                    row.PaymentTogetherDivision__c != trigger.oldMap.get(row.id).PaymentTogetherDivision__c ||
                    row.PaymentFrequency__c != trigger.oldMap.get(row.id).PaymentFrequency__c ||
                    row.PaymentTerms__c != trigger.oldMap.get(row.id).PaymentTerms__c ||
                    row.PaymentDayDivision__c != trigger.oldMap.get(row.id).PaymentDayDivision__c ||
                    row.PaymentDatePeriod__c != trigger.oldMap.get(row.id).PaymentDatePeriod__c ||
                    row.InstallationDay__c != trigger.oldMap.get(row.id).InstallationDay__c ||
                    row.OrderNumber__c != trigger.oldMap.get(row.id).OrderNumber__c ||
                    row.BudgetFiscalYear__c != trigger.oldMap.get(row.id).BudgetFiscalYear__c ||
                    row.OnSpotInspection__c != trigger.oldMap.get(row.id).OnSpotInspection__c) {
    
                    row.adderror('経理確認済みのため、変更できません');   
    
                }
                
            }
                
        }

        row.BypassTriggerCheck__c = false;

    }           
               
}