public with sharing class JEOL_AccountPageCtrl {

    private List<ActivityHistory> lsChildsActivity = new List<ActivityHistory>();
    private integer currentSizeActivityHistory = 5;

    private List<OpenActivity> lsChildsOpenActivity = new List<OpenActivity>();
    private integer currentSizeOpenActivity = 5;
    
    public Account targetRec{get; set;}
    public Boolean isShowRelatedList{get; private set;}
    public static List<String> contactFields{
    // 取引先責任者に名刺追加_変更　2016/01/05　MOD START
//        get {return new List<String>{'name', 'TantoshaCode__c',  'Department', 'Title', 'Email', 'Phone','DMDisplayText__c'};}
        get {return new List<String>{'name', 'TantoshaCode__c', 'SmartViscaf__NameCard__c', 'NineDigitAccountDisplay__c', 'AccountDepartment__c', 'AccountTitle__c', 'Email', 'AccountPhone__c', 'DMList__c'};}
    // 取引先責任者に名刺追加_変更　2016/01/05　MOD END
    }
    public static List<String> NameCardFields{
        get {return new List<String>{'name','SmartViscaf__company_name__c', 'SmartViscaf__division__c', 'SmartViscaf__title_name__c', 'SmartViscaf__tel1__c', 'SmartViscaf__email__c','OwnerId','SmartViscaf__card_exchange_date__c', 'SmartViscaf__list_name__c','SmartViscaf__delivery_type__c'};}
    }
    public static List<String> salespersonFields{
        get {return new List<String>{'sp_BusinessYear__c', 'sp_BMN__c', 'sp_UserName__c','sp_StartDate__c','sp_EndDate__c','sp_Specific_customer__c','name'};}
    }
    public static List<String> salesPipeLineFields{
         get {return new List<String>{'name','Destination__c','Order_number__c','Field7__c','niban_juchu__c','Closing_date__c','Field22__c','Field24__c'};}
    }
    public static List<String> unitBodyFields_delivery{
        get {return new List<String>{'name','Series__c','ModelAbbreviation__c','ModelName__c','ShippingDateFormula__c','AcceptanceDateFormula__c','WasteSituation__c','SvcForm__c','SalesAccount__c'};}
    }
    public static List<String> unitBodyFields_sales{
        get {return new List<String>{'name','Series__c','ModelAbbreviation__c','ModelName__c','ShippingDateFormula__c','AcceptanceDateFormula__c','WasteSituation__c','SvcForm__c','DeliveryAccount__c'};}
    }
    public static List<String> unitNoFields{
        get {return new List<String>{'name','Keiretu__c','Field2__c','Field5__c','ERP__c','Field7__c'};}
    }
    public static List<String> competitionDeviceInfomationFields{
         get {return new List<String>{'Field20_del__c','name', 'Field19__c','Field1__c', 'Field10__c'};}
    }
    
    public JEOL_AccountPageCtrl(ApexPages.StandardController ctrl) {
        Account rec = (Account) ctrl.getRecord();
        if (rec != null) {
            this.isShowRelatedList = isJriRecordType(rec.recordTypeId);
        }
        this.targetRec = rec;
        //refreshChildsActivity();
        //refreshChildsOpenActivity();
    }
    
    //レコードタイプがJRIだったTRUEをかえす
    private Boolean isJriRecordType(String recordTypeId) {
        Boolean ret = false;
        List<RecordType> recTypes = [SELECT id, developerName FROM RecordType WHERE id =: recordTypeId];
        if (recTypes != null && recTypes.size() > 0) {
            RecordType targetRecordType = recTypes.get(0);
            ret = (targetRecordType.developerName == 'JRI_ACCOUNT');
        }
        
        return ret;
    }
    
    private boolean fShouldInsert(ActivityHistory actToInsert, ActivityHistory actCompared) {
        if (actToInsert.ActivityDate == null && actCompared.ActivityDate == null) {
            return (actToInsert.LastModifiedDate > actCompared.LastModifiedDate);
        } else if (actToInsert.ActivityDate == null && actCompared.ActivityDate != null) {
            return false;
        } else if (actToInsert.ActivityDate != null && actCompared.ActivityDate == null) {
            return true;
        } else if (actToInsert.ActivityDate == actCompared.ActivityDate) {
            return (actToInsert.LastModifiedDate > actCompared.LastModifiedDate);
        } else {
            return (actToInsert.ActivityDate > actCompared.ActivityDate);
        }    
    }
    
    private void refreshChildsActivity() {

        if (targetRec == null) {
            return;
        }
        
        lsChildsActivity = new List<ActivityHistory>();
        List<Account> lsChildsAccount = [Select id from Account where ParentId = :targetRec.id];

        if (lsChildsAccount != null && lsChildsAccount.size() > 0) {

            for (Account oneacc : lsChildsAccount) {
    
                List<Account> lsChildsAccountActivity = [Select id, (select id, LastModifiedDate, IsTask, WhatId, What.Name, WhoId, Who.Name, AccountId, Account.Name, ActivityDate, Field4__c, Field5__c, krt__c, model__c, ActivityType, Subject, Status, Priority, OwnerId, Owner.Name from ActivityHistories ORDER BY ActivityDate DESC NULLS LAST, LastModifiedDate DESC LIMIT 500) from Account where id = :oneacc.id];
        
                if (lsChildsAccountActivity != null && lsChildsAccountActivity.size() > 0) {
                    for (Account acc : lsChildsAccountActivity) {
                        for (ActivityHistory act : acc.ActivityHistories) {
                            boolean fAdded = false;
                            if (lsChildsActivity != null && lsChildsActivity.size() > 0) {
                                for (integer i = 0; i < lsChildsActivity.size(); i++) {
                                    if (fShouldInsert(act, lsChildsActivity[i])) {
                                        if (lsChildsActivity != null && lsChildsActivity.size() == 1000) {
                                            lsChildsActivity.remove(999);
                                        }
                                        if (i < 999) {
                                            lsChildsActivity.add(i, act);
                                        } else {
                                            lsChildsActivity.add(act);
                                        }
                                        fAdded = true;
                                        break;
                         
                                    }
                                }
                            }
                            if (!fAdded) {
                                if (lsChildsActivity == null || lsChildsActivity.size() < 1000) {
                                    lsChildsActivity.add(act);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    public List<ActivityHistory> getChildsActivity(){

        List<ActivityHistory> subList = new List<ActivityHistory>();
        for(Integer i = 0; i < currentSizeActivityHistory; i++){
            if (i < lsChildsActivity.size()) {
                subList.add(lsChildsActivity[i]);
            }
        }

        return subList;

    }
    
    public boolean getHasChildActivity() {
        return (lsChildsActivity != null && lsChildsActivity.size() > 0);
    }

    public Integer getResultSizeActivityHistory() {
      Integer resultSizeActivityHistory = 0;
      if (lsChildsActivity != null) {
        resultSizeActivityHistory = lsChildsActivity.size();
      }
      return resultSizeActivityHistory;
    }

    public Integer getCurrentViewSizeActivityHistory() {
      return currentSizeActivityHistory;
    }

    public void AddViewSizeActivityHistory() {
        currentSizeActivityHistory = currentSizeActivityHistory * 2;
        if (currentSizeActivityHistory > getResultSizeActivityHistory()) {
            currentSizeActivityHistory = getResultSizeActivityHistory();
        }
        if (currentSizeActivityHistory > 125 && currentSizeActivityHistory < getResultSizeActivityHistory()) {
            currentSizeActivityHistory = 125;
        }

    }






    private boolean fShouldInsertOpenActivity(OpenActivity actToInsert, OpenActivity actCompared) {
        if (actToInsert.ActivityDate == null && actCompared.ActivityDate == null) {
            return (actToInsert.LastModifiedDate > actCompared.LastModifiedDate);
        } else if (actToInsert.ActivityDate == null && actCompared.ActivityDate != null) {
            return false;
        } else if (actToInsert.ActivityDate != null && actCompared.ActivityDate == null) {
            return true;
        } else if (actToInsert.ActivityDate == actCompared.ActivityDate) {
            return (actToInsert.LastModifiedDate > actCompared.LastModifiedDate);
        } else {
            return (actToInsert.ActivityDate < actCompared.ActivityDate);
        }    
    }

    private void refreshChildsOpenActivity() {

        if (targetRec == null) {
            return;
        }
        
        lsChildsOpenActivity = new List<OpenActivity>();
        List<Account> lsChildsAccount = [Select id, Code__c from Account where ParentId = :targetRec.id];

        if (lsChildsAccount != null && lsChildsAccount.size() > 0) {
            for (Account oneacc : lsChildsAccount) {

                List<Account> lsChildsAccountActivity = [Select id, Code__c, (select id, LastModifiedDate, IsTask, WhatId, What.Name, WhoId, Who.Name, AccountId, Account.Name, ActivityDate, Field4__c, Field5__c, krt__c, model__c, ActivityType, Subject, Status, Priority, OwnerId, Owner.Name from OpenActivities ORDER BY ActivityDate ASC NULLS LAST, LastModifiedDate DESC LIMIT 500) from Account where Id = :oneacc.Id];
        
                if (lsChildsAccountActivity != null && lsChildsAccountActivity.size() > 0) {
                    for (Account acc : lsChildsAccountActivity) {
                        for (OpenActivity act : acc.OpenActivities) {
                            boolean fAdded = false;
                            if (lsChildsOpenActivity != null && lsChildsOpenActivity.size() > 0) {
        
                                for (integer i = 0; i < lsChildsOpenActivity.size(); i++) {
                                    if (fShouldInsertOpenActivity(act, lsChildsOpenActivity[i])) {
                                        if (lsChildsOpenActivity != null && lsChildsOpenActivity.size() == 1000) {
                                            lsChildsOpenActivity.remove(999);
                                        }
                                        if (i < 999) {
                                            lsChildsOpenActivity.add(i, act);
                                        } else {
                                            lsChildsOpenActivity.add(act);
                                        }
                                        fAdded = true;
                                        break;
                         
                                    }
                                }
                
                            }
                            if (!fAdded) {
                                if (lsChildsOpenActivity == null || lsChildsOpenActivity.size() < 1000) {
                                    lsChildsOpenActivity.add(act);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    public List<OpenActivity> getChildsOpenActivity(){

        List<OpenActivity> subList = new List<OpenActivity>();
        for(Integer i = 0; i < currentSizeOpenActivity; i++){
            if (i < lsChildsOpenActivity.size()) {
                subList.add(lsChildsOpenActivity[i]);
            }
        }

        return subList;

    }
    
    public boolean getHasChildOpenActivity() {
        return (lsChildsOpenActivity != null && lsChildsOpenActivity.size() > 0);
    }

    public Integer getResultSizeOpenActivity() {
      Integer resultSizeOpenActivity = 0;
      if (lsChildsOpenActivity != null) {
        resultSizeOpenActivity = lsChildsOpenActivity.size();
      }
      return resultSizeOpenActivity;
    }

    public Integer getCurrentViewSizeOpenActivity() {
      return currentSizeOpenActivity;
    }

    public void AddViewSizeOpenActivity() {
        currentSizeOpenActivity = currentSizeOpenActivity * 2;
        if (currentSizeOpenActivity > getResultSizeOpenActivity()) {
            currentSizeOpenActivity = getResultSizeOpenActivity();
        }
        if (currentSizeOpenActivity > 125 && currentSizeOpenActivity < getResultSizeOpenActivity()) {
            currentSizeOpenActivity = 125;
        }

    }

                
}