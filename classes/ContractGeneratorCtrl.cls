public with sharing class ContractGeneratorCtrl {
	public SVC__c record{get;set;}
	public String signSrc{get;set;}
	public String currentUSer{get;set;}
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public ContractGeneratorCtrl(ApexPages.StandardController stdController) {
        currentUser = [SELECT Name FROM User WHERE Id = :UserInfo.getUserId()].Name;

        SVC_Signing__c sign = [SELECT Sign__c FROM SVC_Signing__c WHERE User__c = :UserInfo.getUserId()];
        String url = sign.Sign__c.subString(sign.Sign__c.indexOf('<img'));
        url = url.substring(url.indexOf('src=') + 5, url.indexOf('">'));
        signSrc = url.replace('&amp;', '&');

        record = (SVC__c)stdController.getRecord();
        record = [SELECT Job_No__c, Date__c, customer_company_name__c, Customer_Contact_Name__c, customer_address__c, model__c, serial_number__c, 
        isform1__c, isform2__c, isform3__c, isform4__c, istype1__c, istype2__c, istype3__c, istype4__c, istype5__c, istype6__c, istype7__c, probrem_request__c, 
        performed_solution__c,
        (SELECT date__c, Duration_Time_From__c, Duration_Time_To__c, Working_Hour__c FROM activity__r),
        (SELECT Description__c, Part_No__c, type__c, qty__c, price_pc__c, total__c FROM parts__r), 
        parts_supplied_total__c
        FROM SVC__c WHERE Id = :record.Id];
    }
}