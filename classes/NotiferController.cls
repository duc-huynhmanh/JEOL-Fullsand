public class NotiferController {

    private List<NotifierObject__c> ns;
    private Integer l = 10;
    
    public List<NotifierObject__c> getNotifiers() {
        Date today = Date.today();
        ns = [SELECT Id, Name, orderNumber__c, detailUrl__c, startDate__c, endDate__c, contents__c, headerfontcolor__c, headerfontsize__c, contentfontcolor__c, contentfontsize__c
                FROM NotifierObject__c
                WHERE startDate__c <=:today AND endDate__c >=:today
                ORDER BY orderNumber__c ASC 
                LIMIT :l];

        return ns;
    }
    
    static testMethod void doTest() {
        NotiferController nc = new NotiferController();
        List<NotifierObject__c> ns = nc.getNotifiers();
    }
}