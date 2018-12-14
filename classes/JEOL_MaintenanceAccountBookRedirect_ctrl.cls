public with sharing class JEOL_MaintenanceAccountBookRedirect_ctrl {

    String sParentID = null;
    String sType = null;
    
    public JEOL_MaintenanceAccountBookRedirect_ctrl(ApexPages.StandardController stdController) {
    
        if(!Test.isRunningTest()) {
            stdController.addFields(new List<String>{'MaintenanceContractManagement__r'});
            stdController.addFields(new List<String>{'Type__c'});
        }
        MaintenanceAccountBook__c accBk = (MaintenanceAccountBook__c) stdController.getRecord();
        If (accBk != null && accBk.id != null && accBk.MaintenanceContractManagement__r != null) {
            sParentID = '' + accBk.MaintenanceContractManagement__r.id;
        }
        If (accBk != null && accBk.id != null && accBk.Type__c != null) {
            sType = '' + accBk.Type__c;
        }
    
    }
    
    public PageReference redirect(){
        if(sParentID != null){
            PageReference pageRef = new PageReference('/apex/JEOL_MaintenanceAccountBook');
            pageRef.getParameters().put('id', sParentID);
            if (sType != null) {
                pageRef.getParameters().put('type', sType);            
            }
            return pageRef;
            
        } else {
            return null;
        }
    }
    
}